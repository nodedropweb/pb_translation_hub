import 'package:flutter/material.dart';
import '../utils/diff_utils.dart';

/// Side-by-side diff widget.
/// [leftText] and [rightText] are HTML strings — they get stripped before display.
/// [leftLabel] / [rightLabel] are the column headers.
class DiffView extends StatefulWidget {
  final String leftText;
  final String rightText;
  final String leftLabel;
  final String rightLabel;

  const DiffView({
    super.key,
    required this.leftText,
    required this.rightText,
    this.leftLabel = 'Bisherige Übersetzung',
    this.rightLabel = 'Neue Quelle (Englisch)',
  });

  @override
  State<DiffView> createState() => _DiffViewState();
}

class _DiffViewState extends State<DiffView> {
  late List<DiffSpan> _spans;
  final _leftScroll = ScrollController();
  final _rightScroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _spans = computeWordDiff(widget.leftText, widget.rightText);
  }

  @override
  void didUpdateWidget(DiffView old) {
    super.didUpdateWidget(old);
    if (old.leftText != widget.leftText || old.rightText != widget.rightText) {
      _spans = computeWordDiff(widget.leftText, widget.rightText);
    }
  }

  @override
  void dispose() {
    _leftScroll.dispose();
    _rightScroll.dispose();
    super.dispose();
  }

  Widget _panel(String side, String label) {
    final textSpan = buildDiffTextSpan(_spans, side, context);
    final changed = side == 'left'
        ? _spans.any((s) => s.op == DiffOp.delete)
        : _spans.any((s) => s.op == DiffOp.insert);

    final accent = side == 'left' ? Colors.red.shade400 : Colors.green.shade400;
    final scroll = side == 'left' ? _leftScroll : _rightScroll;

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: changed ? accent.withOpacity(0.5) : Colors.white12,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: changed ? accent.withOpacity(0.12) : Colors.white.withOpacity(0.05),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(7)),
              ),
              child: Row(
                children: [
                  Icon(
                    side == 'left' ? Icons.arrow_back : Icons.arrow_forward,
                    size: 14,
                    color: changed ? accent : Colors.white38,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: changed ? accent : Colors.white38,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                  if (changed)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: accent.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        side == 'left' ? 'veraltet' : 'aktuell',
                        style: TextStyle(fontSize: 10, color: accent),
                      ),
                    ),
                ],
              ),
            ),
            // Content
            Expanded(
              child: Scrollbar(
                controller: scroll,
                child: SingleChildScrollView(
                  controller: scroll,
                  padding: const EdgeInsets.all(12),
                  child: SelectableText.rich(
                    textSpan,
                    style: const TextStyle(fontSize: 13, height: 1.6),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasChanges = _spans.any((s) => s.op != DiffOp.equal);

    if (!hasChanges) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.08),
          border: Border.all(color: Colors.green.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(Icons.check_circle_outline, color: Colors.green.shade400, size: 18),
            const SizedBox(width: 8),
            Text(
              'Keine inhaltlichen Unterschiede erkannt.',
              style: TextStyle(color: Colors.green.shade300, fontSize: 13),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        // Legend
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              _legendChip(Icons.remove_circle_outline, Colors.red.shade400, 'Entfernt'),
              const SizedBox(width: 12),
              _legendChip(Icons.add_circle_outline, Colors.green.shade400, 'Hinzugefügt'),
            ],
          ),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _panel('left', widget.leftLabel),
              const SizedBox(width: 8),
              _panel('right', widget.rightLabel),
            ],
          ),
        ),
      ],
    );
  }

  Widget _legendChip(IconData icon, Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 11, color: color)),
      ],
    );
  }
}

/// Shows a modal sheet with the diff view.
void showDiffSheet(
  BuildContext context, {
  required String leftText,
  required String rightText,
  String leftLabel = 'Bisherige Übersetzung',
  String rightLabel = 'Neue Quelle (Englisch)',
  String title = 'Änderungen',
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (ctx, scrollCtrl) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor == Colors.transparent
              ? const Color(0xFF1A1D23)
              : Theme.of(context).cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          border: Border.all(color: Colors.white12),
        ),
        child: Column(
          children: [
            // Handle + title
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Column(
                children: [
                  Container(
                    width: 36,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.compare_arrows, size: 18, color: Colors.white60),
                      const SizedBox(width: 8),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close, size: 18, color: Colors.white54),
                        onPressed: () => Navigator.pop(context),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white12, height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: DiffView(
                  leftText: leftText,
                  rightText: rightText,
                  leftLabel: leftLabel,
                  rightLabel: rightLabel,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
