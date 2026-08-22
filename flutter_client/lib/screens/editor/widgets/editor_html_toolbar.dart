import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../l10n/app_localizations.dart';
import '../../../theme/app_theme.dart';

/// WYSIWYG toolbar that acts directly on a [FleatherController].
///
/// Replaces the earlier [onExecCommand]-based HTML toolbar.
class EditorHtmlToolbar extends StatelessWidget {
  final ThemeAttributes attrs;
  final FleatherController controller;
  final bool isSimple;

  const EditorHtmlToolbar({
    super.key,
    required this.attrs,
    required this.controller,
    this.isSimple = false,
  });

  // ── Button factory ────────────────────────────────────────────────────────

  Widget _btn(
    String label,
    VoidCallback onPressed, {
    IconData? icon,
    String? tooltip,
  }) {
    return Tooltip(
      message: tooltip ?? label,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            minimumSize: const Size(32, 32),
            foregroundColor: Colors.white70,
            backgroundColor: Colors.white.withValues(alpha: 0.05),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4)),
          ),
          child: icon != null
              ? Icon(icon, size: 16, color: Colors.white70)
              : Text(label,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 12)),
        ),
      ),
    );
  }

  // ── Attribute toggle helpers ──────────────────────────────────────────────

  /// Toggles an attribute on the current selection.
  ///
  /// Uses [ParchmentStyle.containsSame] so heading/block attributes (which
  /// share a key with other values) toggle correctly based on exact value.
  void _toggle<T>(ParchmentAttribute<T> attr) {
    final style = controller.getSelectionStyle();
    controller.formatSelection(style.containsSame(attr) ? attr.unset : attr);
  }

  // ── Link dialog ───────────────────────────────────────────────────────────

  Future<void> _insertLink(BuildContext context) async {
    final urlController = TextEditingController(text: 'https://');
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E222B),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(AppLocalizations.of(context)!.htmlToolbarInsertLink,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
        content: TextField(
          controller: urlController,
          autofocus: true,
          decoration: InputDecoration(
            labelText: 'URL',
            labelStyle: const TextStyle(color: Colors.white70),
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white30)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: attrs.brand600)),
          ),
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(AppLocalizations.of(context)!.commonCancel,
                style: const TextStyle(color: Colors.white70)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, urlController.text),
            style: ElevatedButton.styleFrom(
              backgroundColor: attrs.brand600,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(AppLocalizations.of(context)!.htmlToolbarInsert),
          ),
        ],
      ),
    );
    if (result != null && result.isNotEmpty) {
      controller.formatSelection(ParchmentAttribute.link.withValue(result));
    }
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        border: Border(bottom: BorderSide(color: attrs.borderMain)),
      ),
      child: Row(
        children: [
          if (!isSimple) ...[
            _btn('H2', () => _toggle(ParchmentAttribute.h2),
                tooltip: AppLocalizations.of(context)!.htmlToolbarHeading2),
            _btn('H3', () => _toggle(ParchmentAttribute.h3),
                tooltip: AppLocalizations.of(context)!.htmlToolbarHeading3),
            const SizedBox(width: 8),
            Container(width: 1, height: 20, color: Colors.white12),
            const SizedBox(width: 8),
          ],
          _btn('B', () => _toggle(ParchmentAttribute.bold),
              tooltip: AppLocalizations.of(context)!.htmlToolbarBold),
          _btn('I', () => _toggle(ParchmentAttribute.italic),
              tooltip: AppLocalizations.of(context)!.htmlToolbarItalic),
          _btn('Link', () => _insertLink(context),
              icon: LucideIcons.link, tooltip: AppLocalizations.of(context)!.htmlToolbarLinkTooltip),
          if (!isSimple) ...[
            _btn('List', () => _toggle(ParchmentAttribute.ul),
                icon: LucideIcons.list, tooltip: AppLocalizations.of(context)!.htmlToolbarBulletList),
            _btn('Num', () => _toggle(ParchmentAttribute.ol),
                icon: LucideIcons.listOrdered, tooltip: AppLocalizations.of(context)!.htmlToolbarNumberedList),
            _btn('Quote', () => _toggle(ParchmentAttribute.bq),
                icon: LucideIcons.quote, tooltip: AppLocalizations.of(context)!.htmlToolbarQuote),
          ],
        ],
      ),
    );
  }
}
