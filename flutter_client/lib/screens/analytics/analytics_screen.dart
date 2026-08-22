import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:go_router/go_router.dart';

import '../../providers/theme_provider.dart';
import '../../providers/language_provider.dart';
import '../../providers/project_provider.dart';
import '../../providers/analytics_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_container.dart';
import '../../l10n/app_localizations.dart';

// Akzentfarben für die Statusabschnitte (themenunabhängig).
const _cReleased = Color(0xFF22C55E); // freigegeben
const _cReview = Color(0xFFF59E0B);   // im Review
const _cMissing = Color(0xFF64748B);  // fehlt
const _cStale = Color(0xFFEF4444);    // veraltet

class AnalyticsScreen extends ConsumerStatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  ConsumerState<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends ConsumerState<AnalyticsScreen> {
  final Set<String> _expandedNew = {};
  final Set<String> _expandedStale = {};

  @override
  void initState() {
    super.initState();
    // Kompatibilitäts-/Bedarfszähler frisch laden.
    Future.microtask(() {
      final lang = ref.read(languageProvider).targetLanguage.code;
      ref.read(filterCountsProvider.notifier).fetchCounts(lang);
    });
  }

  @override
  Widget build(BuildContext context) {
    final attrs = AppTheme.getAttributes(ref.watch(themeProvider).themeId);
    final l10n = AppLocalizations.of(context)!;
    final lang = ref.watch(languageProvider).targetLanguage;
    final counts = ref.watch(filterCountsProvider);
    final analytics = ref.watch(analyticsProvider);
    final weeks = ref.watch(analyticsProvider.notifier).weeks;
    final isMobile = MediaQuery.of(context).size.width < 600;

    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 14 : 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──────────────────────────────────────────────────────
          Row(
            children: [
              Container(
                width: isMobile ? 48 : 56,
                height: isMobile ? 48 : 56,
                decoration: BoxDecoration(
                  color: attrs.brand600,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(LucideIcons.chartColumnBig,
                    color: Colors.white, size: isMobile ? 24 : 28),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.layoutNavAnalytics,
                      style: TextStyle(
                        fontSize: isMobile ? 22 : 32,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Text(
                      l10n.analyticsSubtitle,
                      style: TextStyle(fontSize: 13, color: attrs.textMuted),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: l10n.commonRefresh,
                onPressed: () {
                  ref.read(analyticsProvider.notifier).refresh();
                  ref
                      .read(filterCountsProvider.notifier)
                      .fetchCounts(lang.code);
                },
                icon: Icon(LucideIcons.refreshCw, color: attrs.textMuted),
              ),
            ],
          ),
          const SizedBox(height: 28),

          // ── Übersetzungsbedarf ──────────────────────────────────────────
          _sectionTitle(l10n.analyticsBacklog,
              LucideIcons.languages, attrs),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _statCard(attrs, l10n.analyticsMissing,
                  counts.missing, _cMissing, LucideIcons.circleDashed),
              _statCard(attrs, l10n.analyticsStale, counts.stale,
                  _cStale, LucideIcons.triangleAlert),
              _statCard(attrs, l10n.analyticsInReview,
                  counts.review, _cReview, LucideIcons.clock),
              _statCard(attrs, l10n.analyticsReleased,
                  counts.released, _cReleased, LucideIcons.circleCheck),
              _statCard(attrs, l10n.analyticsTranslated,
                  counts.translated, attrs.brand600, LucideIcons.check),
              _statCard(attrs, l10n.analyticsTotalModules,
                  counts.all, attrs.textMuted, LucideIcons.boxes),
            ],
          ),
          const SizedBox(height: 32),

          // ── Kompatibilität pro Drupal-Version ───────────────────────────
          _sectionTitle(
              l10n.analyticsCompatByVersion,
              LucideIcons.layers,
              attrs),
          const SizedBox(height: 4),
          Text(
            l10n.analyticsLanguageLegend(lang.name),
            style: TextStyle(fontSize: 12, color: attrs.textMuted),
          ),
          const SizedBox(height: 12),
          if (counts.versionCounts.isEmpty)
            _emptyHint(attrs, l10n.analyticsLoadingCounts)
          else
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: (counts.versionCounts.keys.toList()..sort())
                  .map((v) => _versionCard(
                      attrs, v, counts.versionCounts[v]!, isMobile))
                  .toList(),
            ),
          const SizedBox(height: 32),

          // ── Wochen-Auswahl ──────────────────────────────────────────────
          Row(
            children: [
              Text(l10n.analyticsWindow,
                  style: TextStyle(
                      color: attrs.textMuted, fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: attrs.bgInput,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: attrs.borderMain),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: weeks,
                    dropdownColor: attrs.bgCard,
                    icon: Icon(LucideIcons.chevronDown,
                        color: attrs.textMuted, size: 16),
                    onChanged: (val) {
                      if (val != null) {
                        ref.read(analyticsProvider.notifier).setWeeks(val);
                      }
                    },
                    items: [4, 8, 12, 26, 52].map((v) {
                      return DropdownMenuItem<int>(
                        value: v,
                        child: Text(
                          l10n.analyticsWeeks(v.toString()),
                          style: TextStyle(
                              color: attrs.textMain,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              if (analytics.isLoading) ...[
                const SizedBox(width: 14),
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: attrs.brand600),
                ),
              ],
            ],
          ),
          const SizedBox(height: 20),

          if (analytics.error != null)
            _emptyHint(attrs, analytics.error!, error: true),

          // ── Wochenliste: Neue Beschreibungen ────────────────────────────
          _sectionTitle(
              l10n.analyticsNewDescriptionsPerWeek,
              LucideIcons.filePlus,
              attrs),
          const SizedBox(height: 12),
          _weekList(attrs, analytics.weeklyNew, _expandedNew, attrs.brand600),
          const SizedBox(height: 32),

          // ── Wochenliste: Veraltet markiert ──────────────────────────────
          _sectionTitle(
              l10n.analyticsMarkedOutdatedPerWeek(lang.name),
              LucideIcons.triangleAlert,
              attrs),
          const SizedBox(height: 12),
          _weekList(
              attrs, analytics.weeklyStale, _expandedStale, _cStale),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // ── Bausteine ─────────────────────────────────────────────────────────────

  Widget _sectionTitle(String text, IconData icon, ThemeAttributes attrs) {
    return Row(
      children: [
        Icon(icon, size: 18, color: attrs.brand600),
        const SizedBox(width: 8),
        Text(text,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: attrs.textMain)),
      ],
    );
  }

  Widget _statCard(ThemeAttributes attrs, String label, int value, Color color,
      IconData icon) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: attrs.bgCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: attrs.borderMain),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 6),
              Expanded(
                child: Text(label,
                    style: TextStyle(
                        color: attrs.textMuted,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                    overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(_fmt(value),
              style: TextStyle(
                  color: color, fontWeight: FontWeight.w900, fontSize: 26)),
        ],
      ),
    );
  }

  Widget _versionCard(ThemeAttributes attrs, int version, VersionCount vc,
      bool isMobile) {
    final l10n = AppLocalizations.of(context)!;
    final total = vc.all == 0 ? 1 : vc.all;
    return Container(
      width: isMobile ? double.infinity : 320,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: attrs.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: attrs.borderMain),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: attrs.brand600.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('Drupal $version',
                    style: TextStyle(
                        color: attrs.brand600,
                        fontWeight: FontWeight.w900,
                        fontSize: 14)),
              ),
              const Spacer(),
              Text(
                  l10n.analyticsModuleCount(_fmt(vc.all)),
                  style: TextStyle(
                      color: attrs.textMuted,
                      fontWeight: FontWeight.bold,
                      fontSize: 12)),
            ],
          ),
          const SizedBox(height: 14),
          // gestapelter Balken
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Row(
              children: [
                _seg(vc.released, total, _cReleased),
                _seg(vc.review, total, _cReview),
                _seg(vc.missing, total, _cMissing),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 14,
            runSpacing: 6,
            children: [
              _legend(_cReleased,
                  l10n.analyticsReleased, vc.released, attrs),
              _legend(_cReview, l10n.analyticsReviewShort, vc.review,
                  attrs),
              _legend(_cMissing, l10n.analyticsMissing, vc.missing,
                  attrs),
            ],
          ),
        ],
      ),
    );
  }

  Widget _seg(int value, int total, Color color) {
    final flex = (value <= 0) ? 0 : value;
    if (flex == 0) return const SizedBox.shrink();
    return Expanded(
      flex: flex,
      child: Container(height: 12, color: color),
    );
  }

  Widget _legend(Color color, String label, int value, ThemeAttributes attrs) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(3))),
        const SizedBox(width: 6),
        Text('$label: ${_fmt(value)}',
            style: TextStyle(
                color: attrs.textMuted,
                fontSize: 12,
                fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _weekList(ThemeAttributes attrs, List<WeekBucket> weeks,
      Set<String> expanded, Color barColor) {
    final l10n = AppLocalizations.of(context)!;
    if (weeks.isEmpty) {
      return _emptyHint(
          attrs, l10n.analyticsNoDataInWindow);
    }
    final maxCount =
        weeks.map((w) => w.count).fold<int>(1, (a, b) => b > a ? b : a);

    return GlassContainer(
      borderRadius: 16,
      backgroundColor: attrs.bgCard.withOpacity(0.6),
      border: Border.all(color: attrs.borderMain),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: weeks.map((w) {
          final isOpen = expanded.contains(w.weekStart);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () => setState(() {
                  if (isOpen) {
                    expanded.remove(w.weekStart);
                  } else {
                    expanded.add(w.weekStart);
                  }
                }),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      Icon(
                          isOpen
                              ? LucideIcons.chevronDown
                              : LucideIcons.chevronRight,
                          size: 16,
                          color: attrs.textMuted),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 110,
                        child: Text(_weekLabel(w.weekStart, l10n),
                            style: TextStyle(
                                color: attrs.textMain,
                                fontWeight: FontWeight.bold,
                                fontSize: 13)),
                      ),
                      const SizedBox(width: 8),
                      // Mini-Balken
                      Expanded(
                        child: LayoutBuilder(builder: (ctx, c) {
                          final frac = (w.count / maxCount).clamp(0.0, 1.0);
                          return Stack(
                            children: [
                              Container(
                                height: 18,
                                decoration: BoxDecoration(
                                    color: attrs.bgInput,
                                    borderRadius: BorderRadius.circular(6)),
                              ),
                              Container(
                                height: 18,
                                width: c.maxWidth * frac,
                                decoration: BoxDecoration(
                                    color: barColor.withOpacity(0.85),
                                    borderRadius: BorderRadius.circular(6)),
                              ),
                            ],
                          );
                        }),
                      ),
                      const SizedBox(width: 10),
                      Text(_fmt(w.count),
                          style: TextStyle(
                              color: barColor,
                              fontWeight: FontWeight.w900,
                              fontSize: 14)),
                    ],
                  ),
                ),
              ),
              if (isOpen)
                Padding(
                  padding:
                      const EdgeInsets.fromLTRB(34, 0, 10, 12),
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      ...w.modules.map((m) => _moduleChip(attrs, m)),
                      if (w.truncated)
                        Text(
                            l10n.analyticsAndMore,
                            style: TextStyle(
                                color: attrs.textMuted,
                                fontStyle: FontStyle.italic,
                                fontSize: 12)),
                    ],
                  ),
                ),
              Divider(color: attrs.borderMain.withOpacity(0.4), height: 1),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _moduleChip(ThemeAttributes attrs, String name) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () => context.go('/edit/$name'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: attrs.bgInput,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: attrs.borderMain),
        ),
        child: Text(name,
            style: TextStyle(
                color: attrs.textMain,
                fontFamily: 'monospace',
                fontSize: 12)),
      ),
    );
  }

  Widget _emptyHint(ThemeAttributes attrs, String text, {bool error = false}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: attrs.bgCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: error ? _cStale.withOpacity(0.5) : attrs.borderMain),
      ),
      child: Text(text,
          style: TextStyle(
              color: error ? _cStale : attrs.textMuted, fontSize: 13)),
    );
  }

  // ── Helfer ──────────────────────────────────────────────────────────────

  String _fmt(int n) {
    final s = n.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
      buf.write(s[i]);
    }
    return buf.toString();
  }

  String _weekLabel(String isoDate, AppLocalizations l10n) {
    // isoDate = YYYY-MM-DD (Montag). Als "KW ab DD.MM.YYYY" darstellen.
    if (isoDate.length < 10) return isoDate;
    final y = isoDate.substring(0, 4);
    final m = isoDate.substring(5, 7);
    final d = isoDate.substring(8, 10);
    return l10n.localeName == 'de' ? '$d.$m.$y' : '$y-$m-$d';
  }
}
