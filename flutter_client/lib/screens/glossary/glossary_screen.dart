import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../providers/theme_provider.dart';
import '../../providers/language_provider.dart';
import '../../providers/auth_provider.dart';
import '../../services/api_client.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_container.dart';

class GlossaryScreen extends ConsumerStatefulWidget {
  const GlossaryScreen({super.key});

  @override
  ConsumerState<GlossaryScreen> createState() => _GlossaryScreenState();
}

class _GlossaryScreenState extends ConsumerState<GlossaryScreen> {
  final ApiClient _api = ApiClient();
  List<dynamic> _terms = [];
  bool _isLoading = true;
  String? _error;

  // Form state for add/edit dialog
  final _sourceWordCtrl    = TextEditingController();
  final _preferredWordCtrl = TextEditingController();
  final _explanationCtrl   = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(_fetchTerms);
  }

  @override
  void dispose() {
    _sourceWordCtrl.dispose();
    _preferredWordCtrl.dispose();
    _explanationCtrl.dispose();
    super.dispose();
  }

  Future<void> _fetchTerms() async {
    setState(() { _isLoading = true; _error = null; });
    final lang = ref.read(languageProvider).targetLanguage.code;
    try {
      final res = await _api.dio.get('/glossary', queryParameters: {'langcode': lang});
      setState(() { _terms = res.data as List<dynamic>; _isLoading = false; });
    } catch (e) {
      setState(() { _error = 'Fehler beim Laden: $e'; _isLoading = false; });
    }
  }

  Future<void> _showEditDialog({Map<String, dynamic>? existing}) async {
    final attrs = AppTheme.getAttributes(ref.read(themeProvider).themeId);
    final lang  = ref.read(languageProvider).targetLanguage.code;
    final isNew = existing == null;

    _sourceWordCtrl.text    = existing?['source_word']    ?? '';
    _preferredWordCtrl.text = existing?['preferred_word'] ?? '';
    _explanationCtrl.text   = existing?['explanation']    ?? '';

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        child: GlassContainer(
          padding: const EdgeInsets.all(28),
          borderRadius: 20,
          backgroundColor: attrs.bgCard,
          border: Border.all(color: attrs.borderMain),
          width: 520,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(children: [
                Icon(LucideIcons.bookOpen, color: attrs.brand600, size: 20),
                const SizedBox(width: 10),
                Text(
                  isNew ? 'Neuen Begriff anlegen' : 'Begriff bearbeiten',
                  style: TextStyle(
                    color: attrs.textMain,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
              const SizedBox(height: 24),
              _field(attrs, 'Quellwort (erscheint im Text)',
                  'z. B. Knoten', _sourceWordCtrl),
              const SizedBox(height: 14),
              _field(attrs, 'Bevorzugte Übersetzung',
                  'z. B. Inhalt', _preferredWordCtrl),
              const SizedBox(height: 14),
              _field(attrs, 'Erklärung (wird im Tooltip angezeigt)',
                  'Warum soll dieses Wort anders übersetzt werden?',
                  _explanationCtrl, maxLines: 4),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx, false),
                    child: Text('Abbrechen',
                        style: TextStyle(color: attrs.textMuted)),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pop(ctx, true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: attrs.brand600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: Icon(
                        isNew ? LucideIcons.plus : LucideIcons.save,
                        size: 16),
                    label: Text(isNew ? 'Anlegen' : 'Speichern',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    if (confirmed != true) return;
    if (_sourceWordCtrl.text.trim().isEmpty ||
        _preferredWordCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Quellwort und bevorzugte Übersetzung sind Pflichtfelder.'),
        backgroundColor: Colors.redAccent,
      ));
      return;
    }

    final payload = {
      'lang_code':      lang,
      'source_word':    _sourceWordCtrl.text.trim(),
      'preferred_word': _preferredWordCtrl.text.trim(),
      'explanation':    _explanationCtrl.text.trim(),
    };

    try {
      if (isNew) {
        await _api.dio.post('/glossary', data: payload);
      } else {
        await _api.dio.put('/glossary/${existing!['id']}', data: payload);
      }
      await _fetchTerms();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(isNew
              ? 'Begriff angelegt ✓'
              : 'Begriff aktualisiert ✓'),
          backgroundColor: Colors.green,
        ));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Fehler: $e'),
          backgroundColor: Colors.redAccent,
        ));
      }
    }
  }

  Future<void> _deleteTerm(Map<String, dynamic> term) async {
    final attrs = AppTheme.getAttributes(ref.read(themeProvider).themeId);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A1F26),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Begriff löschen?',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: Text(
          '"${term['source_word']}" wird dauerhaft aus dem Glossar entfernt.',
          style: TextStyle(color: attrs.textMuted),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text('Abbrechen',
                  style: TextStyle(color: attrs.textMuted))),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent),
            child: const Text('Löschen',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await _api.dio.delete('/glossary/${term['id']}');
      await _fetchTerms();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Begriff gelöscht.'),
          backgroundColor: Colors.orange,
        ));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Fehler: $e'),
          backgroundColor: Colors.redAccent,
        ));
      }
    }
  }

  Widget _field(ThemeAttributes attrs, String label, String hint,
      TextEditingController ctrl, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
                color: attrs.textMuted,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5)),
        const SizedBox(height: 6),
        TextField(
          controller: ctrl,
          maxLines: maxLines,
          style: TextStyle(color: attrs.textMain, fontSize: 13),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: attrs.textMuted.withOpacity(0.6)),
            filled: true,
            fillColor: attrs.bgInput,
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 14, vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: attrs.borderMain),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: attrs.borderMain),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: attrs.brand600, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeState = ref.watch(themeProvider);
    final langState  = ref.watch(languageProvider);
    final attrs      = AppTheme.getAttributes(themeState.themeId);
    final user       = ref.watch(authProvider).user;
    final canEdit    = user?.isReviewer == true;
    final isMobile   = MediaQuery.of(context).size.width < 600;

    // Re-fetch when language changes
    ref.listen(languageProvider, (prev, next) {
      if (prev?.targetLanguage.code != next.targetLanguage.code) {
        _fetchTerms();
      }
    });

    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 14 : 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Header ───────────────────────────────────────────────────────
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: attrs.brand600,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(LucideIcons.bookOpen,
                    size: 26, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Übersetzungs-Glossar',
                      style: TextStyle(
                        fontSize: isMobile ? 20 : 28,
                        fontWeight: FontWeight.w900,
                        color: attrs.textMain,
                      ),
                    ),
                    Text(
                      'Sprache: ${langState.targetLanguage.name} · '
                      '${_terms.length} Einträge',
                      style:
                          TextStyle(color: attrs.textMuted, fontSize: 13),
                    ),
                  ],
                ),
              ),
              if (canEdit)
                ElevatedButton.icon(
                  onPressed: _showEditDialog,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: attrs.brand600,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: const Icon(LucideIcons.plus, size: 16),
                  label: Text(isMobile ? 'Neu' : 'Begriff anlegen',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
            ],
          ),
          const SizedBox(height: 28),

          // ── Info-Banner ───────────────────────────────────────────────────
          GlassContainer(
            padding: const EdgeInsets.all(16),
            borderRadius: 12,
            border: Border.all(color: attrs.brand600.withOpacity(0.3)),
            backgroundColor: attrs.brand600.withOpacity(0.06),
            child: Row(children: [
              Icon(LucideIcons.info, color: attrs.brand600, size: 16),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Wörter aus diesem Glossar werden im Review-Editor '
                  'farblich hervorgehoben. Ein Tooltip erklärt beim '
                  'Überfahren warum eine andere Übersetzung besser passt.',
                  style: TextStyle(color: attrs.textMuted, fontSize: 13),
                ),
              ),
            ]),
          ),
          const SizedBox(height: 24),

          // ── Content ───────────────────────────────────────────────────────
          if (_isLoading)
            Center(
                child: Padding(
              padding: const EdgeInsets.all(48),
              child: CircularProgressIndicator(color: attrs.brand600),
            ))
          else if (_error != null)
            Center(
                child: Text(_error!,
                    style: const TextStyle(color: Colors.redAccent)))
          else if (_terms.isEmpty)
            GlassContainer(
              padding: const EdgeInsets.all(48),
              border: Border.all(color: attrs.borderMain),
              child: Column(children: [
                Icon(LucideIcons.bookOpen,
                    size: 48, color: attrs.textMuted),
                const SizedBox(height: 16),
                Text('Noch keine Einträge.',
                    style: TextStyle(
                        color: attrs.textMain,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(
                  canEdit
                      ? 'Klicke auf „Begriff anlegen" um den ersten Eintrag zu erstellen.'
                      : 'Noch keine Glossar-Einträge für diese Sprache.',
                  style: TextStyle(color: attrs.textMuted, fontSize: 13),
                  textAlign: TextAlign.center,
                ),
              ]),
            )
          else
            GlassContainer(
              border: Border.all(color: attrs.borderMain),
              child: Column(
                children: _terms.asMap().entries.map((entry) {
                  final i    = entry.key;
                  final term = entry.value as Map<String, dynamic>;
                  final isLast = i == _terms.length - 1;
                  return Column(
                    children: [
                      _TermRow(
                        term: term,
                        attrs: attrs,
                        canEdit: canEdit,
                        onEdit: () =>
                            _showEditDialog(existing: term),
                        onDelete: () => _deleteTerm(term),
                      ),
                      if (!isLast)
                        Divider(
                            height: 1,
                            color: attrs.borderMain),
                    ],
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}

// ── Single term row ──────────────────────────────────────────────────────────

class _TermRow extends StatelessWidget {
  final Map<String, dynamic> term;
  final ThemeAttributes attrs;
  final bool canEdit;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _TermRow({
    required this.term,
    required this.attrs,
    required this.canEdit,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Source word badge
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFF59E0B).withOpacity(0.15),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                  color: const Color(0xFFF59E0B).withOpacity(0.4)),
            ),
            child: Text(
              term['source_word'] ?? '',
              style: const TextStyle(
                color: Color(0xFFF59E0B),
                fontWeight: FontWeight.bold,
                fontSize: 13,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Arrow
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Icon(LucideIcons.arrowRight,
                size: 14, color: attrs.textMuted),
          ),
          const SizedBox(width: 10),
          // Preferred word badge
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: attrs.brand600.withOpacity(0.15),
              borderRadius: BorderRadius.circular(6),
              border:
                  Border.all(color: attrs.brand600.withOpacity(0.4)),
            ),
            child: Text(
              term['preferred_word'] ?? '',
              style: TextStyle(
                color: attrs.brand600,
                fontWeight: FontWeight.bold,
                fontSize: 13,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(width: 14),
          // Explanation
          Expanded(
            child: Text(
              term['explanation'] ?? '',
              style: TextStyle(
                  color: attrs.textMuted, fontSize: 12, height: 1.5),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (canEdit) ...[
            IconButton(
              icon: Icon(LucideIcons.edit2,
                  size: 15, color: attrs.textMuted),
              tooltip: 'Bearbeiten',
              onPressed: onEdit,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(LucideIcons.trash2,
                  size: 15, color: Colors.redAccent),
              tooltip: 'Löschen',
              onPressed: onDelete,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ],
      ),
    );
  }
}
