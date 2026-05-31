-- Migration 001: Basis-Schema
-- Erstellt alle Kern-Tabellen falls sie nicht existieren.
-- Idempotent: CREATE TABLE IF NOT EXISTS ist immer sicher.

CREATE TABLE IF NOT EXISTS projects (
  machine_name VARCHAR(255) NOT NULL,
  title        VARCHAR(255) DEFAULT NULL,
  data         LONGTEXT     DEFAULT NULL,
  updated_at   TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (machine_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS translations (
  machine_name    VARCHAR(255) NOT NULL,
  langcode        VARCHAR(10)  NOT NULL,
  title           VARCHAR(255) DEFAULT NULL,
  summary         TEXT         DEFAULT NULL,
  body            LONGTEXT     DEFAULT NULL,
  screenshot_alts TEXT         DEFAULT NULL,
  source_hash     VARCHAR(32)  DEFAULT NULL,
  is_reviewed     TINYINT(1)   NOT NULL DEFAULT 0,
  reviewed_by     VARCHAR(50)  DEFAULT NULL,
  updated_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (machine_name, langcode)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS priority_projects (
  machine_name VARCHAR(255) NOT NULL,
  list_name    VARCHAR(50)  NOT NULL DEFAULT 'drupal11',
  PRIMARY KEY (machine_name, list_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS ignored_projects (
  machine_name VARCHAR(255) NOT NULL,
  langcode     VARCHAR(10)  NOT NULL DEFAULT 'de',
  PRIMARY KEY (machine_name, langcode)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS site_settings (
  setting_key   VARCHAR(100) NOT NULL,
  setting_value TEXT         DEFAULT NULL,
  PRIMARY KEY (setting_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS users (
  id          INT(11)      NOT NULL AUTO_INCREMENT,
  username    VARCHAR(50)  NOT NULL,
  password    VARCHAR(255) NOT NULL,
  name        VARCHAR(100) DEFAULT NULL,
  email       VARCHAR(100) DEFAULT NULL,
  avatar_url  VARCHAR(255) DEFAULT NULL,
  created_at  TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
  role        VARCHAR(20)  DEFAULT 'user',
  is_active   TINYINT(4)   DEFAULT 0,
  google_ai_key  VARCHAR(255) DEFAULT NULL,
  ai_batch_limit INT(11)   DEFAULT 5,
  ai_prompt   TEXT         DEFAULT NULL,
  last_reviewed_project VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY uk_username (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
