# Changelog

All notable changes to this project are documented in this file.

Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).  
Dates are in `YYYY-MM-DD` format.

---

## [Unreleased]

### Added

#### Stale-Massen-Übersetzung — alle veralteten Module per Knopfdruck neu übersetzen
- **`server/routes/ai.js`** — neuer Endpoint `GET /ai/stale-machine-names?langcode=X`: liefert alle Machine-Names, deren `source_hash` nicht mehr mit dem aktuellen englischen Text übereinstimmt, direkt aus der DB (kein Pagination-Limit).
- **`flutter_client/lib/screens/dashboard/dashboard_screen.dart`** — `_showStaleBulkTranslateDialog()`: spezieller Dialog für den Stale-Filter, der alle veralteten Module vorab abruft, Gesamtanzahl und Kostenschätzung anzeigt und ohne Count-Dropdown direkt startet.
- **`_executeBulkTranslationWithNames()`** — neue Methode, die eine explizite Machine-Name-Liste in Batches à 4 an `/ai/translate-bulk` schickt; orangefarbener Progress-Dialog; aktualisiert nach Abschluss automatisch den Stale-Filter.

#### Stale-Erkennung — veraltete Übersetzungen anzeigen & beheben
- **`server/routes/projects.js`** — `/projects/:machine_name` berechnet jetzt einen MD5-Hash über `title + body.summary + body.value` und vergleicht ihn mit `translations.source_hash`. Weicht der Hash ab, liefert die API `status: 'stale'`.
- **`flutter_client/lib/screens/editor/editor_screen.dart`** — neues Feld `_isStale`; wird beim Laden gesetzt, wenn der API-Status `'stale'` ist. Bei veralteter Übersetzung öffnet sich die englische Quell-Seitenleiste automatisch.
- **`flutter_client/lib/screens/editor/_editor_build_methods.dart`** — orangefarbener „Veraltet — Details"-Button in der Editor-Toolbar; öffnet `_showStaleDialog()`. Neue Methode `_useEnglishSource()` ersetzt Zusammenfassung und Body mit dem aktuellen englischen Original und setzt `_isStale` zurück.

#### Diff-Ansicht — Übersetzung vs. englische Quelle
- **`flutter_client/lib/utils/diff_utils.dart`** — Wort-Diff-Algorithmus (`DiffSpan`, `DiffOp`: equal / insert / delete). Liefert eine Liste von `DiffSpan`-Objekten für zwei Texte.
- **`flutter_client/lib/widgets/diff_view.dart`** — `DiffView`-Widget (inline farbkodierter Diff) und `showDiffSheet()` (Bottom-Sheet mit zweispaltigem Vergleich). Grün = Einfügung, Rot = Löschung.
- **`flutter_client/lib/screens/review/review_screen.dart`** — neuer „DIFF"-Button im Review-Screen-Header: öffnet `showDiffSheet()` mit Übersetzung (links) vs. englischer Quelle (rechts).

#### Debug-Sync-Endpunkte (geschützt via `PB_DEBUG_KEY`)
- **`server/routes/sync.js`** — drei neue Routen, nur erreichbar mit korrektem `X-PB-Debug-Key`-Header:
  - `GET /debug/sync/inspect/:machine_name` — vergleicht DB-Stand mit Live-Daten von Drupal.org (Title, Changed, Body-Länge).
  - `POST /debug/sync/force/:machine_name` — erzwingt Einzelmodul-Sync von Drupal.org in DB + Metadaten-Verzeichnis.
  - `POST /debug/sync/quick` — führt Quick-Sync für ein konfigurierbares Zeitfenster (`days`, Standard: 7) durch und gibt ein detailliertes Log zurück.

#### Automatischer Quick-Sync alle 7,5 Tage
- **`server/index.js`** — `scheduleQuickSync()` startet einen `setInterval` (7,5 Tage) nach dem Server-Start. Überspringt automatisch, wenn bereits ein Sync läuft oder kein `lastFullSync`-Timestamp vorhanden ist.

