# /incident-report — Write Incident Report

Draft a structured post-mortem (incident report) for the incident described in `$ARGUMENTS`.

## What to do

1. **Structure the report**:
   - **Summary** — one paragraph: what happened, impact, duration
   - **Timeline** — bullet list of events with timestamps (use relative times if exact times unknown)
   - **Root Cause** — the single underlying technical cause (not the symptom)
   - **Contributing Factors** — secondary conditions that made the impact worse
   - **Detection** — how was it found? (monitoring alert, user report, etc.)
   - **Resolution** — what fixed it?
   - **Action Items** — 3-5 concrete follow-up tasks with owners and due dates
2. **Use blameless language** — focus on systems and processes, not individuals.
3. **Save to** `docs/incidents/YYYY-MM-DD-<slug>.md`.

## Behavior notes

- Action items must be specific and measurable ("Add PagerDuty alert for queue depth > 1000" not "improve monitoring").
- Severity classification: SEV1 (total outage), SEV2 (major degraded), SEV3 (minor/partial).
