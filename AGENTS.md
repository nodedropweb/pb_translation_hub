# AGENTS.md — Developer & AI Agent Reference

Technical map of the PB Translation Hub for developers and AI coding agents.

---

## Stack

| Layer | Technology |
|---|---|
| Frontend | Flutter (Dart) — web, desktop, and tablet |
| Backend | Node.js (Express) |
| Database | MariaDB (primary) + JSON file backups |
| AI | Google Gemini (bulk translation) |
| Production serving | Nginx (Docker, port 5173) |

---

## Repository Layout

```
pb_translation_hub/
├── server/
│   ├── index.js             # Express app entry; loads routes, starts migrations
│   ├── db_migrate.js        # DB migration runner (auto-called on startup)
│   ├── migrations/          # Numbered SQL migration files
│   │   ├── 001_initial_schema.sql
│   │   ├── 002_users_deepl_key.sql
│   │   ├── 003_users_registration_fields.sql
│   │   └── 004_users_requested_role.sql
│   ├── routes/
│   │   ├── auth.js          # Login, register, registration-status
│   │   ├── projects.js      # Project list, search, single-project sync
│   │   ├── translations.js  # Save/load translations
│   │   ├── ai.js            # Bulk translation, cost estimation
│   │   ├── sync.js          # Full sync from Drupal.org
│   │   ├── admin.js         # User management (pending, active, deactivate, delete)
│   │   └── categories.js    # Category management
│   ├── migrate_to_mysql.js  # One-time JSON → MariaDB migration
│   ├── languages.json       # Supported target language list
│   ├── watch_stale.sh       # Shell script to watch for stale translations
│   ├── data/
│   │   ├── metadata/        # JSON snapshots of Drupal.org module data
│   │   └── translations/    # Per-language JSON translation backups
│   └── .env                 # Secrets (not committed; see .env.example)
├── flutter_client/
│   ├── lib/
│   │   ├── main.dart        # App entry, ProviderScope wrapper
│   │   ├── router.dart      # GoRouter declarations + role guards
│   │   ├── models/          # Data transfer objects
│   │   ├── providers/       # Riverpod state providers
│   │   │   ├── auth_provider.dart
│   │   │   ├── theme_provider.dart
│   │   │   ├── language_provider.dart
│   │   │   ├── project_provider.dart
│   │   │   └── sync_provider.dart
│   │   ├── services/        # ApiClient (Dio), TokenStorage, LogService
│   │   ├── theme/           # AppTheme, ThemeAttributes
│   │   ├── utils/           # html_sanitizer.dart, translation_prompt.dart
│   │   ├── widgets/         # Shared widgets
│   │   │   ├── glass_container.dart
│   │   │   ├── module_logo.dart
│   │   │   ├── page_transition.dart      # Animated route transition
│   │   │   ├── splash_screen.dart        # Branded splash (min 2200 ms)
│   │   │   ├── consent_youtube_player.dart
│   │   │   ├── ckeditor_field.dart
│   │   │   ├── search_with_autocomplete.dart
│   │   │   └── sync_progress_bar.dart
│   │   └── screens/
│   │       ├── auth/
│   │       │   ├── login_screen.dart
│   │       │   └── register_screen.dart  # 4-step registration wizard
│   │       ├── dashboard/
│   │       │   ├── dashboard_screen.dart
│   │       │   └── widgets/
│   │       │       ├── project_card.dart
│   │       │       └── dashboard_filters.dart  # Locale-aware filter labels (AppLocalizations)
│   │       ├── editor/
│   │       │   ├── editor_screen.dart
│   │       │   ├── _editor_build_methods.dart
│   │       │   ├── _editor_quill_bridge.dart
│   │       │   └── widgets/
│   │       │       ├── cost_calculator_dialog.dart
│   │       │       ├── editor_html_toolbar.dart
│   │       │       └── screenshot_alts_section.dart
│   │       ├── review/
│   │       │   ├── review_list_screen.dart  # Shows translated titles/summaries
│   │       │   ├── review_screen.dart       # Optimistic navigation, split diff
│   │       │   └── widgets/
│   │       │       ├── review_diff_view.dart  # Original (red) / Corrected (green)
│   │       │       └── review_sidebar.dart    # StatefulWidget with source toggle
│   │       ├── layout/
│   │       │   └── app_layout.dart  # Sidebar logo: 44×44; Topbar mini: 34×34
│   │       ├── categories/
│   │       │   └── categories_screen.dart
│   │       ├── profile/
│   │       │   └── profile_screen.dart
│   │       ├── help/
│   │       │   ├── help_screen.dart
│   │       │   └── crwb_study_screen.dart
│   │       └── settings/
│   │           └── settings_screen.dart  # Includes confetti toggle
│   ├── web/
│   │   └── index.html       # HTML preloader / splash, flutter-first-frame listener
│   ├── Dockerfile
│   └── nginx.conf
├── hubctl.sh
├── deploy.sh                # rsync + rolling restart + optional --db-backup
├── docker-compose.yml
└── server/.env.example
```

