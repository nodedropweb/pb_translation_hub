import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/module_logo.dart';

class Project {
  final String machineName;
  final String title;
  final String summary;
  final String status;
  final String? logoUrl;

  Project({
    required this.machineName,
    required this.title,
    required this.summary,
    required this.status,
    this.logoUrl,
  });
}

class ProjectCard extends StatelessWidget {
  final Project project;
  final ThemeAttributes attrs;

  /// Active dashboard filter — forwarded to the editor so it can compute the
  /// correct next module when the user presses "Speichern & Weiter".
  final String filter;

  /// Active search query — forwarded alongside [filter].
  final String search;

  const ProjectCard({
    super.key,
    required this.project,
    required this.attrs,
    this.filter = 'all',
    this.search = '',
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (project.status) {
      case 'translated':
      case 'released':
        statusColor = Colors.greenAccent;
        break;
      case 'stale':
        statusColor = Colors.amberAccent;
        break;
      case 'review':
        statusColor = Colors.purpleAccent;
        break;
      default:
        statusColor = attrs.borderMain;
    }

    return Container(
      decoration: BoxDecoration(
        color: attrs.bgCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: attrs.borderMain),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Modul-Bild-Banner ────────────────────────────────────────────
          GestureDetector(
            onTap: () => context.go(Uri(
                    path: '/edit/${project.machineName}',
                    queryParameters: {
                      'filter': filter,
                      if (search.isNotEmpty) 'search': search,
                    },
                  ).toString()),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: SizedBox(
                height: 130,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Hintergrundbild / Fallback – via server proxy (CORS-safe).
                    // Wenn das eigene Modul-Logo fehlt oder auf GitLab nicht
                    // existiert (404 → Proxy 502), wird als Fallback das
                    // project_browser-Icon gezeigt.
                    ModuleLogo(
                      machineName: project.machineName,
                      logoUrl: project.logoUrl,
                      fallbackLogoUrl:
                          'https://git.drupalcode.org/project/project_browser/-/avatar',
                      accentColor: attrs.brand600,
                      bgColor: attrs.bgCard,
                    ),

                    // Unterer Gradient-Übergang zum Karteninhalt
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              attrs.bgCard.withValues(alpha: 0.92),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),

                    // Status-Stripe oben
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(height: 4, color: statusColor),
                    ),

                    // Status-Badge unten-links
                    Positioned(
                      bottom: 10,
                      left: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(6),
                          border:
                              Border.all(color: statusColor.withValues(alpha: 0.4)),
                        ),
                        child: Text(
                          project.status.toUpperCase(),
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                            color: statusColor == attrs.borderMain
                                ? attrs.textMuted
                                : statusColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Karteninhalt ─────────────────────────────────────────────────
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Title (clickable)
                  GestureDetector(
                    onTap: () =>
                        context.go(Uri(
                    path: '/edit/${project.machineName}',
                    queryParameters: {
                      'filter': filter,
                      if (search.isNotEmpty) 'search': search,
                    },
                  ).toString()),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Text(
                        project.title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: attrs.textMain,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Summary
                  Expanded(
                    child: Text(
                      project.summary,
                      style: TextStyle(
                          color: attrs.textMuted, height: 1.4, fontSize: 12),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Machine name
                  Text(
                    project.machineName,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      color: attrs.brand600,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),

                  // Edit button
                  ElevatedButton(
                    onPressed: () =>
                        context.go(Uri(
                    path: '/edit/${project.machineName}',
                    queryParameters: {
                      'filter': filter,
                      if (search.isNotEmpty) 'search': search,
                    },
                  ).toString()),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: attrs.bgInput,
                      foregroundColor: attrs.textMain,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: attrs.borderMain),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Bearbeiten',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12)),
                        SizedBox(width: 6),
                        Icon(LucideIcons.chevronRight, size: 14),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
