import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import 'audio_player_stub.dart'
    if (dart.library.html) 'audio_player_web.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import '../../providers/theme_provider.dart';
import '../../providers/language_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_container.dart';

// ── Data helpers ──────────────────────────────────────────────────────────────

class _StatItem {
  const _StatItem(this.labelEn, this.labelDe, this.pct,
      {this.noteEn, this.noteDe, this.labelJa, this.noteJa});
  final String labelEn;
  final String labelDe;
  final String? labelJa;
  final double pct;
  final String? noteEn;
  final String? noteDe;
  final String? noteJa;
}

class _CountryRow {
  const _CountryRow(
      this.flag,
      this.countryEn, this.countryDe, this.countryJa,
      this.languageEn, this.languageDe, this.languageJa,
      this.highlightEn, this.highlightDe, this.highlightJa);
  final String flag;
  final String countryEn;
  final String countryDe;
  final String countryJa;
  final String languageEn;
  final String languageDe;
  final String languageJa;
  final String highlightEn;
  final String highlightDe;
  final String highlightJa;
}

// ── Screen ────────────────────────────────────────────────────────────────────

/// Embeds the full content of "Can't Read, Won't Buy: Why Language Matters on
/// Global Websites" (Common Sense Advisory, September 2006).
///
/// Trilingual: DE / EN / JA depending on the app's active target language.
///
/// Source: DePalma, D. A., Sargent, B. B., & Beninatto, R. S. (2006).
/// Can't Read, Won't Buy. Common Sense Advisory, Inc.
class CrwbStudyScreen extends ConsumerStatefulWidget {
  const CrwbStudyScreen({super.key});

  @override
  ConsumerState<CrwbStudyScreen> createState() => _CrwbStudyScreenState();
}

class _CrwbStudyScreenState extends ConsumerState<CrwbStudyScreen> {
  // dart:html AudioElement is only used on web (guarded by kIsWeb).
  // We hold a dynamic reference to avoid importing dart:html in this file.
  dynamic _audio;
  bool _isPlaying = false;

  /// Pick the string for the active language.
  /// Falls back to English when [japanese] is null and lang == 'ja'.
  static String _t(String lang, String german, String english,
      [String? japanese]) {
    if (lang == 'ja' && japanese != null) return japanese;
    return lang == 'de' ? german : english;
  }

