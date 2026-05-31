-- Migration 003: Registrierungs-Felder für Benutzer
-- Fügt target_languages (JSON) und user_type (translator/reviewer) hinzu.

ALTER TABLE users
  ADD COLUMN IF NOT EXISTS target_languages LONGTEXT DEFAULT NULL
    COMMENT 'JSON array of language codes the user works on',
  ADD COLUMN IF NOT EXISTS user_type ENUM('translator', 'reviewer') NOT NULL DEFAULT 'translator'
    COMMENT 'translator = no review queue access; reviewer = can approve translations';
