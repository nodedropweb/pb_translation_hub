-- Migration 006: DeepL als suggestion_type erlauben
-- Erweitert den ENUM um 'deepl'.

ALTER TABLE translation_suggestions
  MODIFY COLUMN suggestion_type ENUM('ai', 'manual', 'deepl') DEFAULT 'manual';
