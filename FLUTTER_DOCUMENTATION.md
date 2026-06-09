# Flutter Client — Technical Reference

The Flutter client is the primary (and only) frontend for the PB Translation Hub. It runs as a web app in development, is served via Nginx in Docker production, and can also compile as a native Android or desktop application.

---

## Table of Contents
1. [Quick Start](#1-quick-start)
2. [Architecture & Folder Structure](#2-architecture--folder-structure)
3. [State Management](#3-state-management)
4. [Design System](#4-design-system)
5. [WYSIWYG Editors (Quill)](#5-wysiwyg-editors-quill)
6. [Screens Reference](#6-screens-reference)
7. [Keyboard Shortcuts](#7-keyboard-shortcuts)
8. [Docker Production Build](#8-docker-production-build)
9. [Image Loading & CORS](#9-image-loading--cors)
10. [Android Build](#10-android-build)
11. [Developer Guidelines](#11-developer-guidelines)

---

## 1. Quick Start

### Prerequisites
- Flutter SDK (stable channel, ≥ 3.x)
- Node.js ≥ 18 (for the backend)
- MariaDB running and migrated (see `DATABASE.md`)

### Start everything (recommended)
```bash
# From the repo root
./hubctl.sh start
```
This starts the Node.js backend on **:9901** and the Flutter dev server on **:5173**.
Open `http://localhost:5173` in a browser.

### Start services individually
```bash
# Backend
wsl bash -i -c "cd /var/www/pb_translation_hub/server && node index.js"

# Flutter dev server
wsl bash -i -c "cd /var/www/pb_translation_hub/flutter_client && flutter run -d web-server --web-port 5173 --web-hostname 0.0.0.0"
```

### Hot-reload
`hubctl.sh start` keeps a FIFO at `/tmp/flutter_stdin`. Send `r` to trigger a hot-reload without restarting:
```bash
echo 'r' > /tmp/flutter_stdin
```
Or press `r` in the terminal where Flutter is running.

### hubctl.sh reference
```
./hubctl.sh start    # Start backend + frontend
./hubctl.sh stop     # Kill both services
./hubctl.sh restart  # stop + start
./hubctl.sh status   # Show running state and PIDs
./hubctl.sh logs     # Tail both logs live
```
Logs are written to `/tmp/pb_hub_server.log` and `/tmp/pb_hub_client.log`.

---

## 2. Architecture & Folder Structure

```
flutter_client/
├── lib/
│   ├── main.dart                  # Entry point; wraps app in ProviderScope
│   ├── router.dart                # GoRouter route declarations + role guards
│   ├── models/                    # DTOs and entity models
│   ├── providers/                 # Riverpod providers
│   │   ├── auth_provider.dart
│   │   ├── theme_provider.dart
│   │   ├── language_provider.dart
│   │   ├── project_provider.dart
│   │   └── sync_provider.dart
│   ├── services/
│   │   ├── api_client.dart        # HTTP client (Dio); image proxy helper
│   │   ├── log_service.dart       # Web console logging
│   │   └── token_storage.dart     # JWT persistence (localStorage)
│   ├── theme/
│   │   └── app_theme.dart         # ThemeAttributes + getAttributes()
│   ├── utils/
│   │   ├── html_sanitizer.dart    # HTML cleanup utilities
│   │   └── translation_prompt.dart # Gemini prompt builder
│   ├── widgets/
│   │   ├── ckeditor_field.dart    # CKEditor HTML field wrapper
│   │   ├── consent_youtube_player.dart  # GDPR-compliant video embed
│   │   ├── glass_container.dart   # Glassmorphism card primitive
│   │   ├── module_logo.dart       # CORS-safe module logo loader (3-level cascade)
│   │   ├── page_transition.dart   # Animated route transition helper
│   │   ├── search_with_autocomplete.dart
│   │   ├── splash_screen.dart     # Branded splash widget (min 2200 ms)
│   │   └── sync_progress_bar.dart
│   └── screens/
│       ├── auth/
│       │   ├── login_screen.dart
│       │   └── register_screen.dart   # 4-step registration wizard
│       ├── dashboard/             # Project grid, search, filters, AI bulk modal
│       │   └── widgets/
│       │       ├── project_card.dart      # Module card (uses ModuleLogo)
│       │       └── dashboard_filters.dart # Bilingual filter buttons
│       ├── editor/                # Full WYSIWYG editor
│       │   ├── editor_screen.dart
│       │   ├── _editor_build_methods.dart
│       │   ├── _editor_quill_bridge.dart
│       │   └── widgets/
│       │       ├── cost_calculator_dialog.dart
│       │       ├── editor_html_toolbar.dart
│       │       └── screenshot_alts_section.dart
│       ├── review/                # Human review queue (reviewer/admin only)
│       │   ├── review_list_screen.dart   # Queue list (shows translated titles)
│       │   ├── review_screen.dart        # Split-diff editor + optimistic navigation
│       │   └── widgets/
│       │       ├── review_diff_view.dart  # Original (red) / Corrected (green) split
│       │       └── review_sidebar.dart    # StatefulWidget with source toggle
│       ├── layout/                # AppLayout, sidebar, theme selector
│       │   └── app_layout.dart
│       ├── categories/
│       │   └── categories_screen.dart
│       ├── profile/               # User info, stats, AI settings, password change
│       │   └── profile_screen.dart
│       ├── help/                  # GDPR-safe help center + CRWB study
│       │   ├── help_screen.dart
│       │   └── crwb_study_screen.dart
│       └── settings/              # System config, theme, confetti, large UI, auto-autop
│           └── settings_screen.dart
├── android/                       # Android platform (targetSdk 34 / Android 14)
├── web/                           # Flutter web bootstrap (index.html with splash preloader)
├── Dockerfile                     # Multi-stage: flutter build web → nginx
└── nginx.conf                     # SPA routing + /api/ and /uploads/ proxies
```

---

## 3. State Management

The app uses **Riverpod** (`flutter_riverpod`). All providers are in `lib/providers/`.

| Provider | Responsibility |
|---|---|
| `authProvider` | Login/logout state, JWT token, auto-login on startup, user role |
| `themeProvider` | Active theme ID, font style, confetti, large UI, auto-autop flag, Unsplash background |
| `languageProvider` | Target translation language selection |
| `projectProvider` | Project list, search text, active filter, single-project sync |
| `syncProvider` | Sync progress (current page, total module count) |

Access pattern in widgets:
```dart
final themeState = ref.watch(themeProvider);
final attrs = AppTheme.getAttributes(themeState.themeId);
```

---

## 4. Design System

All visual tokens are resolved through `ThemeAttributes`. Never hardcode hex colors.

### Available attributes
```dart
attrs.brand600       // primary accent color
attrs.bgCard         // card/container background
attrs.bgSidebar      // sidebar background
attrs.bgInput        // input field background
attrs.textMain       // primary text
attrs.textMuted      // secondary / hint text
attrs.borderMain     // border color
```

### Adding a new theme
1. Open `lib/theme/app_theme.dart`.
2. Add a new case in `AppTheme.getAttributes(themeId)` returning a `ThemeAttributes(...)`.
3. Add the theme to the selector list in `lib/screens/layout/` or `settings/`.

### GlassContainer
The primary card primitive. Wraps content in `BackdropFilter` + semi-transparent fill:
```dart
GlassContainer(
  border: Border.all(color: attrs.borderMain),
  padding: const EdgeInsets.all(24),
  child: ...,
)
```

---

## 5. Glossary Term Highlighting

### Overview
The Hub highlights user-defined glossary terms inside every CKEditor 5 instance. Hovering over a highlighted term shows a floating tooltip with the preferred translation and an optional explanation.

### Data flow
```
Flutter boot
  └─ AppLayout.build()
       └─ setCkEditorTheme(themeId)        ← dart:html CSS vars, no JS bridge
  └─ ReviewScreen / EditorScreen initState
       └─ loadCkEditorGlossary(api, lang)  ← GET /api/glossary?langcode=de
            └─ _ckBridge.setGlobalGlossary(json)
                 └─ _ckApplyGlossaryMarkers(editor)  ← per active CKEditor
```

### Wortformen (Plurale, flektierte Formen)

Jeder Glossar-Eintrag kann neben der Grundform (`source_word`) beliebig viele flektierte Formen speichern (Feld `word_forms` als Komma-getrennte Liste in der DB, im API immer als Array). Die Flutter-UI zeigt diese Formen als Chips im Bearbeitungsdialog; über das Textfeld + „+"-Button lassen sich neue Formen hinzufügen, per „✕"-Chip entfernen.

Beispiel: `source_word = "Inhalt"`, `word_forms = ["Inhalte", "Inhalts", "Inhalten"]` → CKEditor erkennt alle vier Schreibweisen.

### CKEditor 5 plugin (`web/index.html`)

#### Marker-Format
`GlossaryHighlightPlugin` registriert einen `editingDowncast`-Konverter (`markerToHighlight`), der Modell-Marker in `<span class="ck-glossary-highlight" data-matched="…" data-preferred="…" data-explanation="…">` im Bearbeitungsbereich umwandelt — **nur in der Editing View**, `getData()` bleibt unberührt (`affectsData: false`).

Marker-Name-Format: `glossaryTerm:<termId>:<uid>:<encodedMatchedForm>`

- `<termId>` — Datenbank-ID des Glossar-Eintrags
- `<uid>` — fortlaufender Zähler (garantiert Eindeutigkeit)
- `<encodedMatchedForm>` — `encodeURIComponent(match[0])`, also die exakte Zeichenkette, die im Text gefunden wurde (z.B. `Inhalte`)

#### Marker-Anwendung (`_ckApplyGlossaryMarkers`)
1. Alle bestehenden `glossaryTerm:*`-Marker werden entfernt.
2. Jedes Block-Element, das `$text` enthalten kann, wird durchlaufen.
3. Pro Term wird eine RegExp-Alternation aus `source_word` + allen `word_forms` gebaut:
   ```
   \b(Inhalt|Inhalte|Inhalts|Inhalten)\b   (gi)
   ```
4. Jeder Match wird als Marker mit der exakten gematchten Form im Namen gespeichert.
5. Der Downcast-Konverter schreibt die gematchte Form als `data-matched`-Attribut ans `<span>`.

#### Marker werden erneuert bei:
- Aufruf von `setGlobalGlossary()` (Erstload oder Sprachwechsel).
- 300 ms nach jedem `change:data`-Event (debounced) — Content-Änderungen verlieren keine Highlights.
- Neuinitialisierung eines Editors, wenn `globalGlossary` bereits befüllt ist.

### Dart utilities (`lib/utils/ck_glossary.dart`)
| Function | Purpose |
|---|---|
| `loadCkEditorGlossary(api, langcode)` | Fetches `/glossary`, calls `setGlobalGlossary` on the bridge. Silently swallowed on error — glossary is non-critical. |
| `setCkEditorTheme(themeId)` | Updates `--ck-hl-bg`, `--ck-hl-border` on `:root` and all `--tip-*` variables on `#_ck_glossary_tip` directly via `dart:html`. No JS bridge involved. |

Both functions are no-ops on non-web platforms (`kIsWeb` guard).

### Theme colours
| Theme | Highlight background | Highlight border | Tooltip accent |
|---|---|---|---|
| dark | amber 22 % | `#F59E0B` | `#8B5CF6` purple |
| light | purple 12 % | `#7F56D9` | `#7F56D9` purple |
| glassy | cyan 18 % | `#009CDE` | `#009CDE` cyan |
| nature | green 18 % | `#10B981` | `#10B981` green |
| liquid | sky-blue 18 % | `#0EA5E9` | `#0EA5E9` sky-blue |

### Floating Tooltip

Beim Hover über ein markiertes Wort erscheint `#_ck_glossary_tip`. Der Tooltip unterscheidet zwei Fälle:

**Fall A — flektierte Form gefunden** (z.B. „Inhalte" im Text, Grundform ist „Inhalt"):
```
💡  Glossar-Hinweis
    Inhalte                ← data-matched (weiß, 13 px)
    ↓ bevorzugte Übersetzung
    Inhalt                 ← data-preferred (lila, 15 px fett)
    ─────────────────────
    [Erklärungstext]
```

**Fall B — Grundform gefunden** (Matched-Form == Preferred-Word):
```
💡  Glossar-Hinweis
    Inhalt                 ← direkt lila, 15 px fett, kein Pfeil
    ─────────────────────
    [Erklärungstext]
```

Das `data-matched`-Attribut enthält immer die exakte Zeichenkette aus dem Text (Groß-/Kleinschreibung wie im Original). Der Vergleich für Fall A/B ist case-insensitive.

### Glossary management screen (`lib/screens/glossary/glossary_screen.dart`)
Route `/glossary`, accessible from the sidebar. Reviewers and admins can:
- View all terms for the currently selected target language.
- Add a new term (source word, preferred word, optional explanation, word forms).
- Edit or delete existing terms.

**Wortformen-UI im Dialog:**  
Unter dem Feld „Quellwort (Grundform)" befindet sich ein Chip-Eingabebereich. Formen werden über ein Textfeld + „+"-Button hinzugefügt und als Chips mit „✕" einzeln entfernt. Die Liste wird als `word_forms`-Array an die API gesendet und in der Tabellenzeile als kleinere Amber-Chips neben dem Grundform-Badge angezeigt.

Changes take effect in open editors after the next `loadCkEditorGlossary` call (e.g. on the next screen navigation or language switch).

### REST API
| Method | Endpoint | Auth | Description |
|---|---|---|---|
| `GET` | `/api/glossary?langcode=de` | any logged-in user | List terms for a language |
| `POST` | `/api/glossary` | reviewer / admin | Create a term |
| `PUT` | `/api/glossary/:id` | reviewer / admin | Update a term |
| `DELETE` | `/api/glossary/:id` | reviewer / admin | Delete a term |

**Request body (POST/PUT):**
```json
{
  "lang_code":      "de",
  "source_word":    "Inhalt",
  "word_forms":     ["Inhalte", "Inhalts", "Inhalten"],
  "preferred_word": "Inhalt",
  "explanation":    "Bitte die standardisierte deutsche Bezeichnung verwenden."
}
```
Das Backend nimmt `word_forms` als Array entgegen, speichert es als komma-getrennten String in der DB und gibt es in GET/POST/PUT-Antworten immer als Array zurück.

---

## 5b. WYSIWYG Editors (Quill)

The editor and review screens embed [Quill 1.3.6](https://quilljs.com/) via `HtmlElementView` platform views.

### Critical: Observer-disconnect pattern
Quill's mutation observer normalizes any HTML written to `q.root.innerHTML`, stripping `<table>`, `<img>` inside `<td>`, and other non-Quill elements. Always disconnect before writing:
```javascript
try { q.scroll.observer.disconnect(); } catch(e) {}
q.root.innerHTML = htmlContent;
try {
  q.scroll.observer.observe(q.root, {
    childList: true, attributes: true,
    characterData: true, subtree: true
  });
} catch(e) {}
```

### Image proxy
All external images are routed through the backend proxy to avoid CORS / mixed-content issues:
```dart
// Dart helper
ApiClient.proxyImageUrl(originalUrl)
// Produces: http://localhost:9901/api/image-proxy?url=<encoded>
```
Strip proxy URLs before saving so canonical `drupal.org` URLs are persisted:
```dart
static String _stripProxyUrls(String html) {
  return html.replaceAllMapped(
    RegExp(r'''src=["']http://localhost:\d+/api/image-proxy\?url=([^"']+)["']''',
           caseSensitive: false),
    (m) => 'src="${Uri.decodeComponent(m[1]!)}"',
  );
}
```

### Editor heights (review screen)
Heights are proportional to the viewport so the app scales across desktop, tablet, and web:
```dart
final vh = MediaQuery.of(context).size.height;
final summaryEditorHeight = (vh * 0.20).clamp(160.0, 420.0);
final bodyEditorHeight    = (vh * 0.45).clamp(320.0, 960.0);
```

---

## 6. Screens Reference

| Screen | File | Route | Access |
|---|---|---|---|
| Splash | `widgets/splash_screen.dart` | (initial overlay) | Public |
| Login | `screens/auth/login_screen.dart` | `/login` | Public |
| Register | `screens/auth/register_screen.dart` | `/register` | Public (if enabled) |
| Dashboard | `screens/dashboard/dashboard_screen.dart` | `/` | Authenticated |
| Editor | `screens/editor/editor_screen.dart` | `/edit/:machineName` | Authenticated |
| Review List | `screens/review/review_list_screen.dart` | `/review` | Reviewer + Admin |
| Review | `screens/review/review_screen.dart` | `/review/:machineName` | Reviewer + Admin |
| Profile | `screens/profile/profile_screen.dart` | `/profile` | Authenticated |
| Settings | `screens/settings/settings_screen.dart` | `/settings` | Admin |
| Help | `screens/help/help_screen.dart` | `/help` | Authenticated |
| CRWB Study | `screens/help/crwb_study_screen.dart` | `/help/crwb` | Authenticated |
| Categories | `screens/categories/categories_screen.dart` | `/categories` | Admin |

### Splash Screen
`lib/widgets/splash_screen.dart` is a Flutter widget that displays the branded logo and name "TRANSLATION HUB". A matching HTML preloader in `web/index.html` is shown until the Flutter engine fires the `flutter-first-frame` event. The minimum display time is 2200 ms to prevent a flash of unstyled content on fast devices.

### Register Screen — 4-step wizard
`lib/screens/auth/register_screen.dart` implements the self-registration flow:
1. **Account** — username, email, password
2. **Role** — translator or reviewer (`requested_role`)
3. **Languages** — target translation language selection
4. **API Keys** — optional personal Gemini key

The screen checks `GET /auth/registration-status` on load. If registration is disabled, it shows a notice instead of the form.

### Review Screen — architecture
The review screen (`review_screen.dart`) receives the full queue as `inheritedQueue` from the review list screen to avoid a double-fetch race condition. Navigation between queue items uses `_goToNextReview()`, which is synchronous (`void`) — the save POST runs in the background via an unawaited future, allowing immediate optimistic navigation.

The off-canvas sidebar (`review_sidebar.dart`) is a `StatefulWidget` with a `_showSourceCode` boolean toggle. It displays the English source with a "Preview / Source" toggle and a copy button. The sidebar toggle button is positioned on the left side of the header.

The split diff view (`review_diff_view.dart`) shows the original text above on a red-tinted background and the corrected text below on a green-tinted background. There is no overlapping text mode.

### Review List Screen
`review_list_screen.dart` shows translated titles and summaries from `meta.translation` rather than the original English texts, so reviewers see the content in the target language.

### Dashboard Filter Buttons
Each filter button in `dashboard_filters.dart` shows two stacked labels: the German label (bold, 13 px) on top and the English label (grey, 10 px) below. This bilingual presentation makes the interface usable for both German and English speakers without additional UI elements.

### Review Screen — off-canvas sidebar
The review screen has a collapsible off-canvas sidebar (default closed) containing the English source text with a Preview/Source toggle and a copy button. The toggle button is on the left side of the header. The main editor expands to full width when the sidebar is hidden.

---

## 7. Keyboard Shortcuts

### Editor screen
| Shortcut | Action |
|---|---|
| `Ctrl+Alt+S` | Save translation and go to next project |
| `Alt+P` | Toggle live HTML preview |
| `Ctrl+Alt+D` | Skip to next project without saving |

### Review screen
| Shortcut | Action |
|---|---|
| `Ctrl+S` | Save suggestion |
| `Ctrl+Enter` | Approve translation for production |
| `Ctrl+→` | Skip to next item in review queue |

---

## 8. Docker Production Build

The `flutter_client/Dockerfile` is a two-stage build:
1. **Build stage** — compiles the Flutter web release with `flutter build web --release`.
2. **Serve stage** — copies the `build/web/` output into an Nginx container.

The `nginx.conf` handles:
- SPA fallback (all paths → `index.html`)
- `/api/` → proxy to `http://server:9901/api/`
- `/uploads/` → proxy to `http://server:9901/uploads/`

```bash
# Build and run the full stack
docker compose up -d --build

# Frontend available at
http://localhost:5173
```

To change the host port, edit `docker-compose.yml`:
```yaml
client:
  ports:
    - "8080:80"   # change 5173 to any available port
```

---

## 9. Image Loading & CORS

### Why images need a server proxy

The Flutter web app runs inside the browser. Any image loaded from an external domain
(e.g. `git.drupalcode.org`, `drupal.org`) is subject to the browser's CORS policy.
These domains do not send `Access-Control-Allow-Origin` headers that permit cross-origin
requests from `pb.drupaltutorials.de`, so a direct `Image.network()` or
`CachedNetworkImage(imageUrl: externalUrl)` call silently fails with a CORS error.

**Solution:** route all external images through the backend proxy endpoint
`GET /api/image-proxy?url=<encoded>`. The server fetches the image server-side
(no CORS restriction) and streams it back with `Access-Control-Allow-Origin: *`.

```dart
// Always use this helper — never pass an external URL directly to an image widget.
final proxied = ApiClient.proxyImageUrl('https://git.drupalcode.org/...');
```

### `CachedNetworkImage` — the only image loader

All network images in the app use `cached_network_image`. It provides:
- **Disk cache** — images survive page reloads (Flutter web: memory cache only).
- **Placeholder / error widgets** — clean UX during load and on failure.
- `CachedNetworkImageProvider` is used as a `CircleAvatar.backgroundImage` provider.

Do **not** use `Image.network()` anywhere in the codebase.

### `RepaintBoundary` — around full-screen backgrounds

Background images (login screen, app layout) are wrapped in `RepaintBoundary`:

```dart
RepaintBoundary(
  child: CachedNetworkImage(
    imageUrl: ApiClient.proxyImageUrl(bgUrl),
    fit: BoxFit.cover,
    ...
  ),
)
```

This isolates the background from the rest of the render tree, preventing the full
widget tree from repainting when only the background changes (e.g. on theme switch).

### `ModuleLogo` widget — CORS-safe module logo loader

`lib/widgets/module_logo.dart` is the single widget for loading Drupal module logos
on project cards. It implements a **3-level cascade**:

| Level | Source | When |
|---|---|---|
| 1 | `logoUrl` via proxy | The module has a valid, reachable GitLab avatar |
| 2 | `fallbackLogoUrl` via proxy | `logoUrl` is `null`, empty, or the proxy returns an error (e.g. GitLab 404 → proxy 502) |
| 3 | Letter avatar (Flutter widget) | Both URLs are absent or fail |

```dart
ModuleLogo(
  machineName: project.machineName,   // used for level-3 initial letter
  logoUrl: project.logoUrl,           // e.g. https://git.drupalcode.org/project/token/-/avatar
  fallbackLogoUrl:                    // shown when logoUrl is missing or broken
      'https://git.drupalcode.org/project/project_browser/-/avatar',
  accentColor: attrs.brand600,
  bgColor: attrs.bgCard,
)
```

**Why project_browser as the fallback?**
This hub translates the metadata consumed by the Drupal Project Browser module
(`project_browser`). Using its logo as the default creates semantic consistency —
modules without their own GitLab avatar still show a Drupal-context icon.

**Why many modules have broken GitLab avatars:**
The server sets `logoUrl = https://git.drupalcode.org/project/{machineName}/-/avatar`
for every module. However, many older or inactive modules do not have a GitLab
repository at all (their code lives on Drupal.org CVS or a private host), so GitLab
returns 404, the proxy returns 502, and `CachedNetworkImage` triggers `errorWidget`.
The `fallbackLogoUrl` catches this case.

### Image proxy in WYSIWYG content

Rich-text content stored in `summary` and `body` fields contains `<img src="...">` tags
pointing to `drupal.org`. When loading into Quill, all `src` attributes are rewritten
to use the proxy. Before saving, `_stripProxyUrls()` in `_editor_quill_bridge.dart`
restores the canonical `drupal.org` URLs so the DB always stores clean, portable HTML.

---

## 10. Android Build

The app targets **Android 14 (API 34)**. Key configuration:

### `android/app/build.gradle.kts`
```kotlin
android {
    compileSdk = flutter.compileSdkVersion
    targetSdk = 34   // Android 14 — required for Play Store new app submissions
    minSdk = flutter.minSdkVersion
}
```

### `android/app/src/main/AndroidManifest.xml`
```xml
<!-- Required for all network requests on Android -->
<uses-permission android:name="android.permission.INTERNET"/>

<application
    ...
    android:enableOnBackInvokedCallback="true">  <!-- Predictive Back Gesture (Android 13+) -->
```

`android:enableOnBackInvokedCallback="true"` opts the app into the Android 13+
Predictive Back Gesture API (the animated back-navigation preview). Without this flag,
the OS still works but issues a deprecation warning on API 33+.

### Building the Android APK
```bash
cd flutter_client
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

---

## 11. Developer Guidelines

### Do not hardcode colors
Widgets that use `attrs.*` colors cannot be `const`. This is intentional — the theme is dynamic at runtime.

### Use `.withValues(alpha:)` instead of `.withOpacity()`
The `Color.withOpacity()` method is deprecated in Flutter 3.x. Use `.withValues(alpha:)`:
```dart
// Deprecated
attrs.brand600.withOpacity(0.2)

// Correct
attrs.brand600.withValues(alpha: 0.2)
```
`alpha` is a `double` in the range `0.0`–`1.0`, identical to the old `opacity` parameter.

### Responsive layout: use `Wrap` not `Row` for filter buttons
The dashboard filter bar uses a `Wrap` widget so buttons flow onto a second line on
narrow viewports (tablet portrait ~768 px) instead of overflowing:
```dart
Wrap(
  runSpacing: 10,
  children: [
    _buildFilterBtn(...),
    ...
  ],
)
```
Do **not** wrap filter rows in a `SingleChildScrollView(scrollDirection: Axis.horizontal)` —
that breaks tablet portrait usability.

### Confetti controller pattern
`editor_screen.dart` and `review_screen.dart` use the `confetti` package for celebration animations. The `ConfettiController` is initialized in `initState` and disposed in `dispose`. The confetti burst is triggered on save/approve, and navigation is delayed by 900 ms to allow the animation to play before the route changes. The confetti feature can be toggled off via the settings screen; check the setting before calling `controller.play()`.

### User preferences (`ThemeState` / `themeProvider`)

All per-user preferences are stored in `ThemeState` and persisted via `SharedPreferences`. The `ThemeNotifier` loads them asynchronously in `_loadInitialState()` and exposes a typed setter for each field.

| Field | SharedPreferences key | Default | Description |
|---|---|---|---|
| `themeId` | `pb-theme` | `'glassy'` | Active colour theme |
| `fontStyle` | `pb-fontStyle` | `'inter'` | UI font family |
| `confettiEnabled` | `pb-confettiEnabled` | `true` | Confetti animation on save/approve |
| `largeUi` | `pb-largeUi` | `false` | Larger text and badges |
| `autoAutop` | `pb-autoAutop` | `false` | Auto paragraph-format on Review Screen load |
| `bgImageUrl` | `pb-bgImage` | *(fetched)* | Unsplash background URL |

#### Auto-Autop (`autoAutop`)

When `autoAutop` is `true`, `_fetchData()` in `review_screen.dart` calls the static `_autop()` method on both the Summary and Body controllers immediately after all content has been loaded — before `setState(() { _loading = false; })`. This is equivalent to clicking the ¶ button on both fields manually. No Snackbar is shown for the automatic run. The setting has no effect when the content already contains `<p>` tags (autop is idempotent).

### Page transitions
`lib/widgets/page_transition.dart` provides a shared animated transition helper. Use it when navigating between screens to maintain a consistent feel.

### File size limit
Keep each screen file under ~500 lines. If a screen grows larger, extract sub-widgets into a `widgets/` subdirectory next to the screen file.

### Platform view lifecycle
`HtmlElementView` widgets are registered once via `ui_web.platformViewRegistry.registerViewFactory`. The factory runs once per view type per session. Use the `_active*Div` static references to re-sync content on route changes.

### Running Flutter analyze
Before committing Flutter changes:
```bash
wsl -d drupaltv -u drupal -- bash -c "cd /var/www/pb_translation_hub/flutter_client && /home/drupal/flutter/bin/dart analyze 2>&1 | grep -E '^(error|warning)'"
```
Fix all `error` and `warning` level findings before deploying. `info`-level deprecation
hints are tracked but non-blocking.
