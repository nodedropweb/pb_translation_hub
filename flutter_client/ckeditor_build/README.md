# Self-hosted CKEditor 5 build

Builds a single self-hosted CKEditor 5 bundle so the app no longer loads the
editor from `cdn.ckeditor.com` (DSGVO) and so the `Code`, `CodeBlock`,
`SourceEditing` and `GeneralHtmlSupport` plugins are available.

## Version

Pinned to **ckeditor5 43.3.1**:

- Unified `ckeditor5` package → trivial bundling with esbuild (no webpack/loaders).
- `licenseKey` is **not** required (that became mandatory only in v44+).
- Includes inline `<code>`, `<pre><code>` code blocks, raw source editing and
  General HTML Support.

## Build

```bash
cd flutter_client/ckeditor_build
npm install
npm run build
```

Outputs to `../web/vendor/ckeditor/`:

- `ckeditor.js`  — exposes `window.ClassicEditor` (same global the bridge uses)
- `ckeditor.css` — editor styles

Both files are committed so a normal `flutter build web` ships them without
needing this build step. Re-run the build only when bumping the CKEditor version.

## How it wires together

- `src/ckeditor.js` defines `ClassicEditor.builtinPlugins` and assigns
  `window.ClassicEditor`.
- `web/index.html` loads `vendor/ckeditor/ckeditor.{js,css}` locally and the
  `_ckBridge` enables General HTML Support via the `htmlSupport` config.
- `lib/widgets/ckeditor_field_web_impl.dart` adds `codeBlock` / `sourceEditing`
  to the toolbar.
