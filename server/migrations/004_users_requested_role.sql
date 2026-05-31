-- Migration 004: Gewünschte Rolle bei Registrierung speichern
-- requested_role speichert den Wunsch des Nutzers dauerhaft,
-- user_type enthält die tatsächlich gewährte Rolle nach Freischaltung.

ALTER TABLE users
  ADD COLUMN IF NOT EXISTS requested_role ENUM('translator', 'reviewer') NOT NULL DEFAULT 'translator'
    COMMENT 'Role requested at registration — shown in pending list for admin reference';
