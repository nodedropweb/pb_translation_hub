/// CKEditor 5 (Classic Build) embedded in a Flutter Web HtmlElementView.
///
/// Unlike the previous srcdoc-iframe approach, each instance is now a plain
/// `<div>` in the **main page DOM**.  Advantages:
///   • Browser extensions (DeepL add-on, Grammarly …) can reach the
///     `contenteditable` area because it lives in the top-level document.
///   • No cross-frame postMessage overhead — the JS bridge communicates via
///     direct Dart→JS method calls and JS→Dart callbacks.
///   • `suppressed: true` hides the editor via CSS (`visibility:hidden` +
///     `pointer-events:none`) without destroying the CKEditor instance.
///     Flutter dialogs that need to appear above the editor just set
///     `suppressed:true` for the duration of the dialog.
///
/// The CKEditor script and dark-theme CSS live in `web/index.html`.
/// The JS bridge (`window._ckBridge`) is also defined there.
///
/// License note: CKEditor 5 is GPL 2+.  For private/internal deployments
/// no additional obligations apply.  See https://ckeditor.com/legal/ckeditor-oss-license
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;
import 'dart:ui_web' as ui_web;
import 'package:flutter/material.dart';

class CkEditorField extends StatefulWidget {
  const CkEditorField({
    super.key,
    required this.initialHtml,
    required this.onChanged,
    this.height = 320.0,
    this.isSimple = false,
    this.suppressed = false,
  });

  /// Initial HTML content shown in the editor.
  final String initialHtml;

  /// Called on every change with the current HTML output.
  final ValueChanged<String> onChanged;

  /// Height of the editor area in logical pixels.
  final double height;

  /// `true`  → minimal toolbar (summary field).
  /// `false` → full toolbar  (body field).
  final bool isSimple;

  /// When `true` the editor div is hidden via CSS and ignores pointer events.
  /// Use this while a Flutter dialog is open so the dialog is fully visible
  /// and interactable even when the HTML renderer is not active.
  final bool suppressed;

  @override
  State<CkEditorField> createState() => _CkEditorFieldState();
}

class _CkEditorFieldState extends State<CkEditorField> {
  static int _counter = 0;
  late final int _id;
  late final String _viewType;

  html.DivElement? _container;
  bool _editorReady = false;
  String _lastContent = '';

  @override
  void initState() {
    super.initState();
    _id = ++_counter;
    _viewType = 'ckeditor5_div_$_id';
    _lastContent = widget.initialHtml;

    ui_web.platformViewRegistry.registerViewFactory(_viewType, (int viewId) {
      // Outer container — the element Flutter embeds in the DOM.
      _container = html.DivElement()
        ..className = 'cke-host'
        ..id = 'cke_container_$_id'
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.background = '#0F1115';

      // Apply initial suppressed state (editor may be hidden from creation).
      _applySuppressionCss(widget.suppressed);

      // Inner div — CKEditor mounts here.
      final editorDiv = html.DivElement()..id = 'cke_editor_$_id';
      _container!.append(editorDiv);

      // Init CKEditor after the element has been added to the live DOM.
      Future.delayed(const Duration(milliseconds: 120), _initEditor);

      return _container!;
    });
  }

  @override
  void didUpdateWidget(covariant CkEditorField old) {
    super.didUpdateWidget(old);

    // 1. Propagate suppression changes via CSS (no widget recreation needed).
    if (widget.suppressed != old.suppressed) {
      _applySuppressionCss(widget.suppressed);
    }

    // 2. Push programmatic content changes (e.g. after AI translation).
    //    Skip while suppressed — we'll push when we un-suppress in case
    //    the content also changed during suppression.
    if (widget.initialHtml != _lastContent && _editorReady) {
      _lastContent = widget.initialHtml;
      _setData(widget.initialHtml);
    }
  }

  @override
  void dispose() {
    _destroyEditor();
    super.dispose();
  }

  // ── CSS suppression ────────────────────────────────────────────────────────

  void _applySuppressionCss(bool suppress) {
    _container?.style.visibility = suppress ? 'hidden' : 'visible';
    _container?.style.pointerEvents = suppress ? 'none' : 'auto';
  }

  // ── CKEditor lifecycle ─────────────────────────────────────────────────────

  void _initEditor() {
    if (!mounted) return;

    final bridge = js.context['_ckBridge'];
    if (bridge == null) {
      debugPrint('[CkEditorField] _ckBridge not found in window. '
          'Ensure index.html loads the bridge before flutter_bootstrap.js.');
      return;
    }

    final toolbarItems = widget.isSimple
        ? '["bold","italic","link","|","undo","redo"]'
        : '["heading","|","bold","italic","|",'
            '"link","bulletedList","numberedList","|",'
            '"blockQuote","code","|","undo","redo"]';

    // Dart callbacks forwarded to JS as allowInterop wrappers.
    final onReady = js.allowInterop(() {
      if (!mounted) return;
      _editorReady = true;
      _setData(widget.initialHtml);
    });

    final onChange = js.allowInterop((String html) {
      if (!mounted) return;
      _lastContent = html;
      widget.onChanged(html);
    });

    (bridge as js.JsObject).callMethod('init', [_id, toolbarItems, onReady, onChange]);
  }

  void _setData(String content) {
    if (!_editorReady) return;
    final bridge = js.context['_ckBridge'];
    if (bridge == null) return;
    (bridge as js.JsObject).callMethod('setData', [_id, content]);
  }

  void _destroyEditor() {
    final bridge = js.context['_ckBridge'];
    if (bridge == null) return;
    try {
      (bridge as js.JsObject).callMethod('destroy', [_id]);
    } catch (_) {}
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: HtmlElementView(viewType: _viewType),
    );
  }
}