---

## Database Schema

### `projects`
| Column | Type | Notes |
|---|---|---|
| `machine_name` | VARCHAR(255) PK | Unique module identifier |
| `title` | VARCHAR(255) | Original English title |
| `data` | LONGTEXT (JSON) | Full Drupal.org metadata blob |
| `changed` | BIGINT | Unix timestamp of last Drupal.org change |
| `updated_at` | TIMESTAMP | Set on every sync |

### `translations`
| Column | Type | Notes |
|---|---|---|
| `machine_name` | VARCHAR(255) PK | FK → projects |
| `langcode` | VARCHAR(10) PK | e.g. `de`, `fr` |
| `title` | VARCHAR(255) | Translated title |
| `summary` | TEXT | Translated summary (HTML) |
| `body` | LONGTEXT | Translated body (HTML) |
| `screenshot_alts` | TEXT (JSON) | Image alt-text map |
| `source_hash` | VARCHAR(32) | MD5 of English source for stale detection |
| `is_reviewed` | TINYINT(1) | 0 = in review queue; 1 = approved for production |
| `reviewed_by` | VARCHAR(50) | Username of the reviewer |
| `updated_at` | TIMESTAMP | Last save time |

### `users`
| Column | Type | Notes |
|---|---|---|
| `id` | INT AUTO_INCREMENT PK | Internal ID |
| `username` | VARCHAR(50) UNIQUE | Login name |
| `password` | VARCHAR(255) | bcrypt hash |
| `name` | VARCHAR(100) | Display name |
| `email` | VARCHAR(100) | Email address |
| `role` | VARCHAR(20) default `'user'` | `'admin'` or `'user'` |
| `user_type` | ENUM('translator','reviewer') default `'translator'` | Determines review queue access |
| `requested_role` | VARCHAR(20) | Role requested during registration |
| `target_languages` | LONGTEXT (JSON) | Array of target languages e.g. `["de","fr"]` |
| `is_active` | TINYINT(1) default `0` | 0 = pending activation; 1 = active |
| `avatar_url` | VARCHAR(255) | Relative path under `/uploads/avatars/` |
| `google_ai_key` | VARCHAR(255) | Personal Gemini API key |
| `deepl_api_key` | VARCHAR(255) | Personal DeepL API key |
| `ai_batch_limit` | INT default `5` | Max modules per AI bulk run |
| `ai_prompt` | TEXT | Custom AI translation prompt |
| `last_reviewed_project` | VARCHAR(255) | Most recently reviewed module |
| `created_at` | TIMESTAMP | Registration time |

**Access logic:**

| `role` | `user_type` | Review Queue | Admin Panel |
|---|---|---|---|
| `admin` | — | Yes | Yes |
| `user` | `reviewer` | Yes | No |
| `user` | `translator` | No | No |

### `schema_migrations`
| Column | Type | Notes |
|---|---|---|
| `version` | VARCHAR(20) PK | Numeric version string, e.g. `003` |
| `filename` | VARCHAR(255) | Migration filename |
| `applied_at` | TIMESTAMP | Execution time |

### `priority_projects`
| Column | Type | Notes |
|---|---|---|
| `machine_name` | VARCHAR(255) PK | Module identifier |
| `list_name` | VARCHAR(50) PK | e.g. `drupal11` |

