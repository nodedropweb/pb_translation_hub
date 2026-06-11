/// Converts plain/single-paragraph text to multi-paragraph HTML,
/// mirroring WordPress's wpautop() behaviour.
///
/// - Already has multiple <p> tags → return unchanged.
/// - Single <p> wrapper from CKEditor → unwrap, then re-wrap per paragraph.
/// - Double newlines → paragraph boundaries.
/// - No double newlines → split on sentence boundaries (~260 chars per paragraph).
String autop(String text) {
  if (text.trim().isEmpty) return text;

  final pCount =
      RegExp(r'<p[\s>]', caseSensitive: false).allMatches(text).length;

  if (pCount > 1) return text;

  String plain = text;
  if (pCount == 1) {
    plain = plain
        .replaceAll(RegExp(r'<p[^>]*>', caseSensitive: false), '')
        .replaceAll(RegExp(r'</p>', caseSensitive: false), ' ')
        .replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n')
        .trim();
  }

  plain = plain.replaceAll(RegExp(r'\r\n|\r'), '\n').trim();
  plain = plain.replaceAll(RegExp(r'\n{3,}'), '\n\n');

  const blocks =
      r'(?:div|ul|ol|li|table|thead|tbody|tr|td|th|blockquote|pre|h[1-6]|hr|figure|figcaption|aside|section|article|header|footer|nav)';

  // ── Pfad A: Text hat bereits doppelte Zeilenumbrüche ─────────────────
  if (plain.contains('\n\n')) {
    plain = plain.replaceAllMapped(
        RegExp('(</?$blocks[^>]*>)', caseSensitive: false),
        (m) => '\n${m[1]}\n');
    plain = plain.replaceAll(RegExp(r'\n{2,}'), '\n\n').trim();

    final chunks = plain.split(RegExp(r'\n\s*\n'));
    final buf = StringBuffer();
    for (final chunk in chunks) {
      final t = chunk.trim();
      if (t.isEmpty) continue;
      if (RegExp('^<(?:$blocks)', caseSensitive: false).hasMatch(t)) {
        buf.writeln(t);
      } else {
        buf.writeln('<p>${t.replaceAll('\n', '<br>\n')}</p>');
      }
    }
    return buf.toString().trim();
  }

  // ── Pfad B: Fließtext — an Satzenden aufteilen ────────────────────────
  final normalized =
      plain.replaceAll('\n', ' ').replaceAll(RegExp(r'  +'), ' ').trim();

  final sentenceSplitter = RegExp(r'(?<=[.!?])\s+(?=[A-ZÄÖÜÀ-ɏ])');
  final sentences = normalized.split(sentenceSplitter);

  if (sentences.length <= 1) {
    return '<p>$normalized</p>';
  }

  const softLimit = 260;
  final paragraphs = <String>[];
  var accumulator = StringBuffer();

  for (final s in sentences) {
    final sentence = s.trim();
    if (sentence.isEmpty) continue;
    if (accumulator.isEmpty) {
      accumulator.write(sentence);
    } else if (accumulator.length >= softLimit) {
      paragraphs.add(accumulator.toString());
      accumulator = StringBuffer(sentence);
    } else {
      accumulator.write(' $sentence');
    }
  }
  if (accumulator.isNotEmpty) paragraphs.add(accumulator.toString());

  return paragraphs.map((p) => '<p>$p</p>').join('\n');
}
