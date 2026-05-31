import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2E),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Logo mit frameBuilder: Animation startet erst wenn
            // der erste Frame des Bildes gerendert ist.
            Image.asset(
              'assets/images/logo.png',
              width: 160,
              height: 160,
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                if (frame == null) {
                  // Noch nicht geladen — Platzhalter gleicher Größe
                  return const SizedBox(width: 160, height: 160);
                }
                // Bild ist da — jetzt animieren
                return child
                    .animate()
                    .scale(
                      begin: const Offset(0.72, 0.72),
                      end: const Offset(1.0, 1.0),
                      duration: 650.ms,
                      curve: Curves.easeOutBack,
                    )
                    .fadeIn(duration: 450.ms, curve: Curves.easeOut);
              },
            ),

            const SizedBox(height: 32),

            const Text(
              'PB TRANSLATION HUB',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w900,
                letterSpacing: 2.5,
              ),
            )
                .animate()
                .fadeIn(delay: 150.ms, duration: 500.ms)
                .slideY(
                  begin: 0.25, end: 0,
                  delay: 150.ms, duration: 500.ms,
                  curve: Curves.easeOut,
                ),

            const SizedBox(height: 8),

            const Text(
              'Project Browser Localizer',
              style: TextStyle(
                color: Color(0xFF6BA3C8),
                fontSize: 13,
                letterSpacing: 1.2,
              ),
            ).animate().fadeIn(delay: 350.ms, duration: 500.ms),

            const SizedBox(height: 48),

            SizedBox(
              width: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: const LinearProgressIndicator(
                  backgroundColor: Color(0xFF1E3A5F),
                  color: Color(0xFF4A90D9),
                  minHeight: 3,
                ),
              ),
            ).animate().fadeIn(delay: 500.ms, duration: 400.ms),
          ],
        ),
      ),
    );
  }
}
