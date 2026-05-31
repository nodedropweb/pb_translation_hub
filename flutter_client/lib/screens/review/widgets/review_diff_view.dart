import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:diff_match_patch/diff_match_patch.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/glass_container.dart';

class ReviewDiffView extends StatelessWidget {
  final ThemeAttributes attrs;
  final String viewMode; // 'visual_diff' or 'source'
  final bool isGerman;
  final String baseTitle;
  final String baseSummary;
  final String baseBody;
  final String currentTitle;
  final String currentSummary;
  final String currentBody;
  final Widget listenButton;

  const ReviewDiffView({
    super.key,
    required this.attrs,
    required this.viewMode,
    required this.isGerman,
    required this.baseTitle,
    required this.baseSummary,
    required this.baseBody,
    required this.currentTitle,
    required this.currentSummary,
    required this.currentBody,
    required this.listenButton,
  });

  Widget _diffSectionTitle(String title, ThemeAttributes attrs) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 16,
          decoration: BoxDecoration(
            color: attrs.brand600,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: attrs.textMain, letterSpacing: 1),
        ),
      ],
    );
  }

  /// Baut das HTML für die Original-Seite (nur Löschungen markiert, Einfügungen ausgeblendet).
  String _computeOldHtml(String oldText, String newText) {
    final dmp = DiffMatchPatch();
    final diffs = dmp.diff(oldText, newText);
    final buffer = StringBuffer();
    for (final d in diffs) {
      if (d.operation == 0) {
        buffer.write(d.text);
      } else if (d.operation == -1) {
        buffer.write('<del style="background:rgba(239,68,68,0.18);color:#f87171;text-decoration:line-through;">${d.text}</del>');
      }
      // Einfügungen (1) im Original nicht anzeigen
    }
    return buffer.toString();
  }

  /// Baut das HTML für die neue Version (nur Einfügungen markiert, Löschungen ausgeblendet).
  String _computeNewHtml(String oldText, String newText) {
    final dmp = DiffMatchPatch();
    final diffs = dmp.diff(oldText, newText);
    final buffer = StringBuffer();
    for (final d in diffs) {
      if (d.operation == 0) {
        buffer.write(d.text);
      } else if (d.operation == 1) {
        buffer.write('<ins style="background:rgba(34,197,94,0.18);color:#4ade80;text-decoration:none;border-bottom:2px solid #22c55e;">${d.text}</ins>');
      }
      // Löschungen (-1) in der neuen Version nicht anzeigen
    }
    return buffer.toString();
  }

  Widget _htmlPane(String html, ThemeAttributes attrs) {
    return HtmlWidget(
      html,
      textStyle: TextStyle(color: attrs.textMain, fontSize: 14, height: 1.6),
      customStylesBuilder: (element) {
        final tag = element.localName ?? '';
        if (['code', 'kbd', 'samp', 'var'].contains(tag)) {
          return {
            'background-color': 'rgba(104,211,145,0.12)',
            'color': '#68D391',
            'border': '1px solid rgba(104,211,145,0.25)',
            'border-radius': '4px',
            'padding': '2px 6px',
            'font-family': 'monospace',
            'font-size': '12px',
          };
        }
        if (tag == 'pre') {
          return {
            'background-color': 'rgba(0,0,0,0.45)',
            'padding': '14px 18px',
            'border-radius': '8px',
            'border-left': '3px solid #6366F1',
            'margin': '12px 0',
          };
        }
        return null;
      },
    );
  }

  Widget _renderHtmlDiff(String oldText, String newText, ThemeAttributes attrs) {
    // Keine Änderungen — nur eine Box anzeigen
    if (oldText == newText) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: attrs.borderMain),
        ),
        child: Text(
          isGerman ? 'Keine Änderungen' : 'No changes',
          style: TextStyle(color: attrs.textMuted, fontSize: 13, fontStyle: FontStyle.italic),
        ),
      );
    }

    final oldHtml = _computeOldHtml(oldText, newText);
    final newHtml = _computeNewHtml(oldText, newText);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Original (oben) ───────────────────────────────────────────────
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1A0A0A),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            border: Border.all(color: const Color(0xFF7F1D1D).withValues(alpha: 0.6)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: const BoxDecoration(
                  color: Color(0xFF450A0A),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(11)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.remove_circle_outline, size: 14, color: Color(0xFFF87171)),
                    const SizedBox(width: 6),
                    Text(
                      isGerman ? 'Original (vor der Korrektur)' : 'Original (before correction)',
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFFF87171)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: _htmlPane(oldHtml, attrs),
              ),
            ],
          ),
        ),

        // ── Neu (unten) ───────────────────────────────────────────────────
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF011A0A),
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
            border: Border(
              left: BorderSide(color: const Color(0xFF14532D).withValues(alpha: 0.6)),
              right: BorderSide(color: const Color(0xFF14532D).withValues(alpha: 0.6)),
              bottom: BorderSide(color: const Color(0xFF14532D).withValues(alpha: 0.6)),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: const BoxDecoration(
                  color: Color(0xFF052E16),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.add_circle_outline, size: 14, color: Color(0xFF4ADE80)),
                    const SizedBox(width: 6),
                    Text(
                      isGerman ? 'Korrigiert (aktuelle Version)' : 'Corrected (current version)',
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF4ADE80)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: _htmlPane(newHtml, attrs),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _rawSourceRow(String label, String base, String review, ThemeAttributes attrs, bool isGerman) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(width: 4, height: 16, decoration: BoxDecoration(color: attrs.brand600, borderRadius: BorderRadius.circular(2))),
            const SizedBox(width: 10),
            Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: attrs.textMain, letterSpacing: 1)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.black26, border: Border.all(color: attrs.borderMain), borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(isGerman ? 'Basis (Original)' : 'Base (Original)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: attrs.textMuted)),
                    const SizedBox(height: 8),
                    SelectableText(base, style: const TextStyle(fontFamily: 'monospace', fontSize: 12, color: Colors.white70)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: attrs.brand600.withOpacity(0.2), border: Border.all(color: attrs.brand600.withOpacity(0.2)), borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(isGerman ? 'Deine Korrektur' : 'Your Correction', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: attrs.brand600)),
                    const SizedBox(height: 8),
                    SelectableText(review, style: const TextStyle(fontFamily: 'monospace', fontSize: 12, color: Colors.white70)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (viewMode == 'visual_diff') {
      return GlassContainer(
        border: Border.all(color: attrs.borderMain),
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isGerman ? 'Änderungen prüfen (Visuell)' : 'Review Your Changes (Visual)',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: attrs.textMain),
                ),
                listenButton,
              ],
            ),
            const Divider(height: 32),

            // Title Diff
            _diffSectionTitle('Title Changes', attrs),
            const SizedBox(height: 12),
            _renderHtmlDiff(baseTitle, currentTitle, attrs),
            const SizedBox(height: 32),

            // Summary Diff
            _diffSectionTitle('Summary Changes', attrs),
            const SizedBox(height: 12),
            _renderHtmlDiff(baseSummary, currentSummary, attrs),
            const SizedBox(height: 32),

            // Body Diff
            _diffSectionTitle('Body Content Changes', attrs),
            const SizedBox(height: 12),
            _renderHtmlDiff(baseBody, currentBody, attrs),
          ],
        ),
      );
    } else {
      // Raw Source comparative blocks (viewMode == 'source')
      return Column(
        children: [
          _rawSourceRow('Title / Titel', baseTitle, currentTitle, attrs, isGerman),
          const SizedBox(height: 24),
          _rawSourceRow('Summary / Zusammenfassung', baseSummary, currentSummary, attrs, isGerman),
          const SizedBox(height: 24),
          _rawSourceRow('Body Content / Hauptinhalt', baseBody, currentBody, attrs, isGerman),
        ],
      );
    }
  }
}
