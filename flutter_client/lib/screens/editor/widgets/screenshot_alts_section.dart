import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../../../theme/app_theme.dart';
import '../../../services/api_client.dart';

class ScreenshotAltsSection extends StatelessWidget {
  final ThemeAttributes attrs;
  final List<dynamic> screenshotUrls;
  final Map<String, TextEditingController> screenshotAltControllers;

  const ScreenshotAltsSection({
    super.key,
    required this.attrs,
    required this.screenshotUrls,
    required this.screenshotAltControllers,
  });

  @override
  Widget build(BuildContext context) {
    if (screenshotUrls.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        const Divider(color: Colors.white10),
        const SizedBox(height: 24),
        Text(
          AppLocalizations.of(context)!.screenshotAltsHeader,
          style: TextStyle(
            color: attrs.brand600,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          AppLocalizations.of(context)!.screenshotAltsIntro,
          style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12),
        ),
        const SizedBox(height: 20),
        ...screenshotUrls.asMap().entries.map((entry) {
          final index = entry.key;
          final img = entry.value;
          final id = img['id'] as String;
          final originalAlt = img['alt'] as String? ?? '';
          final rawUrl = img['url'] as String?;
          final controller = screenshotAltControllers[id];

          if (controller == null) return const SizedBox.shrink();

          // Route through the server-side image proxy to avoid CORS issues.
          final proxyUrl = rawUrl != null && rawUrl.isNotEmpty
              ? ApiClient.proxyImageUrl(rawUrl)
              : null;

          return Padding(
            padding: const EdgeInsets.only(bottom: 28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Screenshot label ──────────────────────────────────
                Text(
                  AppLocalizations.of(context)!.screenshotLabel(index + 1),
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8),

                // ── Screenshot preview ────────────────────────────────
                if (proxyUrl != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white10),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: proxyUrl,
                        width: double.infinity,
                        fit: BoxFit.fitWidth,
                        placeholder: (context, url) => Container(
                          height: 160,
                          color: Colors.white.withOpacity(0.05),
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: attrs.brand600.withOpacity(0.5),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, err) => Container(
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.broken_image_outlined,
                                    color: Colors.white24, size: 32),
                                const SizedBox(height: 8),
                                Text(
                                  AppLocalizations.of(context)!.screenshotPreviewUnavailable,
                                  style: TextStyle(
                                      color: Colors.white24, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: 12),

                // ── Original English alt text (reference) ─────────────
                if (originalAlt.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'EN  ',
                            style: TextStyle(
                              color: attrs.brand600.withOpacity(0.7),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              originalAlt,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                // ── Translation input ─────────────────────────────────
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.screenshotAltHint,
                    hintStyle: const TextStyle(color: Colors.white24),
                    fillColor: Colors.white.withOpacity(0.07),
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.white10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: attrs.brand600),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
}
