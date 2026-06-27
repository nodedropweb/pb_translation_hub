-- Migration 009: Historischer Verlauf der Sync-Ereignisse.
-- Bislang werden Stale-Status und Beschreibungs-Änderungen nur on-the-fly
-- berechnet (MD5-Vergleich) — es gibt keinen Verlauf, wann (in welcher Woche)
-- ein Modul veraltet wurde oder eine neue Beschreibung erhielt.
-- Diese Tabelle protokolliert diese Ereignisse für das Analyse-Dashboard.
--
-- event_type:
--   new_module          — Modul war vorher nicht in der DB (neu auf Drupal.org)
--   description_changed — englischer Beschreibungstext (title/summary/body) hat sich geändert
--   stale               — eine vorhandene Übersetzung wurde durch die Quelländerung veraltet
--
-- new_module + description_changed werden im Dashboard zusammen als
-- "Modul mit neuer Projektbeschreibung" gezählt.

CREATE TABLE IF NOT EXISTS sync_events (
  id            INT AUTO_INCREMENT PRIMARY KEY,
  machine_name  VARCHAR(255) NOT NULL,
  event_type    ENUM('new_module','description_changed','stale') NOT NULL,
  langcode      VARCHAR(10) DEFAULT NULL,        -- nur bei 'stale' gesetzt
  event_date    DATE NOT NULL,                   -- Tag des Ereignisses (Basis für Wochenbucket)
  created_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uniq_event (machine_name, event_type, langcode, event_date),
  KEY idx_type_date (event_type, event_date)
);
