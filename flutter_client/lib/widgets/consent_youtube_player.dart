import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../theme/app_theme.dart';

// dart:html / dart:ui_web are only available on Flutter web builds.
// They are imported via conditional import so desktop builds compile cleanly.
import 'consent_youtube_stub.dart'
    if (dart.library.html) 'consent_youtube_web.dart';

/// A GDPR-compliant YouTube player widget backed by the Vidstack player.
///
/// Flow:
///   1. Shows a fully Flutter-drawn consent wall (zero external network
///      requests) until the user clicks "Video laden".
///   2. On consent the Vidstack `<media-player>` web component is inserted
///      into an [HtmlElementView] and YouTube playback starts automatically.
///
/// Vidstack is loaded via CDN in `web/index.html`; its custom-element
/// definitions are therefore available globally by the time this widget calls
/// [ui_web.platformViewRegistry.registerViewFactory].
///
/// Usage:
/// ```dart
/// ConsentYouTubePlayer(
///   videoId: 'IvhoK9TkQdU',
///   isGerman: true,
///   attrs: attrs,
/// )
/// ```
class ConsentYouTubePlayer extends StatefulWidget {
  const ConsentYouTubePlayer({
    super.key,
    required this.videoId,
    required this.isGerman,
    required this.attrs,
  });

  final String videoId;
  final bool isGerman;
  final ThemeAttributes attrs;

  @override
  State<ConsentYouTubePlayer> createState() => _ConsentYouTubePlayerState();
}

class _ConsentYouTubePlayerState extends State<ConsentYouTubePlayer> {
  /// Whether the user has given explicit GDPR consent.
  bool _consented = false;

  /// Unique view-type key so multiple players on the same page don't clash.
  static int _counter = 0;
  late final String _viewType;
  bool _registered = false;

  @override
  void initState() {
    super.initState();
    _counter++;
    _viewType = 'vidstack_yt_${widget.videoId}_$_counter';
  }

  // ── Consent wall ────────────────────────────────────────────────────────────

  Widget _buildConsentWall() {
    final attrs = widget.attrs;
    final isGerman = widget.isGerman;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            attrs.bgCard,
            Color.lerp(attrs.bgCard, Colors.black, 0.45)!,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // Decorative radial glow
          Positioned.fill(
            child: CustomPaint(painter: _BackgroundPainter(attrs.brand600)),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Shield icon
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: attrs.brand600.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: attrs.brand600.withValues(alpha: 0.35),
                      width: 1.5,
                    ),
                  ),
                  child: Icon(
                    LucideIcons.shieldCheck,
                    color: attrs.brand600,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 16),

                // Title
                Text(
                  isGerman ? 'Datenschutzhinweis' : 'Privacy Notice',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: attrs.textMain,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),

