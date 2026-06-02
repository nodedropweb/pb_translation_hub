import 'dart:ui';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:convert';
import 'dart:ui_web' as ui_web;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:confetti/confetti.dart';

import '../../services/api_client.dart';
import '../../theme/app_theme.dart';
import '../../providers/theme_provider.dart';
import '../../providers/language_provider.dart';
import '../../utils/translation_prompt.dart';
import '../../utils/html_sanitizer.dart';
import '../../utils/ck_glossary.dart';
import '../../widgets/ckeditor_field.dart';
import 'widgets/cost_calculator_dialog.dart';
import 'widgets/screenshot_alts_section.dart';

part '_editor_quill_bridge.dart';
part '_editor_build_methods.dart';

// Top-level constants shared across part files
const double _minDrawerWidth = 260.0;
const double _maxDrawerWidth = 920.0;

// ── Widget ────────────────────────────────────────────────────────────────────

class EditorScreen extends ConsumerStatefulWidget {
  final String machineName;

  /// The dashboard filter that was active when this editor was opened.
  /// Passed to the server so [nextMachineName] comes from the same filter list.
  final String filter;

  /// The search query that was active when this editor was opened.
  final String search;

  const EditorScreen({
    super.key,
    required this.machineName,
    this.filter = 'all',
    this.search = '',
  });

  @override
  ConsumerState<EditorScreen> createState() => _EditorScreenState();
}

// ── State ─────────────────────────────────────────────────────────────────────

class _EditorScreenState extends ConsumerState<EditorScreen> {
  final ApiClient _api = ApiClient();

  ThemeAttributes get attrs =>
      AppTheme.getAttributes(ref.watch(themeProvider).themeId);

  // ── Loading / saving flags ─────────────────────────────────────────────
  bool _isLoading = true;
  bool _isSaving = false;
  bool _isAiTranslating = false;
  bool _isDeeplTranslating = false;
  bool _isIgnored = false;
  bool _isUnignoring = false;

  // ── English source data ────────────────────────────────────────────────
  String _englishTitle = '';
  String _englishSummary = '';
  String _englishBody = '';
  List<dynamic> _screenshotUrls = [];
  String? _nextMachineName;
  int? _remainingPriorityCount;
  Map<String, dynamic>? _projectSource; // kept for potential future use

  // ── Translation controllers (HTML source-of-truth for saving) ─────────
  final TextEditingController _summaryController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final Map<String, TextEditingController> _screenshotAltControllers = {};

  // ── UI state ───────────────────────────────────────────────────────────
  bool _showSourceCode = false;
  bool _showPreview = false;
  bool _isReviewMode = false;
  bool _showSummaryHtml = false;
  bool _showBodyHtml = false;

  /// When `true`, CkEditorField iframes are replaced with opaque Containers so
  /// that Flutter dialogs (CostCalculatorDialog) render ABOVE the editor layer.
  /// Flutter Web (CanvasKit) places HtmlElementView DOM nodes above the canvas,
  /// which means any showDialog() call would appear visually *behind* the iframes
  /// unless we temporarily remove them from the tree.
  bool _suppressEditors = false;

  // ── CodeMirror source-editor iframes ──────────────────────────────────
  static bool _sourceViewsRegistered = false;
  static html.IFrameElement? _activeSummarySourceIFrame;
  static html.IFrameElement? _activeBodySourceIFrame;
  late html.EventListener _sourceMessageListener;

  // ── DOM-level keyboard shortcuts (work even when CKEditor has focus) ───
  late html.EventListener _keyDownListener;

  // ── Confetti ───────────────────────────────────────────────────────────
  late ConfettiController _confettiController;

  // ── Off-canvas source drawer ───────────────────────────────────────────
  bool _sourceDrawerOpen = false;
  double _sourceDrawerWidth = 500.0;
  bool _isResizing = false;