### `ignored_projects`
| Column | Type | Notes |
|---|---|---|
| `machine_name` | VARCHAR(255) PK | Module identifier |
| `langcode` | VARCHAR(10) PK | Language code |

### `site_settings`
| Column | Type | Notes |
|---|---|---|
| `setting_key` | VARCHAR(100) PK | Setting name |
| `setting_value` | TEXT | Value |

Known keys: `registration_enabled` (`'1'` / `'0'`).

---

## Server Routes

### Authentication (`routes/auth.js`)

| Method | Path | Description |
|---|---|---|
| `POST` | `/auth/login` | Login; returns JWT |
| `POST` | `/auth/register` | Create new (inactive) user account |
| `GET` | `/auth/registration-status` | Returns `{ enabled: true/false }` |

### Projects (`routes/projects.js`)

| Method | Path | Description |
|---|---|---|
| `GET` | `/api/projects` | Filtered, paginated project list; SQL-scored search |
| `GET` | `/api/projects/:machineName` | Single project with translation and suggestions |
| `POST` | `/api/sync/project/:machineName` | Single-project refresh from Drupal.org |

### Translations (`routes/translations.js`)

| Method | Path | Description |
|---|---|---|
| `POST` | `/api/translations/:machineName` | Save translation (title, summary, body) |
| `POST` | `/api/translations/:machineName/review` | Approve translation (sets `is_reviewed = 1`) |
| `GET` | `/api/translations/:machineName/suggestions` | List suggestions |
| `POST` | `/api/translations/:machineName/suggestions` | Save new suggestion |

### AI (`routes/ai.js`)

| Method | Path | Description |
|---|---|---|
| `POST` | `/api/ai/translate-bulk` | Bulk translation; max 150 modules per request |
| `POST` | `/api/ai/estimate-cost` | Token and cost estimate before bulk run |
| `POST` | `/api/ai/translate-single` | Single-module AI translation |

### Sync (`routes/sync.js`)

| Method | Path | Description |
|---|---|---|
| `POST` | `/api/sync/start` | Start full sync from Drupal.org |
| `GET` | `/api/sync/status` | Sync progress (current page, total fetched from API first-page response) |
| `POST` | `/api/sync/stop` | Stop running sync |

### Admin (`routes/admin.js`)

| Method | Path | Description |
|---|---|---|
| `GET` | `/admin/users/pending` | List users with `is_active = 0` |
| `POST` | `/admin/users/:id/activate` | Activate user; body `{ user_type }` assigns role |
| `GET` | `/admin/users/active` | List users with `is_active = 1` |
| `PATCH` | `/admin/users/:id/deactivate` | Deactivate (ban) an active user |
| `DELETE` | `/admin/users/:id` | Permanently delete a user |

### Other

| Method | Path | Description |
|---|---|---|
| `GET` | `/api/image-proxy` | Proxy external image (`?url=<encoded>`); up to 5 redirects |
| `POST` | `/api/unsplash/track-download` | Unsplash download tracking (API compliance) |
| `GET` | `/api/unsplash/random` | Fetch a random Unsplash background |
| `GET` | `/uploads/:path` | Serve uploaded files (avatars) |

---

## Key Backend Services

### `db_migrate.js`
Called at server startup before any routes are registered. Reads all `.sql` files in `server/migrations/` sorted by numeric prefix. Skips versions already in `schema_migrations`. Runs each pending migration in a transaction. Exits the process with code 1 on failure.

### `syncProjects`
Paginated fetch from `https://www.drupal.org/jsonapi/index/project_modules`. Includes a 100 ms inter-page delay — do not remove it (rate-limit compliance). The `total` count is read from the first API response (`meta.count`) and stored in `syncProvider` for accurate progress display. Writes to both MariaDB and `server/data/metadata/`.

### `GET /api/projects`
SQL-backed filtered list. Uses joins to resolve status (`missing` / `translated` / `stale`). In-SQL search scoring: exact > prefix > contains. Translators and reviewers both see the same list; the router guards control who can open the review screen.

### `POST /api/ai/translate-bulk`
Accepts `{ machineNames, langcode }`. Capped at 150 modules per call. The `receiveTimeout` on the Dio client for this route is set to 10 minutes. Orchestrates Gemini translation for title, summary, and body. Saves results as **Suggestions** (not live translations). Supports cancellation via per-request abort signals.

