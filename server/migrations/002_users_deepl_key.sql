-- Migration 002: DeepL API Key für Benutzer
-- Fügt deepl_api_key zur users-Tabelle hinzu.

ALTER TABLE users
  ADD COLUMN IF NOT EXISTS deepl_api_key VARCHAR(255) DEFAULT NULL;