  // ── Lifecycle ─────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
    _registerSourceEditorViews();
    _setupSourceMessageListener();
    _setupKeyDownListener();
    _fetchData();
    Future.delayed(const Duration(milliseconds: 400), _loadGlossary);
  }

  @override
  void didUpdateWidget(covariant EditorScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.machineName != widget.machineName) {
      _fetchData();
    }
  }

  Future<void> _loadGlossary() async {
    if (!mounted) return;
    final lang = ref.read(languageProvider).targetLanguage.code;
    await loadCkEditorGlossary(_api, lang);
  }

  @override
  void dispose() {
    html.window.removeEventListener('message', _sourceMessageListener);
    html.window.removeEventListener('keydown', _keyDownListener, true);
    _confettiController.dispose();
    _summaryController.dispose();
    _bodyController.dispose();
    for (final c in _screenshotAltControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  // ── CodeMirror source-editor iframes ──────────────────────────────────────

  /// Registers HtmlElementView factories for the two CodeMirror source iframes.
  /// The static flag prevents double-registration on hot-reload / navigation.
  void _registerSourceEditorViews() {
    if (_sourceViewsRegistered) return;
    _sourceViewsRegistered = true;

    ui_web.platformViewRegistry.registerViewFactory(
      'editor-summary-source',
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
      'editor-body-source',
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

  /// Listens for postMessage events from the CodeMirror iframes and syncs
  /// HTML back into the relevant text controller.
  void _setupSourceMessageListener() {
    _sourceMessageListener = (html.Event event) {
      if (event is! html.MessageEvent) return;
      final rawData = event.data;
      if (rawData is! String) return;
      try {
        final data = jsonDecode(rawData);
        if (data is! Map) return;
        switch (data['type'] as String?) {
          case 'editor-summary-source-change':
            _summaryController.text = (data['html'] as String?) ?? '';
          case 'editor-body-source-change':
            _bodyController.text = (data['html'] as String?) ?? '';
          case 'editor-summary-source-ready':
            _syncToSourceIFrame('summary', _summaryController.text);
          case 'editor-body-source-ready':
            _syncToSourceIFrame('body', _bodyController.text);
        }
      } catch (_) {}
    };
    html.window.addEventListener('message', _sourceMessageListener);
  }

  /// DOM-level keyboard shortcuts — captured before CKEditor can consume them.
  /// Uses the capture phase (useCapture=true) so the listener fires even when
  /// a CKEditor contenteditable element has focus.
  void _setupKeyDownListener() {
    _keyDownListener = (html.Event event) {
      if (event is! html.KeyboardEvent) return;
      final ctrl = event.ctrlKey || event.metaKey;
      final alt = event.altKey;
      final key = event.key?.toLowerCase() ?? '';

      if (ctrl && alt && key == 's') {
        event.preventDefault();
        _save(andNext: true);
      } else if (ctrl && alt && key == 'd') {
        event.preventDefault();
        _skipAndNext();
      } else if (!ctrl && alt && key == 'p') {
        event.preventDefault();
        if (mounted) setState(() => _showPreview = !_showPreview);
      }
    };
    // true = capture phase: fires before CKEditor's own keydown handlers
    html.window.addEventListener('keydown', _keyDownListener, true);
  }

  /// Posts current HTML to the CodeMirror iframe for [type] ('summary'|'body').
  void _syncToSourceIFrame(String type, String htmlContent) {
    final iframe = type == 'summary'
        ? _activeSummarySourceIFrame
        : _activeBodySourceIFrame;
    iframe?.contentWindow?.postMessage(
      jsonEncode({'type': 'setHtml', 'html': htmlContent}),
      '*',
    );
  }

  /// Raw JS: tidy function — r-string so Dart never touches \n \r \t inside.
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

  /// Builds the srcdoc for a CodeMirror HTML-source editor iframe.
  static String _getSourceIFrameSrcDoc(String type) => '''<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/codemirror.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/theme/material-darker.min.css">
  <style>
    html, body { margin:0; padding:0; width:100%; height:100%;
                 background:#0F1115; overflow:hidden; }
    .CodeMirror { height:100%; font-family:'Fira Code',monospace;
                  font-size:13px; line-height:1.6; background:#0F1115 !important; }
    .CodeMirror-gutters { background:#0F1115 !important;
                          border-right:1px solid #1F2937 !important; }
    .CodeMirror-linenumber { color:#4B5563 !important; }
  </style>
</head>
<body>
  <textarea id="code-editor" style="display:none;"></textarea>
  <textarea id="fallback-textarea" style="display:none; width:100%; height:100%;
    background:#0F1115; color:#E2E8F0; border:none; padding:16px;
    font-family:monospace; font-size:13px; line-height:1.6;
    outline:none; resize:none; box-sizing:border-box;"></textarea>

  <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/codemirror.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/mode/xml/xml.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/mode/javascript/javascript.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/mode/css/css.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/mode/htmlmixed/htmlmixed.min.js"></script>

  <script>
    let editor, isFallback = false, isUpdating = false;
    const fallback = document.getElementById('fallback-textarea');

    $_tidyJs

    function initEditor() {
      if (typeof CodeMirror !== 'undefined') {
        document.getElementById('code-editor').style.display = 'block';
        editor = CodeMirror.fromTextArea(
          document.getElementById('code-editor'), {
            mode: 'text/html',
            theme: 'material-darker',
            lineNumbers: true,
            lineWrapping: true,
            tabSize: 2,
            viewportMargin: Infinity,
          }
        );
        editor.on('change', cm => {
          if (isUpdating) return;
          window.parent.postMessage(
            JSON.stringify({ type: 'editor-$type-source-change', html: cm.getValue() }),
            '*'
          );
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
        fallback.style.display = 'block';
        fallback.addEventListener('input', () => {
          if (isUpdating) return;
          window.parent.postMessage(
            JSON.stringify({ type: 'editor-$type-source-change', html: fallback.value }),
            '*'
          );
        });
        fallback.addEventListener('paste', e => {
          const text = e.clipboardData && e.clipboardData.getData('text/plain');
          if (!text) return;
          const tidied = tidyDeeplHtml(text);
          if (tidied !== text) {
            e.preventDefault();
            const s = fallback.selectionStart, end = fallback.selectionEnd;
            fallback.value = fallback.value.slice(0, s) + tidied + fallback.value.slice(end);
            fallback.selectionStart = fallback.selectionEnd = s + tidied.length;
            fallback.dispatchEvent(new Event('input'));
          }
        });
      }
      window.parent.postMessage(
        JSON.stringify({ type: 'editor-$type-source-ready' }), '*'
      );
    }

    window.addEventListener('load', () => setTimeout(initEditor, 100));

    window.addEventListener('message', event => {
      try {
        const msg = JSON.parse(event.data);
        if (msg.type === 'setHtml') {
          isUpdating = true;
          if (!isFallback && editor) editor.setValue(msg.html || '');
          else fallback.value = msg.html || '';
          isUpdating = false;
        }
      } catch (_) {}
    });
  </script>
</body>
</html>''';

  // ── Data fetching ──────────────────────────────────────────────────────────

  Future<void> _fetchData() async {
    setState(() => _isLoading = true);

    final langcode = ref.read(languageProvider).targetLanguage.code;

    try {
      // 1. Fetch English source from API.
      //    Pass filter + search so the server computes nextMachineName from the
      //    same filtered list the user was browsing on the dashboard.
      final projectRes = await _api.dio.get(
        '/projects/${widget.machineName}',
        queryParameters: {
          'langcode': langcode,
          'filter': widget.filter,
          'search': widget.search,
        },
      );

      final source = projectRes.data['data'];
      final attributes = source['attributes'] ?? {};
      final body = attributes['body'] ?? {};
      final meta = source['meta'] ?? {};

      _projectSource = source;
      _englishTitle = attributes['title'] ?? widget.machineName;
      _englishSummary = body['summary'] ?? '';
      _englishBody = body['value'] ?? '';
      _screenshotUrls = meta['screenshot_urls'] ?? [];
      _nextMachineName = meta['next_machine_name'];
      _remainingPriorityCount = meta['filter_count'];
      _isIgnored = meta['is_ignored'] == true;

      for (final c in _screenshotAltControllers.values) {
        c.dispose();
      }
      _screenshotAltControllers.clear();
      for (final img in _screenshotUrls) {
        final id = img['id'] as String;
        final alt = img['alt'] as String? ?? '';
        _screenshotAltControllers[id] = TextEditingController(text: alt);
      }

      // 2. Fetch existing translation for the active target language (may not exist yet)
      try {
        final transRes =
            await _api.dio.get('/translations/$langcode/${widget.machineName}');
        final t = transRes.data;

        _summaryController.text =
            t['body']?['summary'] ?? t['summary'] ?? '';
        _bodyController.text = t['body']?['value'] ?? t['body'] ?? '';
        final tAlts = t['screenshot_alts'] ?? {};
        tAlts.forEach((id, val) {
          _screenshotAltControllers[id]?.text = val as String;
        });
        _isReviewMode = t['is_reviewed'] ?? false;
      } catch (_) {
        // No translation yet — pre-populate with English source
        _summaryController.text = _englishSummary;
        _bodyController.text = _englishBody;
        _isReviewMode = false;
      }

      setState(() => _isLoading = false);
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fehler beim Laden der Projektdaten: $e')),
        );
      }
    }
  }

  // ── AI translation ─────────────────────────────────────────────────────────

  /// Removes all editor iframes from the DOM, waits until Flutter has actually
  /// painted the new frame (so the browser DOM is settled), then returns.
  ///
  /// This is necessary because in Flutter Web (CanvasKit) every HtmlElementView
  /// sits in a DOM layer *above* the Flutter canvas.  Any showDialog() call would
  /// render the dialog on the canvas, where it is invisible behind the iframes.
  /// Removing the iframes first lets the dialog appear fully on top.
  Future<void> _suppressAndWait() async {
    setState(() => _suppressEditors = true);
    // Wait for the widget rebuild so Flutter removes the iframe DOM nodes.
    await WidgetsBinding.instance.endOfFrame;
    // One extra frame to let the browser propagate the DOM removal.
    await WidgetsBinding.instance.endOfFrame;
  }

  /// Restores editors after a dialog.  If the user was in QUELLCODE mode we
  /// also re-push content to the CodeMirror iframes because they may have been
  /// re-created while hidden.
  void _restoreEditors() {
    setState(() => _suppressEditors = false);
    // Re-sync CodeMirror views that were visible before suppression.
    if (_showSummaryHtml) {
      Future.delayed(
        const Duration(milliseconds: 80),
        () => _syncToSourceIFrame('summary', _summaryController.text),
      );
    }
    if (_showBodyHtml) {
      Future.delayed(
        const Duration(milliseconds: 80),
        () => _syncToSourceIFrame('body', _bodyController.text),
      );
    }
  }

  Future<void> _triggerAiTranslation() async {
    await _suppressAndWait();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => CostCalculatorDialog(
        attrs: attrs,
        englishSummary: _englishSummary,
        englishBody: _englishBody,
      ),
    );

    if (confirmed != true) {
      if (mounted) _restoreEditors();
      return;
    }

    setState(() => _isAiTranslating = true);

    final langcode = ref.read(languageProvider).targetLanguage.code;

    try {
      final res = await _api.dio.post('/ai/translate-bulk', data: {
        'machineNames': [widget.machineName],
        'langcode': langcode,
      });

      // The server always returns 200, but individual translations may fail.
      // Check `count` (successful translations) and the first result's `error`
      // rather than relying solely on the HTTP status code.
      final responseData = res.data as Map<String, dynamic>;
      final successCount = responseData['count'] as int? ?? 0;

      if (res.statusCode == 200 && successCount > 0) {
        final transRes =
            await _api.dio.get('/translations/$langcode/${widget.machineName}');
        final t = transRes.data;
        if (mounted) {
          setState(() {
            // Restore editors + update content in one setState.
            // Because CkEditorField is always in the tree (just hidden via CSS
            // while suppressed), didUpdateWidget will push the new content to
            // the live CKEditor instance the moment suppressed → false.
            _suppressEditors = false;
            _isReviewMode = t['is_reviewed'] ?? false;
            _summaryController.text =
                t['body']?['summary'] ?? t['summary'] ?? '';
            _bodyController.text = t['body']?['value'] ?? t['body'] ?? '';
            final tAlts = t['screenshot_alts'] ?? {};
            tAlts.forEach((id, val) {
              _screenshotAltControllers[id]?.text = val as String;
            });
          });
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Übersetzung mit Gemini erfolgreich! ✨'),
            backgroundColor: Colors.green,
          ));
        }
      } else {
        // Extract the error detail reported by the server for the first item.
        final results = responseData['results'] as List<dynamic>? ?? [];
        final firstError = results.isNotEmpty
            ? (results.first as Map<String, dynamic>)['error'] as String?
            : null;
        // Top-level error (e.g. missing key returns HTTP 400).
        final topError = responseData['error'] as String?;
        final detail = topError ?? firstError ?? 'Unbekannter Fehler';

        if (mounted) {
          _restoreEditors();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Gemini-Übersetzung fehlgeschlagen: $detail'),
            backgroundColor: Colors.redAccent,
            duration: const Duration(seconds: 6),
          ));
        }
      }
    } catch (e) {
      if (mounted) {
        _restoreEditors();
        // Distinguish between a network/server error and a missing key.
        final msg = e.toString().toLowerCase().contains('google_ai_key') ||
                e.toString().toLowerCase().contains('missing')
            ? 'Bitte hinterlege deinen Google AI Key in deinem Benutzerprofil (nicht in den Admin-Einstellungen).'
            : 'Fehler bei der Gemini-Übersetzung. Bitte deinen Google AI Key im Benutzerprofil prüfen.';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(msg),
          backgroundColor: Colors.redAccent,
          duration: const Duration(seconds: 6),
        ));
      }
    } finally {
      if (mounted) setState(() => _isAiTranslating = false);
    }
  }

  // ── DeepL translation ─────────────────────────────────────────────────────

  Future<void> _triggerDeeplTranslation() async {
    setState(() => _isDeeplTranslating = true);

    final langcode = ref.read(languageProvider).targetLanguage.code;

    try {
      final res = await _api.dio.post('/ai/deepl-translate', data: {
        'machineName': widget.machineName,
        'langcode': langcode,
      });

      if (res.statusCode == 200 && res.data['success'] == true) {
        final transRes =
            await _api.dio.get('/translations/$langcode/${widget.machineName}');
        final t = transRes.data;
        setState(() {
  
          _summaryController.text =
              t['body']?['summary'] ?? t['summary'] ?? '';
          _bodyController.text = t['body']?['value'] ?? t['body'] ?? '';
          final tAlts = t['screenshot_alts'] ?? {};
          tAlts.forEach((id, val) {
            _screenshotAltControllers[id]?.text = val as String;
          });
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Übersetzung mit DeepL erfolgreich! 🔵'),
            backgroundColor: Colors.blue,
          ));
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'DeepL Übersetzung fehlgeschlagen: ${res.data['error'] ?? 'Unbekannter Fehler'}'),
            backgroundColor: Colors.redAccent,
          ));
        }
      }
    } catch (e) {
      if (mounted) {
        // Extract server-side error message if available
        String message =
            'Fehler bei der DeepL Übersetzung. Bitte stelle sicher, dass dein DeepL API-Key im Profil hinterlegt ist.';
        if (e is Exception) {
          final raw = e.toString();
          if (raw.contains('400')) {
            message = 'Ungültiger DeepL API-Key. Bitte im Profil prüfen.';
          } else if (raw.contains('402')) {
            message = 'DeepL Kontingent erschöpft. Bitte Plan prüfen.';
          }
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message),
          backgroundColor: Colors.redAccent,
          duration: const Duration(seconds: 5),
        ));
      }
    } finally {
      if (mounted) setState(() => _isDeeplTranslating = false);
    }
  }

  // ── Review reset ───────────────────────────────────────────────────────────

  Future<void> _resetReview() async {
    final langcode = ref.read(languageProvider).targetLanguage.code;
    try {
      await _api.dio.patch(
          '/translations/$langcode/${widget.machineName}/unreview');
      if (mounted) {
        setState(() => _isReviewMode = false);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Übersetzung zurück in Review-Status gesetzt.'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 3),
        ));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Fehler beim Zurücksetzen: $e'),
          backgroundColor: Colors.redAccent,
        ));
      }
    }
  }

  // ── Unignore this module ───────────────────────────────────────────────────

  Future<void> _unignoreModule() async {
    final isGerman = ref.read(languageProvider).targetLanguage.code == 'de';
    setState(() => _isUnignoring = true);
    try {
      await _api.dio.delete('/projects/${widget.machineName}/ignore');
      if (mounted) {
        setState(() => _isIgnored = false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(isGerman
              ? 'Modul wurde wieder in die aktive Liste aufgenommen.'
              : 'Module has been returned to the active list.'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(isGerman
              ? 'Fehler beim Einreihen des Moduls.'
              : 'Failed to unignore the module.'),
          backgroundColor: Colors.redAccent,
        ));
      }
    } finally {
      if (mounted) setState(() => _isUnignoring = false);
    }
  }

  // ── Save / navigation ──────────────────────────────────────────────────────

  Future<void> _save({bool andNext = false}) async {
    if (_isSaving) return;
    setState(() => _isSaving = true);

    try {
      final screenshotAlts = <String, String>{};
      _screenshotAltControllers
          .forEach((id, c) => screenshotAlts[id] = c.text);

      final langcode = ref.read(languageProvider).targetLanguage.code;
      await _api.dio.post('/translations/$langcode/${widget.machineName}', data: {
        'title': _englishTitle,
        'summary': _summaryController.text,
        'body': _bodyController.text,
        'screenshot_alts': screenshotAlts,
        'is_review': false, // Editor saves always push back to review queue
      });

      if (mounted) {
        setState(() => _isReviewMode = false);
        final confettiEnabled = ref.read(themeProvider).confettiEnabled;
        if (confettiEnabled) _confettiController.play();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Übersetzung gespeichert – zurück in Review-Warteschlange.'),
          backgroundColor: Colors.green,
        ));
      }
      if (andNext) _goToNext();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Fehler beim Speichern: $e'),
          backgroundColor: Colors.red,
        ));
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  void _goToNext() {
    if (_nextMachineName != null && _nextMachineName!.isNotEmpty) {
      // Carry the filter + search context so the next editor also knows
      // which list it belongs to and can compute *its* successor correctly.
      final uri = Uri(
        path: '/edit/$_nextMachineName',
        queryParameters: {
          'filter': widget.filter,
          if (widget.search.isNotEmpty) 'search': widget.search,
        },
      );
      context.go(uri.toString());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Keine weiteren offenen Projekte in der Liste.'),
      ));
      context.go('/');
    }
  }

  void _skipAndNext() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Änderungen verworfen, lade nächstes Projekt...'),
      backgroundColor: Colors.orange,
    ));
    _goToNext();
  }

  Future<void> _launchDrupalProject(String machineName) async {
    final cleanName = machineName.replaceAll('.json', '');
    final url = Uri.parse('https://www.drupal.org/project/$cleanName');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Konnte URL nicht öffnen: $url')),
        );
      }
    }
  }

  Color _getStatusColor() => attrs.brand600;

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    // Re-fetch data whenever the user switches the target language in the sidebar
    ref.listen(languageProvider, (previous, next) {
      if (previous?.targetLanguage.code != next.targetLanguage.code) {
        _fetchData();
        _loadGlossary();
      }
    });

    if (_isLoading) {
      return Scaffold(
        backgroundColor: const Color(0xFF0F1114),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: attrs.brand600),
              const SizedBox(height: 16),
              const Text(
                'Projektdetails werden geladen...',
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
    }

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.keyS,
            alt: true, control: true): () => _save(andNext: true),
        const SingleActivator(LogicalKeyboardKey.keyD,
            alt: true, control: true): () => _skipAndNext(),
        const SingleActivator(LogicalKeyboardKey.keyS,
            alt: true, shift: true): () => _save(andNext: true),
        const SingleActivator(LogicalKeyboardKey.keyD,
            alt: true, shift: true): () => _skipAndNext(),
        const SingleActivator(LogicalKeyboardKey.keyS, alt: true): () =>
            _save(andNext: true),
        const SingleActivator(LogicalKeyboardKey.keyD, alt: true): () =>
            _skipAndNext(),
        const SingleActivator(LogicalKeyboardKey.keyP, alt: true): () =>
            setState(() => _showPreview = !_showPreview),
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            _buildHeaderBar(),
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(child: _buildTranslationPane()),

                  // Scrim
                  AnimatedOpacity(
                    opacity: _sourceDrawerOpen ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 280),
                    child: IgnorePointer(
                      ignoring: !_sourceDrawerOpen,
                      child: GestureDetector(
                        onTap: () =>
                            setState(() => _sourceDrawerOpen = false),
                        child: Container(color: Colors.black54),
                      ),
                    ),
                  ),

                  // Off-canvas source drawer
                  AnimatedPositioned(
                    duration: _isResizing
                        ? Duration.zero
                        : const Duration(milliseconds: 280),
                    curve: Curves.easeInOut,
                    left: _sourceDrawerOpen ? 0 : -_sourceDrawerWidth,
                    top: 0,
                    bottom: 0,
                    width: _sourceDrawerWidth,
                    child: _buildEnglishSourcePane(),
                  ),

                  // Resize handle
                  if (_sourceDrawerOpen)
                    AnimatedPositioned(
                      duration: _isResizing
                          ? Duration.zero
                          : const Duration(milliseconds: 280),
                      curve: Curves.easeInOut,
                      left: _sourceDrawerWidth - 8,
                      top: 0,
                      bottom: 0,
                      width: 16,
                      child: _buildResizeHandle(),
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
            ),
          ],
        ),
      ),
    );
  }
}