### Performance: `res.json()` before file write
For translation save endpoints, the JSON response is sent to the client immediately after the DB write completes. The file-system JSON backup (`fs.writeJson`) runs asynchronously in the background. This keeps the API response fast without sacrificing data durability.

---

## Flutter Client Guidelines

### Role guards in router.dart
The GoRouter in `lib/router.dart` checks the user's `user_type` from `authProvider` for all `/review*` routes. Users with `user_type == 'translator'` are redirected to `/` with a toast message. Admins bypass the check.

### Theme attributes — never hardcode colors
```dart
final themeState = ref.watch(themeProvider);
final attrs = AppTheme.getAttributes(themeState.themeId);
// Use: attrs.brand600, attrs.bgCard, attrs.textMain, attrs.borderMain, etc.
```

### Adding a new screen
1. Create `lib/screens/<domain>/<screen>_screen.dart`.
2. Register the route in `lib/router.dart`.
3. Add role guard if the screen requires reviewer/admin access.
4. Do not use `const` on widgets that consume `attrs` values.

### All network images must use the server proxy
Never pass an external URL directly to `Image.network()` or `CachedNetworkImage`.
Always route through the proxy:
```dart
ApiClient.proxyImageUrl('https://git.drupalcode.org/project/token/-/avatar')
```
Use `CachedNetworkImage` (never bare `Image.network`).
Use `RepaintBoundary` around full-screen background images.

### Module logos: always use `ModuleLogo`
For project card logo banners, use `lib/widgets/module_logo.dart`:
```dart
ModuleLogo(
  machineName: project.machineName,
  logoUrl: project.logoUrl,
  fallbackLogoUrl: 'https://git.drupalcode.org/project/project_browser/-/avatar',
  accentColor: attrs.brand600,
  bgColor: attrs.bgCard,
)
```

### WYSIWYG editors (Quill via HtmlElementView)
- Use `q.scroll.observer.disconnect()` **before** setting `q.root.innerHTML` to prevent Quill's mutation observer from stripping `<table>` and `<img>` elements.
- Re-connect with `q.scroll.observer.observe(...)` immediately after.
- Images must be routed through the image proxy.
- Strip proxy URLs before saving with `_stripProxyUrls(html)`.

### Confetti pattern
```dart
// In initState:
_confettiController = ConfettiController(duration: const Duration(seconds: 2));

// On success (check setting first):
if (confettiEnabled) _confettiController.play();
await Future.delayed(const Duration(milliseconds: 900));
// then navigate
```

---

## Ports

| Service | Dev port | Production |
|---|---|---|
| Backend (Node.js) | 9901 | 9901 (internal Docker) |
| Frontend (Flutter) | 5173 | 5173 → nginx:80 (Docker) |

Use `./hubctl.sh start` for local development — it manages both ports.

---

## Unsplash API Compliance

1. **Hotlinking** — always use `photo.urls.regular` directly in `<img>` or CSS backgrounds. Do not re-host.
2. **Download tracking** — call `POST /api/unsplash/track-download` when a background is selected.
3. **Attribution links** — always include `?utm_source=pb_translation_hub&utm_medium=referral`.

---

## App UI Localization (i18n)

The Flutter client's own **interface chrome** (buttons, labels, tooltips, section headers — not the translated project *content*) is localized via Flutter ARB files in `flutter_client/lib/l10n/`, compiled with `flutter gen-l10n` into `AppLocalizations`. The active UI locale follows the same target-language dropdown used for content (`languageProvider`), resolved in `main.dart` via the `_nativeUiLocales` map (internal `languages.json` code → Flutter `Locale`).

