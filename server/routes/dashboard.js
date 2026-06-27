const express = require('express');

// Analyse-Dashboard-Endpoints.
//
// Kompatibilität pro Drupal-Version und Übersetzungsbedarf liefert bereits
// /api/projects/filter-counts (version_counts). Hier kommt nur der historische
// Wochen-Verlauf aus der Tabelle sync_events (Migration 009) hinzu.

module.exports = (ctx) => {
  const { db } = ctx;
  const router = express.Router();

  // Wie viele Module pro Woche pro Modulliste je Event-Typ.
  // Query: ?type=new_description|stale & weeks=12 & langcode=de
  //
  //   new_description = new_module + description_changed (Modul-Ebene)
  //   stale           = veraltete Übersetzungen (optional nach langcode gefiltert)
  router.get('/dashboard/weekly', async (req, res) => {
    const type = req.query.type === 'stale' ? 'stale' : 'new_description';
    let weeks = parseInt(req.query.weeks, 10);
    if (!Number.isFinite(weeks) || weeks < 1) weeks = 12;
    if (weeks > 104) weeks = 104;
    const langcode = req.query.langcode || null;

    // Cutoff: Montag der Woche vor `weeks` Wochen.
    const cutoff = new Date();
    cutoff.setUTCDate(cutoff.getUTCDate() - weeks * 7);
    const cutoffStr = cutoff.toISOString().slice(0, 10);

    const MODULES_CAP = 500; // pro Woche im Payload begrenzen

    try {
      const eventTypes = type === 'stale'
        ? ['stale']
        : ['new_module', 'description_changed'];
      const placeholders = eventTypes.map(() => '?').join(',');

      let sql = `
        SELECT machine_name, langcode,
               DATE_SUB(event_date, INTERVAL WEEKDAY(event_date) DAY) AS week_start
        FROM sync_events
        WHERE event_type IN (${placeholders})
          AND event_date >= ?
      `;
      const params = [...eventTypes, cutoffStr];

      if (type === 'stale' && langcode) {
        sql += ' AND langcode = ? ';
        params.push(langcode);
      }
      sql += ' ORDER BY week_start DESC, machine_name ASC ';

      const [rows] = await db.execute(sql, params);

      // Pro Woche distinct machine_names sammeln.
      const buckets = new Map(); // week_start(ISO) -> Set<machine_name>
      for (const r of rows) {
        const wk = r.week_start instanceof Date
          ? r.week_start.toISOString().slice(0, 10)
          : String(r.week_start).slice(0, 10);
        if (!buckets.has(wk)) buckets.set(wk, new Set());
        buckets.get(wk).add(r.machine_name);
      }

      const weeksOut = [...buckets.entries()]
        .sort((a, b) => (a[0] < b[0] ? 1 : -1)) // neueste zuerst
        .map(([week_start, set]) => {
          const all = [...set];
          return {
            week_start,
            count: all.length,
            modules: all.slice(0, MODULES_CAP),
            truncated: all.length > MODULES_CAP,
          };
        });

      res.json({ type, weeks, langcode: type === 'stale' ? langcode : null, data: weeksOut });
    } catch (error) {
      console.error('Dashboard weekly error:', error);
      res.status(500).json({ error: 'Failed to fetch weekly dashboard data' });
    }
  });

  return router;
};
