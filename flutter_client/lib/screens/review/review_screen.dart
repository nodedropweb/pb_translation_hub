// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;
import 'dart:convert';
import 'dart:ui_web' as ui_web;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:go_router/go_router.dart';
import 'package:confetti/confetti.dart';
import '../../services/api_client.dart';
import '../../providers/theme_provider.dart';
import '../../providers/language_provider.dart';
import '../../providers/project_provider.dart';
import '../../utils/translation_prompt.dart';
import '../../utils/html_sanitizer.dart';
import '../../utils/ck_glossary.dart';
import '../../theme/app_theme.dart';
import '../../widgets/ckeditor_field.dart';
import '../../widgets/glass_container.dart';
import 'widgets/review_diff_view.dart';
import 'widgets/review_sidebar.dart';

class ReviewScreen extends ConsumerStatefulWidget {
  final String machineName;
  /// Queue vom vorherigen Review-Screen geerbt — verhindert doppeltes Laden
  /// während ein Approve-POST noch im Hintergrund läuft.
  final List<String> inheritedQueue;

  const ReviewScreen({
    super.key,
    required this.machineName,
    this.inheritedQueue = const [],
  });

  @override
  ConsumerState<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends ConsumerState<ReviewScreen> {
  final ApiClient _api = ApiClient();
  bool _loading = true;
  bool _approving = false;
  bool _ignoring = false;
  bool _isIgnored = false;
  
  Map<String, dynamic>? _project;
  Map<String, dynamic>? _currentTranslation;
  List<dynamic> _suggestions = [];
  List<String> _queue = [];
  String? _activeSuggestionId;
  String _voiceGender = 'female'; // 'female' or 'male'
  String _viewMode = 'edit'; // 'edit', 'visual_diff', 'diff', 'preview', 'source'
  String _diffBase = 'current'; // 'current' or suggestion ID
  Map<String, dynamic> _screenshotAlts = {};
  bool _titleEditable = false;

  // Text inputs
  final _titleController = TextEditingController();
  final _summaryController = TextEditingController();
  final _bodyController = TextEditingController();

  // Speech Synth state
  String? _currentlyPlayingField; // 'summary', 'body', or null

  bool _showSummaryHtml = false;
  bool _showBodyHtml = false;

  // Off-canvas details/suggestions panel (closed by default → more editor space)
  bool _sidebarOpen = false;

  // ── Confetti ───────────────────────────────────────────────────────────
  late ConfettiController _confettiController;

  static bool _viewsRegistered = false;
  static html.IFrameElement? _activeSummarySourceIFrame;
  static html.IFrameElement? _activeBodySourceIFrame;
  late html.EventListener _messageListener;
  // DOM-level keyboard shortcuts (capture phase — bypass CKEditor focus)
  late html.EventListener _keyDownListener;

  /// Registers the CodeMirror source-editor iframes.
  void _registerReviewWysiwygViews() {
    if (_viewsRegistered) return;
    _viewsRegistered = true;

    ui_web.platformViewRegistry.registerViewFactory(
      'wysiwyg-review-summary-source',
      (int viewId) {
        final iframe = html.IFrameElement()
          ..style.border = 'none'
          ..style.width = '100%'
          ..style.height = '100%'
          ..srcdoc = _getSourceIFrameSrcDoc('summary');
        _activeSummarySourceIFrame = iframe;
        return iframe;
      },
    );

    ui_web.platformViewRegistry.registerViewFactory(
      'wysiwyg-review-body-source',
      (int viewId) {
        final iframe = html.IFrameElement()
          ..style.border = 'none'
          ..style.width = '100%'
          ..style.height = '100%'
          ..srcdoc = _getSourceIFrameSrcDoc('body');
        _activeBodySourceIFrame = iframe;
        return iframe;
      },
    );
  }

  /// Posts HTML to the CodeMirror source-editor iframe for [type].
  void _syncToSourceIFrame(String type, String htmlContent) {
    final lang = ref.read(languageProvider).targetLanguage.code;
    final iframe = (type == 'summary') ? _activeSummarySourceIFrame : _activeBodySourceIFrame;
    iframe?.contentWindow?.postMessage({'type': 'setHtml', 'html': htmlContent, 'lang': lang}, '*');
  }

  // ── Message / event listeners ────────────────────────────────────────────────

  void _setupMessageListener() {
    // Listen for source iframe postMessage events (CodeMirror ↔ Dart sync)
    _messageListener = (html.Event event) {
      if (event is html.MessageEvent) {
        final rawData = event.data;
        if (rawData is String) {
          try {
            final data = jsonDecode(rawData);
            if (data is Map) {
              if (data['type'] == 'review-summary-source-change') {
                _summaryController.text = data['html'] ?? '';
              } else if (data['type'] == 'review-body-source-change') {
                _bodyController.text = data['html'] ?? '';
              } else if (data['type'] == 'review-summary-source-ready') {
                _syncToSourceIFrame('summary', _summaryController.text);
              } else if (data['type'] == 'review-body-source-ready') {
                _syncToSourceIFrame('body', _bodyController.text);
              }
            }
          } catch (_) {
            // Ignore other message formats
          }
        }
      }
    };
    html.window.addEventListener('message', _messageListener);
  }

  /// DOM-level keyboard shortcuts — captured before CKEditor can consume them.
  void _setupKeyDownListener() {
    _keyDownListener = (html.Event event) {
      if (event is! html.KeyboardEvent) return;
      final ctrl = event.ctrlKey || event.metaKey;
      final alt = event.altKey;
      final key = event.key?.toLowerCase() ?? '';

      if (ctrl && alt && key == 's') {
        event.preventDefault();
        _handleSaveSuggestion();
      } else if (ctrl && key == 'enter') {
        event.preventDefault();
        _handleApprove();
      } else if (ctrl && key == 'arrowright') {
        event.preventDefault();
        _goToNextReview();
      }
    };
    html.window.addEventListener('keydown', _keyDownListener, true);
  }

  static const _tidyJs = r'''
    function tidyDeeplHtml(text) {
      var bs = String.fromCharCode(92);
      text = text.split('<' + bs + '/').join('</');
      text = text.split('<' + bs + 'n').join('');
      text = text.replace(/<\\[ \t]*(\r\n|\r|\n)/g, '$1');
      text = text.replace(/<\\[ \t]*$/gm, '');
      text = text.replace(/\n{3,}/g, '\n\n');
      return text;
    }
  ''';

  static String _getSourceIFrameSrcDoc(String type) {
    return '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/codemirror.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/theme/material-darker.min.css">
  <style>
    html, body {
      margin: 0;
      padding: 0;
      width: 100%;
      height: 100%;
      background-color: #0F1115;
      overflow: hidden;
    }
    .CodeMirror {
      height: 100%;
      font-family: 'Fira Code', 'Courier New', Courier, monospace;
      font-size: 13px;
      line-height: 1.6;
      background-color: #0F1115 !important;
    }
    .CodeMirror-gutters {
      background-color: #0F1115 !important;
      border-right: 1px solid #1F2937 !important;
    }
    .CodeMirror-linenumber {
      color: #4B5563 !important;
    }
  </style>
</head>
<body>
  <textarea id="code-editor" style="display:none;"></textarea>
  <textarea id="fallback-textarea" style="display:none; width:100%; height:100%; background:#0F1115; color:#E2E8F0; border:none; padding:16px; font-family:monospace; font-size:13px; line-height:1.6; outline:none; resize:none; box-sizing:border-box;"></textarea>

  <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/codemirror.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/mode/xml/xml.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/mode/javascript/javascript.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/mode/css/css.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/mode/htmlmixed/htmlmixed.min.js"></script>

  <script>
    let editor;
    let isUpdating = false;
    let fallbackTextarea = document.getElementById('fallback-textarea');
    let isFallback = false;

    $_tidyJs

    function initEditor() {
      if (typeof CodeMirror !== 'undefined') {
        document.getElementById('code-editor').style.display = 'block';
        editor = CodeMirror.fromTextArea(document.getElementById('code-editor'), {
          mode: 'text/html',
          theme: 'material-darker',
          lineNumbers: true,
          lineWrapping: true,
          tabSize: 2,
          viewportMargin: Infinity
        });

        editor.on('change', (cm) => {
          if (isUpdating) return;
          window.parent.postMessage(JSON.stringify({
            type: 'review-${type}-source-change',
            html: cm.getValue()
          }), '*');
        });
        editor.on('paste', (cm, e) => {
          const text = e.clipboardData && e.clipboardData.getData('text/plain');
          if (!text) return;
          const tidied = tidyDeeplHtml(text);
          if (tidied !== text) {
            e.preventDefault();
            cm.replaceSelection(tidied);
          }
        });
      } else {
        isFallback = true;
        fallbackTextarea.style.display = 'block';
        fallbackTextarea.addEventListener('input', () => {
          if (isUpdating) return;
          window.parent.postMessage(JSON.stringify({
            type: 'review-${type}-source-change',
            html: fallbackTextarea.value
          }), '*');
        });
        fallbackTextarea.addEventListener('paste', e => {
          const text = e.clipboardData && e.clipboardData.getData('text/plain');
          if (!text) return;
          const tidied = tidyDeeplHtml(text);
          if (tidied !== text) {
            e.preventDefault();
            const s = fallbackTextarea.selectionStart, end = fallbackTextarea.selectionEnd;
            fallbackTextarea.value = fallbackTextarea.value.slice(0, s) + tidied + fallbackTextarea.value.slice(end);
            fallbackTextarea.selectionStart = fallbackTextarea.selectionEnd = s + tidied.length;
            fallbackTextarea.dispatchEvent(new Event('input'));
          }
        });
      }

      // Notify parent ready
      window.parent.postMessage(JSON.stringify({ type: 'review-${type}-source-ready' }), '*');
    }

    window.addEventListener('load', () => {
      setTimeout(initEditor, 100);
    });

    window.addEventListener('message', (event) => {
      if (event.data && typeof event.data === 'object') {
        if (event.data.type === 'setHtml') {
          isUpdating = true;
          if (!isFallback && editor) {
            editor.setValue(event.data.html || '');
          } else {
            fallbackTextarea.value = event.data.html || '';
          }
          isUpdating = false;
        }
      }
    });
  </script>
</body>
</html>
''';
  }

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
    _registerReviewWysiwygViews();
    _setupMessageListener();
    _setupKeyDownListener();
    Future.microtask(() async {
      await _fetchData();
      // CKEditor braucht ~120 ms zum Initialisieren nach dem ersten Render.
      // Glossar kurz verzögert laden damit setGlobalGlossary auf einen
      // bereits fertigen Editor trifft.
      await Future.delayed(const Duration(milliseconds: 400));
      _loadGlossary();
    });
  }

  /// Lädt das Glossar für die aktuelle Zielsprache und übergibt es
  /// an die CKEditor-Bridge, die alle aktiven Editoren damit hervorhebt.
  Future<void> _loadGlossary() async {
    final lang = ref.read(languageProvider).targetLanguage.code;
    await loadCkEditorGlossary(_api, lang);
  }

  @override
  void didUpdateWidget(covariant ReviewScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.machineName != widget.machineName) {
      _fetchData();
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _titleController.dispose();
    _summaryController.dispose();
    _bodyController.dispose();
    _stopSpeech();
    html.window.removeEventListener('message', _messageListener);
    html.window.removeEventListener('keydown', _keyDownListener, true);
    super.dispose();
  }

  Future<void> _fetchData() async {
    setState(() {
      _loading = true;
      _titleEditable = false;
      _isIgnored = false;
    });

    final lang = ref.read(languageProvider).targetLanguage.code;

    // 1. Queue laden — geerbte Queue vom vorherigen Screen nutzen falls vorhanden,
    //    damit freigegebene Module nicht nochmal auftauchen während der POST noch läuft.
    if (widget.inheritedQueue.isNotEmpty) {
      _queue = List<String>.from(widget.inheritedQueue);
    } else {
      try {
        final queueRes = await _api.dio.get('/projects', queryParameters: {
          'langcode': lang,
          'filter': 'review',
          'limit': 100,
        });
        final queueData = queueRes.data['data'] as List<dynamic>;
        _queue = queueData.map((p) {
          final attrs = p['attributes'] ?? {};
          return (attrs['field_project_machine_name'] ?? attrs['machine_name'] ?? '').toString();
        }).where((name) => name.isNotEmpty).toList();
      } catch (e) {
        print('ReviewScreen queue fetch error: $e');
        _queue = [];
      }
    }

    // 2. Fetch project details
    try {
      final projectRes = await _api.dio.get('/projects/${widget.machineName}', queryParameters: {
        'langcode': lang,
      });
      _project = projectRes.data['data'] as Map<String, dynamic>;
      _isIgnored = _project?['meta']?['is_ignored'] == true;
    } catch (e) {
      print('ReviewScreen project fetch error: $e');
      _project = null;
    }

    // 3. Fetch current translation
    try {
      final transRes = await _api.dio.get('/translations/$lang/${widget.machineName}');
      _currentTranslation = transRes.data as Map<String, dynamic>;
      
      final engTitle = _project?['attributes']?['title'] as String? ?? '';
      _titleController.text = (_currentTranslation?['title'] as String? ?? '').isNotEmpty
          ? _currentTranslation!['title'] as String
          : engTitle;
      _summaryController.text = _currentTranslation?['body']?['summary'] ?? _currentTranslation?['summary'] ?? '';
      _bodyController.text = _currentTranslation?['body']?['value'] ?? _currentTranslation?['body'] ?? '';
      _screenshotAlts = _currentTranslation?['screenshot_alts'] is Map
          ? Map<String, dynamic>.from(_currentTranslation!['screenshot_alts'])
          : {};
    } catch (e) {
      _currentTranslation = null;
      
      // Fallback to database translation embedded in _project
      final dbTrans = _project?['meta']?['translation'];
      if (dbTrans != null) {
        final engTitle = _project?['attributes']?['title'] as String? ?? '';
        _titleController.text = ((dbTrans['title'] as String?) ?? '').isNotEmpty
            ? dbTrans['title'] as String
            : engTitle;
        _summaryController.text = dbTrans['summary'] ?? '';
        _bodyController.text = dbTrans['body'] ?? '';
        _screenshotAlts = dbTrans['screenshot_alts'] is Map
            ? Map<String, dynamic>.from(dbTrans['screenshot_alts'])
            : {};
      } else {
        _titleController.text = _project?['attributes']?['title'] ?? '';
        _summaryController.text = _project?['attributes']?['body']?['summary'] ?? '';
        _bodyController.text = _project?['attributes']?['body']?['value'] ?? '';
        _screenshotAlts = {};
      }
    }

    // 4. Fetch suggestions
    try {
      final suggestionsRes = await _api.dio.get('/suggestions/$lang/${widget.machineName}');
      _suggestions = suggestionsRes.data as List<dynamic>;

      if (_suggestions.isNotEmpty) {
        final firstSuggestion = _suggestions.first;
        _activeSuggestionId = firstSuggestion['id']?.toString();
        _diffBase = _activeSuggestionId ?? 'current';

        if (_currentTranslation == null && _project?['meta']?['translation'] == null) {
          final engTitle = _project?['attributes']?['title'] as String? ?? '';
          _titleController.text = ((firstSuggestion['title'] as String?) ?? '').isNotEmpty
              ? firstSuggestion['title'] as String
              : engTitle;
          _summaryController.text = firstSuggestion['summary'] ?? '';
          _bodyController.text = firstSuggestion['body'] ?? '';
        }
      } else {
        _diffBase = 'current';
      }
    } catch (e) {
      print('ReviewScreen suggestions fetch error: $e');
      _suggestions = [];
      _diffBase = 'current';
    }

    setState(() {
      _loading = false;
    });
  }

  /// Navigates to the next project using the locally cached queue — no extra
  /// network round-trip needed. Falls back to a fresh fetch only if cache is empty.
  void _goToNextReview() {
    if (!mounted) return;

    // Aktuelles Modul aus der Queue entfernen und die verkleinerte Queue weitergeben.
    // So sieht der nächste Screen sofort die richtige Queue ohne Server-Abfrage,
    // auch wenn der Approve-POST noch im Hintergrund läuft.
    final nextQueue = _queue.where((n) => n != widget.machineName).toList();

    if (nextQueue.isNotEmpty) {
      context.go('/review/${nextQueue.first}',
          extra: {'queue': nextQueue});
    } else {
      context.go('/');
    }
  }

  Future<void> _handleApprove() async {
    final lang = ref.read(languageProvider).targetLanguage.code;
    final isGerman = lang == 'de';
    final attrs = AppTheme.getAttributes(ref.read(themeProvider).themeId);

    final title = _titleController.text.trim();
    final summary = _summaryController.text.trim();
    final body = _bodyController.text.trim();

    if (title.isEmpty && summary.isEmpty && body.isEmpty) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: const Color(0xFF1E222B),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Text(isGerman ? 'Leeres Projekt' : 'Empty Project', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            content: Text(
              isGerman 
                ? 'Dieses Projekt ist leer (kein Titel, Zusammenfassung oder Inhalt) und kann nicht freigegeben werden. Bitte überspringen Sie es.'
                : 'This project is empty (no title, summary, or body) and cannot be approved. Please skip it.',
              style: const TextStyle(color: Colors.white70),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(isGerman ? 'Abbrechen' : 'Cancel', style: const TextStyle(color: Colors.white70)),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _goToNextReview();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: attrs.brand600,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(isGerman ? 'Überspringen' : 'Skip'),
              ),
            ],
          ),
        );
      }
      return;
    }

    setState(() => _approving = true);

    // Ensure any unsaved content in CodeMirror source iframes is flushed to
    // the controllers synchronously before we snapshot them.
    _flushSourceEditors();

    // Snapshot controllers before navigation (they get disposed with the widget)
    final snapTitle   = _titleController.text;
    final snapSummary = _summaryController.text;
    final snapBody    = _bodyController.text;
    final snapAlts    = Map<String, dynamic>.from(_screenshotAlts);
    final machine     = widget.machineName;

    if (mounted) {
      final confettiEnabled = ref.read(themeProvider).confettiEnabled;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isGerman ? 'Übersetzung freigegeben! 🎉' : 'Translation approved! 🎉'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
      if (confettiEnabled) {
        // Konfetti kurz abspielen lassen, dann zum nächsten navigieren
        _confettiController.play();
        await Future.delayed(const Duration(milliseconds: 900));
      }
    }

    // Decrement the review badge immediately so the counter updates without
    // waiting for a server round-trip (optimistic update).
    ref.read(filterCountsProvider.notifier).decrementReview();

    _goToNextReview();

    // POST im Hintergrund; bei Fehler nachträglicher Snackbar
    _api.dio.post('/translations/$lang/$machine', data: {
      'title': snapTitle,
      'summary': snapSummary,
      'body': snapBody,
      'screenshot_alts': snapAlts,
      'is_review': true,
    }).catchError((e) {
      // Widget ist evtl. schon weg — ScaffoldMessenger bleibt trotzdem erreichbar
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isGerman
                ? '⚠️ Freigabe von "$machine" fehlgeschlagen — bitte erneut versuchen.'
                : '⚠️ Approval of "$machine" failed — please retry.'),
            backgroundColor: Colors.redAccent,
            duration: const Duration(seconds: 6),
          ),
        );
      }
    });

    if (mounted) setState(() => _approving = false);
  }

  Future<void> _handleToggleIgnore() async {
    final lang = ref.read(languageProvider).targetLanguage.code;
    final isGerman = lang == 'de';
    final attrs = AppTheme.getAttributes(ref.read(themeProvider).themeId);

    if (_isIgnored) {
      // Unignoring
      setState(() {
        _ignoring = true;
      });

      try {
        await _api.dio.delete('/projects/${widget.machineName}/ignore');
        
        setState(() {
          _isIgnored = false;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: attrs.brand600,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              content: Text(isGerman ? 'Ignorieren aufgehoben. Modul ist wieder aktiv!' : 'Unignored. Module is active again!'),
            ),
          );
        }
      } catch (e) {
        print('Unignore project error: $e');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              content: Text(isGerman ? 'Aktion fehlgeschlagen.' : 'Action failed.'),
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _ignoring = false;
          });
        }
      }
      return;
    }

    // Ignoring (original code)
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A1F26),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: attrs.borderMain)),
        title: Text(
          isGerman ? 'Modul ignorieren?' : 'Ignore Module?',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: Text(
          isGerman 
              ? 'Dieses Modul wird dauerhaft aus allen Listen ausgeblendet. Du bleibst nicht mehr daran hängen.'
              : 'This module will be permanently hidden from all lists. You will no longer get stuck on it.',
          style: TextStyle(color: attrs.textMuted),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(isGerman ? 'Abbrechen' : 'Cancel', style: TextStyle(color: attrs.textMuted)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: Text(isGerman ? 'Ignorieren' : 'Ignore', style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    setState(() {
      _ignoring = true;
    });

    try {
      await _api.dio.post('/projects/${widget.machineName}/ignore');
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: Text(isGerman ? 'Modul dauerhaft ausgeblendet.' : 'Module permanently ignored.'),
          ),
        );
        // Automatically skip to the next project
        _goToNextReview();
      }
    } catch (e) {
      print('Ignore project error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: Text(isGerman ? 'Ignorieren fehlgeschlagen.' : 'Failed to ignore module.'),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _ignoring = false;
        });
      }
    }
  }

  Future<void> _handleSaveSuggestion() async {
    setState(() {
      _loading = true;
    });

    final lang = ref.read(languageProvider).targetLanguage.code;
    final isGerman = lang == 'de';

    try {
      await _api.dio.post('/suggestions/$lang/${widget.machineName}', data: {
        'title': _titleController.text,
        'summary': _summaryController.text,
        'body': _bodyController.text,
        'suggestion_type': 'manual',
      });

      // Refresh suggestions
      final suggestionsRes = await _api.dio.get('/suggestions/$lang/${widget.machineName}');
      _suggestions = suggestionsRes.data as List<dynamic>;

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isGerman ? 'Vorschlag gespeichert! 💾' : 'Suggestion draft saved! 💾'),
            backgroundColor: Colors.green,
          ),
        );
      }
      setState(() {
        _viewMode = 'edit';
        _loading = false;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isGerman ? 'Speichern fehlgeschlagen.' : 'Failed to save suggestion draft.'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _deleteSuggestion(String id) async {
    final lang = ref.read(languageProvider).targetLanguage.code;
    final isGerman = lang == 'de';

    try {
      await _api.dio.delete('/suggestions/$id');
      setState(() {
        _suggestions.removeWhere((s) => s['id']?.toString() == id);
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isGerman ? 'Vorschlag gelöscht.' : 'Suggestion deleted.'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Löschen fehlgeschlagen.'), backgroundColor: Colors.redAccent),
        );
      }
    }
  }

  void _applySuggestion(Map<String, dynamic> suggestion) {
    final isGerman = ref.read(languageProvider).targetLanguage.code == 'de';
    setState(() {
      _titleController.text = suggestion['title'] ?? _titleController.text;
      _summaryController.text = suggestion['summary'] ?? '';
      _bodyController.text = suggestion['body'] ?? '';
      _diffBase = suggestion['id']?.toString() ?? 'current';
    });

    // CkEditorField.didUpdateWidget handles pushing the new content.
    if (_showSummaryHtml) _syncToSourceIFrame('summary', _summaryController.text);
    if (_showBodyHtml) _syncToSourceIFrame('body', _bodyController.text);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isGerman ? 'Vorschlag übernommen.' : 'Suggestion applied.'),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  void _speakText(String fieldKey, String text) {
    final lang = ref.read(languageProvider).targetLanguage.code;
    final synth = html.window.speechSynthesis;
    if (synth != null) {
      synth.cancel();
      // Remove HTML tags for clean text reading
      final plainText = text.replaceAll(RegExp(r'<[^>]*>'), '');
      if (plainText.trim().isEmpty) return;

      final utterance = html.SpeechSynthesisUtterance(plainText);
      utterance.lang = lang == 'de' ? 'de-DE' : 'en-US';

      // Attempt matching high quality / natural voices
      final voices = synth.getVoices();
      final preferredLangCode = utterance.lang!.toLowerCase();
      final preferredLangVoices = voices.where((v) {
        final vLang = (v.lang ?? '').toLowerCase().replaceAll('_', '-');
        return vLang.startsWith(preferredLangCode) || preferredLangCode.startsWith(vLang);
      }).toList();

      if (preferredLangVoices.isNotEmpty) {
        // Let's filter by gender preference
        final isMale = _voiceGender == 'male';
        
        // Define lists of male/female voice name keywords (case-insensitive)
        final maleKeywords = ['conrad', 'stefan', 'guy', 'andrew', 'brian', 'christopher', 'eric', 'ryan', 'male', 'david', 'mark', 'conny'];
        final femaleKeywords = ['katja', 'aria', 'elke', 'gisela', 'clarissa', 'female', 'zira', 'susan', 'jenny', 'amala', 'female'];
        final genderKeywords = isMale ? maleKeywords : femaleKeywords;

        // Try to find natural/online voice with correct gender first (Microsoft Edge high quality)
        html.SpeechSynthesisVoice? matchedVoice;
        
        // 1. Natural / Online voice matching the gender keywords
        for (var voice in preferredLangVoices) {
          final name = (voice.name ?? '').toLowerCase();
          final isNatural = name.contains('natural') || name.contains('online');
          if (isNatural && genderKeywords.any((k) => name.contains(k))) {
            matchedVoice = voice;
            break;
          }
        }
        
        // 2. Any voice matching the gender keywords
        if (matchedVoice == null) {
          for (var voice in preferredLangVoices) {
            final name = (voice.name ?? '').toLowerCase();
            if (genderKeywords.any((k) => name.contains(k))) {
              matchedVoice = voice;
              break;
            }
          }
        }
        
        // 3. Fallback to any Natural / Online voice of the preferred language
        if (matchedVoice == null) {
          for (var voice in preferredLangVoices) {
            final name = (voice.name ?? '').toLowerCase();
            if (name.contains('natural') || name.contains('online')) {
              matchedVoice = voice;
              break;
            }
          }
        }

        // 4. Default fallback
        matchedVoice ??= preferredLangVoices.first;
        
        utterance.voice = matchedVoice;
      }

      utterance.onEnd.listen((_) {
        if (mounted) {
          setState(() {
            _currentlyPlayingField = null;
          });
        }
      });
      utterance.onError.listen((_) {
        if (mounted) {
          setState(() {
            _currentlyPlayingField = null;
          });
        }
      });

      setState(() {
        _currentlyPlayingField = fieldKey;
      });
      synth.speak(utterance);
    }
  }

  void _stopSpeech() {
    final synth = html.window.speechSynthesis;
    if (synth != null) {
      synth.cancel();
      setState(() {
        _currentlyPlayingField = null;
      });
    }
  }

  /// Synchronously reads the latest content from any open source-editor
  /// iframes (CodeMirror) directly via JS eval, bypassing the postMessage
  /// queue. This avoids a race condition where the user edits in CodeMirror
  /// and immediately clicks Approve before the postMessage handler has run.
  void _flushSourceEditors() {
    const jsExpr = 'editor ? editor.getValue() '
        ': (document.getElementById("fallback-textarea") '
        '   ? document.getElementById("fallback-textarea").value : "")';

    if (_showSummaryHtml && _activeSummarySourceIFrame != null) {
      try {
        final win = js.JsObject.fromBrowserObject(
            _activeSummarySourceIFrame!.contentWindow!);
        final result = win.callMethod('eval', [jsExpr]);
        if (result is String && result.isNotEmpty) {
          _summaryController.text = result;
        }
      } catch (_) {}
    }

    if (_showBodyHtml && _activeBodySourceIFrame != null) {
      try {
        final win = js.JsObject.fromBrowserObject(
            _activeBodySourceIFrame!.contentWindow!);
        final result = win.callMethod('eval', [jsExpr]);
        if (result is String && result.isNotEmpty) {
          _bodyController.text = result;
        }
      } catch (_) {}
    }
  }

  /// Returns the native display name for a language code (used for the chip
  /// in the header so users see "DEUTSCH" instead of "GERMAN").
  static String _nativeLangName(String code) {
    const map = {
      'de': 'DEUTSCH',
      'fr': 'FRANÇAIS',
      'es': 'ESPAÑOL',
      'pt-pt': 'PORTUGUÊS',
      'pt-br': 'PORTUGUÊS (BR)',
      'zh-hans': '中文 (简)',
      'zh-hant': '中文 (繁)',
      'ja': '日本語',
      'ko': '한국어',
      'ru': 'РУССКИЙ',
      'uk': 'УКРАЇНСЬКА',
      'nl': 'NEDERLANDS',
      'it': 'ITALIANO',
      'pl': 'POLSKI',
      'tr': 'TÜRKÇE',
      'ar': 'العربية',
    };
    return map[code.toLowerCase()] ?? code.toUpperCase();
  }

  Map<String, String> _getBaseData() {
    if (_diffBase == 'current') {
      return {
        'title': _currentTranslation?['title'] ?? _project?['attributes']?['title'] ?? '',
        'summary': _currentTranslation?['body']?['summary'] ?? _currentTranslation?['summary'] ?? '',
        'body': _currentTranslation?['body']?['value'] ?? _currentTranslation?['body'] ?? '',
      };
    }
    final s = _suggestions.firstWhere((s) => s['id']?.toString() == _diffBase, orElse: () => null);
    if (s != null) {
      return {
        'title': s['title'] ?? '',
        'summary': s['summary'] ?? '',
        'body': s['body'] ?? '',
      };
    }
    return {'title': '', 'summary': '', 'body': ''};
  }

  @override
  Widget build(BuildContext context) {
    final themeState = ref.watch(themeProvider);
    final langState = ref.watch(languageProvider);
    final attrs = AppTheme.getAttributes(themeState.themeId);
    final isGerman = langState.targetLanguage.code == 'de';
    // Use the accurate total from filterCountsProvider (same source as the
    // Dashboard "Review" tab) instead of the capped _queue list length.
    final reviewCount = ref.watch(filterCountsProvider).review;

    // Re-fetch data + glossary whenever the user switches the target language
    ref.listen(languageProvider, (previous, next) {
      if (previous?.targetLanguage.code != next.targetLanguage.code) {
        _fetchData();
        _loadGlossary();
      }
    });

    if (_loading) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: attrs.brand600),
              const SizedBox(height: 16),
              Text(
                isGerman ? 'Review-Daten werden vorbereitet...' : 'Preparing review data...',
                style: TextStyle(color: attrs.textMuted, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
    }

    final baseData = _getBaseData();
    final baseTitle = baseData['title'] ?? '';
    final baseSummary = baseData['summary'] ?? '';
    final baseBody = baseData['body'] ?? '';

    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1100;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          CallbackShortcuts(
        bindings: <ShortcutActivator, VoidCallback>{
          const SingleActivator(LogicalKeyboardKey.keyS, control: true, alt: true): _handleSaveSuggestion,
          const SingleActivator(LogicalKeyboardKey.keyS, meta: true, alt: true): _handleSaveSuggestion,
          const SingleActivator(LogicalKeyboardKey.enter, control: true): _handleApprove,
          const SingleActivator(LogicalKeyboardKey.enter, meta: true): _handleApprove,
          const SingleActivator(LogicalKeyboardKey.arrowRight, control: true): () => _goToNextReview(),
          const SingleActivator(LogicalKeyboardKey.arrowRight, meta: true): () => _goToNextReview(),
        },
        child: Focus(
          autofocus: true,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(isMobile ? 12.0 : 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header bar
            GlassContainer(
              border: Border.all(color: attrs.borderMain),
              padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 12 : 24,
                  vertical: isMobile ? 10 : 16),
              child: isMobile
                  ? _buildReviewHeaderMobile(attrs, isGerman, reviewCount)
                  : isTablet
                      ? _buildReviewHeaderTablet(attrs, isGerman, reviewCount)
                      : _buildReviewHeaderDesktop(attrs, isGerman, reviewCount),
            ),
            const SizedBox(height: 32),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReviewSidebar(
                  isOpen: _sidebarOpen,
                  attrs: attrs,
                  isGerman: isGerman,
                  machineName: widget.machineName,
                  project: _project,
                  currentTranslation: _currentTranslation,
                  suggestions: _suggestions,
                  activeSuggestionId: _activeSuggestionId,
                  onSuggestionTap: (id) {
                    setState(() {
                      _activeSuggestionId = id;
                      _diffBase = id;
                    });
                  },
                  onApplySuggestion: _applySuggestion,
                  onDeleteSuggestion: _deleteSuggestion,
                ),
                // Main Comparison Canvas
                Expanded(
                  flex: 9,
                  child: Column(
                    children: [
                      // View Modes Tab bar
                      GlassContainer(
                        border: Border.all(color: attrs.borderMain),
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                _tabButton('edit', LucideIcons.edit3, isGerman ? 'Direkt-Editor' : 'Direct Edit'),
                                _tabButton('preview', LucideIcons.eye, isGerman ? 'Vorschau' : 'Live Preview'),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  isGerman ? 'Vergleichen mit:' : 'Compare with:',
                                  style: TextStyle(color: attrs.textMuted, fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 8),
                                DropdownButton<String>(
                                  value: _diffBase,
                                  dropdownColor: attrs.bgSidebar,
                                  style: TextStyle(color: attrs.textMain, fontSize: 12, fontWeight: FontWeight.bold),
                                  underline: const SizedBox(),
                                  items: [
                                    DropdownMenuItem(value: 'current', child: Text(isGerman ? 'Produktions-Version' : 'Production Version')),
                                    ..._suggestions.map((s) {
                                      final id = s['id']?.toString() ?? '';
                                      return DropdownMenuItem(value: id, child: Text('Suggestion #$id'));
                                    }),
                                  ],
                                  onChanged: (val) {
                                    if (val != null) setState(() => _diffBase = val);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Canvas Content
                      _buildCanvasContent(attrs, isGerman, baseTitle, baseSummary, baseBody, isMobile),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
        ),
      ),
          // Confetti overlay
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              numberOfParticles: 40,
              gravity: 0.15,
              emissionFrequency: 0.05,
              colors: const [
                Color(0xFF6366F1),
                Color(0xFF8B5CF6),
                Color(0xFF10B981),
                Color(0xFFF59E0B),
                Color(0xFFEF4444),
                Colors.white,
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Responsive Header Helpers ────────────────────────────────────────────

  void _copyPromptToClipboard(bool isGerman) {
    final lang = ref.read(languageProvider).targetLanguage.code;
    final srcSummary = _project?['attributes']?['body']?['summary'] ?? '';
    final srcBody    = _project?['attributes']?['body']?['value'] ?? '';
    final prompt = buildTranslationPrompt(
      langcode: lang,
      sourceSummary: srcSummary,
      sourceBody: srcBody,
    );
    Clipboard.setData(ClipboardData(text: prompt));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(isGerman
          ? 'Prompt in die Zwischenablage kopiert 📋'
          : 'Prompt copied to clipboard 📋'),
      backgroundColor: Colors.teal,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
    ));
  }

  /// Mobile-Header: zwei Zeilen — Titelzeile + Aktionszeile
  Widget _buildReviewHeaderMobile(
      ThemeAttributes attrs, bool isGerman, int reviewCount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Zeile 1: Zurück + Sidebar + Titel + Counter
        Row(children: [
          IconButton(
            icon: Icon(LucideIcons.arrowLeft, color: attrs.textMuted, size: 20),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () => context.go('/'),
          ),
          const SizedBox(width: 4),
          IconButton(
            onPressed: () => setState(() => _sidebarOpen = !_sidebarOpen),
            icon: Icon(
              _sidebarOpen ? LucideIcons.panelLeftClose : LucideIcons.panelLeft,
              size: 18,
              color: _sidebarOpen ? attrs.brand600 : Colors.white54,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(children: [
                  Icon(LucideIcons.shieldCheck,
                      color: attrs.brand600, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    isGerman ? 'Redaktionelle Überarbeitung' : 'Editorial Review',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      color: attrs.textMain,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                    decoration: BoxDecoration(
                      color: attrs.brand600.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _nativeLangName(
                          ref.read(languageProvider).targetLanguage.code),
                      style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w900,
                          color: attrs.brand600),
                    ),
                  ),
                ]),
                Text(
                  widget.machineName,
                  style:
                      TextStyle(color: attrs.textMuted, fontSize: 11),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (reviewCount > 0)
            Tooltip(
              message: isGerman
                  ? 'Review-Warteschlange öffnen'
                  : 'Open review queue',
              child: InkWell(
                onTap: () => context.go('/review-list'),
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(LucideIcons.layers,
                        size: 12, color: attrs.brand600),
                    const SizedBox(width: 4),
                    Text(
                      '$reviewCount',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: attrs.brand600,
                      ),
                    ),
                  ]),
                ),
              ),
            ),
        ]),
        const SizedBox(height: 8),
        // Zeile 2: Aktions-Buttons als gleichmäßige Row
        Row(children: [
          // Prompt (icon only)
          Tooltip(
            message: isGerman
                ? 'Prompt kopieren'
                : 'Copy prompt',
            child: OutlinedButton(
              onPressed: () => _copyPromptToClipboard(isGerman),
              style: OutlinedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                side: BorderSide(color: attrs.borderMain),
                minimumSize: Size.zero,
              ),
              child: Icon(LucideIcons.clipboard,
                  size: 16, color: attrs.textMuted),
            ),
          ),
          const SizedBox(width: 6),
          // Ignore (icon only)
          Tooltip(
            message: _isIgnored
                ? (isGerman ? 'Ignorieren aufheben' : 'Unignore')
                : (isGerman ? 'Ignorieren' : 'Ignore'),
            child: OutlinedButton(
              onPressed: _ignoring ? null : _handleToggleIgnore,
              style: OutlinedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                side: BorderSide(
                    color: _isIgnored ? attrs.brand600 : Colors.redAccent),
                minimumSize: Size.zero,
              ),
              child: _ignoring
                  ? SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: _isIgnored ? attrs.brand600 : Colors.redAccent,
                      ),
                    )
                  : Icon(
                      _isIgnored ? LucideIcons.eye : LucideIcons.eyeOff,
                      size: 16,
                      color: _isIgnored ? attrs.brand600 : Colors.redAccent),
            ),
          ),
          const SizedBox(width: 6),
          // Skip
          Tooltip(
            message: isGerman ? 'Überspringen' : 'Skip',
            child: OutlinedButton(
              onPressed: () => _goToNextReview(),
              style: OutlinedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                side: BorderSide(color: attrs.borderMain),
                minimumSize: Size.zero,
              ),
              child: Icon(LucideIcons.arrowRight,
                  size: 16, color: attrs.textMain),
            ),
          ),
          const SizedBox(width: 6),
          // Approve (full width remaining)
          Expanded(
            child: ElevatedButton.icon(
              onPressed: _approving ? null : _handleApprove,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
                backgroundColor: attrs.brand600,
              ),
              icon: _approving
                  ? const SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white))
                  : const Icon(LucideIcons.checkCircle, size: 14),
              label: Text(
                isGerman ? 'FREIGEBEN' : 'APPROVE',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
          ),
        ]),
      ],
    );
  }

  /// Desktop-Header: Original-Layout (eine Zeile)
  Widget _buildReviewHeaderDesktop(
      ThemeAttributes attrs, bool isGerman, int reviewCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              icon: Icon(LucideIcons.arrowLeft, color: attrs.textMuted),
              onPressed: () => context.go('/'),
            ),
            const SizedBox(width: 4),
            Tooltip(
              message: _sidebarOpen
                  ? (isGerman ? 'Details ausblenden' : 'Hide details')
                  : (isGerman
                      ? 'Details & Englische Quelle'
                      : 'Details & English Source'),
              child: IconButton(
                onPressed: () =>
                    setState(() => _sidebarOpen = !_sidebarOpen),
                icon: Icon(
                  _sidebarOpen
                      ? LucideIcons.panelLeftClose
                      : LucideIcons.panelLeft,
                  size: 18,
                  color: _sidebarOpen ? attrs.brand600 : Colors.white54,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: _sidebarOpen
                      ? attrs.brand600.withOpacity(0.2)
                      : Colors.white.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(LucideIcons.shieldCheck,
                        color: attrs.brand600, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      isGerman ? 'Redaktionelle Überarbeitung' : 'Editorial Review',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: attrs.textMain,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(
                        color: attrs.brand600.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: attrs.brand600.withValues(alpha: 0.2)),
                      ),
                      child: Text(
                        _nativeLangName(
                            ref.read(languageProvider).targetLanguage.code),
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          color: attrs.brand600,
                        ),
                      ),
                    ),
                    if (reviewCount > 0) ...[
                      const SizedBox(width: 16),
                      Tooltip(
                        message: isGerman
                            ? 'Review-Warteschlange öffnen'
                            : 'Open review queue',
                        child: InkWell(
                          onTap: () => context.go('/review-list'),
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(LucideIcons.layers,
                                    size: 14, color: attrs.brand600),
                                const SizedBox(width: 6),
                                Text(
                                  isGerman
                                      ? '$reviewCount ausstehend'
                                      : '$reviewCount pending',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: attrs.brand600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${isGerman ? "Überprüfung von" : "Reviewing"} ${widget.machineName}',
                  style:
                      TextStyle(color: attrs.textMuted, fontSize: 13),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Tooltip(
              message: isGerman
                  ? 'Quelltext + Übersetzungsprompt in die Zwischenablage kopieren'
                  : 'Copy source text + translation prompt to clipboard',
              child: OutlinedButton.icon(
                onPressed: () => _copyPromptToClipboard(isGerman),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 16),
                  side: BorderSide(color: attrs.borderMain),
                  foregroundColor: attrs.textMuted,
                ),
                icon: const Icon(LucideIcons.clipboard, size: 16),
                label: const Text('PROMPT',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(width: 8),
            OutlinedButton.icon(
              onPressed: _ignoring ? null : _handleToggleIgnore,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 16),
                side: BorderSide(
                    color:
                        _isIgnored ? attrs.brand600 : Colors.redAccent),
                foregroundColor:
                    _isIgnored ? attrs.brand600 : Colors.redAccent,
              ),
              icon: _ignoring
                  ? SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color:
                            _isIgnored ? attrs.brand600 : Colors.redAccent,
                      ),
                    )
                  : Icon(
                      _isIgnored ? LucideIcons.eye : LucideIcons.eyeOff,
                      size: 16),
              label: Text(
                _isIgnored
                    ? (isGerman ? 'IGNORIEREN AUFHEBEN' : 'UNIGNORE')
                    : (isGerman ? 'IGNORIEREN' : 'IGNORE'),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 8),
            OutlinedButton.icon(
              onPressed: () => _goToNextReview(),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 16),
                side: BorderSide(color: attrs.borderMain),
              ),
              icon: const Icon(LucideIcons.arrowRight, size: 16),
              label: Text(
                isGerman ? 'ÜBERSPRINGEN (Strg+→)' : 'SKIP (Ctrl+→)',
                style: TextStyle(
                    color: attrs.textMain, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 12),
            ElevatedButton.icon(
              onPressed: _approving ? null : _handleApprove,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 16),
                backgroundColor: attrs.brand600,
              ),
              icon: _approving
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white))
                  : const Icon(LucideIcons.checkCircle, size: 16),
              label: Text(
                isGerman
                    ? 'FREIGEBEN FÜR PRODUKTION (Strg+Enter)'
                    : 'APPROVE FOR PRODUCTION (Ctrl+Enter)',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Tablet-Header (600–1099 dp): Desktop-Layout ohne Keyboard-Shortcut-Hinweise
  Widget _buildReviewHeaderTablet(
      ThemeAttributes attrs, bool isGerman, int reviewCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left side — identical to desktop
        Row(
          children: [
            IconButton(
              icon: Icon(LucideIcons.arrowLeft, color: attrs.textMuted),
              onPressed: () => context.go('/'),
            ),
            const SizedBox(width: 4),
            Tooltip(
              message: _sidebarOpen
                  ? (isGerman ? 'Details ausblenden' : 'Hide details')
                  : (isGerman ? 'Details & Englische Quelle' : 'Details & English Source'),
              child: IconButton(
                onPressed: () => setState(() => _sidebarOpen = !_sidebarOpen),
                icon: Icon(
                  _sidebarOpen ? LucideIcons.panelLeftClose : LucideIcons.panelLeft,
                  size: 18,
                  color: _sidebarOpen ? attrs.brand600 : Colors.white54,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: _sidebarOpen
                      ? attrs.brand600.withOpacity(0.2)
                      : Colors.white.withOpacity(0.1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(LucideIcons.shieldCheck, color: attrs.brand600, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      isGerman ? 'Redakt. Überarbeitung' : 'Editorial Review',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: attrs.textMain,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: attrs.brand600.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        _nativeLangName(ref.read(languageProvider).targetLanguage.code),
                        style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: attrs.brand600),
                      ),
                    ),
                    if (reviewCount > 0) ...[
                      const SizedBox(width: 12),
                      Tooltip(
                        message: isGerman ? 'Review-Warteschlange öffnen' : 'Open review queue',
                        child: InkWell(
                          onTap: () => context.go('/review-list'),
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                            child: Row(mainAxisSize: MainAxisSize.min, children: [
                              Icon(LucideIcons.layers, size: 13, color: attrs.brand600),
                              const SizedBox(width: 4),
                              Text('$reviewCount',
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: attrs.brand600)),
                            ]),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  widget.machineName,
                  style: TextStyle(color: attrs.textMuted, fontSize: 11),
                ),
              ],
            ),
          ],
        ),
        // Right side — compact buttons without keyboard shortcut labels
        Row(
          children: [
            Tooltip(
              message: isGerman
                  ? 'Quelltext + Übersetzungsprompt kopieren'
                  : 'Copy source + translation prompt',
              child: OutlinedButton.icon(
                onPressed: () => _copyPromptToClipboard(isGerman),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  side: BorderSide(color: attrs.borderMain),
                  foregroundColor: attrs.textMuted,
                ),
                icon: const Icon(LucideIcons.clipboard, size: 14),
                label: const Text('PROMPT', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              ),
            ),
            const SizedBox(width: 8),
            OutlinedButton.icon(
              onPressed: _ignoring ? null : _handleToggleIgnore,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                side: BorderSide(color: _isIgnored ? attrs.brand600 : Colors.redAccent),
                foregroundColor: _isIgnored ? attrs.brand600 : Colors.redAccent,
              ),
              icon: _ignoring
                  ? SizedBox(
                      width: 14, height: 14,
                      child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: _isIgnored ? attrs.brand600 : Colors.redAccent))
                  : Icon(_isIgnored ? LucideIcons.eye : LucideIcons.eyeOff, size: 14),
              label: Text(
                _isIgnored
                    ? (isGerman ? 'EINREIHEN' : 'UNIGNORE')
                    : (isGerman ? 'IGNORIEREN' : 'IGNORE'),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
            const SizedBox(width: 8),
            OutlinedButton.icon(
              onPressed: () => _goToNextReview(),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                side: BorderSide(color: attrs.borderMain),
              ),
              icon: const Icon(LucideIcons.arrowRight, size: 14),
              label: Text(
                isGerman ? 'ÜBERSPRINGEN' : 'SKIP',
                style: TextStyle(color: attrs.textMain, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton.icon(
              onPressed: _approving ? null : _handleApprove,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                backgroundColor: attrs.brand600,
              ),
              icon: _approving
                  ? const SizedBox(
                      width: 14, height: 14,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Icon(LucideIcons.checkCircle, size: 14),
              label: Text(
                isGerman ? 'FREIGEBEN' : 'APPROVE',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _tabButton(String id, IconData icon, String label) {
    final active = _viewMode == id;
    final attrs = AppTheme.getAttributes(ref.read(themeProvider).themeId);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: TextButton.icon(
        onPressed: () => setState(() => _viewMode = id),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          backgroundColor: active ? attrs.brand600 : Colors.transparent,
          foregroundColor: active ? Colors.white : attrs.textMuted,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        icon: Icon(icon, size: 14),
        label: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
      ),
    );
  }

  Widget _buildCanvasContent(ThemeAttributes attrs, bool isGerman, String baseTitle, String baseSummary, String baseBody, [bool isMobile = false]) {
    // Viewport-proportional editor heights — scales across desktop, tablet and web.
    final vh = MediaQuery.of(context).size.height;
    final summaryEditorHeight = (vh * 0.20).clamp(160.0, 420.0);
    final bodyEditorHeight    = (vh * 0.45).clamp(320.0, 960.0);

    final lang = ref.read(languageProvider).targetLanguage.code.toLowerCase();
    String unlockLabel;
    String lockLabel;

    switch (lang) {
      case 'de':
        unlockLabel = 'Titel korrigieren';
        lockLabel = 'Titel sperren';
        break;
      case 'fr':
        unlockLabel = 'Corriger le titre';
        lockLabel = 'Verrouiller le titre';
        break;
      case 'es':
        unlockLabel = 'Corregir título';
        lockLabel = 'Bloquear título';
        break;
      case 'pt-pt':
      case 'pt-br':
        unlockLabel = 'Corrigir título';
        lockLabel = 'Bloquear título';
        break;
      case 'zh-hans':
        unlockLabel = '纠正标题';
        lockLabel = '锁定标题';
        break;
      case 'zh-hant':
        unlockLabel = '糾正標題';
        lockLabel = '鎖定標題';
        break;
      case 'ja':
        unlockLabel = 'タイトルを修正';
        lockLabel = 'タイトルをロック';
        break;
      case 'uk':
        unlockLabel = 'Виправити заголовок';
        lockLabel = 'Заблокувати заголовок';
        break;
      case 'ru':
        unlockLabel = 'Исправить заголовок';
        lockLabel = 'Заблокировать заголовок';
        break;
      case 'nl':
        unlockLabel = 'Titel corrigeren';
        lockLabel = 'Titel vergrendelen';
        break;
      default:
        unlockLabel = 'Correct title';
        lockLabel = 'Lock title';
    }

    if (_viewMode == 'edit') {
      return GlassContainer(
        border: Border.all(color: attrs.borderMain),
        padding: EdgeInsets.all(isMobile ? 14.0 : 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isGerman ? 'Manuelle Korrektur' : 'Direct Refinement',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: attrs.textMain),
            ),
            const Divider(height: 32),

            // Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isGerman ? 'Titel' : 'Title',
                  style: TextStyle(color: attrs.brand600, fontWeight: FontWeight.bold, fontSize: 12),
                ),
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _titleEditable = !_titleEditable;
                    });
                  },
                  icon: Icon(
                    _titleEditable ? LucideIcons.unlock : LucideIcons.lock,
                    size: 14,
                    color: _titleEditable ? attrs.brand600 : attrs.textMuted,
                  ),
                  label: Text(
                    _titleEditable ? lockLabel : unlockLabel,
                    style: TextStyle(
                      fontSize: 11,
                      color: _titleEditable ? attrs.brand600 : attrs.textMuted,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _titleController,
              readOnly: !_titleEditable,
              decoration: InputDecoration(
                filled: true,
                fillColor: _titleEditable ? attrs.bgInput : attrs.bgInput.withOpacity(0.5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: _titleEditable ? attrs.brand600 : attrs.borderMain,
                  ),
                ),
                prefixIcon: Icon(
                  _titleEditable ? LucideIcons.unlock : LucideIcons.lock,
                  size: 16,
                  color: _titleEditable ? attrs.brand600 : attrs.textMuted,
                ),
              ),
              style: TextStyle(
                color: _titleEditable ? attrs.textMain : attrs.textMuted,
              ),
            ),
            const SizedBox(height: 24),

            // Summary
            _buildFieldModeToggle(
              isGerman ? 'Zusammenfassung (Summary)' : 'Summary',
              _showSummaryHtml,
              (val) {
                setState(() => _showSummaryHtml = val);
                if (val) {
                  Future.delayed(const Duration(milliseconds: 50), () {
                    _syncToSourceIFrame('summary', _summaryController.text);
                  });
                }
              },
              action: _listenButton('summary'),
              onTidy: () {
                final cleaned = tidyDeeplHtml(_summaryController.text);
                setState(() => _summaryController.text = cleaned);
                if (_showSummaryHtml) {
                  Future.delayed(const Duration(milliseconds: 50),
                      () => _syncToSourceIFrame('summary', cleaned));
                }
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('HTML bereinigt'),
                  duration: Duration(seconds: 2),
                ));
              },
              onAutop: () {
                final converted = _autop(_summaryController.text);
                if (converted == _summaryController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Text enthält bereits <p>-Tags — keine Änderung'),
                    duration: Duration(seconds: 2),
                  ));
                  return;
                }
                setState(() => _summaryController.text = converted);
                if (_showSummaryHtml) {
                  Future.delayed(const Duration(milliseconds: 50),
                      () => _syncToSourceIFrame('summary', converted));
                }
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Absätze formatiert ¶'),
                  duration: Duration(seconds: 2),
                ));
              },
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF14171C),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: attrs.borderMain),
                ),
                child: _showSummaryHtml
                    ? SizedBox(
                        height: summaryEditorHeight,
                        child: const HtmlElementView(
                            viewType: 'wysiwyg-review-summary-source'),
                      )
                    : CkEditorField(
                        initialHtml: _summaryController.text,
                        onChanged: (html) => _summaryController.text = html,
                        height: summaryEditorHeight,
                        isSimple: true,
                      ),
              ),
            ),
            const SizedBox(height: 24),

            // Body
            _buildFieldModeToggle(
              isGerman ? 'Hauptinhalt (Body)' : 'Body Content',
              _showBodyHtml,
              (val) {
                setState(() => _showBodyHtml = val);
                if (val) {
                  Future.delayed(const Duration(milliseconds: 50), () {
                    _syncToSourceIFrame('body', _bodyController.text);
                  });
                }
              },
              action: _listenButton('body'),
              onTidy: () {
                final cleaned = tidyDeeplHtml(_bodyController.text);
                setState(() => _bodyController.text = cleaned);
                if (_showBodyHtml) {
                  Future.delayed(const Duration(milliseconds: 50),
                      () => _syncToSourceIFrame('body', cleaned));
                }
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('HTML bereinigt'),
                  duration: Duration(seconds: 2),
                ));
              },
              onAutop: () {
                final converted = _autop(_bodyController.text);
                if (converted == _bodyController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Text enthält bereits <p>-Tags — keine Änderung'),
                    duration: Duration(seconds: 2),
                  ));
                  return;
                }
                setState(() => _bodyController.text = converted);
                if (_showBodyHtml) {
                  Future.delayed(const Duration(milliseconds: 50),
                      () => _syncToSourceIFrame('body', converted));
                }
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Absätze formatiert ¶'),
                  duration: Duration(seconds: 2),
                ));
              },
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF14171C),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: attrs.borderMain),
                ),
                child: _showBodyHtml
                    ? SizedBox(
                        height: bodyEditorHeight,
                        child: const HtmlElementView(
                            viewType: 'wysiwyg-review-body-source'),
                      )
                    : CkEditorField(
                        initialHtml: _bodyController.text,
                        onChanged: (html) => _bodyController.text = html,
                        height: bodyEditorHeight,
                        isSimple: false,
                      ),
              ),
            ),
            const SizedBox(height: 32),

            // Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton.icon(
                  onPressed: _handleSaveSuggestion,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    side: BorderSide(color: attrs.borderMain),
                  ),
                  icon: const Icon(LucideIcons.save, size: 16),
                  label: Text(
                    isGerman ? 'SPEICHERN (Strg+Alt+S)' : 'SAVE (Ctrl+Alt+S)',
                    style: TextStyle(color: attrs.textMain, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else if (_viewMode == 'preview') {
      return GlassContainer(
        border: Border.all(color: attrs.borderMain),
        padding: EdgeInsets.all(isMobile ? 14.0 : 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isGerman ? 'Live Vorschau (Rendering)' : 'Live Preview (Rendering)',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: attrs.textMain),
                ),
                _listenButton(
                  '${_titleController.text}. ${_summaryController.text}. ${_bodyController.text}'
                ),
              ],
            ),
            const Divider(height: 32),
            
            Text(
              _titleController.text,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: attrs.textMain),
            ),
            const SizedBox(height: 20),
            
            if (_summaryController.text.isNotEmpty) ...[
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: attrs.borderMain),
                ),
                child: HtmlWidget(
                  _summaryController.text,
                  textStyle: TextStyle(color: attrs.textMuted, fontSize: 16, fontStyle: FontStyle.italic),
                ),
              ),
              const SizedBox(height: 24),
            ],

            HtmlWidget(
              _bodyController.text,
              textStyle: TextStyle(color: attrs.textMain, fontSize: 15, height: 1.6),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _listenButton(String fieldKey) {
    final attrs = AppTheme.getAttributes(ref.read(themeProvider).themeId);
    final isGerman = ref.read(languageProvider).targetLanguage.code == 'de';
    final isPlaying = _currentlyPlayingField == fieldKey;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _voiceGender,
            dropdownColor: attrs.bgSidebar,
            style: TextStyle(color: attrs.textMain, fontSize: 11, fontWeight: FontWeight.bold),
            icon: Icon(LucideIcons.chevronDown, size: 12, color: attrs.textMuted),
            items: [
              DropdownMenuItem(value: 'female', child: Text(isGerman ? 'Weiblich' : 'Female')),
              DropdownMenuItem(value: 'male', child: Text(isGerman ? 'Männlich' : 'Male')),
            ],
            onChanged: (val) {
              if (val != null) setState(() => _voiceGender = val);
            },
          ),
        ),
        const SizedBox(width: 8),
        TextButton.icon(
          onPressed: () {
            if (isPlaying) {
              _stopSpeech();
            } else {
              final textToSpeak = fieldKey == 'summary' ? _summaryController.text : _bodyController.text;
              _speakText(fieldKey, textToSpeak);
            }
          },
          icon: Icon(isPlaying ? LucideIcons.stopCircle : LucideIcons.volume2, size: 14),
          label: Text(
            isPlaying 
                ? (isGerman ? 'Stoppen' : 'Stop')
                : (isGerman ? 'Anhören' : 'Listen'),
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 10, letterSpacing: 1),
          ),
          style: TextButton.styleFrom(
            foregroundColor: isPlaying ? Colors.redAccent : attrs.brand600,
            backgroundColor: isPlaying ? Colors.redAccent.withOpacity(0.15) : attrs.brand600.withOpacity(0.2),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }

  /// Wandelt unstrukturierten Text in HTML-Absätze um.
  ///
  /// Strategie:
  ///   1. Bereits mehrere <p>-Tags → unverändert zurückgeben.
  ///   2. Genau ein <p>-Tag (CKEditor-Default) oder kein Tag →
  ///      inneren Text extrahieren und strukturieren.
  ///   3. Text mit doppelten Zeilenumbrüchen → an \n\n aufteilen.
  ///   4. Fließtext ohne Zeilenumbrüche → an Satzenden aufteilen
  ///      ([.!?] gefolgt von Leerzeichen + Großbuchstabe).
  ///      Sätze werden zu Absätzen mit ~260 Zeichen Zielgröße gruppiert.
  static String _autop(String text) {
    if (text.trim().isEmpty) return text;

    // Zählt vorhandene <p>-Tags
    final pCount =
        RegExp(r'<p[\s>]', caseSensitive: false).allMatches(text).length;

    // Bereits mehrere Absätze — nichts zu tun
    if (pCount > 1) return text;

    // CKEditor liefert immer mindestens ein <p>…</p> — das äußere
    // Wrapper-Tag entfernen und den Rohtext für die weitere Verarbeitung nutzen.
    String plain = text;
    if (pCount == 1) {
      plain = plain
          .replaceAll(RegExp(r'<p[^>]*>', caseSensitive: false), '')
          .replaceAll(RegExp(r'</p>', caseSensitive: false), ' ')
          .replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n')
          .trim();
    }

    // Zeilenenden normalisieren
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
    // Einzelne Zeilenumbrüche als Leerzeichen behandeln.
    final normalized =
        plain.replaceAll('\n', ' ').replaceAll(RegExp(r'  +'), ' ').trim();

    // Satzgrenzen: [.!?] gefolgt von Leerzeichen + Großbuchstabe (inkl. Umlaute).
    // Lookbehind behält die Satzzeichen beim vorigen Satz.
    final sentenceSplitter =
        RegExp(r'(?<=[.!?])\s+(?=[A-ZÄÖÜÀ-ɏ])');
    final sentences = normalized.split(sentenceSplitter);

    if (sentences.length <= 1) {
      return '<p>$normalized</p>';
    }

    // Sätze zu Absätzen gruppieren — Zielgröße ~260 Zeichen pro Absatz.
    const softLimit = 260;
    final paragraphs = <String>[];
    var buf = StringBuffer();

    for (final s in sentences) {
      final sentence = s.trim();
      if (sentence.isEmpty) continue;
      if (buf.isEmpty) {
        buf.write(sentence);
      } else if (buf.length >= softLimit) {
        paragraphs.add(buf.toString());
        buf = StringBuffer(sentence);
      } else {
        buf.write(' $sentence');
      }
    }
    if (buf.isNotEmpty) paragraphs.add(buf.toString());

    return paragraphs.map((p) => '<p>$p</p>').join('\n');
  }

  Widget _buildFieldModeToggle(String label, bool showHtml, ValueChanged<bool> onChanged, {Widget? action, VoidCallback? onTidy, VoidCallback? onAutop}) {
    final attrs = AppTheme.getAttributes(ref.read(themeProvider).themeId);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.bold),
              ),
              if (onTidy != null) ...[
                const SizedBox(width: 8),
                Tooltip(
                  message: 'HTML bereinigen (DeepL-Artefakte entfernen)',
                  child: InkWell(
                    onTap: onTidy,
                    borderRadius: BorderRadius.circular(4),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      child: Icon(LucideIcons.wand, size: 13, color: Colors.white38),
                    ),
                  ),
                ),
              ],
              if (onAutop != null) ...[
                const SizedBox(width: 4),
                Tooltip(
                  message: 'Absätze automatisch formatieren (Zeilenumbrüche → <p>)',
                  child: InkWell(
                    onTap: onAutop,
                    borderRadius: BorderRadius.circular(4),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      child: Icon(LucideIcons.alignJustify, size: 13, color: Colors.white38),
                    ),
                  ),
                ),
              ],
              if (action != null) ...[
                const SizedBox(width: 16),
                action,
              ],
            ],
          ),
          Container(
            height: 28,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Visual Mode Tab
                InkWell(
                  onTap: () => onChanged(false),
                  borderRadius: const BorderRadius.horizontal(left: Radius.circular(5)),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: !showHtml ? attrs.brand600.withOpacity(0.2) : Colors.transparent,
                      borderRadius: const BorderRadius.horizontal(left: Radius.circular(5)),
                    ),
                    child: Text(
                      'VISUELL',
                      style: TextStyle(
                        color: !showHtml ? attrs.brand600 : Colors.white60,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
                Container(width: 1, color: Colors.white.withOpacity(0.1)),
                // HTML Mode Tab
                InkWell(
                  onTap: () => onChanged(true),
                  borderRadius: const BorderRadius.horizontal(right: Radius.circular(5)),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: showHtml ? attrs.brand600.withOpacity(0.2) : Colors.transparent,
                      borderRadius: const BorderRadius.horizontal(right: Radius.circular(5)),
                    ),
                    child: Text(
                      'QUELLCODE',
                      style: TextStyle(
                        color: showHtml ? attrs.brand600 : Colors.white60,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
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

}
