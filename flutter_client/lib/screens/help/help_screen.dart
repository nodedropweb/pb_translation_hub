import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import '../../providers/language_provider.dart';
import '../../providers/theme_provider.dart';
import '../../theme/app_theme.dart';
import '../../services/api_client.dart';
import '../../widgets/consent_youtube_player.dart';
import '../../widgets/glass_container.dart';

/// Fetches help video URLs from the server.
/// Returns `{'de': url|null, 'en': url|null}`.
/// The server reads HELP_VIDEO_DE / HELP_VIDEO_EN from its .env file.
final _helpVideosProvider =
    FutureProvider.autoDispose<Map<String, String?>>((ref) async {
  final response = await ApiClient().dio.get('/config/help-videos');
  return {
    'de': response.data['de'] as String?,
    'en': response.data['en'] as String?,
  };
});

/// Extracts the YouTube video ID from a youtu.be or youtube.com/watch?v= URL.
/// Returns null if the URL is null, empty, or does not match.
String? _youTubeId(String? url) {
  if (url == null || url.isEmpty) return null;
  final short = RegExp(r'youtu\.be/([a-zA-Z0-9_-]{11})').firstMatch(url);
  if (short != null) return short.group(1);
  final long = RegExp(r'[?&]v=([a-zA-Z0-9_-]{11})').firstMatch(url);
  return long?.group(1);
}

