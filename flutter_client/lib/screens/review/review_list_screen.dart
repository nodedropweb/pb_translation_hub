import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import '../../services/api_client.dart';
import '../../providers/theme_provider.dart';
import '../../providers/language_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/module_logo.dart';

class ReviewListScreen extends ConsumerStatefulWidget {
  const ReviewListScreen({super.key});

  @override
  ConsumerState<ReviewListScreen> createState() => _ReviewListScreenState();
}

class _ReviewListScreenState extends ConsumerState<ReviewListScreen> {
  final ApiClient _api = ApiClient();
  bool _isLoading = true;
  bool _isResettingAll = false;
  List<dynamic> _reviewProjects = [];
  int _totalCount = 0;
  String _searchQuery = '';

  // Debounce timer so we don't fire a request on every keystroke.
  DateTime? _lastSearchTime;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _fetchReviewProjects());
  }

  Future<void> _fetchReviewProjects({String search = ''}) async {
    setState(() => _isLoading = true);

    final lang = ref.read(languageProvider).targetLanguage.code;

    try {
      final queryParams = {
        'langcode': lang,
        'filter': 'review',
        'limit': 100,
        if (search.isNotEmpty) 'search': search,
      };
      final response = await _api.dio.get('/projects', queryParameters: queryParams);
      final rawData = response.data['data'] as List<dynamic>;
      final meta = response.data['meta'] as Map<String, dynamic>?;
      setState(() {
        _reviewProjects = rawData;
        _totalCount = meta?['count'] ?? rawData.length;
        _isLoading = false;
      });
    } catch (e) {
      print('Failed to fetch review projects: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _resetAllPublished() async {
    final lang = ref.read(languageProvider).targetLanguage.code;
    final attrs = AppTheme.getAttributes(ref.read(themeProvider).themeId);
    final isGerman = lang == 'de';

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A1D23),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          isGerman
              ? 'Alle veröffentlichten Übersetzungen zurücksetzen?'
              : 'Reset all published translations?',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: Text(
          isGerman
              ? 'Alle als "Veröffentlicht" markierten Übersetzungen für ${lang.toUpperCase()} werden auf den Review-Status zurückgesetzt. Diese Aktion kann nicht rückgängig gemacht werden.'
              : 'All translations marked as published for ${lang.toUpperCase()} will be reset to review state. This cannot be undone.',
          style: TextStyle(color: Colors.white70, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(isGerman ? 'Abbrechen' : 'Cancel',
                style: TextStyle(color: Colors.white54)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: Text(isGerman ? 'Zurücksetzen' : 'Reset',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _isResettingAll = true);
    try {
      final res = await _api.dio.post('/translations/unreview-all', data: {'langcode': lang});
      final count = res.data['count'] as int? ?? 0;
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(isGerman
              ? '$count Übersetzungen zurück in Review gesetzt.'
              : '$count translations reset to review state.'),
          backgroundColor: Colors.orange,
          duration: const Duration(seconds: 4),
        ));
        _fetchReviewProjects(search: _searchQuery);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Fehler: $e'),
          backgroundColor: Colors.redAccent,
        ));
      }
    } finally {
      if (mounted) setState(() => _isResettingAll = false);
    }
  }

  void _onSearchChanged(String value) {
    setState(() => _searchQuery = value);
    final now = DateTime.now();
    _lastSearchTime = now;
    // Debounce: wait 400 ms before firing the request.
    Future.delayed(const Duration(milliseconds: 400), () {
      if (_lastSearchTime == now) {
        _fetchReviewProjects(search: value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeState = ref.watch(themeProvider);
    final langState = ref.watch(languageProvider);
    final attrs = AppTheme.getAttributes(themeState.themeId);
    final isGerman = langState.targetLanguage.code == 'de';

    // Filtering is now done server-side via the search parameter.
    // The local list already reflects the current search query.
    final filteredList = _reviewProjects;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: attrs.brand600,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(LucideIcons.shieldAlert, size: 28, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isGerman ? 'Review-Warteschlange' : 'Review Pipeline',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: attrs.textMain,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isGerman 
                            ? 'Menschliche Endabnahme für automatische Übersetzungen' 
                            : 'Human quality assurance pipeline for AI translations',
                        style: TextStyle(
                          color: attrs.textMuted,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
            ],
          ),
          const SizedBox(height: 32),

          // Search + action toolbar
          GlassContainer(
            border: Border.all(color: attrs.borderMain),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Search field
                Expanded(
                  child: TextFormField(
                    onChanged: _onSearchChanged,
                    decoration: InputDecoration(
                      hintText: isGerman ? 'Projekt suchen...' : 'Search projects...',
                      hintStyle: TextStyle(color: attrs.textMuted),
                      prefixIcon: Icon(LucideIcons.search, color: attrs.textMuted, size: 18),
                      filled: true,
                      fillColor: Colors.black12,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: attrs.borderMain),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: attrs.borderMain),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: attrs.brand600),
                      ),
                    ),
                    style: TextStyle(color: attrs.textMain),
                  ),
                ),
                const SizedBox(width: 12),

                // Refresh button
                OutlinedButton.icon(
                  onPressed: _isLoading
                      ? null
                      : () => _fetchReviewProjects(search: _searchQuery),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                    side: BorderSide(color: attrs.borderMain),
                    foregroundColor: attrs.textMain,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: _isLoading
                      ? SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: attrs.brand600))
                      : Icon(LucideIcons.refreshCw,
                          size: 15, color: attrs.brand600),
                  label: Text(
                    isGerman ? 'Aktualisieren' : 'Refresh',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 12),

                // Reset all published button
                OutlinedButton.icon(
                  onPressed: _isResettingAll ? null : _resetAllPublished,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                    side: const BorderSide(color: Colors.orange),
                    foregroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: _isResettingAll
                      ? const SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.orange))
                      : const Icon(LucideIcons.rotateCcw, size: 15),
                  label: Text(
                    isGerman ? 'Freigaben zurücksetzen' : 'Reset published',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 12),

                // Count badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  decoration: BoxDecoration(
                    color: attrs.brand600.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: attrs.brand600.withOpacity(0.2)),
                  ),
                  child: Row(
                    children: [
                      Icon(LucideIcons.layers, size: 16, color: attrs.brand600),
                      const SizedBox(width: 8),
                      Text(
                        _searchQuery.isNotEmpty
                            ? (isGerman
                                ? 'Treffer: ${_reviewProjects.length} / $_totalCount'
                                : 'Results: ${_reviewProjects.length} / $_totalCount')
                            : (isGerman
                                ? 'Wartend: $_totalCount'
                                : 'Pending: $_totalCount'),
                        style: TextStyle(
                          color: attrs.brand600,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Grid/List of projects
          if (_isLoading)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(64.0),
                child: CircularProgressIndicator(color: attrs.brand600),
              ),
            )
          else if (filteredList.isEmpty)
            GlassContainer(
              border: Border.all(color: attrs.borderMain),
              padding: const EdgeInsets.all(64),
              child: Column(
                children: [
                  Icon(LucideIcons.checkCircle, size: 48, color: attrs.textMuted),
                  const SizedBox(height: 16),
                  Text(
                    isGerman ? 'Keine Projekte ausstehend.' : 'No projects pending review.',
                    style: TextStyle(
                      color: attrs.textMain,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isGerman
                        ? 'Alle Übersetzungen wurden bereits geprüft oder es sind keine Übersetzungen vorhanden.'
                        : 'All translations have already been verified or none exist in this language context.',
                    style: TextStyle(color: attrs.textMuted, fontSize: 13),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 420,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: 0.82,
              ),
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final p = filteredList[index];
                final translation = p['meta']?['translation'] as Map<String, dynamic>?;
                // Übersetzte Version bevorzugen, englischer Fallback
                final title = (translation?['title'] as String?)?.isNotEmpty == true
                    ? translation!['title'] as String
                    : p['attributes']?['title'] ?? 'Unknown Project';
                final machineName = p['attributes']?['field_project_machine_name'] ?? '';
                final rawSummary = (translation?['summary'] as String?)?.isNotEmpty == true
                    ? translation!['summary'] as String
                    : p['attributes']?['body']?['summary'] ?? '';
                final summary = _stripHtml(rawSummary.isNotEmpty ? rawSummary : 'Keine Zusammenfassung.');
                final logoUrl = p['meta']?['logo_url'] as String?;

                return Container(
                  decoration: BoxDecoration(
                    color: attrs.bgCard,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: attrs.borderMain),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // ── Modul-Bild-Banner ────────────────────────────────
                      GestureDetector(
                        onTap: () => context.go('/review/$machineName'),
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: SizedBox(
                            height: 120,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                // Modul-Logo (cached, validiert, mit Fallback)
                                ModuleLogo(
                                  machineName: machineName,
                                  accentColor: Colors.amber,
                                  bgColor: attrs.bgCard,
                                  logoUrl: logoUrl,
                                ),

                                // Gradient-Übergang unten
                                Positioned(
                                  bottom: 0, left: 0, right: 0,
                                  child: Container(
                                    height: 48,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.transparent,
                                          attrs.bgCard.withOpacity(0.85),
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                  ),
                                ),

                                // Status-Stripe oben
                                Positioned(
                                  top: 0, left: 0, right: 0,
                                  child: Container(height: 4, color: Colors.amber),
                                ),

                                // REVIEW-Badge unten-links
                                Positioned(
                                  bottom: 10, left: 16,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.amber.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                          color: Colors.amber.withOpacity(0.15)),
                                    ),
                                    child: const Text(
                                      'REVIEW',
                                      style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.amber,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // ── Karteninhalt ──────────────────────────────────────
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () => context.go('/review/$machineName'),
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: Text(
                                    title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: attrs.textMain,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                machineName,
                                style: TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 11,
                                  color: attrs.brand600,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 10),
                              Expanded(
                                child: Text(
                                  summary,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: attrs.textMuted,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              ElevatedButton.icon(
                                onPressed: () => context.go('/review/$machineName'),
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size.fromHeight(40),
                                  backgroundColor: attrs.brand600,
                                ),
                                icon: const Icon(LucideIcons.shieldAlert, size: 14),
                                label: Text(
                                  isGerman ? 'AUDIT STARTEN' : 'START AUDIT',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  String _stripHtml(String htmlString) {
    final RegExp exp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: true);
    return htmlString.replaceAll(exp, '').trim();
  }
}
