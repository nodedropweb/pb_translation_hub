/// CkEditorField — cross-platform rich-text editor widget.
///
/// • Web:     CKEditor 5 via HtmlElementView (dart:html + dart:js)
/// • Desktop: FleatherEditor from the `fleather` package
///
/// The public API is identical on both platforms so that callers need no
/// platform checks.
library;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:fleather/fleather.dart';
import 'package:parchment/parchment.dart';
import 'dart:convert';

// Web-only implementation — loaded only when dart:html is available.
import 'ckeditor_field_stub.dart'
    if (dart.library.html) 'ckeditor_field_web_impl.dart';

/// A rich-text / HTML editor widget.
///
/// On web it uses CKEditor 5; on desktop it uses FleatherEditor.
class CkEditorField extends StatefulWidget {
  const CkEditorField({
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
  State<CkEditorField> createState() => _CkEditorFieldState();
}

class _CkEditorFieldState extends State<CkEditorField> {
  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return CkEditorFieldWebImpl(
        key: widget.key,
        initialHtml: widget.initialHtml,
        onChanged: widget.onChanged,
        height: widget.height,
        isSimple: widget.isSimple,
        suppressed: widget.suppressed,
      );
    }
    return _DesktopEditor(
      initialHtml: widget.initialHtml,
      onChanged: widget.onChanged,
      height: widget.height,
    );
  }
}

// ── Desktop editor ─────────────────────────────────────────────────────────────

class _DesktopEditor extends StatefulWidget {
  const _DesktopEditor({
    required this.initialHtml,
    required this.onChanged,
    required this.height,
  });

  final String initialHtml;
  final ValueChanged<String> onChanged;
  final double height;

  @override
  State<_DesktopEditor> createState() => _DesktopEditorState();
}

class _DesktopEditorState extends State<_DesktopEditor> {
  late FleatherController _controller;
  late FocusNode _focusNode;
  String _lastEmitted = '';

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    final doc = ParchmentDocument();
    // Start with plain text derived from the HTML (strip tags for simplicity).
    final plain = widget.initialHtml
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>');
    if (plain.isNotEmpty) {
      doc.insert(0, plain);
    }
    _controller = FleatherController(document: doc);
    _controller.addListener(_onDocChanged);
    _lastEmitted = widget.initialHtml;
  }

  void _onDocChanged() {
    // Emit plain text wrapped in a <p> tag as minimal HTML representation.
    final text = _controller.document.toPlainText().trimRight();
    final html = text.isEmpty ? '' : '<p>$text</p>';
    if (html != _lastEmitted) {
      _lastEmitted = html;
      widget.onChanged(html);
    }
  }

  @override
  void didUpdateWidget(covariant _DesktopEditor old) {
    super.didUpdateWidget(old);
    // If parent pushes new content (e.g. AI translation), update the document.
    if (widget.initialHtml != old.initialHtml) {
      final plain = widget.initialHtml
          .replaceAll(RegExp(r'<[^>]*>'), '')
          .replaceAll('&nbsp;', ' ')
          .replaceAll('&amp;', '&')
          .replaceAll('&lt;', '<')
          .replaceAll('&gt;', '>');
      _controller.removeListener(_onDocChanged);
      final doc = ParchmentDocument();
      if (plain.isNotEmpty) doc.insert(0, plain);
      _controller.dispose();
      _controller = FleatherController(document: doc);
      _controller.addListener(_onDocChanged);
      _lastEmitted = widget.initialHtml;
      if (mounted) setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onDocChanged);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0F1115),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white12),
        ),
        child: Column(
          children: [
            FleatherToolbar.basic(controller: _controller),
            Expanded(
              child: FleatherEditor(
                controller: _controller,
                focusNode: _focusNode,
                padding: const EdgeInsets.all(12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
