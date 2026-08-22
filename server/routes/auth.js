const express = require('express');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const rateLimit = require('express-rate-limit');
const { encryptSecret, decryptSecret } = require('../lib/secretCrypto');

// 15 attempts / 15 min per IP — generous enough for real users who mistype a
// password a few times, tight enough to make online brute-forcing impractical.
const authLimiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 15,
  standardHeaders: true,
  legacyHeaders: false,
  message: { error: 'Too many attempts. Please wait a few minutes and try again.' },
});

module.exports = (ctx) => {
  const { db, authenticateToken, JWT_SECRET, uploadAvatar } = ctx;
  const router = express.Router();

  // Check registration status (public)
  router.get('/auth/registration-status', async (req, res) => {
    try {
      const [settings] = await db.execute('SELECT setting_value FROM site_settings WHERE setting_key = ?', ['registration_enabled']);
      const enabled = !(settings.length > 0 && settings[0].setting_value === '0');
      res.json({ enabled });
    } catch (err) {
      res.json({ enabled: true });
    }
  });

  // Register a new user
  router.post('/auth/register', authLimiter, async (req, res) => {
    const { username, password, email, user_type, target_languages } = req.body;
    try {
      const [settings] = await db.execute('SELECT setting_value FROM site_settings WHERE setting_key = ?', ['registration_enabled']);
      if (settings.length > 0 && settings[0].setting_value === '0') {
        return res.status(403).json({ error: 'Registration is currently disabled by the administrator' });
      }

      if (!username || !password || !email) {
        return res.status(400).json({ error: 'Username, password and email are required' });
      }
      if (!user_type || !['translator', 'reviewer'].includes(user_type)) {
        return res.status(400).json({ error: 'Invalid user type' });
      }
      if (!target_languages || !Array.isArray(target_languages) || target_languages.length === 0) {
        return res.status(400).json({ error: 'At least one target language is required' });
      }

      const hashedPassword = await bcrypt.hash(password, 10);
      const [result] = await db.execute(
        'INSERT INTO users (username, password, name, email, target_languages, user_type, requested_role, is_active) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
        [username, hashedPassword, username, email, JSON.stringify(target_languages), 'translator', user_type, 0]
      );
      res.json({ success: true, userId: result.insertId });
    } catch (err) {
      console.error('Registration Error:', err);
      if (err.code === 'ER_DUP_ENTRY') {
        return res.status(400).json({ error: 'Username already exists' });
      }
      res.status(500).json({ error: 'Registration failed' });
    }
  });

  // Login
  router.post('/auth/login', authLimiter, async (req, res) => {
    const { username, password } = req.body;
    try {
      const [rows] = await db.execute('SELECT * FROM users WHERE username = ?', [username]);
      if (rows.length === 0) return res.status(401).json({ error: 'Invalid credentials' });

      const user = rows[0];
      const isMatch = await bcrypt.compare(password, user.password);
      if (!isMatch) return res.status(401).json({ error: 'Invalid credentials' });

      if (user.is_active === 0) {
        return res.status(403).json({ error: 'Your account is pending approval by an administrator.' });
      }

      const token = jwt.sign({ id: user.id, username: user.username, role: user.role, user_type: user.user_type }, JWT_SECRET, { expiresIn: '7d' });
      res.json({
        token,
        user: {
          id: user.id,
          username: user.username,
          name: user.name,
          email: user.email,
          avatar_url: user.avatar_url,
          role: user.role,
          user_type: user.user_type,
          target_languages: user.target_languages ? JSON.parse(user.target_languages) : [],
          google_ai_key: decryptSecret(user.google_ai_key),
          ai_batch_limit: user.ai_batch_limit,
          deepl_api_key: decryptSecret(user.deepl_api_key),
          last_reviewed_project: user.last_reviewed_project
        }
      });
    } catch (err) {
      res.status(500).json({ error: 'Login failed' });
    }
  });

  // Get current user profile
  router.get('/auth/me', authenticateToken, async (req, res) => {
    try {
      const [rows] = await db.execute('SELECT id, username, name, email, avatar_url, role, user_type, target_languages, is_active, google_ai_key, ai_batch_limit, ai_prompt, deepl_api_key, last_reviewed_project FROM users WHERE id = ?', [req.user.id]);
      if (rows.length === 0) return res.status(404).json({ error: 'User not found' });
      const user = rows[0];
      if (user.target_languages) {
        try { user.target_languages = JSON.parse(user.target_languages); } catch { user.target_languages = []; }
      } else {
        user.target_languages = [];
      }
      user.google_ai_key = decryptSecret(user.google_ai_key);
      user.deepl_api_key = decryptSecret(user.deepl_api_key);
      res.json(user);
    } catch (err) {
      res.status(500).json({ error: 'Failed to fetch user' });
    }
  });

  // Update profile
  router.put('/user/profile', authenticateToken, async (req, res) => {
    const { name, email, google_ai_key, ai_batch_limit, ai_prompt, deepl_api_key } = req.body;
    try {
      await db.execute(
        'UPDATE users SET name = ?, email = ?, google_ai_key = ?, ai_batch_limit = ?, ai_prompt = ?, deepl_api_key = ? WHERE id = ?',
        [name, email, encryptSecret(google_ai_key) || null, ai_batch_limit || 5, ai_prompt || null, encryptSecret(deepl_api_key) || null, req.user.id]
      );
      res.json({ success: true });
    } catch (err) {
      res.status(500).json({ error: 'Profile update failed' });
    }
  });

  // Update password
  router.put('/user/password', authenticateToken, async (req, res) => {
    const { currentPassword, newPassword } = req.body;
    try {
      const [rows] = await db.execute('SELECT password FROM users WHERE id = ?', [req.user.id]);
      if (rows.length === 0) return res.status(404).json({ error: 'User not found' });
      
      const isMatch = await bcrypt.compare(currentPassword, rows[0].password);
      if (!isMatch) return res.status(400).json({ error: 'Current password incorrect' });
      
      const hashed = await bcrypt.hash(newPassword, 10);
      await db.execute('UPDATE users SET password = ? WHERE id = ?', [hashed, req.user.id]);
      res.json({ success: true });
    } catch (err) {
      res.status(500).json({ error: 'Password update failed' });
    }
  });

  // Upload avatar
  router.post('/user/avatar', authenticateToken, uploadAvatar.single('avatar'), async (req, res) => {
    if (!req.file) return res.status(400).json({ error: 'No file uploaded' });
    
    const avatarUrl = `/uploads/avatars/${req.file.filename}`;
    try {
      await db.execute('UPDATE users SET avatar_url = ? WHERE id = ?', [avatarUrl, req.user.id]);
      res.json({ success: true, avatarUrl });
    } catch (err) {
      res.status(500).json({ error: 'Avatar update failed' });
    }
  });

  return router;
};
