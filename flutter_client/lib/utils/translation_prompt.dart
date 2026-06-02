/// Builds the manual-translation clipboard payload.
///
/// Produces the same prompt that is sent to Gemini / DeepL so that users
/// without an API key can paste the text directly into any AI tool.
library;

/// Maps a BCP-47 language code to the English full name used inside the
/// prompt (consistent with what the server sends to Gemini).
String promptLangName(String code) {
  const map = {
    'de': 'German',
    'fr': 'French',
    'es': 'Spanish',
    'pt-pt': 'Portuguese (Portugal)',
    'pt-br': 'Portuguese (Brazil)',
    'zh-hans': 'Chinese (Simplified)',
    'zh-hant': 'Chinese (Traditional)',
    'ja': 'Japanese',
    'ko': 'Korean',
    'ru': 'Russian',
    'uk': 'Ukrainian',
    'nl': 'Dutch',
    'it': 'Italian',
    'pl': 'Polish',
    'tr': 'Turkish',
    'ar': 'Arabic',
    'sv': 'Swedish',
    'da': 'Danish',
    'fi': 'Finnish',
    'nb': 'Norwegian',
    'cs': 'Czech',
    'sk': 'Slovak',
    'hu': 'Hungarian',
    'ro': 'Romanian',
    'bg': 'Bulgarian',
    'hr': 'Croatian',
    'el': 'Greek',
    'he': 'Hebrew',
    'id': 'Indonesian',
    'ms': 'Malay',
    'th': 'Thai',
    'vi': 'Vietnamese',
  };
  return map[code.toLowerCase()] ?? code;
}

/// Builds the full prompt string ready to be copied to the clipboard.
///
/// [langcode]      — BCP-47 target-language code from [languageProvider].
/// [sourceSummary] — Original (English) summary HTML.
/// [sourceBody]    — Original (English) body HTML.
String buildTranslationPrompt({
  required String langcode,
  required String sourceSummary,
  required String sourceBody,
}) {
  final langName = promptLangName(langcode);

  return '''Translate the following two HTML blocks from the Drupal Project Browser to $langName.
The first block is the short description (summary), the second block is the full description (body).
IMPORTANT:
1. Return ONLY the translated HTML — no introduction, no comments, no explanations, no labels (do NOT write "Summary:", "Body:", "Here is the translation", etc.).
2. Do NOT wrap your output in markdown code fences (no triple backtick html, no triple backtick, no code blocks). Output raw HTML only.
3. Your output MUST be valid HTML. Keep ALL HTML tags (<p>, <a>, <ul>, <li>, <strong>, <em>, <code>, <pre>, <img>, etc.) exactly as they are in the source. Translate only the visible text content inside the tags.
4. All hyperlinks (<a href="...">) and image URLs (<img src="...">) MUST remain completely unchanged.
5. Module names, package names and technical identifiers must stay in English.
6. Separate the two translated blocks EXACTLY by the string '---' on its own line (nothing else on that line).

$sourceSummary

---

$sourceBody''';
}
