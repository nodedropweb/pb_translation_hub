// HTML utility functions shared across editor part files.
// Pure Dart helpers (no editor JS bridge): code-block escaping, relative-path
// fixing and related HTML normalisation used by editor_screen.dart.
part of 'editor_screen.dart';

// ── HTML utility functions ─────────────────────────────────────────────────

/// Escapes raw HTML tags inside `<code>` blocks so they show as literal text.
/// Thin alias for the shared [escapeCodeBlockContent] in html_sanitizer.dart
/// (kept so the editor part-files can use the short private name).
String _escapeCodeBlockContent(String html) => escapeCodeBlockContent(html);

/// Converts remaining relative Drupal paths to absolute drupal.org URLs.
String _fixRelativePaths(String html) {
  if (html.isEmpty) return html;
  const base = 'https://www.drupal.org';
  return html.replaceAllMapped(
    RegExp(
      r'''(src|href)=['"]\/(files|sites|core|themes|modules|node|user|media|libraries)\/([^'"]+)['"]''',
      caseSensitive: false,
    ),
    (m) => '${m[1]}="$base/${m[2]}/${m[3]}"',
  );
}

/// Prepares HTML for the READ-ONLY English source panel (rendered via [HtmlWidget]).
///
/// Fixes relative paths, escapes `<code>` block content, and routes external
/// image `src` values through the server proxy to avoid CORS issues.
String _toDisplayHtml(String html) {
  html = _fixRelativePaths(html);
  html = _escapeCodeBlockContent(html);
  if (html.isEmpty) return html;
  return html.replaceAllMapped(
    RegExp(r'''src=["'](https?://(?!localhost)[^"']+)["']''',
        caseSensitive: false),
    (m) => 'src="${ApiClient.proxyImageUrl(m[1]!)}"',
  );
}

