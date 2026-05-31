#!/bin/bash
# Überwacht in Echtzeit welche Module durch einen Sync stale werden
# Aufruf: bash watch_stale.sh

MYSQL="mysql -u pb_hub -pdrupal pb_translation_hub --silent --skip-column-names"
STALE_QUERY="SELECT COUNT(*) FROM projects p
  JOIN translations t ON p.machine_name = t.machine_name AND t.langcode = 'de'
  WHERE t.source_hash IS NOT NULL AND t.source_hash != ''
  AND MD5(CONCAT(
    IFNULL(JSON_UNQUOTE(JSON_EXTRACT(p.data,'$.attributes.title')),''),
    IFNULL(JSON_UNQUOTE(JSON_EXTRACT(p.data,'$.attributes.body.summary')),''),
    IFNULL(JSON_UNQUOTE(JSON_EXTRACT(p.data,'$.attributes.body.value')),'')))
  != t.source_hash"

DETAIL_QUERY="SELECT p.machine_name, p.title,
  SUBSTRING(t.source_hash,1,8) as hash_alt,
  SUBSTRING(MD5(CONCAT(
    IFNULL(JSON_UNQUOTE(JSON_EXTRACT(p.data,'$.attributes.title')),''),
    IFNULL(JSON_UNQUOTE(JSON_EXTRACT(p.data,'$.attributes.body.summary')),''),
    IFNULL(JSON_UNQUOTE(JSON_EXTRACT(p.data,'$.attributes.body.value')),''
  ))),1,8) as hash_neu,
  p.changed
  FROM projects p
  JOIN translations t ON p.machine_name = t.machine_name AND t.langcode = 'de'
  WHERE t.source_hash IS NOT NULL AND t.source_hash != ''
  AND MD5(CONCAT(
    IFNULL(JSON_UNQUOTE(JSON_EXTRACT(p.data,'$.attributes.title')),''),
    IFNULL(JSON_UNQUOTE(JSON_EXTRACT(p.data,'$.attributes.body.summary')),''),
    IFNULL(JSON_UNQUOTE(JSON_EXTRACT(p.data,'$.attributes.body.value')),'')))
  != t.source_hash
  ORDER BY p.changed DESC
  LIMIT 30"

echo "=== Stale-Watch gestartet $(date '+%H:%M:%S') ==="
echo ""

INITIAL=$($MYSQL -e "$STALE_QUERY" 2>/dev/null)
echo "Stale-Module vor Sync: $INITIAL"
echo ""
echo "Überwache DB alle 3 Sekunden..."
echo "────────────────────────────────────────────────────────"

LAST=$INITIAL

while true; do
  NOW=$($MYSQL -e "$STALE_QUERY" 2>/dev/null)

  if [ "$NOW" != "$LAST" ]; then
    TS=$(date '+%H:%M:%S')
    DIFF=$((NOW - LAST))

    if [ "$DIFF" -gt 0 ]; then
      echo ""
      echo "[$TS] ▲ +$DIFF neue Stale-Module (gesamt: $NOW)"
      echo "--- Details (neueste zuerst) ---"
      $MYSQL -e "$DETAIL_QUERY" 2>/dev/null | while IFS=$'\t' read -r machine title hash_alt hash_neu changed; do
        echo "  • $machine | \"$title\""
        echo "    hash: $hash_alt... → $hash_neu... | drupal.org changed: $changed"
      done
      echo "────────────────────────────────────────────────────────"
    else
      echo "[$TS] ▼ $DIFF Stale-Module (gesamt: $NOW) — evtl. Übersetzungen aktualisiert"
    fi
    LAST=$NOW
  fi

  sleep 3
done
