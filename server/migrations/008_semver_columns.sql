-- Migration 008: Stored generated columns for Drupal core semver range fields.
-- JSON_EXTRACT on 38k rows without an index takes ~38s per query.
-- STORED computed columns are pre-calculated on insert/update and indexable.

ALTER TABLE projects
  ADD COLUMN semver_min BIGINT UNSIGNED
    AS (CAST(IFNULL(NULLIF(JSON_UNQUOTE(JSON_EXTRACT(data, '$.attributes.field_core_semver_minimum')), 'null'), '0') AS UNSIGNED)) STORED,
  ADD COLUMN semver_max BIGINT UNSIGNED
    AS (CAST(IFNULL(NULLIF(JSON_UNQUOTE(JSON_EXTRACT(data, '$.attributes.field_core_semver_maximum')), 'null'), '0') AS UNSIGNED)) STORED;

CREATE INDEX idx_projects_semver ON projects (semver_min, semver_max);
