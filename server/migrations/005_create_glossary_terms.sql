-- Migration 005: Glossar-Tabelle für fachsprachliche Übersetzungshinweise
--
-- Jeder Eintrag definiert ein Wort das im übersetzten Text problematisch ist,
-- die bevorzugte Alternative und eine Erklärung für den Reviewer.
-- Einträge sind sprachspezifisch (lang_code) und können beliebig erweitert werden.

CREATE TABLE IF NOT EXISTS glossary_terms (
  id           INT AUTO_INCREMENT PRIMARY KEY,
  lang_code    VARCHAR(20)  NOT NULL DEFAULT 'de'
                 COMMENT 'Zielsprache, für die dieser Eintrag gilt',
  source_word  VARCHAR(255) NOT NULL
                 COMMENT 'Wort wie es im übersetzten Text auftaucht (z.B. Knoten)',
  preferred_word VARCHAR(255) NOT NULL
                 COMMENT 'Bevorzugte/korrekte Übersetzung (z.B. Inhalt)',
  explanation  TEXT
                 COMMENT 'Erklärung warum das Wort so übersetzt werden soll',
  created_by   INT          NULL
                 COMMENT 'User-ID des Erstellers',
  created_at   TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at   TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
                 ON UPDATE CURRENT_TIMESTAMP,

  INDEX idx_lang     (lang_code),
  INDEX idx_word     (source_word),
  INDEX idx_lang_word (lang_code, source_word)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
