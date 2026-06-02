/// CKEditor 5 (Classic Build) embedded in a Flutter Web HtmlElementView.
///
/// This file contains the web-only implementation. It is only compiled when
/// running on Flutter Web (dart.library.html is available).
///
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;
import 'dart:ui_web' as ui_web;
import 'package:flutter/material.dart';

/// Web implementation of CkEditorField.
///
/// Exposed under the same name as the stub so that the conditional import
/// in ckeditor_field.dart resolves to this class on web.
class CkEditorFieldWebImpl extends StatefulWidget {
  const CkEditorFieldWebImpl({
    super.key,
    required this.initialHtml,
    required this.onChanged,
    this.height = 320.0,
    this.isSimple = false,
    this.suppressed = false,
  });

  final String initialHtml;
  final ValueChanged<String> onChanged;
  final double height;
  final bool isSimple;
  final bool suppressed;

  @override
  State<CkEditorFieldWebImpl> createState() => _CkEditorFieldWebImplState();
}

class _CkEditorFieldWebImplState extends State<CkEditorFieldWebImpl> {
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
      _container = html.DivElement()
        ..className = 'cke-host'
        ..id = 'cke_container_$_id'
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.background = '#0F1115';

      _applySuppressionCss(widget.suppressed);

      final editorDiv = html.DivElement()..id = 'cke_editor_$_id';
      _container!.append(editorDiv);

      Future.delayed(const Duration(milliseconds: 120), _initEditor);

      return _container!;
    });
  }

  @override
  void didUpdateWidget(covariant CkEditorFieldWebImpl old) {
    super.didUpdateWidget(old);

    if (widget.suppressed != old.suppressed) {
      _applySuppressionCss(widget.suppressed);
    }

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

  void _applySuppressionCss(bool suppress) {
    _container?.style.visibility = suppress ? 'hidden' : 'visible';
    _container?.style.pointerEvents = suppress ? 'none' : 'auto';
  }

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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: HtmlElementView(viewType: _viewType),
    );
  }
}
