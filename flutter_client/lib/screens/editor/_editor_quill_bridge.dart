// HTML utility functions shared across editor part files.
// The Quill.js bridge has been removed; these are pure Dart helpers.
part of 'editor_screen.dart';

// ── HTML utility functions ─────────────────────────────────────────────────

/// Escapes raw HTML tags inside `<code>` blocks so the browser renders them
/// as visible text rather than as actual DOM elements.
/// Example: `<code><audio></audio></code>` → `<code>&lt;audio&gt;&lt;/audio&gt;</code>`
String _escapeCodeBlockContent(String html) {
  return html.replaceAllMapped(
    RegExp(r'<code>(.*?)</code>', multiLine: true, dotAll: true),
    (m) {
      final inner = m[1]!.replaceAllMapped(
        RegExp(r'<([a-zA-Z/][^>]*)>'),
        (t) => '&lt;${t[1]}&gt;',
      );
      return '<code>$inner</code>';
    },
  );
}

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

