/// Desktop stub for CkEditorFieldWebImpl.
/// This class is never instantiated on desktop (kIsWeb == false prevents it),
/// but it must exist so the conditional import compiles.
import 'package:flutter/material.dart';

class CkEditorFieldWebImpl extends StatelessWidget {
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
  Widget build(BuildContext context) => const SizedBox.shrink();
}
