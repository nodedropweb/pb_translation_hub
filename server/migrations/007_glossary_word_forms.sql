-- Migration 007: Wortformen für Glossar-Einträge
--
-- Ermöglicht das Hinterlegen von Pluralformen, Genitiv-/Dativformen etc.
-- damit der CKEditor-Highlight auch flektierte Formen erkennt.
-- Gespeichert als kommagetrennte Liste, z. B. "Inhalte,Inhalts,Inhalten".

ALTER TABLE glossary_terms
  ADD COLUMN word_forms TEXT NULL DEFAULT NULL
    COMMENT 'Kommagetrennte Wortformen (Plural, Genitiv usw.) für CKEditor-Regex'
  AFTER source_word;
