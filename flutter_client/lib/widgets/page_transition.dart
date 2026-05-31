import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Hüllt eine Seite ein und lässt sie beim ersten Build sanft einblenden.
/// Wird im ShellRoute um AppLayout gelegt damit jeder Screen davon profitiert.
class PageTransition extends StatelessWidget {
  final Widget child;
  const PageTransition({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child
        .animate()
        .fadeIn(duration: 350.ms, curve: Curves.easeOut)
        .slideY(
          begin: 0.04,
          end: 0,
          duration: 350.ms,
          curve: Curves.easeOut,
        );
  }
}
