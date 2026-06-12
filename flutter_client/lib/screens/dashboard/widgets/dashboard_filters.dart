import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../providers/theme_provider.dart';
import '../../../providers/project_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../theme/app_theme.dart';

class DashboardFilters extends ConsumerWidget {
  const DashboardFilters({super.key});

  Widget _buildFilterBtn(
    BuildContext context,
    WidgetRef ref,
    String id,
    String labelDe,
    String labelEn,
    int count,
    String activeFilter,
    ThemeAttributes attrs, {
    VoidCallback? onTapOverride,
  }) {
    final isActive = activeFilter == id;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
      child: InkWell(
        onTap: onTapOverride ?? () => ref.read(projectProvider.notifier).setFilter(id),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: isActive ? attrs.brand600 : attrs.bgCard,
            border: Border.all(color: isActive ? attrs.brand600 : attrs.borderMain),
            borderRadius: BorderRadius.circular(12),
            boxShadow: isActive
                ? [BoxShadow(color: attrs.brand600.withOpacity(0.2), blurRadius: 12, offset: const Offset(0, 4))]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    labelDe,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: isActive ? Colors.white : attrs.textMain,
                    ),
                  ),
                  Text(
                    labelEn,
                    style: TextStyle(
                      fontSize: 10,
                      color: isActive ? Colors.white.withOpacity(0.7) : attrs.textMuted,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 7),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: isActive ? Colors.white.withOpacity(0.15) : attrs.bgInput,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$count',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: isActive ? Colors.white : attrs.textMuted,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVersionChip(
    WidgetRef ref,
    int? version,
    String label,
    int? subCount,
    int? activeVersion,
    ThemeAttributes attrs,
  ) {
    final isActive = activeVersion == version;
    return Padding(
      padding: const EdgeInsets.only(right: 6.0, bottom: 6.0),
      child: InkWell(
        onTap: () => ref.read(projectProvider.notifier).setCoreVersion(version),
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: isActive ? attrs.brand600.withOpacity(0.9) : attrs.bgCard,
            border: Border.all(
              color: isActive ? attrs.brand600 : attrs.borderMain,
              width: isActive ? 1.5 : 1,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                  color: isActive ? Colors.white : attrs.textMain,
                ),
              ),
              if (subCount != null) ...[
                const SizedBox(width: 5),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                  decoration: BoxDecoration(
                    color: isActive ? Colors.white.withOpacity(0.2) : attrs.bgInput,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '$subCount',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: isActive ? Colors.white : attrs.textMuted,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilter = ref.watch(projectProvider.notifier).activeFilter;
    final activeVersion = ref.watch(projectProvider.notifier).coreVersion;
    final themeState = ref.watch(themeProvider);
    final attrs = AppTheme.getAttributes(themeState.themeId);
    final filterCounts = ref.watch(filterCountsProvider);
    final vc = filterCounts.versionCounts;

    int? vcCount(int v) {
      final c = vc[v];
      if (c == null) return null;
      switch (activeFilter) {
        case 'missing': return c.missing;
        case 'review': return c.review;
        case 'released': return c.released;
        default: return c.all;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Drupal-Version-Chips ─────────────────────────────────────────────
        Wrap(
          children: [
            _buildVersionChip(ref, null, 'Alle', null, activeVersion, attrs),
            _buildVersionChip(ref, 9,    'D9',  vcCount(9),  activeVersion, attrs),
            _buildVersionChip(ref, 10,   'D10', vcCount(10), activeVersion, attrs),
            _buildVersionChip(ref, 11,   'D11', vcCount(11), activeVersion, attrs),
            _buildVersionChip(ref, 12,   'D12', vcCount(12), activeVersion, attrs),
          ],
        ),
        const SizedBox(height: 6),
        // ── Status-Filter-Buttons ────────────────────────────────────────────
        Wrap(
          children: [
            _buildFilterBtn(context, ref, 'all',        'Alle Projekte', 'All Projects',   filterCounts.all,        activeFilter, attrs),
            _buildFilterBtn(context, ref, 'missing',    'Fehlend',       'Missing',        filterCounts.missing,    activeFilter, attrs),
            _buildFilterBtn(context, ref, 'translated', 'Übersetzt',     'Translated',     filterCounts.translated, activeFilter, attrs),
            if (ref.watch(authProvider).user?.isReviewer == true)
              _buildFilterBtn(context, ref, 'review',   'Review',        'Review Queue',   filterCounts.review,     activeFilter, attrs,
                  onTapOverride: () => context.go('/review-list')),
            _buildFilterBtn(context, ref, 'released',   'Freigegeben',   'Released',       filterCounts.released,   activeFilter, attrs),
            _buildFilterBtn(context, ref, 'stale',      'Veraltet',      'Outdated',       filterCounts.stale,      activeFilter, attrs),
            _buildFilterBtn(context, ref, 'priority',   'Priorität',     'Priority',       filterCounts.priority,   activeFilter, attrs),
            _buildFilterBtn(context, ref, 'ignored',    'Ignoriert',     'Ignored',        filterCounts.ignored,    activeFilter, attrs),
          ],
        ),
      ],
    );
  }
}
