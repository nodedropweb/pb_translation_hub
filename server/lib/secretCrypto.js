const crypto = require('crypto');

// Encrypts user-supplied third-party API keys (Gemini/DeepL) before they are
// stored in the `users` table, so a DB dump/leak does not expose them in
// plaintext. Prefers a dedicated ENCRYPTION_KEY; falls back to deriving one
// from JWT_SECRET so this doesn't require a new mandatory env var on
// existing deployments (same trust boundary as JWT_SECRET already implies).
const rawKey = process.env.ENCRYPTION_KEY || process.env.JWT_SECRET;
if (!rawKey) {
  throw new Error('ENCRYPTION_KEY or JWT_SECRET must be set to encrypt stored API keys.');
}
const KEY = crypto.createHash('sha256').update(rawKey).digest();
const PREFIX = 'enc:v1:';

/**
 * Encrypts a secret for storage. Returns falsy input unchanged (nothing to
 * encrypt for an empty/cleared field).
 */
function encryptSecret(plainText) {
  if (!plainText) return plainText;
  const iv = crypto.randomBytes(12);
  const cipher = crypto.createCipheriv('aes-256-gcm', KEY, iv);
  const ciphertext = Buffer.concat([cipher.update(String(plainText), 'utf8'), cipher.final()]);
  const authTag = cipher.getAuthTag();
  return PREFIX + Buffer.concat([iv, authTag, ciphertext]).toString('base64');
}

/**
 * Decrypts a stored secret. Values written before this migration are plain
 * text (no PREFIX) — returned unchanged so existing keys keep working until
 * the user next saves their profile, at which point they get encrypted.
 */
function decryptSecret(value) {
  if (!value || typeof value !== 'string' || !value.startsWith(PREFIX)) {
    return value;
  }
  try {
    const raw = Buffer.from(value.slice(PREFIX.length), 'base64');
    const iv = raw.subarray(0, 12);
    const authTag = raw.subarray(12, 28);
    const ciphertext = raw.subarray(28);
    const decipher = crypto.createDecipheriv('aes-256-gcm', KEY, iv);
    decipher.setAuthTag(authTag);
    return Buffer.concat([decipher.update(ciphertext), decipher.final()]).toString('utf8');
  } catch (e) {
    console.error('[secretCrypto] Failed to decrypt stored secret:', e.message);
    return null;
  }
}

module.exports = { encryptSecret, decryptSecret };