class HelpScreen extends ConsumerWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final langState = ref.watch(languageProvider);
    final attrs = AppTheme.getAttributes(themeState.themeId);
    final helpVideos = ref.watch(_helpVideosProvider);

    final lang = langState.targetLanguage.code;
    final isGerman = lang == 'de';

    // Resolve video URL for the current target language.
    // Falls back to the English video if no DE video is configured.
    final videoUrl = helpVideos.when(
      data: (data) => isGerman ? (data['de'] ?? data['en']) : data['en'],
      loading: () => null,
      error: (_, __) => null,
    );
    // Whether the API call is still in flight.
    final videoLoading = helpVideos is AsyncLoading;
    // Whether the API call failed (server not reachable or endpoint missing).
    final videoError = helpVideos is AsyncError;
    // Extract the YouTube video ID — null means no video is configured.
    // The ConsentYouTubePlayer handles all external requests (thumbnail,
    // iframe) only AFTER explicit user consent.
    final videoId = _youTubeId(videoUrl);
    final isFrench = lang == 'fr';
    final isPortuguese = lang.startsWith('pt');
    final isJapanese = lang == 'ja';
    final isChinese = lang == 'zh-hans';

    String getTitle() {
      if (isGerman) return 'Hilfe & Dokumentation';
      if (isFrench) return 'Aide & Documentation';
      if (isPortuguese) return 'Ajuda e Documentação';
      if (isJapanese) return 'ヘルプとドキュメント';
      if (isChinese) return '帮助与文档';
      return 'Help & Documentation';
    }

    String getSubtitle() {
      if (isGerman) return 'Hier erfährst du, was das PB Translation Hub ist und warum wir die Beschreibungen der Projekte im Drupal Project Browser unbedingt übersetzen sollten.';
      if (isFrench) return 'Découvrez ce qu\'est le PB Translation Hub et pourquoi il est essentiel de traduire les descriptions des projets dans le Drupal Project Browser.';
      if (isPortuguese) return 'Saiba o que é o PB Translation Hub e por que é essencial traduzir as descrições dos projetos no Drupal Project Browser.';
      if (isJapanese) return 'PB Translation Hubとは何か、指示通りに翻訳することがなぜ不可欠なのかを学びましょう。';
      if (isChinese) return '了解什么是 PB Translation Hub，以及为什么翻译 Drupal Project Browser 中的项目描述至关重要。';
      return 'Learn what the PB Translation Hub is and why it is essential to translate project descriptions in the Drupal Project Browser.';
    }

    String getMission() {
      if (isGerman) return 'Unsere Mission';
      if (isFrench) return 'Notre Mission';
      if (isPortuguese) return 'Nossa Missão';
      if (isJapanese) return '私たちの使命';
      if (isChinese) return '我们的使命';
      return 'Our Mission';
    }

    String getQuote() {
      if (isGerman) return '"Sprache ist Vertrauen"';
      if (isFrench) return '"La langue est une question de confiance"';
      if (isPortuguese) return '"Linguagem é Confiança"';
      if (isJapanese) return '「言語は信頼である」';
      if (isChinese) return '“语言即信任”';
      return '"Language is Trust"';
    }

    String getPhilosophyWhy() {
      if (isGerman) return 'Warum wir tun, was wir tun: Simon Sineks "Why" für den Translation Hub.';
      if (isFrench) return 'Pourquoi nous faisons ce que nous faisons : le "Why" de Simon Sinek pour le Hub.';
      if (isPortuguese) return 'Por que fazemos o que fazemos: O "Why" de Simon Sinek para o Translation Hub.';
      if (isJapanese) return '私たちがこれを行う理由：Translation Hubのためのサイモン・シネックの「Why」。';
      if (isChinese) return '我们为什么这么做：西蒙·斯涅克为翻译中心提出的“为什么”。';
      return 'Why we do what we do: Simon Sinek\'s "Why" for the Translation Hub.';
    }

    Widget getBodyText() {
      if (isGerman) {
        return const Text(
          'Stell dir vor, du stehst vor einem Regal voller Werkzeuge, aber alle Beschreibungen sind in einer Sprache verfasst, die du nur zur Hälfte verstehst. Würdest du diesem Werkzeug dein Projekt anvertrauen? '
          'Genau dieses Szenario untersuchte die bahnbrechende Studie "Can\'t Read, Won\'t Buy". Sie liefert den wissenschaftlichen Beweis dafür, dass Sprache nicht nur ein "Bonus" ist, sondern das Fundament für Vertrauen und Akzeptanz bildet. '
          'Die Studie befragte tausende Nutzer in globalen Schlüsselmärkten:',
          style: TextStyle(fontSize: 16, height: 1.5),
        );
      }
      if (isJapanese) {
        return const Text(
          '説明が半分しか理解できない言語で書かれたツールが並ぶ棚の前に立っていることを想像してください。そのツールをプロジェクトで信頼できますか？'
          'これがまさに、画期的な研究「Can\'t Read, Won\'t Buy」が調査したシナリオです。この研究は、言語が単なる「ボーナス」ではなく、信頼と採用の根本的な基盤であることを科学的に証明しています。'
          '研究では、主要なグローバル市場の数千人のユーザーを対象に調査が行われました：',
          style: TextStyle(fontSize: 16, height: 1.5),
        );
      }
      return const Text(
        'Imagine standing in front of a shelf full of tools, but all the descriptions are written in a language you only half-understand. Would you trust these tools with your project? '
        'This is exactly the scenario explored by the groundbreaking study "Can\'t Read, Won\'t Buy". It provides scientific proof that language isn\'t just a "bonus"—it\'s the very foundation of trust and adoption. '
        'The study surveyed thousands of users across major global markets:',
        style: TextStyle(fontSize: 16, height: 1.5),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header Panel
          GlassContainer(
            borderRadius: 32,
            border: Border.all(color: attrs.borderMain),
            padding: const EdgeInsets.all(48),
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: attrs.brand600,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: attrs.brand600.withOpacity(0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      )
                    ],
                  ),
                  child: const Icon(LucideIcons.helpCircle, size: 40, color: Colors.white),
                ),
                const SizedBox(height: 24),
                Text(
                  getTitle(),
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: attrs.textMain,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  getSubtitle(),
                  style: TextStyle(
                    fontSize: 18,
                    color: attrs.textMuted,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Philosophy Panel
          GlassContainer(
            borderRadius: 32,
            border: Border.all(color: attrs.borderMain),
            padding: const EdgeInsets.all(48),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: attrs.brand600.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: attrs.brand600.withOpacity(0.2)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(LucideIcons.globe, size: 14, color: attrs.brand600),
                            const SizedBox(width: 8),
                            Text(
                              getMission(),
                              style: TextStyle(
                                color: attrs.brand600,
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        getQuote(),
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: attrs.textMain,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        getPhilosophyWhy(),
                        style: TextStyle(
                          fontSize: 16,
                          color: attrs.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 48),
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultTextStyle(
                        style: TextStyle(color: attrs.textMain),
                        child: getBodyText(),
                      ),
                      const SizedBox(height: 24),
                      
                      // Stat Cards
                      _statCard(
                        '72.4%',
                        isJapanese ? '好み（コンフォートゾーン）' : (isGerman ? 'Präferenz (Komfortzone)' : 'Preference (Comfort Zone)'),
                        isJapanese
                            ? 'サイトビルダーの約4分の3が、母国語の説明があるモジュールを本能的に好みます。安心感と親しみやすさを感じるからです。'
                            : (isGerman
                            ? 'Fast drei Viertel der Site-Builder bevorzugen Module in ihrer Sprache. Es fühlt sich sicherer und vertrauter an.'
                            : 'Nearly three-quarters of site builders instinctively prefer modules with descriptions in their native language.'),
                        attrs,
                      ),
                      const SizedBox(height: 12),
                      _statCard(
                        '52.4%',
                        isJapanese ? '必要性（ハードな境界）' : (isGerman ? 'Notwendigkeit (Die harte Grenze)' : 'Necessity (The Hard Boundary)'),
                        isJapanese
                            ? '世界のユーザーの半数以上が、英語のみで提供されているモジュールは検討すらしません。'
                            : (isGerman
                            ? 'Über die Hälfte der Nutzer ignoriert ein Modul komplett, wenn die Beschreibung nur auf Englisch ist.'
                            : 'Over half of global users won\'t even consider a module if it is presented exclusively in English.'),
                        attrs,
                      ),
                      const SizedBox(height: 12),
                      _statCard(
                        '67%',
                        isJapanese ? '信頼と品質' : (isGerman ? 'Vertrauen & Qualität' : 'Trust & Quality'),
                        isJapanese
                            ? '言語が信頼を決定します。プロフェッショナルなローカライズ表示は、コードの品質と結びつけられます。'
                            : (isGerman
                            ? 'Sprache entscheidet über Vertrauen. Eine professionelle deutsche Präsentation wird mit Sorgfalt im Code assoziiert.'
                            : 'Language determines trust. A professional localized presentation is associated with code quality.'),
                        attrs,
                      ),
                      const SizedBox(height: 24),
                      
                      TextButton.icon(
                        onPressed: () => context.push('/help/crwb'),
                        icon: const Icon(LucideIcons.bookOpen, size: 14),
                        label: Text(
                          isJapanese
                              ? '元の研究を読む'
                              : (isGerman
                              ? 'Originalstudie lesen'
                              : 'Read original study'),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: attrs.brand600,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Shortcuts Panel
          GlassContainer(
            borderRadius: 32,
            border: Border.all(color: attrs.borderMain),
            padding: const EdgeInsets.all(48),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: attrs.brand600.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(LucideIcons.layout, size: 28, color: attrs.brand600),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        isJapanese ? '生産性ショートカット' : (isGerman ? 'Produktivitäts-Shortcuts' : 'Productivity Shortcuts'),
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: attrs.textMain,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        isJapanese
                            ? 'CKEditorにフォーカスがある状態でもショートカットは機能します。'
                            : (isGerman
                            ? 'Tastenkombinationen funktionieren auch wenn der CKEditor fokussiert ist.'
                            : 'Shortcuts work even when the CKEditor is focused.'),
                        style: TextStyle(
                          fontSize: 16,
                          color: attrs.textMuted,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 48),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Editor shortcuts
                      Text(
                        isJapanese ? '翻訳エディター' : (isGerman ? 'Übersetzungs-Editor' : 'Translation Editor'),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: attrs.textMuted,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      GlassContainer(
                        borderRadius: 16,
                        border: Border.all(color: attrs.borderMain),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            _shortcutRow(isJapanese ? '保存して次へ' : (isGerman ? 'Speichern & Weiter' : 'Save & Next'), 'S', attrs, isGerman: isGerman),
                            _shortcutRow(isJapanese ? 'プレビュー切替' : (isGerman ? 'Vorschau umschalten' : 'Toggle Preview'), 'P', attrs, showCtrl: false, isGerman: isGerman),
                            _shortcutRow(isJapanese ? '次のプロジェクト' : (isGerman ? 'Nächstes Projekt' : 'Next Project'), 'D', attrs, isGerman: isGerman),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Review shortcuts
                      Text(
                        isJapanese ? 'レビュー画面' : (isGerman ? 'Review-Screen' : 'Review Screen'),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: attrs.textMuted,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      GlassContainer(
                        borderRadius: 16,
                        border: Border.all(color: attrs.borderMain),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            _shortcutRow(isJapanese ? '提案を保存' : (isGerman ? 'Vorschlag speichern' : 'Save Suggestion'), 'S', attrs, isGerman: isGerman),
                            _shortcutRow(isJapanese ? '承認' : (isGerman ? 'Freigeben' : 'Approve'), 'Enter', attrs, showAlt: false, isGerman: isGerman),
                            _shortcutRow(isJapanese ? '次のレビュー' : (isGerman ? 'Nächste Review' : 'Next Review'), '→', attrs, showAlt: false, isGerman: isGerman),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Video / Tutorial Panel
          // - Loading: shows a skeleton while the server responds.
          // - Error:   shows a hint when the /config/help-videos endpoint is
          //            unreachable (server not started or not yet deployed).
          // - No ID:   hidden when the env variables are not configured.
          // - Has ID:  shows GDPR consent wall → YouTube embed after consent.
          if (videoLoading)
            GlassContainer(
              borderRadius: 32,
              border: Border.all(color: attrs.borderMain),
              padding: const EdgeInsets.all(48),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: attrs.brand600,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      isJapanese
                          ? 'ビデオ設定を読み込み中…'
                          : (isGerman
                          ? 'Video-Konfiguration wird geladen…'
                          : 'Loading video configuration…'),
                      style: TextStyle(color: attrs.textMuted, fontSize: 13),
                    ),
                  ],
                ),
              ),
            )
          else if (videoError)
            GlassContainer(
              borderRadius: 32,
              border: Border.all(
                  color: Colors.amber.withValues(alpha: 0.3)),
              padding: const EdgeInsets.symmetric(
                  horizontal: 32, vertical: 20),
              child: Row(
                children: [
                  Icon(LucideIcons.alertTriangle,
                      size: 16, color: Colors.amber),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      isJapanese
                          ? 'ビデオパネル利用不可 — サーバーに接続できないか、.envファイルにHELP_VIDEO_DE / HELP_VIDEO_ENが設定されていません。'
                          : (isGerman
                          ? 'Video-Panel nicht verfügbar — Server nicht erreichbar oder HELP_VIDEO_DE / HELP_VIDEO_EN in der .env-Datei nicht gesetzt.'
                          : 'Video panel unavailable — server not reachable or HELP_VIDEO_DE / HELP_VIDEO_EN not set in the .env file.'),
                      style: TextStyle(
                          color: Colors.amber.withValues(alpha: 0.9),
                          fontSize: 12,
                          height: 1.5),
                    ),
                  ),
                ],
              ),
            )
          else if (videoId != null)
            GlassContainer(
              borderRadius: 32,
              border: Border.all(color: attrs.borderMain),
              padding: EdgeInsets.zero,
              child: Row(
                children: [
                  // Left: GDPR consent wall → YouTube embed after consent
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(32),
                        bottomLeft: Radius.circular(32),
                      ),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: ConsentYouTubePlayer(
                          videoId: videoId,
                          isGerman: isGerman,
                          attrs: attrs,
                        ),
                      ),
                    ),
                  ),

                  // Right: description text
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(48.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: attrs.brand600,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'TUTORIAL',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const CircleAvatar(
                                  radius: 4,
                                  backgroundColor: Colors.greenAccent),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Text(
                            isJapanese
                                ? 'ビデオガイド：使い方'
                                : (isGerman
                                ? 'Video-Anleitung: So funktionierts'
                                : 'Video Guide: How it works'),
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              color: attrs.textMain,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            isJapanese
                                ? 'Project Browserのモジュールをすばやくローカライズするために、Hubを最大限に活用する方法をご覧ください。'
                                : (isGerman
                                ? 'Schau dir an, wie du den Hub optimal nutzt, um Module blitzschnell für den Project Browser zu lokalisieren.'
                                : 'Watch how to optimally use the Hub to localize modules for the Project Browser in no time.'),
                            style: TextStyle(
                              fontSize: 16,
                              color: attrs.textMuted,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 24),
                          _tutorialBullet(
                              LucideIcons.layers,
                              isJapanese
                                  ? 'プロジェクトリストフィルターの活用法'
                                  : (isGerman
                                  ? 'Projekt-Listen-Filter effektiv nutzen'
                                  : 'Using project list filters effectively'),
                              attrs),
                          _tutorialBullet(
                              LucideIcons.messageSquare,
                              isJapanese
                                  ? 'AI翻訳の精度を高める'
                                  : (isGerman
                                  ? 'KI-Übersetzungen verfeinern'
                                  : 'Refining AI translations'),
                              attrs),
                          _tutorialBullet(
                              LucideIcons.layout,
                              isJapanese
                                  ? 'Project Browserでのプレビュー'
                                  : (isGerman
                                  ? 'Vorschau im Project Browser'
                                  : 'Preview in Project Browser'),
                              attrs),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _statCard(String val, String title, String desc, ThemeAttributes attrs) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: attrs.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: attrs.borderMain),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            val,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: attrs.brand600,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: attrs.textMain,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: TextStyle(
                    fontSize: 12,
                    color: attrs.textMuted,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Renders one shortcut row.
  ///
  /// [showCtrl]  — include the CTRL/STRG chip (default true).
  /// [showAlt]   — include the ALT chip (default true).
  /// [isGerman]  — use German key labels (STRG instead of CTRL).
  ///
  /// Examples:
  ///   Editor "Save & Next"    → showCtrl:true,  showAlt:true  → CTRL + ALT + S
  ///   Editor "Toggle Preview" → showCtrl:false, showAlt:true  → ALT + P
  ///   Review "Save"           → showCtrl:true,  showAlt:true  → CTRL + ALT + S
  Widget _shortcutRow(
    String label,
    String key,
    ThemeAttributes attrs, {
    bool showCtrl = true,
    bool showAlt = true,
    bool isGerman = false,
  }) {
    final ctrlLabel = isGerman ? 'STRG' : 'CTRL';
    final chips = <Widget>[];

    void addChip(String text, {bool accent = false}) {
      if (chips.isNotEmpty) {
        chips.add(const SizedBox(width: 4));
        chips.add(Text('+', style: TextStyle(color: attrs.textMuted, fontSize: 10)));
        chips.add(const SizedBox(width: 4));
      }
      chips.add(_kbd(text, attrs, isAccent: accent));
    }

    if (showCtrl) addChip(ctrlLabel);
    if (showAlt)  addChip('ALT');
    addChip(key, accent: true);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: attrs.textMuted, fontWeight: FontWeight.bold),
          ),
          Row(children: chips),
        ],
      ),
    );
  }

  Widget _kbd(String text, ThemeAttributes attrs, {bool isAccent = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isAccent ? attrs.brand600.withOpacity(0.2) : attrs.bgInput,
        border: Border.all(
          color: isAccent ? attrs.brand600.withOpacity(0.2) : attrs.borderMain,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: isAccent ? attrs.brand600 : attrs.textMain,
        ),
      ),
    );
  }

  Widget _tutorialBullet(IconData icon, String text, ThemeAttributes attrs) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: attrs.bgInput,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: attrs.borderMain),
            ),
            child: Icon(icon, size: 16, color: attrs.brand600),
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(
              color: attrs.textMain,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
