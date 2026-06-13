import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../providers/sync_provider.dart';
import '../providers/theme_provider.dart';
import '../theme/app_theme.dart';

/// Shows a progress bar with a Stop button while a sync is active.
/// Renders nothing (SizedBox.shrink) when no sync is running.
class SyncProgressBar extends ConsumerWidget {
  const SyncProgressBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final syncStatus = ref.watch(syncProvider);
    final attrs = AppTheme.getAttributes(ref.watch(themeProvider).themeId);

    if (!syncStatus.active) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: attrs.bgCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: attrs.brand600.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: attrs.brand600.withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Spinner
            SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: attrs.brand600,
              ),
            ),
            const SizedBox(width: 16),

            // Progress info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        syncStatus.syncType == 'quick'
                            ? 'Quick Sync: ${syncStatus.current} geänderte Module …'
                            : syncStatus.total > 0
                                ? 'Full Sync: ${syncStatus.current} / ${syncStatus.total} Module'
                                : 'Full Sync: ${syncStatus.current} Module …',
                        style: TextStyle(
                          color: attrs.textMain,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      if (syncStatus.total > 0)
                        Text(
                          '${(syncStatus.progress * 100).toStringAsFixed(1)} %',
                          style: TextStyle(
                            color: attrs.brand600,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: syncStatus.progress,
                      backgroundColor: attrs.bgInput,
                      color: attrs.brand600,
                      minHeight: 6,
                    ),
                  ),
                  if (syncStatus.syncType != 'quick' && syncStatus.lastMachineName.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      syncStatus.lastMachineName,
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'monospace',
                        color: attrs.textMuted,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 16),

            // Stop button
            TextButton.icon(
              onPressed: () => ref.read(syncProvider.notifier).stopSync(),
              style: TextButton.styleFrom(
                foregroundColor: Colors.redAccent,
                backgroundColor: Colors.redAccent.withOpacity(0.15),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(
                    color: Colors.redAccent,
                    width: 0.5,
                  ),
                ),
              ),
              icon: const Icon(LucideIcons.squareSlash, size: 14),
              label: const Text(
                'Stop',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
