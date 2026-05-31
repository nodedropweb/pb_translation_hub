/// Fixes the broken HTML that the DeepL **desktop** app produces when it
/// encounters HTML source text.  DeepL sometimes emits:
///
///   * `<\/tag>` — a backslash before the slash in closing tags
///   * `<\` at the end of a line — orphaned `<\` with nothing after it
///   * `<\n` — a literal `<` + backslash + n sequence
///
/// Call this **before** passing DeepL output to [sanitizeHtmlForParchment]
/// or to CKEditor.
String tidyDeeplHtml(String html) {
  if (html.trim().isEmpty) return html;
  var h = html;

  // 1. Fix `<\/tag>` → `</tag>` (literal backslash before the slash)
  h = h.replaceAll(r'<\/', '</');

  // 2. Remove `<\n` (literal `<` + backslash + letter-n, not a real newline)
  h = h.replaceAll(r'<\n', '');

  // 3. Remove orphan `<\` at end of line (backslash + optional spaces + newline)
  h = h.replaceAll(RegExp(r'<\\[ \t]*(\r\n|\r|\n)', multiLine: true), '\n');

  // 4. Remove trailing orphan `<\` at end of string
  h = h.replaceAll(RegExp(r'<\\[ \t]*$', multiLine: true), '');

  // 5. Collapse runs of 3+ blank lines that may result from step 3
  h = h.replaceAll(RegExp(r'\n{3,}'), '\n\n');

  return h.trim();
}

/// Strips HTML tags that [ParchmentHtmlCodec] cannot represent, preventing
/// Fleather from receiving malformed documents that crash during rendering.
///
/// **Tags supported by Parchment / kept as-is:**
///   Block : `<p>`, `<h1>`–`<h6>`, `<ul>`, `<ol>`, `<li>`,
///           `<blockquote>`, `<pre>`, `<hr>`
///   Inline: `<strong>`, `<b>`, `<em>`, `<i>`, `<u>`, `<s>`, `<del>`,
///           `<a>`, `<code>`
///   Other : `<br>`
///
/// **Everything else is either:**
/// - Removed entirely (img, figure, table, video, audio, …)
/// - Mapped to `<p>` (div, section, article, …)
/// - Stripped (span and other inline wrappers — text content kept)
///
/// Call this function **before** [ParchmentHtmlCodec().decode()].
String sanitizeHtmlForParchment(String html) {
  if (html.trim().isEmpty) return html;
  var h = html;

  // ── 1. Strip HTML comments ─────────────────────────────────────────────────
  h = h.replaceAll(RegExp(r'<!--[\s\S]*?-->', dotAll: true), '');

  // ── 2. Strip complete element subtrees Parchment cannot represent ──────────
  // Non-greedy so adjacent occurrences don't collapse into one match.
  for (final tag in [
    'figure', 'figcaption',
    'table', 'thead', 'tbody', 'tfoot', 'colgroup', 'col',
    'video', 'audio', 'track', 'source',
    'iframe', 'embed', 'object', 'param',
    'script', 'style', 'noscript', 'template',
    'svg', 'math',
    'picture',
    'details', 'summary',
    'dialog', 'menu',
    'canvas', 'map', 'area',
    'form', 'fieldset', 'legend', 'select', 'option', 'optgroup',
    'datalist', 'output', 'progress', 'meter',
  ]) {
    h = h.replaceAll(
      RegExp('<$tag\\b[^>]*>[\\s\\S]*?</$tag>',
          caseSensitive: false, dotAll: true),
      '',
    );
    // Orphan closing tags (e.g. if the opening was already stripped)
    h = h.replaceAll(RegExp('</$tag>', caseSensitive: false), '');
  }

  // ── 3. Strip void / self-closing tags Parchment cannot represent ───────────
  h = h.replaceAll(RegExp(r'<img\b[^>]*/?>',   caseSensitive: false), '');
  h = h.replaceAll(RegExp(r'<input\b[^>]*/?>',  caseSensitive: false), '');
  h = h.replaceAll(RegExp(r'<link\b[^>]*/?>',   caseSensitive: false), '');
  h = h.replaceAll(RegExp(r'<meta\b[^>]*/?>',   caseSensitive: false), '');
  h = h.replaceAll(RegExp(r'<wbr\b[^>]*/?>',    caseSensitive: false), '');
  h = h.replaceAll(RegExp(r'<button\b[^>]*/?>',  caseSensitive: false), '');

  // ── 4. Map block-level wrapper elements → <p> (keep inner content) ─────────
  for (final tag in [
    'div', 'section', 'article', 'main', 'aside', 'nav',
    'header', 'footer', 'address', 'hgroup',
  ]) {
    h = h.replaceAll(RegExp('<$tag\\b[^>]*>',  caseSensitive: false), '<p>');
    h = h.replaceAll(RegExp('</$tag>',          caseSensitive: false), '</p>');
  }

  // ── 5. Strip inline wrapper elements (keep text content) ──────────────────
  for (final tag in [
    'span', 'label', 'abbr', 'acronym', 'cite', 'dfn', 'kbd', 'samp',
    'var', 'mark', 'ruby', 'rt', 'rp', 'bdi', 'bdo', 'time', 'data',
    'small', 'sub', 'sup', 'q', 'ins', 'font',
    'button', 'a-tag-stripped-below',   // <a> is kept; this is a no-op guard
  ]) {
    h = h.replaceAll(RegExp('<$tag\\b[^>]*>', caseSensitive: false), '');
    h = h.replaceAll(RegExp('</$tag>',         caseSensitive: false), '');
  }

  // ── 6. Normalise <br> to a consistent self-closing-free form ──────────────
  h = h.replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '<br>');

  // ── 7. Collapse empty paragraphs (may arise from stripped content) ─────────
  h = h.replaceAll(
      RegExp(r'<p>\s*(?:<br>\s*)*</p>', caseSensitive: false), '');

  // ── 8. Collapse runs of 3+ blank lines ────────────────────────────────────
  h = h.replaceAll(RegExp(r'\n{3,}'), '\n\n');

  return h.trim();
}
