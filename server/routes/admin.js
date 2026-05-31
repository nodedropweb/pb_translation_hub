const express = require('express');

module.exports = (ctx) => {
  const { db, authenticateToken, isAdmin } = ctx;
  const router = express.Router();

  // Get active (approved) users — excludes the requesting admin
  router.get('/admin/users/active', authenticateToken, isAdmin, async (req, res) => {
    try {
      const [rows] = await db.execute(
        'SELECT id, username, name, email, user_type, target_languages, avatar_url, created_at FROM users WHERE is_active = 1 AND role != "admin" ORDER BY username'
      );
      const users = rows.map(u => ({
        ...u,
        target_languages: u.target_languages ? (() => { try { return JSON.parse(u.target_languages); } catch { return []; } })() : []
      }));
      res.json(users);
    } catch (err) {
      res.status(500).json({ error: 'Failed to fetch active users' });
    }
  });

  // Deactivate (lock) a user without deleting
  router.patch('/admin/users/:id/deactivate', authenticateToken, isAdmin, async (req, res) => {
    try {
      await db.execute('UPDATE users SET is_active = 0 WHERE id = ? AND role != "admin"', [req.params.id]);
      res.json({ success: true });
    } catch (err) {
      res.status(500).json({ error: 'Deactivation failed' });
    }
  });

  // Get pending users
  router.get('/admin/users/pending', authenticateToken, isAdmin, async (req, res) => {
    try {
      const [rows] = await db.execute('SELECT id, username, name, email, user_type, requested_role, target_languages, avatar_url, created_at FROM users WHERE is_active = 0');
      const users = rows.map(u => ({
        ...u,
        target_languages: u.target_languages ? (() => { try { return JSON.parse(u.target_languages); } catch { return []; } })() : []
      }));
      res.json(users);
    } catch (err) {
      res.status(500).json({ error: 'Failed to fetch pending users' });
    }
  });

  // Approve a user — defaults to 'translator' regardless of requested role.
  // Admin can explicitly pass user_type to override.
  router.post('/admin/users/:id/approve', authenticateToken, isAdmin, async (req, res) => {
    try {
      const { user_type } = req.body;
      const grantedType = (user_type && ['translator', 'reviewer'].includes(user_type))
        ? user_type
        : 'translator';
      await db.execute('UPDATE users SET is_active = 1, user_type = ? WHERE id = ?', [grantedType, req.params.id]);
      res.json({ success: true });
    } catch (err) {
      res.status(500).json({ error: 'Approval failed' });
    }
  });

  // Delete a user
  router.delete('/admin/users/:id', authenticateToken, isAdmin, async (req, res) => {
    try {
      await db.execute('DELETE FROM users WHERE id = ? AND role != "admin"', [req.params.id]);
      res.json({ success: true });
    } catch (err) {
      res.status(500).json({ error: 'Deletion failed' });
    }
  });

  // Get settings
  router.get('/admin/settings', authenticateToken, isAdmin, async (req, res) => {
    try {
      const [rows] = await db.execute('SELECT * FROM site_settings');
      const settings = {};
      rows.forEach(r => settings[r.setting_key] = r.setting_value);
      res.json(settings);
    } catch (err) {
      res.status(500).json({ error: 'Failed to fetch settings' });
    }
  });

  // Save settings
  router.put('/admin/settings', authenticateToken, isAdmin, async (req, res) => {
    const { registration_enabled } = req.body;
    try {
      await db.execute(
        'INSERT INTO site_settings (setting_key, setting_value) VALUES (?, ?) ON DUPLICATE KEY UPDATE setting_value = ?',
        ['registration_enabled', registration_enabled, registration_enabled]
      );
      res.json({ success: true });
    } catch (err) {
      res.status(500).json({ error: 'Failed to update settings' });
    }
  });

  return router;
};
