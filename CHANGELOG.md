# Changelog

All notable changes to this project are documented in this file.

Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).  
Dates are in `YYYY-MM-DD` format.

---

## [Unreleased]

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
