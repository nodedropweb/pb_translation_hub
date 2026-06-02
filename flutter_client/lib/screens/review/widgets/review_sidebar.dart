import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/glass_container.dart';

class ReviewSidebar extends StatefulWidget {
  final bool isOpen;
  final ThemeAttributes attrs;
  final bool isGerman;
  final String machineName;
  final Map<String, dynamic>? project;
  final Map<String, dynamic>? currentTranslation;
  final List<dynamic> suggestions;
  final String? activeSuggestionId;
  final ValueChanged<String> onSuggestionTap;
  final ValueChanged<Map<String, dynamic>> onApplySuggestion;
  final ValueChanged<String> onDeleteSuggestion;

  const ReviewSidebar({
    super.key,
    required this.isOpen,
    required this.attrs,
    required this.isGerman,
    required this.machineName,
    required this.project,
    required this.currentTranslation,
    required this.suggestions,
    required this.activeSuggestionId,
    required this.onSuggestionTap,
    required this.onApplySuggestion,
    required this.onDeleteSuggestion,
  });

  @override
  State<ReviewSidebar> createState() => _ReviewSidebarState();
}

class _ReviewSidebarState extends State<ReviewSidebar> {
  bool _showSourceCode = false;

  Widget _detailRow(String label, String value, ThemeAttributes a) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: a.textMuted, fontSize: 12, fontWeight: FontWeight.bold)),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: a.textMain, fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final attrs    = widget.attrs;
    final isGerman = widget.isGerman;
    final project  = widget.project;

    final engTitle   = project?['attributes']?['title'] as String? ?? '';
    final engSummary = project?['attributes']?['body']?['summary'] as String? ?? '';
    final engBody    = project?['attributes']?['body']?['value'] as String? ?? '';

    return AnimatedContainer(
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeInOut,
      width: widget.isOpen ? 340 : 0,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 24),
          child: Column(
            children: [
              // ── Englische Quelle ─────────────────────────────────────────
              GlassContainer(
                border: Border.all(color: attrs.borderMain),
                padding: const EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                        border: Border(bottom: BorderSide(color: attrs.borderMain)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            isGerman ? 'ENGLISCHE QUELLE' : 'ENGLISH SOURCE',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: attrs.textMuted, letterSpacing: 1),
                          ),
                          Row(
                            children: [
                              // Quellcode / Vorschau toggle
                              Tooltip(
                                message: _showSourceCode
                                    ? (isGerman ? 'Vorschau anzeigen' : 'Show preview')
                                    : (isGerman ? 'HTML-Quellcode' : 'HTML source'),
                                child: IconButton(
                                  icon: Icon(_showSourceCode ? LucideIcons.eye : LucideIcons.code, size: 14, color: Colors.white54),
                                  onPressed: () => setState(() => _showSourceCode = !_showSourceCode),
                                  style: IconButton.styleFrom(visualDensity: VisualDensity.compact),
                                ),
                              ),
                              // Copy
                              Tooltip(
                                message: isGerman ? 'Quelltext kopieren' : 'Copy source',
                                child: IconButton(
                                  icon: const Icon(LucideIcons.copy, size: 14, color: Colors.white54),
                                  onPressed: () {
                                    final text = 'TITLE:\n$engTitle\n\nSUMMARY:\n$engSummary\n\nBODY:\n$engBody';
                                    Clipboard.setData(ClipboardData(text: text));
                                  },
                                  style: IconButton.styleFrom(visualDensity: VisualDensity.compact),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Content
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: _showSourceCode
                          ? Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.white10),
                              ),
                              child: SelectableText(
                                'TITLE:\n$engTitle\n\nSUMMARY:\n$engSummary\n\nBODY:\n$engBody',
                                style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: attrs.brand600),
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (engTitle.isNotEmpty) ...[
                                  Text(engTitle, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 12),
                                ],
                                if (engSummary.isNotEmpty) ...[
                                  Text(isGerman ? 'Zusammenfassung:' : 'Summary:', style: TextStyle(color: attrs.brand600, fontSize: 11, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 6),
                                  HtmlWidget(engSummary, textStyle: const TextStyle(color: Color(0xFFE2E8F0), fontSize: 13, height: 1.6)),
                                  const SizedBox(height: 12),
                                ],
                                if (engBody.isNotEmpty) ...[
                                  Text(isGerman ? 'Beschreibung:' : 'Description:', style: TextStyle(color: attrs.brand600, fontSize: 11, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 6),
                                  HtmlWidget(engBody, textStyle: const TextStyle(color: Color(0xFFE2E8F0), fontSize: 13, height: 1.6)),
                                ],
                              ],
                            ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // ── Details Card ─────────────────────────────────────────────
              GlassContainer(
                border: Border.all(color: attrs.borderMain),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isGerman ? 'Modul Details' : 'Module Details',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: attrs.textMain),
                    ),
                    const SizedBox(height: 20),
                    _detailRow(isGerman ? 'Original-Titel' : 'Original Title', project?['attributes']?['title'] ?? '', attrs),
                    _detailRow('Status', widget.currentTranslation?['is_review'] == true ? 'In Review' : 'Translated', attrs),
                    _detailRow('Machine Name', widget.machineName, attrs),
                    const Divider(height: 32),
                    OutlinedButton.icon(
                      onPressed: () async {
                        final uri = Uri.parse('https://drupal.org/project/${widget.machineName}');
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri, mode: LaunchMode.externalApplication);
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(40),
                        side: BorderSide(color: attrs.borderMain),
                      ),
                      icon: const Icon(LucideIcons.externalLink, size: 14),
                      label: Text(
                        isGerman ? 'Drupal.org-Projekt' : 'Drupal.org Project',
                        style: TextStyle(color: attrs.textMain, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // ── Suggestions Card ─────────────────────────────────────────
              GlassContainer(
                border: Border.all(color: attrs.borderMain),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          isGerman ? 'Vorschläge' : 'Suggestions',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: attrs.textMain),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: attrs.borderMain),
                          ),
                          child: Text(
                            '${widget.suggestions.length}',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: attrs.textMuted),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    if (widget.suggestions.isEmpty)
                      Text(
                        isGerman ? 'Keine Vorschläge vorhanden.' : 'No suggestions available.',
                        style: TextStyle(color: attrs.textMuted, fontSize: 13, fontStyle: FontStyle.italic),
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.suggestions.length,
                        itemBuilder: (context, index) {
                          final s = widget.suggestions[index];
                          final id = s['id']?.toString() ?? '';
                          final isAi = s['suggestion_type'] == 'ai';
                          final author = isAi ? 'AI Generated' : (s['username'] ?? 'User');
                          final dateStr = s['created_at'] != null
                              ? DateTime.parse(s['created_at'].toString()).toLocal().toString().substring(0, 10)
                              : '';
                          final isActive = widget.activeSuggestionId == id;

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: InkWell(
                              onTap: () => widget.onSuggestionTap(id),
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: isActive ? attrs.brand600.withOpacity(0.2) : Colors.white.withOpacity(0.1),
                                  border: Border.all(color: isActive ? attrs.brand600 : attrs.borderMain),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(isAi ? LucideIcons.sparkles : LucideIcons.user, size: 12, color: isAi ? Colors.amber : attrs.brand600),
                                            const SizedBox(width: 6),
                                            Text(author, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: attrs.textMain)),
                                          ],
                                        ),
                                        Text(dateStr, style: TextStyle(color: attrs.textMuted, fontSize: 10)),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '"${s['title'] ?? ''}"',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: attrs.textMuted, fontSize: 11, fontStyle: FontStyle.italic),
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () => widget.onApplySuggestion(s),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: attrs.brand600,
                                              padding: const EdgeInsets.symmetric(vertical: 8),
                                            ),
                                            child: Text(isGerman ? 'Übernehmen' : 'Apply', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        IconButton(
                                          icon: const Icon(LucideIcons.trash2, size: 14, color: Colors.redAccent),
                                          onPressed: () => widget.onDeleteSuggestion(id),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
