# Contributing to PB Translation Hub

## Getting Started

1. Clone the repository.
2. Copy `server/.env.example` to `server/.env` and fill in your credentials.
3. Start the stack: `./hubctl.sh start`
4. Open `http://localhost:5173`.
5. Register a new account or log in with the admin account.

See [README.md](./README.md) for a full feature overview and [FLUTTER_DOCUMENTATION.md](./FLUTTER_DOCUMENTATION.md) for Flutter-specific setup.

---

## Development Workflow

### Frontend (Flutter)

The frontend is a Flutter web application under `flutter_client/`.

- **Styles:** Use `ThemeAttributes` (`attrs.*`) — never hardcode colors.
- **State:** Use Riverpod (`ref.watch` / `ref.read`). Do not use `setState` for shared state.
- **Widgets:** Keep widgets under ~500 lines. Extract sub-widgets into a `widgets/` subdirectory when a screen grows large.
- **WYSIWYG editors:** Always use the observer-disconnect pattern when writing to Quill. See [FLUTTER_DOCUMENTATION.md §5](./FLUTTER_DOCUMENTATION.md#5-wysiwyg-editors-quill).
- **New screens:** Add the file under `lib/screens/<domain>/`, register the route in `lib/router.dart`, and add a role guard if the screen requires reviewer or admin access.
- **Role guards:** Review-related routes must check `user_type != 'translator'` in the router redirect. See the existing `/review` route in `router.dart` as a reference.
- **Confetti:** Trigger `ConfettiController.play()` on save/approve and delay navigation by 900 ms. Always check whether confetti is enabled in settings before playing.
- **Images:** All network images must go through `ApiClient.proxyImageUrl()`. Use `CachedNetworkImage`, not `Image.network`. Wrap full-screen backgrounds in `RepaintBoundary`.

### Backend (Node.js)

The backend is a modular Express server. Routes are in `server/routes/`. The entry point is `server/index.js`.

- **Database:** All queries must use the `db` pool with prepared statements (`mysql2`).
- **Dual persistence:** When writing data, save to both MariaDB *and* the `server/data/` JSON backups.
- **Response speed:** Send `res.json()` immediately after the DB write. Run file-system backup writes (`fs.writeJson`) asynchronously in the background.
- **Role enforcement:** Review endpoints must check the user's `user_type`. Return HTTP 403 for `translator` users.
- **Filtering:** Use `getFilteredIndex` for project list queries — do not duplicate that logic.
- **AI prompts:** Keep `[DESCRIPTION]` and similar placeholders intact when editing Gemini prompts.
- **Sync rate limit:** Do not remove the 100 ms delay between Drupal.org sync pages.
- **Bulk translation limit:** Do not raise the 150-module cap without also extending the Dio `receiveTimeout` on the client.

### DB Schema Changes

All schema changes must go through the migration system in `server/migrations/`. See [DATABASE.md](./DATABASE.md) for the full migration workflow.

- Name files `NNN_description.sql` with zero-padded numbers.
- Only use `ADD COLUMN IF NOT EXISTS` and `CREATE TABLE IF NOT EXISTS` — never `DROP` or `RENAME` without explicit coordination.
- Test your migration locally before deploying to production.

---

## Testing

- Test the Flutter UI at both a narrow viewport (tablet ~768 px) and a wide desktop viewport.
- Verify HTML tags in descriptions survive AI translation without corruption.
- For backend changes, test both the DB path and the JSON-file fallback path.
- Test the registration flow with both `translator` and `reviewer` role selections.
- Verify that a `translator` user cannot access the review queue (router redirect + HTTP 403 on the API).
- Run `flutter analyze` before committing Flutter changes:
  ```bash
  wsl bash -i -c "cd /var/www/pb_translation_hub/flutter_client && flutter analyze"
  ```

---

## Commit Guidelines

- Prefix commits: `fix:` for bug fixes, `feat:` for new features, `docs:` for documentation, `refactor:` for refactoring without behavior changes.
- Keep commits focused on a single concern.
- Do not commit `server/.env`, `server/data/`, or Flutter build artifacts.

---

## Unsplash API Compliance

Any feature that displays or selects Unsplash photos must:

1. Use hotlinked URLs (`photo.urls.regular`) — do not proxy or re-host images.
2. Trigger download tracking via `POST /api/unsplash/track-download`.
3. Include UTM attribution on all links: `?utm_source=pb_translation_hub&utm_medium=referral`.