                // Body
                Text(
                  isGerman
                      ? 'Durch Klick auf „Video laden" wird eine Verbindung zu YouTube (Google LLC, USA) hergestellt. Dabei können personenbezogene Daten (z. B. IP-Adresse) an Google übertragen werden. Wir nutzen den Datenschutz-Modus von YouTube (youtube-nocookie.com).'
                      : 'By clicking "Load Video", a connection to YouTube (Google LLC, USA) will be established. Personal data (e.g. your IP address) may be transmitted to Google. We use YouTube\'s privacy-enhanced mode (youtube-nocookie.com).',
                  style: TextStyle(
                    fontSize: 12,
                    color: attrs.textMuted,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 14),

                _bulletRow(
                  LucideIcons.cookie,
                  isGerman
                      ? 'Keine Cookies vor Zustimmung'
                      : 'No cookies before consent',
                  attrs,
                ),
                const SizedBox(height: 6),
                _bulletRow(
                  LucideIcons.lock,
                  isGerman
                      ? 'Privacy-Enhanced Mode aktiv'
                      : 'Privacy-Enhanced Mode active',
                  attrs,
                ),
                const SizedBox(height: 20),

                // CTA button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _onConsent,
                    icon: const Icon(LucideIcons.play, size: 16),
                    label: Text(
                      isGerman
                          ? 'Video laden & zustimmen'
                          : 'Load video & consent',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: attrs.brand600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
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

  Widget _bulletRow(IconData icon, String text, ThemeAttributes attrs) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 13, color: attrs.brand600),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            fontSize: 11,
            color: attrs.textMuted,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // ── Consent handler ──────────────────────────────────────────────────────────

  void _onConsent() {
    if (kIsWeb) {
      if (!_registered) {
        registerYouTubeViewFactory(_viewType, widget.videoId);
        _registered = true;
      }
      setState(() => _consented = true);
    } else {
      // On desktop: nothing to do — the consent wall is replaced by a
      // static placeholder (see _buildDesktopPlaceholder).
      setState(() => _consented = true);
    }
  }

  // ── Web player embed ─────────────────────────────────────────────────────────

  Widget _buildPlayer() {
    if (!kIsWeb) return _buildDesktopPlaceholder();
    // HtmlElementView renders the registered factory element inline.
    return HtmlElementView(viewType: _viewType);
  }

  // ── Desktop placeholder ───────────────────────────────────────────────────────

  Widget _buildDesktopPlaceholder() {
    final attrs = widget.attrs;
    final isGerman = widget.isGerman;
    return Container(
      decoration: BoxDecoration(
        color: attrs.bgCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: attrs.borderMain),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LucideIcons.play, size: 48, color: attrs.textMuted),
            const SizedBox(height: 16),
            Text(
              isGerman
                  ? 'YouTube nicht verfügbar in der Desktop-App.'
                  : 'YouTube not available in the desktop app.',
              style: TextStyle(color: attrs.textMuted, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // ── Root ─────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb && !_consented) {
      // On desktop: show consent wall but when user clicks, show placeholder.
      return _buildConsentWall();
    }
    return _consented ? _buildPlayer() : _buildConsentWall();
  }
}

// ── Decorative background painter ─────────────────────────────────────────────

/// Paints a subtle radial glow and faint geometric rings behind the shield icon
/// to give the consent wall visual depth without any external asset requests.
class _BackgroundPainter extends CustomPainter {
  const _BackgroundPainter(this.accentColor);

  final Color accentColor;

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;

    // Radial glow centred slightly above mid-height (behind the shield icon).
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          accentColor.withValues(alpha: 0.10),
          accentColor.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromCircle(
        center: Offset(cx, cy * 0.55),
        radius: size.width * 0.45,
      ));
    canvas.drawCircle(Offset(cx, cy * 0.55), size.width * 0.45, glowPaint);

    // Decorative outer ring segments.
    final ringPaint = Paint()
      ..color = accentColor.withValues(alpha: 0.06)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    for (final r in [size.width * 0.35, size.width * 0.48]) {
      canvas.drawCircle(Offset(cx, cy * 0.55), r, ringPaint);
    }

    // Corner accent dots.
    final dotPaint = Paint()
      ..color = accentColor.withValues(alpha: 0.12)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width * 0.08, size.height * 0.12), 3, dotPaint);
    canvas.drawCircle(Offset(size.width * 0.92, size.height * 0.12), 3, dotPaint);
    canvas.drawCircle(Offset(size.width * 0.08, size.height * 0.88), 3, dotPaint);
    canvas.drawCircle(Offset(size.width * 0.92, size.height * 0.88), 3, dotPaint);

    // Faint diagonal texture lines.
    final gridPaint = Paint()
      ..color = accentColor.withValues(alpha: 0.04)
      ..strokeWidth = 0.5;
    final step = size.width / 8;
    for (var i = 0; i < 16; i++) {
      final x = i * step - size.height;
      canvas.drawLine(Offset(x, 0), Offset(x + size.height, size.height), gridPaint);
    }
  }

  @override
  bool shouldRepaint(_BackgroundPainter old) => old.accentColor != accentColor;
}