  void _toggleAudio(String lang) {
    if (!kIsWeb) return; // Audio playback only supported on web.

    if (_isPlaying) {
      AudioWebPlayer.pause(_audio);
      setState(() => _isPlaying = false);
      return;
    }

    // Japanese falls back to English audio until a JA recording is available.
    final url = lang == 'de' ? '/audio/crwb_de.mp3' : '/audio/crwb_en.mp3';
    AudioWebPlayer.play(
      url: url,
      onEnded: () {
        if (mounted) setState(() => _isPlaying = false);
      },
      onError: () {
        if (mounted) {
          setState(() => _isPlaying = false);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(_t(
              lang,
              'Audio-Datei noch nicht verfügbar. Bitte zuerst generieren.',
              'Audio file not yet available. Please generate it first.',
              'オーディオファイルはまだ利用できません。最初に生成してください。',
            )),
            backgroundColor: Colors.orange.shade700,
          ));
        }
      },
      setAudio: (a) => _audio = a,
    );
    setState(() => _isPlaying = true);
  }

  @override
  void dispose() {
    if (kIsWeb) AudioWebPlayer.pause(_audio);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = ref.watch(themeProvider);
    final attrs = AppTheme.getAttributes(themeState.themeId);
    final langState = ref.watch(languageProvider);
    final lang = langState.targetLanguage.code;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildBackButton(context, attrs, lang),
          const SizedBox(height: 24),
          _buildHero(attrs, lang),
          const SizedBox(height: 32),
          _buildAbstract(attrs, lang),
          const SizedBox(height: 32),
          _buildDemographics(attrs, lang),
          const SizedBox(height: 32),
          _buildFinding1(attrs, lang),
          const SizedBox(height: 32),
          _buildFinding2(attrs, lang),
          const SizedBox(height: 32),
          _buildFinding3(attrs, lang),
          const SizedBox(height: 32),
          _buildFinding4(attrs, lang),
          const SizedBox(height: 32),
          _buildFinding5(attrs, lang),
          const SizedBox(height: 32),
          _buildFinding6(attrs, lang),
          const SizedBox(height: 32),
          _buildFinding7(attrs, lang),
          const SizedBox(height: 32),
          _buildFinding8(attrs, lang),
          const SizedBox(height: 32),
          _buildAbandonmentFunnel(attrs, lang),
          const SizedBox(height: 32),
          _buildConclusions(attrs, lang),
          const SizedBox(height: 32),
          _buildCitation(attrs, lang),
          const SizedBox(height: 48),
        ],
      ),
    );
  }

  // ── Back button ───────────────────────────────────────────────────────────

  Widget _buildBackButton(
      BuildContext context, ThemeAttributes attrs, String lang) {
    return Row(
      children: [
        TextButton.icon(
          onPressed: () => context.go('/help'),
          icon: Icon(LucideIcons.arrowLeft, size: 16, color: attrs.brand600),
          label: Text(
            _t(lang, 'Zurück zur Hilfe', 'Back to Help', 'ヘルプに戻る'),
            style:
                TextStyle(color: attrs.brand600, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }

  // ── Hero ──────────────────────────────────────────────────────────────────

  Widget _buildHero(ThemeAttributes attrs, String lang) {
    return GlassContainer(
      borderRadius: 32,
      border: Border.all(color: attrs.borderMain),
      padding: const EdgeInsets.all(48),
      backgroundColor: attrs.bgCard,
      child: Column(
        children: [
          // Publisher badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFE07B20).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: const Color(0xFFE07B20).withValues(alpha: 0.4)),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(LucideIcons.building2,
                    size: 12, color: Color(0xFFE07B20)),
                SizedBox(width: 6),
                Text(
                  'Common Sense Advisory, Inc.',
                  style: TextStyle(
                    color: Color(0xFFE07B20),
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          Text(
            "Can't Read, Won't Buy",
            style: TextStyle(
              fontSize: 44,
              fontWeight: FontWeight.w900,
              color: attrs.textMain,
              height: 1.1,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            _t(lang,
                'Warum Sprache auf globalen Websites eine Rolle spielt',
                'Why Language Matters on Global Websites',
                'グローバルウェブサイトにおいて言語が重要な理由'),
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w400,
              color: attrs.brand600,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            _t(lang,
                'Eine internationale Umfrage zu globalen Kaufpräferenzen von Verbrauchern',
                'An International Survey of Global Consumer Buying Preferences',
                '国際的な消費者の購買嗜好に関するグローバル調査'),
            style: TextStyle(
              fontSize: 16,
              color: attrs.textMuted,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 24,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              _metaChip(
                LucideIcons.users,
                'Donald A. DePalma, Benjamin B. Sargent, Renato S. Beninatto',
                attrs,
              ),
              _metaChip(LucideIcons.calendar, 'September 2006', attrs),
              _audioChip(attrs, lang),
            ],
          ),
        ],
      ),
    );
  }

  Widget _metaChip(IconData icon, String text, ThemeAttributes attrs) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: attrs.textMuted),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
              fontSize: 12,
              color: attrs.textMuted,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _audioChip(ThemeAttributes attrs, String lang) {
    if (!kIsWeb) return const SizedBox.shrink(); // Audio not available on desktop.
    return GestureDetector(
      onTap: () => _toggleAudio(lang),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: _isPlaying
                ? attrs.brand600.withValues(alpha: 0.2)
                : Colors.white.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _isPlaying
                  ? attrs.brand600.withValues(alpha: 0.6)
                  : attrs.borderMain,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _isPlaying ? LucideIcons.pause : LucideIcons.volume2,
                size: 13,
                color: _isPlaying ? attrs.brand600 : attrs.textMuted,
              ),
              const SizedBox(width: 6),
              Text(
                _isPlaying
                    ? _t(lang, 'Pausieren', 'Pause', '一時停止')
                    : _t(lang,
                        'Studienergebnisse vorlesen lassen',
                        'Read study aloud',
                        '研究結果を読み上げる'),
                style: TextStyle(
                  fontSize: 12,
                  color: _isPlaying ? attrs.brand600 : attrs.textMuted,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Abstract ──────────────────────────────────────────────────────────────

  Widget _buildAbstract(ThemeAttributes attrs, String lang) {
    return _section(
      icon: LucideIcons.fileText,
      title: _t(lang, 'Zusammenfassung', 'Executive Summary', 'エグゼクティブ・サマリー'),
      attrs: attrs,
      lang: lang,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _body(
            _t(lang,
                'Unternehmen aller Größen investieren konsequent Marketing-, Vertriebs-, Support- und '
                    'Produktentwicklungsbudgets, um Interessenten zu überzeugen – selbst wenn es sich um '
                    'unvollständige oder fehlerhafte Übersetzungen handelt. Die Annahme, potenzielle Käufer '
                    'könnten „wahrscheinlich Englisch", führt zu unzureichender Lokalisierung und widerspricht '
                    'dem Bauchgefühl, dass Menschen keine Produkte kaufen, die sie weder verstehen noch die '
                    'sie ansprechen.',
                'Companies large and small religiously devote marketing, sales, support, '
                    'and product-development funds to educating prospects and convincing them '
                    'of their products\' value -- even when it comes to incomplete or inaccurate '
                    'translations. The assumption that potential buyers "probably speak English" '
                    'drives inadequate localization, warning against the gut feeling that people '
                    'are unlikely to buy products they cannot understand or that do not appeal to them.',
                '大小を問わず多くの企業が、マーケティング・営業・サポート・製品開発の予算を惜しみなく投入して見込み顧客を説得し続けています──'
                    'たとえ翻訳が不完全・不正確であっても。「見込み客はおそらく英語を話せる」という思い込みが、不十分なローカライズを招いています。'
                    'これは「自分が理解できない、あるいは魅力を感じない製品は買わない」という消費者の本能に反しています。'),
            attrs,
          ),
          const SizedBox(height: 16),
          _body(
            _t(lang,
                'Dieser Bericht beschreibt die Ergebnisse einer Umfrage in acht Ländern, die im Juli und '
                    'August 2006 durchgeführt wurde. Mehr als 2.400 Verbraucher beantworteten Fragen zu ihrem '
                    'Verhalten und ihren Präferenzen beim Besuch von Websites und beim Online-Kauf – auf '
                    'Englisch und in ihrer Muttersprache – für eine breite Palette von Produktkategorien.',
                'This report describes the results of an eight-nation survey conducted in '
                    'July and August 2006. It includes responses from over 2,400 consumers who '
                    'answered questions about their behavior and preferences for website visits '
                    'and purchases, in English and in their own language, across a wide range '
                    'of product types.',
                '本レポートは、2006年7月・8月に実施した8カ国調査の結果をまとめたものです。'
                    'オンラインで購入経験を持つ2,400人以上の消費者が、英語サイトと母国語サイトそれぞれにおける'
                    'ウェブサイト訪問・オンライン購買の行動と嗜好について回答しました。対象は幅広い製品カテゴリーにわたります。'),
            attrs,
          ),
          const SizedBox(height: 20),
          _highlight(
            _t(lang,
                'Die Umfrage erstreckte sich über drei Kontinente. Zur Einladung der Teilnehmer wurde ein '
                    'externes Verbraucherpanel genutzt. Die Stichprobe umfasste mindestens 300 Verbraucher aus '
                    'jeweils Brasilien, China (VR), Frankreich, Deutschland, Japan, Russland, Spanien und der Türkei.',
                'The survey crossed three continents. We used a third-party consumer panel '
                    'company to invite participation from a global online poll and analyze the '
                    'results. Our sample represented three continents, with at least 300 '
                    'consumers each from Brazil, China (PRC), France, Germany, Japan, Russia, '
                    'Spain, and Turkey.',
                '調査は三大陸に及びました。サードパーティのコンシューマーパネル企業を活用し、グローバルオンライン調査への参加を呼びかけました。'
                    '標本はブラジル・中国（中華人民共和国）・フランス・ドイツ・日本・ロシア・スペイン・トルコから各国最低300名ずつで構成されています。'),
            attrs,
          ),
          const SizedBox(height: 12),
          _highlight(
            _t(lang,
                'Die meisten Menschen kaufen bevorzugt in ihrer eigenen Sprache. Da nur Online-Käufer '
                    'befragt wurden, sind die Ergebnisse repräsentativ für „Käufer" und nicht für Besucher '
                    'allgemein. Mehr als die Hälfte der Stichprobe (52,4 %) kauft ausschließlich auf '
                    'Websites, auf denen Informationen in der eigenen Sprache angeboten werden.',
                'Most people prefer buying in their own language. Our data set only includes '
                    'web users who purchased online, so results are representative of "buyers" '
                    'rather than visitors in general. More than half our sample (52.4%) buys only '
                    'at websites where the information is presented in their language.',
                'ほとんどの人は母国語での購入を好みます。データには購入経験のあるウェブユーザーのみが含まれるため、'
                    '結果は訪問者全般ではなく「購買者」を代表しています。回答者の半数以上（52.4%）が、'
                    '自国語で情報が提供されているウェブサイトでのみ購入すると答えました。'),
            attrs,
          ),
        ],
      ),
    );
  }

  // ── Demographics ──────────────────────────────────────────────────────────

  Widget _buildDemographics(ThemeAttributes attrs, String lang) {
    const countries = [
      _CountryRow(
        '\u{1F1E7}\u{1F1F7}',
        'Brazil', 'Brasilien', 'ブラジル',
        'Portuguese', 'Portugiesisch', 'ポルトガル語',
        'Strong preference for native language; 52.4 % buy only in their own language.',
        'Starke Präferenz für die Muttersprache; 52,4 % kaufen ausschließlich in ihrer eigenen Sprache.',
        '母国語への強い嗜好あり。52.4%が自国語サイトでのみ購入。',
      ),
      _CountryRow(
        '\u{1F1E8}\u{1F1F3}',
        'China (PRC)', 'China (VR)', '中国（中華人民共和国）',
        'Chinese (Simplified)', 'Chinesisch (Vereinfacht)', '中国語（簡体字）',
        'Brand loyalty highest globally -- 90.3 % factor brand in purchase decisions.',
        'Markentreue weltweit am höchsten – 90,3 % berücksichtigen die Marke bei Kaufentscheidungen.',
        '世界最高水準のブランド忠誠心──90.3%が購買決定にブランドを考慮。',
      ),
      _CountryRow(
        '\u{1F1EB}\u{1F1F7}',
        'France', 'Frankreich', 'フランス',
        'French', 'Französisch', 'フランス語',
        '66.5 % buy only in French -- highest single-language purchase preference in the study.',
        '66,5 % kaufen ausschließlich auf Französisch – die höchste Einzelsprachpräferenz beim Kauf in der Studie.',
        '66.5%がフランス語サイトのみで購入──本調査で最高の単一言語購買嗜好率。',
      ),
      _CountryRow(
        '\u{1F1E9}\u{1F1EA}',
        'Germany', 'Deutschland', 'ドイツ',
        'German', 'Deutsch', 'ドイツ語',
        'Strong global brand tolerance; 47.3 % favor a global brand with local language info.',
        'Hohe globale Markentoleranz; 47,3 % bevorzugen eine globale Marke mit lokalen Sprachinformationen.',
        'グローバルブランドへの高い許容度；47.3%が母国語情報付きのグローバルブランドを好む。',
      ),
      _CountryRow(
        '\u{1F1EF}\u{1F1F5}',
        'Japan', 'Japan', '日本',
        'Japanese', 'Japanisch', '日本語',
        '65.6 % buy only in Japanese; 87.6 % visit English sites at least monthly.',
        '65,6 % kaufen ausschließlich auf Japanisch; 87,6 % besuchen englische Websites mindestens einmal im Monat.',
        '65.6%が日本語サイトでのみ購入；87.6%が英語サイトを月1回以上訪問。',
      ),
      _CountryRow(
        '\u{1F1F7}\u{1F1FA}',
        'Russia', 'Russland', 'ロシア',
        'Russian', 'Russisch', 'ロシア語',
        '41.2 % choose a global brand with local language info over cheaper alternatives.',
        '41,2 % wählen eine globale Marke mit lokalen Sprachinformationen gegenüber günstigeren Alternativen.',
        '41.2%が安価な代替品よりも母国語情報付きのグローバルブランドを選択。',
      ),
      _CountryRow(
        '\u{1F1EA}\u{1F1F8}',
        'Spain', 'Spanien', 'スペイン',
        'Spanish', 'Spanisch', 'スペイン語',
        'Higher tolerance for English sites compared to other nations surveyed.',
        'Höhere Toleranz gegenüber englischen Websites im Vergleich zu anderen befragten Ländern.',
        '他の調査国と比較して英語サイトへの許容度が高い。',
      ),
      _CountryRow(
        '\u{1F1F9}\u{1F1F7}',
        'Turkey', 'Türkei', 'トルコ',
        'Turkish', 'Türkisch', 'トルコ語',
        'Language competence significantly drives visit frequency to English sites.',
        'Sprachkompetenz beeinflusst die Häufigkeit der Besuche englischsprachiger Websites erheblich.',
        '英語力が英語サイトの訪問頻度を大きく左右する。',
      ),
    ];

    return _section(
      icon: LucideIcons.globe,
      title: _t(lang,
          'Umfragedemografie: 2.430 Verbraucher in acht Ländern',
          'Survey Demographics: 2,430 Consumers in Eight Countries',
          '調査統計：8カ国2,430人の消費者'),
      attrs: attrs,
      lang: lang,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _body(
            _t(lang,
                'Die Umfrage wurde im Juli und August 2006 unter 2.430 Internetnutzern durchgeführt, '
                    'die bereits online eingekauft hatten. Die Mehrheit waren Frauen (57 %). Die Teilnehmenden '
                    'verteilten sich auf alle Altersgruppen: 26–35 Jahre (24 %), 36–45 Jahre (26 %), '
                    '46–55 Jahre (31 %) und über 41 Jahre (24 %). Die meisten nutzten das Internet von '
                    'zu Hause (72,1 %), mit Hochgeschwindigkeitsverbindungen bei der Arbeit (46,3 %). '
                    'Die Teilnehmenden bewerteten ihre Englischkenntnisse auf einer fünfstufigen Skala '
                    'von „kein Englisch" bis „fließend".',
                'The survey was conducted in July and August 2006 among 2,430 web users '
                    'who had purchased online. The majority were women (57 %). Participants '
                    'spanned all age groups: 26-35 (24 %), 36-45 (26 %), 46-55 (31 %), and '
                    '41+ (24 %). Most accessed the internet from home (72.1 %), with high-speed '
                    'connections at work (46.3 %). Participants self-described English competence '
                    'across five levels from "no English" to "fluent".',
                '調査は2006年7月・8月、オンラインで購入したことのある2,430名のウェブユーザーを対象に実施されました。'
                    '回答者の過半数は女性（57%）。年齢層は26〜35歳（24%）・36〜45歳（26%）・46〜55歳（31%）・41歳以上（24%）と幅広い層にわたりました。'
                    '自宅からのインターネット利用が72.1%と最多で、職場での高速回線利用は46.3%。'
                    '英語力は「英語ゼロ」から「流暢」まで5段階で自己申告されています。'),
            attrs,
          ),
          const SizedBox(height: 20),
          ...countries.map((c) => _countryTile(c, attrs, lang)),
        ],
      ),
    );
  }

  Widget _countryTile(_CountryRow c, ThemeAttributes attrs, String lang) {
    final country   = lang == 'ja' ? c.countryJa   : (lang == 'de' ? c.countryDe   : c.countryEn);
    final language  = lang == 'ja' ? c.languageJa  : (lang == 'de' ? c.languageDe  : c.languageEn);
    final highlight = lang == 'ja' ? c.highlightJa : (lang == 'de' ? c.highlightDe : c.highlightEn);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: attrs.bgCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: attrs.borderMain),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(c.flag, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(country,
                        style: TextStyle(
                            color: attrs.textMain,
                            fontWeight: FontWeight.w800,
                            fontSize: 14)),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: attrs.brand600.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(language,
                          style: TextStyle(
                              color: attrs.brand600,
                              fontSize: 10,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  highlight,
                  style: TextStyle(
                      color: attrs.textMuted, fontSize: 12, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Finding 1 ─────────────────────────────────────────────────────────────

  Widget _buildFinding1(ThemeAttributes attrs, String lang) {
    return _section(
      icon: LucideIcons.mousePointerClick,
      title: _t(lang,
          'Englischsprachige Websites ziehen ausländische Besucher an',
          'English-Language Sites Attract Foreign Visitors',
          '英語サイトは海外からの訪問者を引き付ける'),
      number: '01',
      attrs: attrs,
      lang: lang,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _body(
            _t(lang,
                'Ob von amerikanischen, englischen, australischen oder auch nicht-anglophonen Unternehmen '
                    'betrieben – globale Websites ziehen Besucher aus aller Welt an. Mehr als zwei Drittel '
                    '(67,4 %) der Stichprobe aus acht Ländern besuchten englische Websites mindestens einmal '
                    'im Monat, während fast ein Drittel (32,6 %) die meiste oder gesamte Zeit auf Websites '
                    'in der Muttersprache verbrachte.',
                'Whether hosted by American, English, Australian, or even non-Anglophone '
                    'companies, global websites attract visitors from around the world. Over '
                    'two-thirds (67.4 %) of the eight-nation sample fell into the "visits at '
                    'least monthly" category, while nearly one-third (32.6 %) spent most or '
                    'all of their time on sites in their native language.',
                'アメリカ・イギリス・オーストラリア、あるいは非英語圏企業が運営するものを問わず、グローバルウェブサイトは世界中から訪問者を集めます。'
                    '8カ国サンプルの3分の2以上（67.4%）が「英語サイトに月1回以上訪問する」カテゴリーに属し、'
                    '約3分の1（32.6%）が母国語サイトで大半または全ての時間を過ごしていました。'),
            attrs,
          ),
          const SizedBox(height: 20),
          _bar(_StatItem(
            'Visit English-language sites at least monthly',
            'Besuchen englischsprachige Websites mindestens einmal monatlich',
            67.4,
            labelJa: '月1回以上英語サイトを訪問',
          ), attrs, lang),
          _bar(_StatItem(
            'Prefer most/all time on native-language sites',
            'Verbringen die meiste/gesamte Zeit auf muttersprachlichen Websites',
            72.1,
            labelJa: '母国語サイトで大半または全ての時間を過ごすことを好む',
          ), attrs, lang),
          _bar(_StatItem(
            'No/low English: rarely or never visit English sites (approx.)',
            'Kein/geringes Englisch: besuchen englische Websites selten oder nie (ca.)',
            45.0,
            noteEn: '6x more likely to avoid English sites than proficient speakers',
            noteDe: '6-mal häufiger englische Websites gemieden als bei sprachkundigen Nutzern',
            labelJa: '英語力低/なし：英語サイトをほとんど・全く訪問しない（推定）',
            noteJa: '英語に自信のある話者と比べて英語サイトを避ける確率が6倍高い',
          ), attrs, lang),
          const SizedBox(height: 16),
          _body(
            _t(lang,
                'Manche Nationalitäten besuchen englische Websites seltener. Das Herkunftsland bestimmt '
                    'die Besuchshäufigkeit – 59 % der französischen und 87,6 % der türkischen Befragten '
                    'erschienen mindestens einmal im Monat.',
                'Some nationalities are less inclined to visit English sites. Country of '
                    'origin determined frequency of visits -- 59 % of French respondents and '
                    '87.6 % of Turkish respondents showed up at least once a month.',
                '英語サイトを訪れる頻度は国籍によって異なります。'
                    'フランスの回答者は59%、トルコは87.6%が月1回以上アクセスしました。'),
            attrs,
          ),
        ],
      ),
    );
  }

  // ── Finding 2 ─────────────────────────────────────────────────────────────

  Widget _buildFinding2(ThemeAttributes attrs, String lang) {
    return _section(
      icon: LucideIcons.clock,
      title: _t(lang,
          'Internationale Besucher verbringen mehr Zeit auf Websites in ihrer Sprache',
          'International Visitors Spend More Time in Their Language',
          '海外訪問者は母国語サイトでより多くの時間を過ごす'),
      number: '02',
      attrs: attrs,
      lang: lang,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _body(
            _t(lang,
                'Nachdem wir festgestellt hatten, dass die Befragten englischsprachige Websites besuchten, '
                    'untersuchten wir, wie viel Zeit sie dort im Vergleich zu Websites in ihrer eigenen Sprache '
                    'verbrachten. Die meisten Menschen (72,1 %) bevorzugen muttersprachliche Websites für '
                    'längere Aufenthalte.',
                'Once we found that respondents were visiting English-language sites, we '
                    'clocked how much time they spent there compared to destinations in their '
                    'own language. Most people (72.1 %) favor quality time on native-language sites.',
                '回答者が英語サイトを訪問していることを確認した上で、母国語サイトと比べてどのくらいの時間を過ごすかを調査しました。'
                    'ほとんどの人（72.1%）が母国語サイトでの滞在を好みます。'),
            attrs,
          ),
          const SizedBox(height: 20),
          _bar(_StatItem(
            'Favor most/all time on native-language sites',
            'Bevorzugen die meiste/gesamte Zeit auf muttersprachlichen Websites',
            72.1,
            labelJa: '母国語サイトで大半または全ての時間を好む',
          ), attrs, lang),
          _bar(_StatItem(
            'Brazilians: share of visits to Portuguese sites',
            'Brasilien: Anteil der Besuche auf portugiesischsprachigen Websites',
            52.3,
            noteEn: 'Despite significant visitation to English sites',
            noteDe: 'Trotz erheblicher Besuche auf englischsprachigen Websites',
            labelJa: 'ブラジル：ポルトガル語サイトへの訪問割合',
            noteJa: '英語サイトへの相当な訪問にもかかわらず',
          ), attrs, lang),
          const SizedBox(height: 16),
          _body(
            _t(lang,
                'Sprachkenntnisse verstärken den Effekt. Teilnehmende mit keinen oder geringen '
                    'Englischkenntnissen mieden englische Websites sechsmal häufiger als versierte Sprecher. '
                    '89,3 % der Gruppe mit keinen oder geringen Englischkenntnissen verbrachten mehr '
                    'Internetzeit auf muttersprachlichen Adressen.',
                'Language competence ups the ante. Survey participants with no-or-low '
                    'confidence in English were six times more likely to avoid English sites '
                    'than their proficient counterparts. 89.3 % of no/low-English participants '
                    'said they devote more web-visiting time to native-language addresses.',
                '英語力が差をさらに広げます。英語に自信のない参加者は、自信のある参加者と比べて英語サイトを6倍以上避ける傾向がありました。'
                    '英語力低/なしの89.3%が、母国語アドレスでのウェブ閲覧時間が長いと答えました。'),
            attrs,
          ),
        ],
      ),
    );
  }

  // ── Finding 3 ─────────────────────────────────────────────────────────────

  Widget _buildFinding3(ThemeAttributes attrs, String lang) {
    return _section(
      icon: LucideIcons.shoppingCart,
      title: _t(lang,
          'Verbraucher kaufen lieber auf Websites in ihrer Sprache',
          'Consumers Prefer Buying from Sites in Their Language',
          '消費者は母国語サイトでの購入を好む'),
      number: '03',
      attrs: attrs,
      lang: lang,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _body(
            _t(lang,
                'Die meisten ausländischen Besucher kaufen nicht auf englischsprachigen Websites. '
                    'Es besteht eine starke Korrelation zwischen der Zeit, die Menschen auf einer Website '
                    'verbringen, und ihrer Kaufbereitschaft. Sprache wirkt als Bindungsfaktor, ist aber '
                    'nicht der einzige Kaufhemmnis.',
                'Most foreign visitors do not buy from English-language websites. '
                    'There is a strong correlation between time people spend on a website '
                    'and their propensity to buy. Language becomes a stickiness factor, '
                    'but it is not the only thing that limits buying.',
                '大多数の海外訪問者は英語サイトで購入しません。サイトで過ごす時間と購買意向には強い相関があります。'
                    '言語は粘着要因になりますが、購買を制限する唯一の要因ではありません。'),
            attrs,
          ),
          const SizedBox(height: 20),
          _bar(_StatItem(
            '"I only buy at websites presented in my own language" (agree/strongly agree)',
            '"Ich kaufe nur auf Websites, die in meiner Sprache präsentiert werden" (stimme zu/voll zu)',
            48.6,
            labelJa: '「自分の言語で表示されているウェブサイトでのみ購入する」（同意/強く同意）',
          ), attrs, lang),
          _bar(_StatItem(
            'France: buy only in French',
            'Frankreich: kauft ausschließlich auf Französisch',
            66.5,
            noteEn: 'Highest single-country purchase preference in study',
            noteDe: 'Höchste Einzelland-Kaufpräferenz in der Studie',
            labelJa: 'フランス：フランス語のみで購入',
            noteJa: '本調査で最高の単一国購買嗜好率',
          ), attrs, lang),
          _bar(_StatItem(
            'Japan: buy only in Japanese',
            'Japan: kauft ausschließlich auf Japanisch',
            65.6,
            labelJa: '日本：日本語のみで購入',
          ), attrs, lang),
          _bar(_StatItem(
            'English-proficient respondents agreeing',
            'Zustimmung bei englischkundigen Befragten',
            32.1,
            noteEn: 'Lowest -- comfort with English reduces exclusivity',
            noteDe: 'Niedrigster Wert – Komfort mit Englisch verringert die Exklusivität',
            labelJa: '英語に堪能な回答者の同意率',
            noteJa: '最低値──英語への慣れが排他性を低下させる',
          ), attrs, lang),
          const SizedBox(height: 16),
          _body(
            _t(lang,
                'Trotz transaktionaler Einschränkungen liefert die Kluft zwischen Besuchs- und Kaufraten '
                    'überzeugende Belege dafür, dass der Kauf eine deutlich höhere Sprachhürde aufweist '
                    'als das bloße Stöbern.',
                'Notwithstanding transactional limitations, the disparity between '
                    'visitation and buying rates offers compelling evidence that purchasing '
                    'has a higher language bar than mere browsing.',
                '取引上の制限はあるものの、訪問率と購買率の乖離は、'
                    '購入がブラウジングよりも言語ハードルが高いことを示す強力な証拠です。'),
            attrs,
          ),
        ],
      ),
    );
  }

  // ── Finding 4 ─────────────────────────────────────────────────────────────

  Widget _buildFinding4(ThemeAttributes attrs, String lang) {
    final cats = [
      _StatItem(
        'Financial & travel services', 'Finanz- & Reisedienstleistungen', 85.8,
        noteEn: 'Overall 79 %; rises to 85.8 % for financial services specifically',
        noteDe: 'Gesamt 79 %; steigt auf 85,8 % speziell für Finanzdienstleistungen',
        labelJa: '金融・旅行サービス',
        noteJa: '全体79%；金融サービス単体では85.8%まで上昇',
      ),
      _StatItem(
        'Big-ticket items (electronics, cars, appliances)',
        'Hochpreisige Produkte (Elektronik, Fahrzeuge, Haushaltsgeräte)',
        68.8,
        labelJa: '高額品（電子機器・自動車・家電）',
      ),
      _StatItem(
        'Commodities (media, CDs, consumables)',
        'Massenprodukte (Medien, CDs, Verbrauchsgüter)',
        71.0,
        labelJa: 'コモディティ（メディア・CD・消耗品）',
      ),
      _StatItem(
        'Food, personal care & household products',
        'Lebensmittel, Körperpflege & Haushaltsprodukte',
        58.4,
        labelJa: '食品・パーソナルケア・家庭用品',
      ),
    ];

    return _section(
      icon: LucideIcons.tag,
      title: _t(lang,
          'Die Bedeutung der Sprache variiert je nach Produktkategorie',
          'Language Importance Varies by Product Category',
          '言語の重要性は製品カテゴリーによって異なる'),
      number: '04',
      attrs: attrs,
      lang: lang,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _body(
            _t(lang,
                'Wir fragten die Befragten, wie wichtig es ihnen ist, Produktkommunikation (Werbung, '
                    'Etikettierung, Verpackung, Handbuch, Website, Helpdesk) in der eigenen Sprache zu '
                    'erhalten – auf einer 3-stufigen Likert-Skala ("sehr wichtig" / "wichtig" / "nicht wichtig").',
                'We asked respondents how important it was to have product communications '
                    '(advertising, labeling, packaging, user manual, website, help desk) '
                    'available in their own language, using a 3-step Likert scale '
                    '("very important" / "important" / "not important").',
                '製品コミュニケーション（広告・ラベリング・パッケージ・マニュアル・ウェブサイト・ヘルプデスク）が'
                    '自国語で提供されることの重要性を、3段階のリッカート尺度（「非常に重要」「重要」「重要でない」）で回答してもらいました。'),
            attrs,
          ),
          const SizedBox(height: 20),
          ...cats.map((r) => _bar(r, attrs, lang)),
          const SizedBox(height: 16),
          _body(
            _t(lang,
                'Dienstleistungen: Vier von fünf Verbrauchern (79 %) wünschen sich Finanz-/Reisekommunikation '
                    'in der Muttersprache. Bei Teilnehmenden mit keinen oder geringen Englischkenntnissen '
                    'steigt dieser Wert auf 85,1 %. Selbst bei englischkundigen Nutzern stimmen 75,8 % zu.',
                'Services: Four out of five (79 %) want financial/travel communications '
                    'in their mother tongue. For no/low-proficiency speakers, this jumps to '
                    '85.1 %. Even English-proficient users agreed at 75.8 %.',
                'サービス：5人中4人（79%）が金融・旅行のコミュニケーションを母国語で受けたいと答えました。'
                    '英語力低/なしの参加者ではこの値が85.1%に跳ね上がります。英語に堪能なユーザーでも75.8%が同意しました。'),
            attrs,
          ),
          const SizedBox(height: 8),
          _body(
            _t(lang,
                'Hochpreisige Käufe: Fast sechs von zehn Befragten (59,5 %) weltweit gaben an, die eigene '
                    'Sprache sei bei solchen Käufen wichtig oder sehr wichtig. In der Gruppe mit keinen oder '
                    'geringen Englischkenntnissen: 78,7 %.',
                'Big-ticket purchases: Almost six out of ten (59.5 %) worldwide said '
                    'their own language was important or very important for these purchases. '
                    'No/low-proficiency group: 78.7 %.',
                '高額購入：世界全体の約6割（59.5%）が、このような購入において自国語は重要または非常に重要と答えました。'
                    '英語力低/なしグループでは78.7%。'),
            attrs,
          ),
        ],
      ),
    );
  }

  // ── Finding 5 ─────────────────────────────────────────────────────────────

  Widget _buildFinding5(ThemeAttributes attrs, String lang) {
    return _section(
      icon: LucideIcons.scale,
      title: _t(lang,
          'Unter sonst gleichen Bedingungen kaufen Verbraucher lieber in ihrer Sprache',
          'All Other Things Being Equal, Consumers Prefer Buying in Their Language',
          '他の条件が同じなら、消費者は母国語での購入を好む'),
      number: '05',
      attrs: attrs,
      lang: lang,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _body(
            _t(lang,
                '"Wenn ich vor der Wahl zwischen zwei ähnlichen Produkten stehe, kaufe ich eher das Produkt, '
                    'das Produktinformationen in meiner eigenen Sprache enthält." Knapp drei Viertel (72,4 %) '
                    'stimmten dieser Aussage zu.',
                '"When faced with the choice of buying two similar products, I am more '
                    'likely to purchase the one that has product information in my own language." '
                    'Nearly three-quarters (72.4 %) agreed with this statement.',
                '「2つの同様の製品を選ぶとき、自分の言語で製品情報が提供されているものを購入する可能性が高い。」'
                    'ほぼ3分の3（72.4%）がこの意見に同意しました。'),
            attrs,
          ),
          const SizedBox(height: 20),
          _bigStat(
            '72,4 %',
            _t(lang,
                'würden das muttersprachliche Produkt wählen, wenn alles andere gleich ist',
                'would choose the native-language product when all else is equal',
                '他の条件が同じなら母国語製品を選ぶ'),
            attrs,
          ),
          const SizedBox(height: 12),
          _bigStat(
            '4,8×',
            _t(lang,
                'wichtiger für Nicht-Englischsprecher als für englischkundige Käufer',
                'more important for no/low English speakers vs. English-proficient buyers',
                '英語力低/なしの購買者と英語に堪能な購買者の差'),
            attrs,
          ),
          const SizedBox(height: 20),
          _bar(_StatItem(
            'France: shop exclusively in French',
            'Frankreich: kauft ausschließlich auf Französisch',
            66.5,
            labelJa: 'フランス：フランス語のみで買い物',
          ), attrs, lang),
          _bar(_StatItem(
            'Japan: shop exclusively in Japanese',
            'Japan: kauft ausschließlich auf Japanisch',
            65.6,
            labelJa: '日本：日本語のみで買い物',
          ), attrs, lang),
          _bar(_StatItem(
            'Spain: open to buying in English',
            'Spanien: offen für Käufe auf Englisch',
            63.9,
            noteEn: 'More tolerant than most other nations',
            noteDe: 'Toleranter als die meisten anderen befragten Länder',
            labelJa: 'スペイン：英語での購入も受け入れる',
            noteJa: '他の調査国より許容度が高い',
          ), attrs, lang),
          _bar(_StatItem(
            'Brazil: open to buying in English',
            'Brasilien: offen für Käufe auf Englisch',
            63.8,
            labelJa: 'ブラジル：英語での購入も受け入れる',
          ), attrs, lang),
          const SizedBox(height: 16),
          _body(
            _t(lang,
                'Wenn Franzosen zu Ihren Wunschkäufern gehören, ist es an der Zeit, einen Sprachdienstleister '
                    'mit der Übersetzung Ihrer Website, Ihrer Marketingmaterialien und Ihrer Produktinhalte '
                    'zu beauftragen.',
                'If the French appear on your list of desirable buyers, it is time to '
                    'hire a language service provider to translate your website, marketing, '
                    'and product content.',
                'フランス人が購買ターゲットに含まれるなら、今すぐ言語サービスプロバイダーを採用して'
                    'ウェブサイト・マーケティング・製品コンテンツを翻訳すべき時です。'),
            attrs,
          ),
        ],
      ),
    );
  }

  // ── Finding 6 ─────────────────────────────────────────────────────────────

  Widget _buildFinding6(ThemeAttributes attrs, String lang) {
    return _section(
      icon: LucideIcons.trendingUp,
      title: _t(lang,
          'Immer mehr Käufer zahlen mehr für Produkte in ihrer Sprache',
          'More Buyers Will Pay More for Local-Language Products',
          '母国語製品に多くを払う購買者が増加している'),
      number: '06',
      attrs: attrs,
      lang: lang,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _body(
            _t(lang,
                'Wir schließen daraus, dass die meisten Menschen mehr für Produkte mit Informationen in '
                    'ihrer eigenen Sprache zahlen. Die Nachfrage nach muttersprachlichen Produkten war höher, '
                    'wenn wir die muttersprachliche Option neben einer günstigeren englischen Alternative anboten.',
                'We conclude that most people will pay more for products with information '
                    'in their own language. The demand for local-language products was higher '
                    'when we offered the native-language option alongside a cheaper English '
                    'alternative.',
                'ほとんどの人は自国語の情報が付いた製品に多くを支払うでしょう。'
                    '安価な英語の代替品と並べて母国語オプションを提示すると、母国語製品への需要がより高まりました。'),
            attrs,
          ),
          const SizedBox(height: 20),
          _bar(_StatItem(
            'More likely to buy with product info in own language vs. cheaper English product',
            'Eher bereit zu kaufen, wenn Produktinformationen in der eigenen Sprache vorliegen – vs. günstigerem englischen Produkt',
            56.2,
            labelJa: '自国語情報付き製品の方が購入意欲が高い（安価な英語製品と比較）',
          ), attrs, lang),
          _bar(_StatItem(
            'Would opt for the cheaper product even without own-language content',
            'Würden das günstigere Produkt wählen, auch ohne Inhalte in der eigenen Sprache',
            43.8,
            noteEn: 'Willingness to trade language preference for lower price',
            noteDe: 'Bereitschaft, die Sprachpräferenz gegen einen niedrigeren Preis einzutauschen',
            labelJa: '自国語コンテンツがなくても安価な製品を選ぶ',
            noteJa: '価格のために言語嗜好を犠牲にする意欲',
          ), attrs, lang),
          _bar(_StatItem(
            'China: prefer native-language product info',
            'China: bevorzugt muttersprachliche Produktinformationen',
            90.3,
            noteEn: 'Highest nationally',
            noteDe: 'Höchster nationaler Wert',
            labelJa: '中国：母国語の製品情報を好む',
            noteJa: '国別最高値',
          ), attrs, lang),
          _bar(_StatItem(
            'France: prefer native-language over cheaper English',
            'Frankreich: bevorzugt Muttersprache gegenüber günstigerem Englisch',
            50.2,
            labelJa: 'フランス：安価な英語製品より母国語を好む',
          ), attrs, lang),
          const SizedBox(height: 20),
          _highlight(
            _t(lang,
                '"Ich kaufe eher ein günstigeres Produkt, auch wenn es keine Informationen in meiner '
                    'Sprache enthält." – Nur 36,9 % der Befragten stimmten zu, was bestätigt, dass die '
                    'Sprachpräferenz bei der Mehrheit die Preissensitivität überwiegt.',
                '"I am more likely to purchase a less expensive product even if it does '
                    'not have info in my language." -- Only 36.9 % of respondents agreed, '
                    'confirming that language preference outweighs price sensitivity for the '
                    'majority.',
                '「自国語情報がなくても、より安価な製品を購入する可能性が高い。」'
                    '──同意したのは回答者の36.9%のみで、言語嗜好が価格感応性を上回ることが多数派にとって確認されました。'),
            attrs,
          ),
          const SizedBox(height: 16),
          _body(
            _t(lang,
                'Marken können Sprachbarrieren überwinden: 55,9 % würden eine globale Marke ohne '
                    'muttersprachliche Produktinformationen einer unbekannten Marke mit Informationen '
                    'in ihrer Sprache vorziehen. Markenwiedererkennung kompensiert Sprachdefizite – '
                    'insbesondere bei international bekannten Marken.',
                'Brand can overcome language barriers: 55.9 % said they would purchase '
                    'a global brand without local-language product information over a '
                    'little-known brand that has information in their language. Brand '
                    'recognition compensates somewhat for language deficiencies -- especially '
                    'for internationally recognized brands.',
                'ブランドが言語の壁を乗り越えられることもあります：55.9%が、母国語の製品情報がないグローバルブランドを、'
                    '自国語情報付きの無名ブランドより選ぶと答えました。ブランド認知は言語の欠如をある程度補います'
                    '──特に国際的に知名度の高いブランドにおいて。'),
            attrs,
          ),
        ],
      ),
    );
  }

  // ── Finding 7 ─────────────────────────────────────────────────────────────

  Widget _buildFinding7(ThemeAttributes attrs, String lang) {
    return _section(
      icon: LucideIcons.refreshCw,
      title: _t(lang,
          'Inhalte in der Muttersprache werden über den Produktlebenszyklus hinweg wichtiger',
          'Mother Tongue Content Becomes More Important Over the Product Life Cycle',
          '母国語コンテンツは製品ライフサイクルを通じてより重要になる'),
      number: '07',
      attrs: attrs,
      lang: lang,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _body(
            _t(lang,
                'Wir untersuchten den Bedarf der Befragten nach muttersprachlicher Unterstützung an zwei '
                    'Punkten im Produktlebenszyklus: beim Erstkauf und beim Kundendienst nach dem Kauf.',
                'We gauged respondents\' needs for local-language support at two points in '
                    'the product life cycle: when they first buy and when they seek '
                    'post-sales support.',
                '製品ライフサイクルの2つの時点──初回購入時とアフターサポート時──において、'
                    '母国語サポートのニーズを測定しました。'),
            attrs,
          ),
          const SizedBox(height: 20),
          _bar(_StatItem(
            '"I will only purchase if the user guide is in my own language" (agree/strongly agree)',
            '"Ich kaufe nur, wenn die Bedienungsanleitung in meiner Sprache ist" (stimme zu/voll zu)',
            45.5,
            noteEn: 'Documentation matters less at point of purchase',
            noteDe: 'Dokumentation ist beim Kauf weniger entscheidend',
            labelJa: '「操作マニュアルが自国語でなければ購入しない」（同意/強く同意）',
            noteJa: '購入時点では文書化の重要性は低い',
          ), attrs, lang),
          _bar(_StatItem(
            'Post-sales support must be in own language',
            'Support nach dem Kauf muss in der eigenen Sprache sein',
            74.7,
            labelJa: 'アフターサービスサポートは自国語でなければならない',
          ), attrs, lang),
          _bar(_StatItem(
            'No/low English: post-sales support must be in own language',
            'Kein/geringes Englisch: Support nach dem Kauf muss in der eigenen Sprache sein',
            80.6,
            noteEn: 'vs. 70.6 % for English-proficient group',
            noteDe: 'vs. 70,6 % bei englischkundigen Befragten',
            labelJa: '英語力低/なし：アフターサービスは自国語でなければならない',
            noteJa: '英語に堪能なグループの70.6%と比較',
          ), attrs, lang),
          const SizedBox(height: 20),
          _highlight(
            _t(lang,
                'Sprache wird NACH dem Kauf noch wichtiger. 80,6 % der Gruppe mit keinen oder geringen '
                    'Englischkenntnissen forderten muttersprachlichen Support nach dem Kauf, gegenüber '
                    '70,6 % bei englischkundigen Befragten.',
                'Language becomes more of an issue AFTER the sale. 80.6 % of the '
                    'no/low-English group agreed on the need for in-language post-sales '
                    'support, compared to 70.6 % of English-proficient respondents.',
                '言語は購入後にさらに重要になります。英語力低/なしグループの80.6%が母国語のアフターサービスサポートを必要とすると同意し、'
                    '英語に堪能な回答者の70.6%を上回りました。'),
            attrs,
          ),
          const SizedBox(height: 16),
          _body(
            _t(lang,
                'Die Lektion für Online-Marketer: Sprache ist ein Schlüsselelement beim Aufbau einer '
                    'langfristigen Kundenbeziehung. Auch wenn Verbraucher beim Kauf ein Produkt mit '
                    'anderssprachiger Dokumentation akzeptieren, werden sie langfristig an Support-Materialien '
                    'interessiert sein, die sie vollständig verstehen.',
                'The lesson to online marketers: language comprises a key element in '
                    'building a long-term relationship with a customer. While consumers may '
                    'accept a product documented in another language at the point of purchase, '
                    'they will be more interested over the long term in support materials '
                    'they can fully understand.',
                'オンラインマーケターへの教訓：言語は長期的な顧客関係を築く上で重要な要素です。'
                    '消費者は購入時に他言語の文書付き製品を受け入れるかもしれませんが、'
                    '長期的には完全に理解できるサポート資料をより求めるようになります。'),
            attrs,
          ),
        ],
      ),
    );
  }

  // ── Finding 8 ─────────────────────────────────────────────────────────────

  Widget _buildFinding8(ThemeAttributes attrs, String lang) {
    return _section(
      icon: LucideIcons.languages,
      title: _t(lang,
          'Schlechte Übersetzungen sind besser als keine – und maschinelle Übersetzung ist weit verbreitet',
          'Bad Translations Are Better Than No Translations -- and Machine Translation Is Widely Used',
          '下手な翻訳でも翻訳なしよりはまし──機械翻訳も広く利用されている'),
      number: '08',
      attrs: attrs,
      lang: lang,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _body(
            _t(lang,
                '45 % der Befragten stimmten zu: „Ich bevorzuge Inhalte in meiner Sprache, auch wenn '
                    'diese von schlechter Qualität sind, gegenüber englischen Inhalten." Auf Länderebene '
                    'stimmten mehr als die Hälfte der Deutschen (65,4 %), Franzosen (57,4 %), Japaner '
                    '(57,4 %) und Russen (51,0 %) zu.',
                '45 % of respondents said "I would prefer to have local language content '
                    'instead of English, even if it were poor quality." Once we factored in '
                    'nationality, more than half of the French (57.4 %), Germans (65.4 %), '
                    'Japanese (57.4 %), and Russians (51.0 %) agreed.',
                '「英語ではなく自国語のコンテンツがあれば、たとえ品質が低くても好む」と45%の回答者が答えました。'
                    '国別では、ドイツ（65.4%）・フランス（57.4%）・日本（57.4%）・ロシア（51.0%）の半数以上が同意しました。'),
            attrs,
          ),
          const SizedBox(height: 20),
          _bar(_StatItem(
            'Prefer bad translation over no translation (overall)',
            'Bevorzugen schlechte Übersetzung gegenüber keiner Übersetzung (gesamt)',
            55.9,
            labelJa: '翻訳なしよりも粗い翻訳の方を好む（全体）',
          ), attrs, lang),
          _bar(_StatItem(
            'Germany: prefer imperfect translation',
            'Deutschland: bevorzugt unvollkommene Übersetzung',
            65.4,
            noteEn: 'Highest nationally for this preference',
            noteDe: 'Höchster nationaler Wert für diese Präferenz',
            labelJa: 'ドイツ：不完全な翻訳を好む',
            noteJa: 'この嗜好で国別最高値',
          ), attrs, lang),
          _bar(_StatItem(
            'France: prefer imperfect translation',
            'Frankreich: bevorzugt unvollkommene Übersetzung',
            57.4,
            labelJa: 'フランス：不完全な翻訳を好む',
          ), attrs, lang),
          _bar(_StatItem(
            'Japan: prefer imperfect translation',
            'Japan: bevorzugt unvollkommene Übersetzung',
            57.4,
            labelJa: '日本：不完全な翻訳を好む',
          ), attrs, lang),
          _bar(_StatItem(
            'No/low English: prefer imperfect translation',
            'Kein/geringes Englisch: bevorzugt unvollkommene Übersetzung',
            72.1,
            noteEn: '2.7x more than English-proficient speakers',
            noteDe: '2,7-mal häufiger als bei englischkundigen Sprechern',
            labelJa: '英語力低/なし：不完全な翻訳を好む',
            noteJa: '英語に堪能な話者の2.7倍',
          ), attrs, lang),
          const SizedBox(height: 20),
          _body(
            _t(lang,
                'Maschinelle Übersetzung ist weit verbreitet. Mehr als die Hälfte aller Besucher (53,5 %) '
                    'nutzt gelegentlich maschinelle Übersetzung, um englischsprachige Websites besser zu '
                    'verstehen. „Gelegentlich" war die häufigste Antwort mit 31,5 %. „Selten" nannten 22,7 % '
                    'und „nie" 21,6 % der englischkundigen Befragten.',
                'Machine translation is widely used. More than half of all visitors '
                    '(53.5 %) sometimes turn to machine translation (MT) to better understand '
                    'English-language websites. "Sometimes" was the biggest group at 31.5 %. '
                    '"Rarely" came in at 22.7 % and "never" at 21.6 % of proficient '
                    'English speakers.',
                '機械翻訳が広く利用されています。全訪問者の半数以上（53.5%）が、英語サイトをより理解するために機械翻訳（MT）を使うことがあります。'
                    '「ときどき」が最多で31.5%、「めったに」が22.7%、「全くない」が英語に堪能な話者の21.6%でした。'),
            attrs,
          ),
          const SizedBox(height: 8),
          _bar(_StatItem(
            'Sometimes use machine translation to browse English sites',
            'Nutzen gelegentlich maschinelle Übersetzung für englischsprachige Websites',
            53.5,
            labelJa: '英語サイトを閲覧するために機械翻訳をときどき使う',
          ), attrs, lang),
          const SizedBox(height: 16),
          _body(
            _t(lang,
                'Eine schnelle und günstige Übersetzung kann ausreichen, um ein Produkt oder eine '
                    'Dienstleistung in die engere Wahl zu bringen. Mit zunehmendem Wettbewerb und mehr '
                    'Auswahlmöglichkeiten für Verbraucher wird eine schnelle und günstige Übersetzung '
                    'allein nicht mehr ausreichen.',
                'The cheap, \'quick and dirty\' translation may be enough to get your '
                    'product or service considered. As competition increases and consumers '
                    'have more options to choose from, \'quick and dirty\' translation will '
                    'no longer suffice.',
                '「安くて素早い翻訳」は製品やサービスを検討対象に入れてもらうのに十分かもしれません。'
                    '競争が激化し消費者の選択肢が増えるにつれ、「素早い翻訳」だけではもはや十分ではなくなるでしょう。'),
            attrs,
          ),
        ],
      ),
    );
  }

  // ── Abandonment funnel ────────────────────────────────────────────────────

  Widget _buildAbandonmentFunnel(ThemeAttributes attrs, String lang) {
    final stages = [
      (
        _t(lang, 'Eintreten', 'Enter', '入場'),
        <String>[
          _t(lang, 'Website wechselt zu schnell ins Englische',
              'Site reverts to English too quickly', 'サイトがすぐに英語に切り替わる'),
          _t(lang, 'Website lädt zu langsam',
              'Site is too slow to load', 'サイトの読み込みが遅すぎる'),
          _t(lang, 'Zu viele Animationen oder Grafiken lenken vom Inhalt ab',
              'Too much animation or graphics distract from the purpose',
              'アニメーションやグラフィックが多すぎて目的が分かりにくい'),
        ],
      ),
      (
        _t(lang, 'Stöbern', 'Browse', '閲覧'),
        <String>[
          _t(lang, 'Zu viele Informationsanfragen', 'Too much information requested',
              '入力を求められる情報が多すぎる'),
          _t(lang, 'Zu viel Zeitaufwand', 'Too much time required', '時間がかかりすぎる'),
          _t(lang, 'Versandkosten zu hoch', 'Shipping costs too high', '送料が高すぎる'),
          _t(lang, 'Lange oder unverständliche rechtliche Vereinbarungen',
              'Lengthy or confusing legal agreements', '長くて分かりにくい利用規約'),
        ],
      ),
      (
        _t(lang, 'Einkaufen', 'Shop', 'ショッピング'),
        <String>[
          _t(lang, 'Kein Transaktionssupport für mein Land',
              'No transaction support for my country', '自国での取引サポートがない'),
          _t(lang, 'Keine lokale Kreditkarte akzeptiert',
              'No local credit card accepted', 'ローカルクレジットカードが使えない'),
          _t(lang, 'Versandkosten werden zu spät im Prozess angezeigt',
              'Shipping costs presented too late in the process',
              '送料がプロセスの後半まで表示されない'),
        ],
      ),
      (
        _t(lang, 'Registrieren', 'Register', '登録'),
        <String>[
          _t(lang, 'Kaufbereich erlaubt keine Transaktionen aus meinem Land',
              'Purchase area does not allow transactions in my country',
              '購入エリアが自国からの取引を許可していない'),
          _t(lang, 'Keine lokale Kreditkarte akzeptiert',
              'No local credit card accepted', 'ローカルクレジットカードが使えない'),
        ],
      ),
      (
        _t(lang, 'Kaufen', 'Buy', '購入'),
        <String>[
          _t(lang, 'Website akzeptierte meine Kreditkarte nicht',
              'Site did not accept my credit card', 'サイトが自分のクレジットカードを受け付けなかった'),
          _t(lang, 'Unerwartete Versandkosten beim Checkout',
              'Unexpected shipping costs revealed at checkout',
              'チェックアウト時に予期しない送料が発生'),
        ],
      ),
      (
        _t(lang, 'Support', 'Support', 'サポート'),
        <String>[
          _t(lang, 'Wechselt für Support-Inhalte ins Englische',
              'Reverts to English for support content', 'サポートコンテンツで英語に切り替わる'),
          _t(lang, 'Kein lokales Supportpersonal verfügbar',
              'No local support staff available', 'ローカルサポートスタッフがいない'),
        ],
      ),
    ];

    return _section(
      icon: LucideIcons.logOut,
      title: _t(lang,
          'Warum ausländische Besucher englischsprachige Websites verlassen',
          'Why Foreign Visitors Abandon English-Language Websites',
          '海外訪問者が英語サイトを離脱する理由'),
      attrs: attrs,
      lang: lang,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _body(
            _t(lang,
                'Wir baten die Befragten, acht häufig genannte Gründe für das Verlassen einer Website '
                    'zu bewerten – während sie den Übergang vom Gelegenheitsbesucher zum Browser, '
                    'Einkäufer, Käufer und schließlich Kunden durchliefen.',
                'We asked respondents to rank eight commonly cited reasons for leaving a '
                    'website as visitors transitioned from casual visitor to browser to '
                    'shopper to buyer to customer.',
                '回答者に、ウェブサイトを離脱する理由としてよく挙げられる8つの要因を順位付けしてもらいました'
                    '──カジュアル訪問者からブラウザ・ショッパー・購買者・顧客へと移行する各段階で。'),
            attrs,
          ),
          const SizedBox(height: 20),
          ...stages.map((s) {
            final (name, reasons) = s;
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: attrs.bgCard,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: attrs.borderMain),
              ),
              child: ExpansionTile(
                tilePadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                leading: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: attrs.brand600.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      name[0],
                      style: TextStyle(
                          color: attrs.brand600,
                          fontWeight: FontWeight.w900,
                          fontSize: 14),
                    ),
                  ),
                ),
                title: Text(name,
                    style: TextStyle(
                        color: attrs.textMain,
                        fontWeight: FontWeight.w700,
                        fontSize: 15)),
                subtitle: Text(
                  _t(lang,
                      '${reasons.length} Abbruchgründe',
                      '${reasons.length} abandonment reasons',
                      '${reasons.length}件の離脱理由'),
                  style: TextStyle(color: attrs.textMuted, fontSize: 11),
                ),
                iconColor: attrs.brand600,
                collapsedIconColor: attrs.textMuted,
                children: reasons
                    .map(
                      (r) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(LucideIcons.alertTriangle,
                                size: 13, color: Colors.amber),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(r,
                                  style: TextStyle(
                                      color: attrs.textMuted,
                                      fontSize: 13,
                                      height: 1.4)),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            );
          }),
          const SizedBox(height: 16),
          _body(
            _t(lang,
                'Sprachliche und vor-kommerzielle Probleme schrecken Nicht-Englischsprecher zuerst ab. '
                    'Ein schnelles Zurückfallen ins Englische, lange Vereinbarungen und hohe Versandkosten '
                    'sind weitere Abbruchgründe. Fehlender Transaktionssupport für das Heimatland folgt, '
                    'dann die Unmöglichkeit, mit einer lokalen Kreditkarte zu zahlen.',
                'Language and pre-commerce issues drive away non-English visitors first. '
                    'A quick reversion to English, lengthy agreements, and hefty shipping '
                    'costs are secondary reasons for leaving. The absence of transaction '
                    'support for their country follows, then inability to pay with a local '
                    'credit card.',
                '言語および商取引前の問題が最初に非英語話者を遠ざけます。'
                    '英語への素早い切り替え・長い規約・高額な送料が離脱の二次的要因です。'
                    '続いて自国の取引サポート不足、ローカルクレジットカードでの支払い不可が続きます。'),
            attrs,
          ),
        ],
      ),
    );
  }

  // ── Conclusions ───────────────────────────────────────────────────────────

  Widget _buildConclusions(ThemeAttributes attrs, String lang) {
    return _section(
      icon: LucideIcons.checkCircle,
      title: _t(lang,
          'Fazit: Im globalen Web sind Sprache und Lokalisierung wichtiger denn je',
          'Conclusions: On the Global Web, Language and Localization Matter More Than Ever',
          '結論：グローバルウェブでは言語とローカライズがこれまで以上に重要'),
      attrs: attrs,
      lang: lang,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _highlight(
            _t(lang,
                '"Hochwertige Sprachinhalte bringen Interessenten in den digitalen Verkaufsprozess. '
                    'Vollständigere Informationen in der eigenen Sprache halten sie beim Stöbern. '
                    'Beim Einkaufen und Kaufen bietet eine erfolgreiche globale Website angepasste '
                    'Formulare, Transaktionen und Logistik. Eine lokalisierte Erfahrung erhöht die '
                    'Wahrscheinlichkeit, dass aus einem Besucher ein Käufer wird – und aus einem '
                    'Käufer ein Stammkunde."',
                '"Language of quality drives prospects into the web sales funnel. More '
                    'complete information in your language will keep them actively browsing. '
                    'Once they are shopping and buying, a successful global website will offer '
                    'properly adapted forms, transactions, and logistics. A localized experience '
                    'increases the likelihood of a browser becoming a buyer -- and of a buyer '
                    'progressing to repeat customer."',
                '「質の高い言語コンテンツが見込み客をウェブ販売ファネルに引き込みます。'
                    'より完全な自国語情報が積極的なブラウジングを維持します。'
                    'ショッピング・購入段階では、成功するグローバルウェブサイトが適切に適応されたフォーム・取引・物流を提供します。'
                    'ローカライズされた体験が、訪問者を購買者に──そして購買者をリピート顧客に──変える可能性を高めます。」'),
            attrs,
          ),
          const SizedBox(height: 20),
          _body(
            _t(lang,
                'Bei Ermessenskäufen toleriert ein Verbraucher möglicherweise Unannehmlichkeiten, um '
                    'einen erwarteten Vorteil zu erzielen. Bei notwendigen Produkten werden Menschen das '
                    'Produkt finden und kaufen, selbst wenn es bedeutet, eine englischsprachige Website '
                    'zu besuchen – solange diese Website Besuchern aus ihrem Land erlaubt, Transaktionen '
                    'abzuschließen.',
                'For a discretionary purchase, an offer might not warrant even bloggers '
                    'passing it along to their contacts. If a visitor sees some benefit to '
                    'buying, a consumer may tolerate some discomfort to achieve an anticipated '
                    'gain. When a necessary item, people will find the product and buy it, '
                    'even if it means going to an English-only site -- as long as that site '
                    'allows visitors from their country to complete their transactions.',
                '裁量的購入において、消費者は期待される利益を得るためにある程度の不便を受け入れるかもしれません。'
                    '必需品においては、たとえ英語のみのサイトを訪れる必要があっても、'
                    'そのサイトが自国からの取引を許可する限り、人々は製品を見つけて購入するでしょう。'),
            attrs,
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _conclusionCard(
                  LucideIcons.trendingUp,
                  _t(lang, 'Sprache treibt Umsatz', 'Language Drives Revenue', '言語が収益を牽引する'),
                  _t(lang,
                      '72,4 % der Verbraucher kaufen lieber in ihrer Sprache, wenn alles andere gleich ist. Lokalisierte Produktinformationen erhöhen direkt die Kaufwahrscheinlichkeit.',
                      '72.4 % of consumers prefer buying in their language when all else is equal. Localized product information directly increases purchasing likelihood.',
                      '他の条件が同じなら72.4%の消費者が母国語での購入を好みます。ローカライズされた製品情報が購買意向を直接高めます。'),
                  attrs,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _conclusionCard(
                  LucideIcons.heart,
                  _t(lang, 'Kundenbindung nach dem Kauf', 'Post-Sale Retention', '購入後のリテンション'),
                  _t(lang,
                      'Sprache wird NACH dem Erstkauf noch wichtiger. 74,7 % benötigen muttersprachlichen Support, um treue Kunden zu bleiben.',
                      'Language becomes more critical AFTER the first purchase. 74.7 % need post-sales support in their native language to remain loyal customers.',
                      '言語は初回購入後にさらに重要になります。74.7%が母国語でのアフターサポートを必要とし、ロイヤル顧客であり続けるとしています。'),
                  attrs,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _conclusionCard(
                  LucideIcons.zap,
                  _t(lang, 'Unvollkommen schlägt Nichts', 'Imperfect > Nothing', '不完全 ＞ ゼロ'),
                  _t(lang,
                      'Eine minderwertige Übersetzung wird von 55,9 % der Käufer gegenüber keiner Übersetzung bevorzugt. 53,5 % nutzen maschinelle Übersetzung zur Navigation englischsprachiger Websites.',
                      'A low-quality translation is preferred over no translation by 55.9 % of buyers. Machine translation used by 53.5 % to navigate English-only sites.',
                      '低品質な翻訳でも55.9%の購買者が翻訳なしより好みます。53.5%が英語のみサイトをナビゲートするために機械翻訳を活用。'),
                  attrs,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _conclusionCard(
                  LucideIcons.award,
                  _t(lang, 'Marke vs. Sprache', 'Brand vs. Language', 'ブランド vs. 言語'),
                  _t(lang,
                      'Starke globale Marken können die Sprachbarriere in ~56 % der Fälle überwinden – aber lokale Sprachinformationen stärken den Markenwert erheblich.',
                      'Strong global brands can overcome the language barrier in ~56 % of cases -- but local language information amplifies brand value significantly.',
                      '強いグローバルブランドは約56%のケースで言語の壁を乗り越えられます──しかし母国語情報はブランド価値をさらに高めます。'),
                  attrs,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _conclusionCard(
      IconData icon, String title, String text, ThemeAttributes attrs) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: attrs.brand600.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: attrs.brand600.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: attrs.brand600, size: 22),
          const SizedBox(height: 12),
          Text(title,
              style: TextStyle(
                  color: attrs.textMain,
                  fontWeight: FontWeight.w800,
                  fontSize: 14)),
          const SizedBox(height: 8),
          Text(text,
              style:
                  TextStyle(color: attrs.textMuted, fontSize: 12, height: 1.5)),
        ],
      ),
    );
  }

  // ── Citation ──────────────────────────────────────────────────────────────

  Widget _buildCitation(ThemeAttributes attrs, String lang) {
    return GlassContainer(
      borderRadius: 20,
      border: Border.all(color: attrs.borderMain),
      padding: const EdgeInsets.all(28),
      backgroundColor: attrs.bgCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.bookOpen, size: 16, color: attrs.brand600),
              const SizedBox(width: 8),
              Text(
                _t(lang, 'Quellenangabe', 'Citation', '引用文献'),
                style: TextStyle(
                    color: attrs.brand600,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                    letterSpacing: 0.5),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "DePalma, D. A., Sargent, B. B., & Beninatto, R. S. (2006). "
            "Can't Read, Won't Buy: Why Language Matters on Global Websites. "
            "Common Sense Advisory, Inc.",
            style: TextStyle(
                color: attrs.textMuted,
                fontSize: 13,
                height: 1.6,
                fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 16),
          Text(
            _t(lang,
                'Diese Inhalte sind in den PB Translation Hub eingebettet, um die dauerhafte '
                    'Verfügbarkeit der Studienergebnisse für die Drupal-Community zu gewährleisten. '
                    'Die Originalstudie wurde im September 2006 von Common Sense Advisory, Inc., '
                    'Lowell, Massachusetts, USA, veröffentlicht. Alle Rechte liegen bei den jeweiligen Inhabern.',
                'This content is embedded in the PB Translation Hub to ensure permanent '
                    'availability of the study\'s findings for the Drupal community. '
                    'The original study was published September 2006 by Common Sense Advisory, '
                    'Inc., Lowell, Massachusetts, USA. All rights belong to their respective owners.',
                '本コンテンツは、Drupalコミュニティへの研究成果の恒久的な提供を目的として、PB Translation Hubに埋め込まれています。'
                    '原著研究は2006年9月、米国マサチューセッツ州ローウェルのCommon Sense Advisory, Inc.によって発行されました。'
                    '全ての権利は各権利保有者に帰属します。'),
            style: TextStyle(
                color: attrs.textMuted.withValues(alpha: 0.7),
                fontSize: 11,
                height: 1.5),
          ),
        ],
      ),
    );
  }

  // ── Shared helpers ────────────────────────────────────────────────────────

  Widget _section({
    required IconData icon,
    required String title,
    required ThemeAttributes attrs,
    required Widget child,
    required String lang,
    String? number,
  }) {
    return GlassContainer(
      borderRadius: 28,
      border: Border.all(color: attrs.borderMain),
      padding: const EdgeInsets.all(40),
      backgroundColor: attrs.bgCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: attrs.brand600.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                      color: attrs.brand600.withValues(alpha: 0.2)),
                ),
                child: Icon(icon, color: attrs.brand600, size: 22),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (number != null) ...[
                      Text(
                        _t(lang, 'ERKENNTNIS $number', 'FINDING $number',
                            '知見 $number'),
                        style: TextStyle(
                            color: attrs.brand600,
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.5),
                      ),
                      const SizedBox(height: 4),
                    ],
                    Text(
                      title,
                      style: TextStyle(
                          color: attrs.textMain,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          height: 1.3),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          child,
        ],
      ),
    );
  }

  Widget _body(String text, ThemeAttributes attrs) {
    return Text(text,
        style: TextStyle(color: attrs.textMuted, fontSize: 14, height: 1.65));
  }

  Widget _highlight(String text, ThemeAttributes attrs) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: attrs.brand600.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: attrs.brand600.withValues(alpha: 0.18)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 3,
            height: 20,
            margin: const EdgeInsets.only(right: 14, top: 2),
            decoration: BoxDecoration(
              color: attrs.brand600,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                  color: attrs.textMain,
                  fontSize: 13,
                  height: 1.6,
                  fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bar(_StatItem item, ThemeAttributes attrs, String lang) {
    final label = lang == 'ja'
        ? (item.labelJa ?? item.labelEn)
        : (lang == 'de' ? item.labelDe : item.labelEn);
    final note = lang == 'ja'
        ? (item.noteJa ?? item.noteEn)
        : (lang == 'de' ? item.noteDe : item.noteEn);
    final barVal = (item.pct / 100).clamp(0.0, 1.0);
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(label,
                    style: TextStyle(
                        color: attrs.textMain,
                        fontSize: 13,
                        fontWeight: FontWeight.w600)),
              ),
              const SizedBox(width: 12),
              Text(
                '${item.pct.toStringAsFixed(1)} %',
                style: TextStyle(
                    color: attrs.brand600,
                    fontSize: 16,
                    fontWeight: FontWeight.w900),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: barVal,
              backgroundColor: attrs.brand600.withValues(alpha: 0.1),
              valueColor: AlwaysStoppedAnimation<Color>(attrs.brand600),
              minHeight: 5,
            ),
          ),
          if (note != null) ...[
            const SizedBox(height: 4),
            Text(note,
                style: TextStyle(
                    color: attrs.textMuted, fontSize: 11, height: 1.3)),
          ],
        ],
      ),
    );
  }

  Widget _bigStat(String value, String label, ThemeAttributes attrs) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: attrs.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: attrs.borderMain),
      ),
      child: Row(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w900,
              color: attrs.brand600,
              height: 1,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(label,
                style: TextStyle(
                    color: attrs.textMain, fontSize: 15, height: 1.4)),
          ),
        ],
      ),
    );
  }
}
