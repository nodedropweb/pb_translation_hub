import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../services/api_client.dart';

/// Shared module-logo widget for all card grids.
///
/// Validates and normalises [logoUrl] before loading, uses
/// [CachedNetworkImage] for persistent disk caching and automatic retry,
/// and falls back to a branded gradient + initial-letter avatar when the
/// URL is absent, malformed, or the network request fails.
///
/// The widget **fills its parent** — wrap it in a [SizedBox] or place it
/// inside a [Stack] with [StackFit.expand] to control the rendered size.
class ModuleLogo extends StatelessWidget {
  const ModuleLogo({
    super.key,
    required this.machineName,
    required this.accentColor,
    required this.bgColor,
    this.logoUrl,
    this.fallbackLogoUrl,
  });

  /// Used for the initial-letter fallback avatar.
  final String machineName;

  /// Brand / accent colour — drives fallback avatar and loading shimmer.
  final Color accentColor;

  /// Card background colour — used in gradient blends so the widget blends
  /// seamlessly into the card surface.
  final Color bgColor;

  /// Raw URL string from the API. Validated before any network request.
  final String? logoUrl;

  /// Secondary URL to try when [logoUrl] fails (e.g. 404/502).
  /// Falls back to the letter avatar if this also fails.
  final String? fallbackLogoUrl;

  // ── URL validation ────────────────────────────────────────────────────────

  /// Returns a trimmed, structurally valid URL or [null] when unusable.
  static String? _validate(String? raw) {
    if (raw == null) return null;
    final s = raw.trim();
    if (s.isEmpty) return null;
    // Require an explicit scheme — relative paths won't work.
    if (!s.startsWith('http://') && !s.startsWith('https://')) return null;
    // Spaces indicate a malformed or un-encoded URL.
    if (s.contains(' ')) return null;
    try {
      Uri.parse(s); // throws on invalid syntax
      return s;
    } catch (_) {
      return null;
    }
  }

  // ── Internal widgets ──────────────────────────────────────────────────────

  Widget _fallback() {
    final initial =
        machineName.isNotEmpty ? machineName[0].toUpperCase() : 'D';
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            accentColor.withValues(alpha: 0.18),
            bgColor.withValues(alpha: 0.95),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: accentColor.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: accentColor.withValues(alpha: 0.3),
            ),
          ),
          child: Center(
            child: Text(
              initial,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: accentColor.withValues(alpha: 0.85),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loading() => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              accentColor.withValues(alpha: 0.10),
              bgColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: accentColor.withValues(alpha: 0.5),
          ),
        ),
      );

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final url = _validate(logoUrl);
    final fbUrl = _validate(fallbackLogoUrl);

    // If the primary URL is absent/invalid but we have a fallback, go straight
    // to the fallback image; otherwise show the letter avatar.
    if (url == null) {
      if (fbUrl == null) return _fallback();
      return _buildImage(ApiClient.proxyImageUrl(fbUrl), null);
    }

    // Route through the server proxy so the browser's CORS policy
    // never blocks cross-origin image hosts (e.g. git.drupalcode.org).
    return _buildImage(
      ApiClient.proxyImageUrl(url),
      fbUrl != null ? ApiClient.proxyImageUrl(fbUrl) : null,
    );
  }

  /// Loads [imageUrl] via [CachedNetworkImage].
  /// On error, tries [errorFallbackUrl] first (if given) before the letter avatar.
  Widget _buildImage(String imageUrl, String? errorFallbackUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.contain,
      fadeInDuration: const Duration(milliseconds: 200),
      placeholderFadeInDuration: Duration.zero,
      placeholder: (context, url) => _loading(),
      errorWidget: (context, url, error) => errorFallbackUrl != null
          ? _buildImage(errorFallbackUrl, null) // one more try, no further chaining
          : _fallback(),
    );
  }
}