**17 UI locales exist today, plus English fallback: German (native template), French, Japanese, Russian, Spanish, Turkish, Brazilian Portuguese (`pt-br` → `app_pt_BR.arb`), European Portuguese (`pt-pt` → `app_pt.arb` — genuinely distinct translation, not a copy of Brazilian), Chinese Simplified (`zh-hans` → `app_zh_Hans.arb`), Ukrainian, Dutch, Norwegian Bokmål, Hungarian, Catalan, Italian, Swedish, Danish, Polish, Romanian, Lithuanian, Estonian, Azerbaijani, Indonesian, Arabic, and Korean.** `app_pt.arb`/`app_zh.arb` do double duty as both the required base-locale fallback for their country/script-qualified siblings (`flutter gen-l10n` refuses to build a `pt_BR`/`zh_Hans` file without a base `pt`/`zh` file present) *and*, for `pt`, the actual European Portuguese translation. This set was prioritized by Drupal.org's most-active-translation-teams ranking — `server/languages.json` lists 88 possible target languages for translation *content* in total. All other target languages below still see the **English** app chrome (editor field labels, settings, sidebar nav, etc.) even though users can already submit translated *project content* in their own language — this is a known gap, not a bug.

Screens fully converted to `AppLocalizations` (DE native / EN fallback): editor, dashboard, review + review-list, categories, login + register, profile, settings, layout/sidebar, analytics, glossary, plus shared widgets (`diff_view.dart`, `sync_progress_bar.dart`) and two provider-level strings (`auth_provider.dart`, `project_provider.dart` — these use a local `ref.read(languageProvider)` check instead of `AppLocalizations` since they have no `BuildContext`).

Deliberately **excluded** from this ARB conversion: `help_screen.dart`, `crwb_study_screen.dart`, and `widgets/consent_youtube_player.dart`. These already implement their own richer multi-language *content* system (DE/EN/FR/PT/JA/ZH via an internal `_t(lang, de, en, [ja])` helper) for genuine help/educational text — converting them to the ARB scheme would have been a regression.

### Target languages with no native app UI yet (fallback = English)

fi Finnish · zh-hant Chinese (Traditional) · cs Czech · el Greek · he Hebrew · lv Latvian · gl Galician · fa Persian/Farsi · sk Slovak · oc Occitan · th Thai · be Belarusian · vi Vietnamese · hi Hindi · hr Croatian · eu Basque · ta Tamil · ms Malay · km Khmer · hy Armenian · cy Welsh · ku Kurdish · is Icelandic · eo Esperanto · sl Slovenian · bg Bulgarian · te Telugu · kk Kazakh · ka Georgian · bs Bosnian · ug Uighur · en-gb English (British) · sq Albanian · kn Kannada · nn Norwegian Nynorsk · gu Gujarati · sr Serbian · af Afrikaans · ne Nepali · my Burmese · am Amharic · dz Dzongkha · mn Mongolian · bn Bengali · mr Marathi · ur Urdu · fil Filipino · ml Malayalam · si Sinhala · fy Frisian (Western) · pa Punjabi · or Odia · ht Haitian Creole · mg Malagasy · br Breton · mk Macedonian · ga Irish · lo Lao · ky Kyrgyz · rw Kinyarwanda · sw Swahili · mt Maltese

(`az`, `pl`, `id`, `da`, `ro`, `lt`, `ko`, `et`, `ar` are next in priority per Drupal.org's most-active list — translation batch in progress, see the note above.)

To add a native UI for one of these: create `lib/l10n/app_<code>.arb` (copy `app_en.arb`'s keys as a base, name the file per Flutter's locale-file convention — e.g. `app_ko.arb`, or `app_zh_Hant.arb` for a script-qualified code, which also needs a base `app_zh.arb` alongside it if one doesn't already exist), translate the values, and add an entry to the `_nativeUiLocales` map in `main.dart` mapping the internal `languages.json` code to the matching `Locale`. `supportedLocales` picks it up automatically from `AppLocalizations.supportedLocales` once `flutter gen-l10n` has run.

---

## Guardrails

- All DB queries must use the `db` connection pool (prepared statements via `mysql2`).
- When saving data, write to **both** MariaDB and the file-system JSON backup.
- The `server/data/` directory is the portable backup layer — keep it in sync.
- Do not skip the 100 ms sync delay between Drupal.org pages.
- Review-related endpoints must check `user_type != 'translator'` before proceeding; return HTTP 403 otherwise.
- Bulk translation is capped at 150 modules per request; do not raise this limit without also extending the Dio `receiveTimeout`.
- DB migrations must use `ADD COLUMN IF NOT EXISTS` and `CREATE TABLE IF NOT EXISTS` — never `DROP` or `RENAME` without explicit coordination.