#### App-Icons (Android / iOS / Windows)
- **`appicons/`** — vollständige Icon-Sets für alle Plattformen hinzugefügt (Android Launcher-Icons, iOS-Größen 16–1024 px, Windows Tiles, Splash Screens, Store Logo).

#### Deutsches Intro-Audio
- **`flutter_client/web/audio/crwb_de.mp3`** — deutschsprachige Audioversion des Project-Browser-Localizer-Intros (ElevenLabs-Generierung) aktualisiert.

### Fixed

#### Docker — PM2-Cluster deaktiviert
- **`server/Dockerfile`** — PM2 läuft jetzt mit `-i 1` (Single-Instance) statt `-i max`. Cluster-Modus würde konkurrierende Sync-Prozesse erzeugen, da der Sync-Status im RAM gehalten wird.

---

## [2.3.0] — 2026-06-09

### Added

#### Glossary — Wortformen (Plurale & flektierte Formen)
- **`server/migrations/007_glossary_word_forms.sql`** — neue Spalte `word_forms TEXT NULL` in `glossary_terms`. Speichert kommagetrennte flektierte Formen (Plural, Genitiv, Dativ usw.), z.B. `"Inhalte,Inhalts,Inhalten"`.
- **`server/routes/glossary.js`** — GET normalisiert `word_forms` von Komma-String zu Array; POST/PUT nehmen ein `word_forms`-Array entgegen, speichern als String, geben in der Antwort wieder Array zurück.
- **`flutter_client/web/index.html`** — `_ckApplyGlossaryMarkers` baut pro Term eine RegExp-Alternation aus `source_word` + allen `word_forms`: `\b(Inhalt|Inhalte|Inhalts|Inhalten)\b`. Die exakte gematchte Form wird als `encodeURIComponent`-kodiertes Segment in den Marker-Namen geschrieben (`glossaryTerm:<id>:<uid>:<encodedForm>`).
- **`GlossaryHighlightPlugin`** — dekodiert die gematchte Form aus dem Marker-Namen und schreibt sie als `data-matched`-Attribut ans Highlight-`<span>`. Zusätzlich zu den bestehenden `data-preferred` und `data-explanation`.
- **Glossar-Tooltip** — zeigt jetzt die konkrete im Text gefundene Wortform an:
  - *Flektierte Form* (z.B. „Inhalte"): kleiner weißer Label „Inhalte" + Pfeil „↓ bevorzugte Übersetzung" + lila/fett „Inhalt".
  - *Grundform* (matched == preferred): nur die Grundform lila/fett, kein Pfeil.
- **`flutter_client/lib/screens/glossary/glossary_screen.dart`** — Chip-UI für Wortformen im Bearbeitungsdialog: Textfeld + „+"-Button zum Hinzufügen, „✕"-Chips zum Entfernen. In der Tabellenzeile werden Wortformen als kleinere Amber-Mini-Chips neben dem Grundform-Badge angezeigt.

#### Einstellung: Automatische Absatzformatierung (Auto-P)
- **`flutter_client/lib/providers/theme_provider.dart`** — neues Feld `autoAutop: bool` in `ThemeState`, persistiert als `pb-autoAutop` in `SharedPreferences`. Standard: `false`. Neue Methode `setAutoAutop(bool)`.
- **`flutter_client/lib/screens/settings/settings_screen.dart`** — Switch-Toggle im Bereich „Workflow & Spaß", direkt unter dem Large-UI-Toggle. Zweisprachig: DE „Automatische Absatzformatierung (¶ Auto-P)" / EN „Automatic Paragraph Formatting (¶ Auto-P)".
- **`flutter_client/lib/screens/review/review_screen.dart`** — am Ende von `_fetchData()`, nachdem alle Felder mit Inhalt befüllt wurden, wird `_autop()` automatisch auf Summary und Body angewendet, wenn `themeState.autoAutop == true`. Identisches Verhalten zum manuellen ¶-Button, aber ohne Snackbar-Meldung.

### Fixed

#### CKEditor — Init-Race-Condition
- **`flutter_client/web/index.html`** (`_ckBridge.init`) — `document.getElementById('cke_editor_<id>')` wird jetzt bis zu 10× mit 200 ms Abstand wiederholt, falls das DOM-Element beim ersten Aufruf noch nicht im Dokument ist. Zusätzlicher Retry (bis zu 3×, 500 ms) bei `ClassicEditor.create()`-Rejection.
- **`flutter_client/lib/widgets/ckeditor_field_web_impl.dart`** — 3-Sekunden-Safety-Net: falls `onReady` nach dem `bridge.init`-Aufruf nie feuert, wird der Editor zerstört und neu initialisiert. `didUpdateWidget` aktualisiert `_lastContent` nun immer, auch wenn `_editorReady` noch `false` ist.

#### Glossar-Tooltip — Stabilität (mouseover/mouseout)
- **`flutter_client/web/index.html`** — `mouseover`- und `mouseout`-Handler nutzen jetzt `relatedTarget`, um zu prüfen ob die Maus den Highlight-Span wirklich verlässt. Interne Bewegungen innerhalb des Spans lösen kein Hide mehr aus. `clearTimeout` wird im `mouseover`-Handler nur noch aufgerufen wenn die Maus tatsächlich über einem Highlight-Element ist.

---

## [2.2.0] — 2026-06-02

### Added

#### DeepL Integration
- **`POST /ai/deepl-translate`** — translates a single module's summary and body via the DeepL API using the authenticated user's personal `deepl_api_key`. Automatically selects `api-free.deepl.com` for keys ending in `:fx` and `api.deepl.com` for Pro keys. Sends `tag_handling: 'html'` to preserve markup. Saves the result as both a `translations` record and a `translation_suggestions` row (type `'deepl'`).
- **`GET /ai/deepl-usage`** — proxies a call to `GET /v2/usage` on the DeepL API with the user's key. Returns `character_count`, `character_limit`, and (for Pro accounts) per-product breakdowns and billing period timestamps. Used by the sidebar usage widget.
- **DeepL sidebar widget** (`_DeeplUsageWidget`) — shown in the navigation sidebar whenever the logged-in user has a `deepl_api_key` stored in their profile. Displays a colour-coded progress bar (green → amber → red at 70 %/90 %) plus formatted character counts. Has a manual refresh button. For unlimited keys, shows "unbegrenzt / unlimited" instead of a bar.
- **`server/migrations/006_suggestion_type_deepl.sql`** — extends the `suggestion_type` ENUM on `translation_suggestions` from `('ai','manual')` to `('ai','manual','deepl')`. This migration caused the original 500 error ("Data truncated") and is now applied automatically on server start.
- **DeepL button in Editor** — joins the existing Gemini and DeepL buttons in the translation pane header. Disabled while any other AI translation is in progress.
- **`User-Agent: PBTranslationHub/1.0`** header added to all DeepL API requests (`/v2/translate` and `/v2/usage`) as required by the DeepL API guidelines.

#### Review Screen — Tablet Layout
- **`_buildReviewHeaderTablet`** — new responsive header variant for screen widths between 600 dp and 1099 dp (covers the BEYNIVAN M986-EEA tablet at ~1000 dp landscape). Identical one-row layout to the desktop header, but keyboard-shortcut hints (`Strg+→`, `Strg+Enter`) are omitted from button labels to prevent overflow.

#### Editor — Off-Canvas Source Pane
- **Clipboard/Prompt button** added to the "Englische Quelle" off-canvas drawer header, identical to the PROMPT button already present in the Review Screen header. Copies `buildTranslationPrompt(…)` with the current English source text.

#### Translation Prompt Improvements
- Labels `"Summary:"` and `"Main Description:"` removed from the copied clipboard text; the two blocks are now separated by a blank line and a bare `---` separator. The AI instruction still explains that the first block is the summary and the second is the body.
- Explicit rule added: **do not wrap output in markdown code fences** (no triple backtick html blocks). Fixes Gemini/Deepseek returning fenced code blocks instead of raw HTML.

#### Ignored Modules — Bulk Unignore
- **`DELETE /projects/ignore-all`** — new server endpoint (auth required). Deletes all rows from `ignored_projects` and returns `{success, count}`.
- **Dashboard "Alle wieder einreihen" button** — appears only when the "Ignoriert" filter is active. Opens a language-aware confirmation dialog (DE/EN). On confirm, calls the bulk-unignore endpoint and switches the filter to "all".
- **Editor "Einreihen" button** — shown in the editor header whenever `meta.is_ignored === true` for the current module. Calls `DELETE /projects/:name/ignore` for the single module.

#### Login Screen — Image Slideshow
- **Manual image slider** with `‹`/`›` navigation arrows, animated progress dots, and crossfade transitions. Each `›` click either shows the next cached slide or fetches a new image from `/unsplash/random-bg`.
- **Auto-play toggle** button above the dots; starts/stops a 6-second auto-advance timer (uses the same lazy-fetch mechanism to avoid unnecessary API calls).
- **Mandatory Unsplash attribution** shown bottom-left for every API-sourced image: photographer name and "Unsplash" both link with `?utm_source=pb_translation_hub&utm_medium=referral` to comply with Unsplash API terms and maintain Production-tier access (50,000 requests/hour).

#### Themes
- **Pearl theme** (`'pearl'`) — clean flat design with solid lavender background (`#ECE8F9`, 100 % opaque overlay), pure white cards, minimal blur (`glassBlur: 1.0`), and soft purple accent (`#8B7FD4`). Replaces the former "Hell/Light" theme.
- **Stage theme** (`'stage'`) — concert/event aesthetic: dark smaragd-teal background (`#0C2222`), warm orange accent (`#F58620`), 80 % teal overlay. Background keyword: `concert,neon,stage,festival,dark`.
- **"Hell/Light" button** in the sidebar and Settings now maps to `pearl` (the internal theme ID). Users who had `light` saved in `SharedPreferences` are automatically migrated to `pearl` on next load.

#### Review List Screen — Toolbar
- **"Aktualisieren / Refresh"** and **"Freigaben zurücksetzen / Reset published"** moved from floating icon buttons in the page header into the search toolbar. Both are now `OutlinedButton.icon` with visible labels and loading spinners.

### Fixed
- **DeepL 500 error** — inserting a suggestion with `suggestion_type = 'deepl'` truncated the ENUM column. Fixed by migration 006.
- **Light-theme readability** — `GlassContainer` sections in the Study and Help screens used `Colors.white.withValues(alpha: 0.04)` backgrounds (invisible on light). All hardcoded near-transparent white containers replaced with `attrs.bgCard`.
- **Keyboard-chip visibility** in Help screen (Shortcut section) — `Colors.white.withOpacity(0.1)` backgrounds replaced with `attrs.bgInput` / `attrs.borderMain`.

---

## [2.1.0] — 2026-06-02

### Added

#### Glossary Term Highlighting (CKEditor 5 Plugin)
- **`server/migrations/005_create_glossary_terms.sql`** — new `glossary_terms` table (`id`, `lang_code`, `source_word`, `preferred_word`, `explanation`, `created_by`, timestamps). Indexed on `lang_code` and `source_word`.
- **`server/routes/glossary.js`** — REST API: `GET /glossary` (filterable by `?langcode=`), `POST /glossary`, `PUT /glossary/:id`, `DELETE /glossary/:id`. Write endpoints require `reviewer` or `admin` role.
- **`GlossaryHighlightPlugin`** in `web/index.html` — CKEditor 5 plugin using `markerToHighlight` (editing-only, never pollutes `getData()`). Markers carry `affectsData: false` so undo/redo ignores them.
- **`_ckApplyGlossaryMarkers(editor)`** — applies `glossaryTerm:<id>:<uid>` model markers to every block element; uses `\b` word-boundary regex (case-insensitive). Runs inside `model.change()`.
- **`_ckBridge.setGlobalGlossary(termsJson)`** — global glossary store. Calling this method re-applies markers in all active CKEditor instances immediately.
- **Floating tooltip** (`#_ck_glossary_tip`) — appears on hover over `.ck-glossary-highlight` spans; shows preferred translation and explanation. Positioned to stay within the viewport.
- **`flutter_client/lib/utils/ck_glossary.dart`** — shared Dart utilities:
  - `loadCkEditorGlossary(api, langcode)` — fetches `/glossary` and calls `setGlobalGlossary` on the bridge. Called from both `ReviewScreen` and `EditorScreen` on mount and language change.
  - `setCkEditorTheme(themeId)` — sets CSS custom properties on `#_ck_glossary_tip` and `:root` via `dart:html` directly (no JS bridge needed). Covers all 5 themes.
- **`flutter_client/lib/screens/glossary/glossary_screen.dart`** — management UI for glossary terms. Reviewers and admins can add, edit, and delete terms. Shows the current target language's terms with source word, preferred translation, and explanation. Accessible via sidebar navigation item.
- **Glossary loading in `EditorScreen`** — `_loadGlossary()` added (was previously only in `ReviewScreen`); triggered 400 ms after `initState` and on language change via `ref.listen`.
- **Glossary loading in `ReviewScreen`** — refactored to call shared `loadCkEditorGlossary`; also triggered on language change.
- **Markers re-applied after `setData`** — a 300 ms debounced call to `_ckApplyGlossaryMarkers` runs inside the `change:data` listener so markers are refreshed after any content change.

#### Theme-aware Glossary Styling
- **CSS custom properties** `--ck-hl-bg` and `--ck-hl-border` on `:root` control the highlight mark colour; `--tip-*` variables on `#_ck_glossary_tip` control the floating tooltip. Both are updated by `setCkEditorTheme()`.
- **Per-theme colour sets** in `ck_glossary.dart`: dark (amber highlight, purple tooltip), light (purple highlight + tooltip), glassy (cyan), nature (green), liquid (sky-blue).
- **`app_layout.dart`** calls `setCkEditorTheme(themeState.themeId)` on every `build()` — tooltip and highlight colours update instantly when the user switches themes.

#### Developer Experience
- **`api_client.dart` WSL / non-standard-port detection** — `baseUrl` and `serverOrigin` now recognise any non-standard port (not 80/443) as a development environment, resolving to `host:9901`. Previously only `localhost` / `127.0.0.1` were detected, causing login failures when accessing via WSL IP.

#### Logging & Diagnostics
- **`LogService`** (`lib/services/log_service.dart`) — in-memory ring buffer for `INFO` / `WARNING` / `ERROR` entries with timestamps and optional details. Integrates into Dio interceptors.
- **Log download** (`lib/services/log_downloader_web.dart` / `_stub.dart`) — exports the log buffer as a JSON file via a `dart:html` Blob download on web.

#### Audio Player
- **`audio_player_web.dart` / `audio_player_stub.dart`** — conditional import wrapping `dart:html AudioElement` for web. Used by the CRWB Study Screen for TTS audio playback without native dependencies.

#### CKEditor 5 Web Implementation
- **`ckeditor_field_web_impl.dart`** — full web-only CKEditor 5 implementation extracted from `ckeditor_field.dart`. Registered via `ui_web.platformViewRegistry`. Handles `init`, `setData`, `destroy`, suppression CSS, and `didUpdateWidget` pushes.
- **`ckeditor_field_stub.dart`** — non-web stub that satisfies the conditional import on desktop.

### Fixed
- **Glossary markers not shown in `EditorScreen`** — `loadCkEditorGlossary` was only called from `ReviewScreen`. Now also called from `EditorScreen`.

---

## [2.0.0] — 2026-05-31

### Breaking Changes
- **User Management System** — users now have a `user_type` (`translator` / `reviewer`) and an `is_active` flag. Existing users in the database must have `is_active = 1` set manually if they were created before this release, or re-activated via the admin panel.
- **Role-based Review Queue Access** — users with `user_type = 'translator'` can no longer access the review queue. The router redirects them to the dashboard, and the server returns HTTP 403 on review endpoints.
- **DB Migrations Required** — migrations `003_users_registration_fields.sql` and `004_users_requested_role.sql` add new columns to the `users` table. The migration runner applies them automatically on server start.

### Added
- **4-step Registration Wizard** (`register_screen.dart`) — self-service account creation: Account → Role → Languages → API Keys. Registration can be disabled globally via `site_settings.registration_enabled`.
- **Pending Users Panel** — admin screen listing accounts with `is_active = 0`. Admins assign a role (`translator` / `reviewer`) and activate each account. A badge appears next to users who requested the `reviewer` role.
- **Active Users Panel** — admin screen listing accounts with `is_active = 1`. Admins can deactivate (ban) or permanently delete users.
- **`GET /auth/registration-status`** — public endpoint; returns `{ enabled: true/false }`.
- **`GET /admin/users/active`** — list active users.
- **`PATCH /admin/users/:id/deactivate`** — deactivate an active user.
- **Confetti** — `confetti` package integrated. `ConfettiController` in editor and review screens fires on save/approve. A 900 ms navigation delay ensures the animation is visible before the route changes. Toggle in Settings screen.
- **Splash Screen** — `lib/widgets/splash_screen.dart` (Flutter widget) + HTML preloader in `web/index.html`. Minimum display time 2200 ms. Dismisses on the `flutter-first-frame` event.
- **Logo** — `assets/images/logo.png` displayed in the sidebar (44×44) and topbar mini logo (34×34). App name changed from "TRANSLATION SUITE" to "TRANSLATION HUB".
- **Bilingual Filter Buttons** — each dashboard filter shows the German label (bold, 13 px) and the English label (grey, 10 px) stacked vertically.
- **Split Diff View** — `review_diff_view.dart`: original text on top (red-tinted background), corrected text below (green-tinted). Replaces the previous overlapping diff display.
- **Optimistic Navigation in Review Screen** — `_goToNextReview()` is synchronous (`void`); the save POST runs in the background while the app immediately navigates to the next item in the queue.
- **`inheritedQueue` in Review Screen** — the full review queue is passed from `review_list_screen.dart` to `review_screen.dart` to eliminate the race condition that caused duplicate modules to appear.
- **Review List Shows Translated Titles** — `review_list_screen.dart` uses `meta.translation.title` and `meta.translation.summary` instead of the English originals, so reviewers see the target-language content.
- **`review_sidebar.dart` as `StatefulWidget`** — sidebar has an internal `_showSourceCode` toggle to switch between rendered preview and raw HTML source view. Includes a copy-to-clipboard button.
- **Off-Canvas Toggle Button Moved to Left** — the review screen sidebar toggle button is now on the left side of the header.
- **English Source Removed from Main Editor Area** — in the review screen, the English source is shown exclusively inside the sidebar. The "Visual Comparison" and "Source Code" tabs have been removed; only "Direct Editor" and "Preview" tabs remain. The "Compare Only" button has been removed.
- **Sync Progress Shows Real Total** — `total` is read from `meta.count` in the first Drupal.org API response. The progress bar shows "X modules …" while the total is not yet known, then switches to "X / Y" once the first page responds.
- **DB Migration System** — `server/db_migrate.js` + `server/migrations/NNN_*.sql`. Tracks applied versions in `schema_migrations`. Runs automatically on server start. Exits with code 1 on failure.
- **New DB Columns** — `users.target_languages` (JSON array), `users.user_type` (ENUM), `users.requested_role` (VARCHAR), `users.deepl_api_key` (VARCHAR), `projects.changed` (BIGINT).
- **`deploy.sh` Rolling Restart** — server and client containers are rebuilt without taking the database offline. No `docker compose down`.
- **`deploy.sh --db-backup` Flag** — creates a compressed `mysqldump` in `~/backups/` before the deploy begins.
- **Migrations Log in deploy.sh** — the deploy script waits for the server container log to confirm that migrations completed successfully.
- **`watch_stale.sh`** — shell script to monitor stale translations on the server.
- **New Flutter files:** `register_screen.dart`, `splash_screen.dart`, `page_transition.dart`.
- **New server files:** `db_migrate.js`, `migrations/001–004_*.sql`, `watch_stale.sh`.

### Changed
- **Bulk Translation Limit** — reduced from 200 to 150 modules per request for improved server stability.
- **Dio `receiveTimeout` for Bulk Route** — increased to 10 minutes to accommodate large bulk translation batches.
- **Server Response Performance** — `res.json()` is sent immediately after the DB write. `fs.writeJson` (file-system backup) runs asynchronously in the background.

### Fixed
- **Duplicate Modules in Review Queue** — caused by a race condition where the review screen fetched the queue independently from the list screen. Queue is now passed as `inheritedQueue`.
- **Sync Progress Showing "1731 / 100"** — the total was hardcoded to 100. It is now read from `meta.count` in the first API response.
- **Confetti Not Visible in Review Screen** — immediate navigation after approval left no time for the animation. A 900 ms delay is now applied before navigation.
- **Splash Screen Logo Not Visible** — `frameBuilder` was not used for the async asset image, causing the logo to be invisible during the first frame. Fixed with proper async asset loading.
- **Review Cards Showing English Text** — `review_list_screen.dart` now reads titles and summaries from `meta.translation` instead of the English `attributes`.

---

## [1.5.0] — 2026-05-25

### Changed
- **Fleather replaces Quill.js as the WYSIWYG editor** across the entire Flutter client.
  - Added `fleather: ^1.26.0` and `parchment: ^1.25.1` to `pubspec.yaml`.
  - Removed the Quill CDN `<link>` and `<script>` tags from `web/index.html`.
  - `editor_html_toolbar.dart` rewritten — now takes a `FleatherController` instead of
    an `onExecCommand` callback. Toolbar buttons use `ParchmentStyle.containsSame()` /
    `controller.formatSelection()` for proper toggle semantics on every attribute.
  - `_editor_quill_bridge.dart` (part file) rewritten into a pure HTML-utility file;
    all DOM / `dart:html` Quill bridge code removed.
  - `editor_screen.dart` migrated to `FleatherController` + `FleatherEditor` for both
    the Summary and Body fields. `TextEditingController` remains the HTML source-of-truth
    for API saving; a listener on `FleatherController` auto-encodes the Parchment document
    to HTML via `ParchmentHtmlCodec` on every edit.
  - `_editor_build_methods.dart` rewritten — visual containers now use `FleatherTheme` +
    `FleatherEditor` (dark theme, all required `FleatherThemeData` fields). Fixed-height
    `SizedBox` wrappers replaced with `constraints: BoxConstraints(minHeight: …)` so
    editors grow with content.
  - `review_screen.dart` fully migrated: Quill visual-editor `HtmlElementView` platform
    views removed; `FleatherEditor` inserted in their place. CodeMirror HTML source iframes
    retained for the source-view toggle. The `quill-change` DOM event listener, `_execCommand`,
    `_setJsPendingContent`, and all `_syncHtmlToReviewIFrame`/`_syncHtmlToReviewVisual`
    calls replaced by `_reloadFleatherControllers()` and `_syncToSourceIFrame()`.

### Removed
- Quill.js CDN dependencies (`quill.snow.css`, `quill.js` 1.3.6) — no longer loaded.
- All `dart:html`-based `document.createElement` / `ScriptElement` hacks that were used
  to pass content into Quill iframes.

---

## [1.4.0] — 2026-05-24

### Added
- **"Can't Read, Won't Buy" study screen** (`lib/screens/help/crwb_study_screen.dart`)
  — All 32 pages of the Common Sense Advisory (2006) study embedded as native Flutter
  content. The screen is always available offline and is independent of the external
  PDF URL. Content includes: Executive Summary, survey demographics (2,430 consumers /
  8 countries), all 8 key findings with animated bar charts, the visitor abandonment
  funnel (expandable tiles), four conclusion cards, and a formal citation block.
- Route `/help/crwb` registered in GoRouter (inside the authenticated ShellRoute).
- **Video panel error/loading states** in `HelpScreen` — a skeleton spinner is shown
  while the server responds; an amber warning banner replaces the empty space when the
  server is unreachable or `HELP_VIDEO_DE` / `HELP_VIDEO_EN` are not set in `.env`.

### Changed
- "Originalstudie lesen (PDF)" button in `HelpScreen` now navigates to `/help/crwb`
  (internal screen) instead of opening the external PDF URL.
- `help_screen.dart` now imports `go_router` for `context.push()`; the unused
  `TokenStorage` import was removed.

---

## [1.3.1] — 2026-05-24

### Fixed
- **Help screen keyboard shortcuts corrected** — three shortcuts (`Ctrl+Alt+K`, `Ctrl+Alt+H`, `Ctrl+Alt+O`) that have never been implemented in the editor were removed from the shortcuts panel.
- **Preview shortcut modifier corrected** — help screen now shows `Alt+P` (not `Ctrl+Alt+P`) for "Toggle Preview", matching the actual binding in `editor_screen.dart`.

### Changed
- `_shortcutRow()` in `HelpScreen` accepts an optional `showCtrl` parameter for rows with non-standard modifiers.
- Removed the "All shortcuts use CTRL + ALT" claim from the shortcuts panel description.

---

## [1.3.0] — 2026-05-24

### Added
- **`ModuleLogo` widget** (`lib/widgets/module_logo.dart`) — unified, CORS-safe module
  logo loader with a 3-level cascade: primary `logoUrl` → `fallbackLogoUrl` → letter avatar.

### Fixed
- **Project card logos invisible in browser** — all logo requests now go through `/api/image-proxy`.
- **Letter fallback for modules with broken GitLab avatar** — modules without a GitLab repository now show the `project_browser` logo via the `fallbackLogoUrl` cascade.

---

## [1.2.0] — 2026-05-22

### Added
- **Dashboard filter wrapping** — filter buttons use a `Wrap` widget; flow to a second line on tablet portrait viewports (~768 px).
- **Android 14 support** — `targetSdk = 34`; `INTERNET` permission and `android:enableOnBackInvokedCallback="true"` added.

### Changed
- **AI Bulk Translation dialog — progress messages** — progress now reports module numbers instead of batch numbers.
- **AI Bulk Translation dialog — defaults** — default selection changed from 24 to 25; option list changed to `[25, 50, 100, 200]`.
- **Profile screen** — removed the redundant "Max Batch Size" slider (the control in the AI dialog is sufficient).

### Fixed
- **`dart analyze` warnings** — removed unused variables; fixed `activeColor` → `activeThumbColor` on `Switch` widgets.

---

## [1.1.0] — 2026-05-20

### Added
- **`CachedNetworkImage` throughout** — replaced every `Image.network()` call.
- **`RepaintBoundary` on background images** — login screen and app layout backgrounds isolated from main render tree.
- **Help screen** (`screens/help/help_screen.dart`) — GDPR-compliant help center with consent-gated YouTube video embeds.

### Changed
- **`Color.withOpacity()` → `.withValues(alpha:)`** — migrated all Flutter color opacity calls to the non-deprecated API.

### Fixed
- **`GlassContainer` broken opacity** — `.withValues(alpha: )` (empty value) fixed to `0.1`.

---

## [1.0.0] — 2026-04-xx

### Added
- **Flutter client** — full replacement of the previous React client. Built with Riverpod, GoRouter, Dio, and a Glassmorphism dark-mode-first UI.
- **Server modularisation** — `server/index.js` split into separate route modules.
- **ProxyManager** — `is_reviewed` quality gate, URL normalization, port-detection logic.
- **MariaDB** as primary data store, replacing the previous SQLite setup.
- **Docker Compose** three-service stack (`db`, `server`, `client`).
- **`deploy.sh`** — automated rsync + Docker build + hot-swap script; supports `--client-only` flag.

---

## Version numbering

Versions follow [Semantic Versioning](https://semver.org/):
- **MAJOR** — breaking changes to the Shadow API contract, DB schema, or access control model
- **MINOR** — new features, new endpoints, new UI screens
- **PATCH** — bug fixes, performance improvements, documentation updates
