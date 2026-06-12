import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
// utf8 is part of dart:convert (already imported above)
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../providers/language_provider.dart';
import '../../providers/theme_provider.dart';
import '../../theme/app_theme.dart';
import '../../services/api_client.dart';
import '../../widgets/glass_container.dart';

class CategoriesScreen extends ConsumerStatefulWidget {
  const CategoriesScreen({super.key});

  @override
  ConsumerState<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends ConsumerState<CategoriesScreen> {
  final ApiClient _api = ApiClient();
  List<dynamic> _categories = [];
  Map<String, String> _translations = {};
  bool _isLoading = true;
  bool _isSaving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _fetchCategories());
  }

  Future<void> _fetchCategories() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final langcode = ref.read(languageProvider).targetLanguage.code;
      final response = await _api.dio.get('/categories', queryParameters: {'langcode': langcode});
      
      final data = response.data['data'] as List<dynamic>;
      final Map<String, String> initialTrans = {};
      
      for (final cat in data) {
        final id = cat['id']?.toString() ?? '';
        final translatedName = cat['meta']?['translated_name']?.toString() ?? '';
        if (translatedName.isNotEmpty) {
          initialTrans[id] = translatedName;
        }
      }

      setState(() {
        _categories = data;
        _translations = initialTrans;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Fehler beim Laden der Kategorien: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _handleSave() async {
    setState(() {
      _isSaving = true;
    });

    final isGerman = ref.read(languageProvider).targetLanguage.code == 'de';

    try {
      final langcode = ref.read(languageProvider).targetLanguage.code;
      await _api.dio.post('/categories/translate', data: {
        'langcode': langcode,
        'translations': _translations,
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isGerman 
              ? 'Kategorien erfolgreich gespeichert.' 
              : 'Categories saved successfully.'),
            backgroundColor: Colors.green.shade800,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isGerman 
              ? 'Fehler beim Speichern.' 
              : 'Failed to save translations: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  Future<void> _handleImport() async {
    final langcode = ref.read(languageProvider).targetLanguage.code;
    final isGerman = langcode == 'de';

    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
      withData: true,
    );

    if (result == null || result.files.single.bytes == null) return;

    final raw = utf8.decode(result.files.single.bytes!);
    if (raw.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(isGerman ? 'Datei ist leer.' : 'File is empty.'),
          backgroundColor: Colors.redAccent,
        ));
      }
      return;
    }

    Map<String, dynamic> parsed;
    try {
      parsed = jsonDecode(raw) as Map<String, dynamic>;
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(isGerman ? 'Ungültiges JSON-Format.' : 'Invalid JSON format.'),
          backgroundColor: Colors.redAccent,
        ));
      }
      return;
    }

    // Only keep UUID-like keys (36 chars with dashes) — skip meta-labels.
    final translations = Map<String, String>.fromEntries(
      parsed.entries
          .where((e) => RegExp(r'^[0-9a-f-]{36}$').hasMatch(e.key) && e.value is String)
          .map((e) => MapEntry(e.key, e.value as String)),
    );

    if (translations.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(isGerman
              ? 'Keine gültigen UUID-Einträge gefunden.'
              : 'No valid UUID entries found in file.'),
          backgroundColor: Colors.redAccent,
        ));
      }
      return;
    }

    try {
      await _api.dio.post('/categories/translate', data: {
        'langcode': langcode,
        'translations': translations,
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(isGerman
              ? '${translations.length} Kategorien aus Datei importiert.'
              : '${translations.length} categories imported from file.'),
          backgroundColor: Colors.green.shade800,
        ));
      }
      _fetchCategories();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(isGerman ? 'Fehler beim Speichern.' : 'Failed to save: $e'),
          backgroundColor: Colors.redAccent,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeState = ref.watch(themeProvider);
    final langState = ref.watch(languageProvider);
    final attrs = AppTheme.getAttributes(themeState.themeId);
    final isGerman = langState.targetLanguage.code == 'de';

    // Reload categories if language changes
    ref.listen(languageProvider, (previous, next) {
      if (previous?.targetLanguage.code != next.targetLanguage.code) {
        _fetchCategories();
      }
    });

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Area
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isGerman ? 'Kategorien' : 'Categories',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: attrs.textMain,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${isGerman ? "Übersetzung für" : "Translating for"}: ${langState.targetLanguage.name}',
                      style: TextStyle(
                        fontSize: 14,
                        color: attrs.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  OutlinedButton.icon(
                    onPressed: _isLoading ? null : _handleImport,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      side: BorderSide(color: attrs.borderMain),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: Icon(LucideIcons.upload, size: 16, color: attrs.brand600),
                    label: Text(
                      isGerman ? 'JSON importieren' : 'Import JSON',
                      style: TextStyle(color: attrs.textMain, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: _isLoading || _isSaving ? null : _handleSave,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      backgroundColor: attrs.brand600,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: _isSaving 
                        ? const SizedBox(
                            width: 16, 
                            height: 16, 
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)
                          )
                        : const Icon(LucideIcons.save, size: 16),
                    label: Text(
                      _isSaving 
                          ? (isGerman ? 'Speichert...' : 'Saving...')
                          : (isGerman ? 'Alle speichern' : 'Save All'),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Content Area
          if (_isLoading)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 64.0),
                child: Column(
                  children: [
                    CircularProgressIndicator(color: attrs.brand600),
                    const SizedBox(height: 16),
                    Text(
                      isGerman ? 'Lade Kategorien...' : 'Loading categories...',
                      style: TextStyle(color: attrs.textMuted),
                    )
                  ],
                ),
              ),
            )
          else if (_error != null)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 64.0),
                child: Column(
                  children: [
                    const Icon(LucideIcons.alertTriangle, color: Colors.redAccent, size: 48),
                    const SizedBox(height: 16),
                    Text(_error!, style: const TextStyle(color: Colors.redAccent)),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _fetchCategories,
                      child: Text(isGerman ? 'Erneut versuchen' : 'Retry'),
                    )
                  ],
                ),
              ),
            )
          else
            GlassContainer(
              border: Border.all(color: attrs.borderMain),
              borderRadius: 24,
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Table Header
                  Container(
                    decoration: BoxDecoration(
                      color: attrs.bgSidebar.withOpacity(0.1),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            isGerman ? 'Original (EN)' : 'Original (EN)',
                            style: TextStyle(
                              color: attrs.textMuted,
                              fontWeight: FontWeight.w900,
                              fontSize: 12,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            isGerman ? 'Übersetzung (${langState.targetLanguage.code})' : 'Translation (${langState.targetLanguage.code})',
                            style: TextStyle(
                              color: attrs.textMuted,
                              fontWeight: FontWeight.w900,
                              fontSize: 12,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Table Body
                  if (_categories.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(48.0),
                      child: Center(
                        child: Text(
                          isGerman ? 'Keine Kategorien gefunden.' : 'No categories found.',
                          style: TextStyle(color: attrs.textMuted),
                        ),
                      ),
                    )
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _categories.length,
                      separatorBuilder: (context, index) => Divider(color: attrs.borderMain, height: 1),
                      itemBuilder: (context, index) {
                        final cat = _categories[index];
                        final id = cat['id']?.toString() ?? '';
                        final name = cat['attributes']?['name']?.toString() ?? 'Unknown';

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  name,
                                  style: TextStyle(
                                    color: attrs.textMain,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: TextEditingController(text: _translations[id] ?? '')
                                    ..selection = TextSelection.collapsed(offset: (_translations[id] ?? '').length),
                                  onChanged: (val) {
                                    _translations[id] = val;
                                  },
                                  decoration: InputDecoration(
                                    hintText: isGerman ? 'Übersetze "$name"...' : 'Translate "$name"...',
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  ),
                                  style: TextStyle(color: attrs.textMain, fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
