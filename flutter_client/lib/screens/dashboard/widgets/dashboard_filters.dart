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
      padding: const EdgeInsets.only(right: 12.0),
      child: InkWell(
        onTap: onTapOverride ?? () => ref.read(projectProvider.notifier).setFilter(id),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                      fontSize: 13,
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
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: isActive ? Colors.white.withOpacity(0.1) : attrs.bgInput,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$count',
                  style: TextStyle(
                    fontSize: 12,
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilter = ref.watch(projectProvider.notifier).activeFilter;
    final themeState = ref.watch(themeProvider);
    final attrs = AppTheme.getAttributes(themeState.themeId);
    final filterCounts = ref.watch(filterCountsProvider);

    return Wrap(
      runSpacing: 10,
      children: [
        _buildFilterBtn(context, ref, 'all',        'Alle Projekte', 'All Projects',   filterCounts.all,        activeFilter, attrs),
        _buildFilterBtn(context, ref, 'priority',   'Drupal 11',     'Drupal 11',      filterCounts.priority,   activeFilter, attrs),
        _buildFilterBtn(context, ref, 'missing',    'Fehlend',       'Missing',        filterCounts.missing,    activeFilter, attrs),
        // Review-Tab nur für Reviewer und Admins
        if (ref.watch(authProvider).user?.isReviewer == true)
          _buildFilterBtn(context, ref, 'review',   'Review',        'Review Queue',   filterCounts.review,     activeFilter, attrs,
              onTapOverride: () => context.go('/review-list')),
        _buildFilterBtn(context, ref, 'released',   'Freigegeben',   'Released',       filterCounts.released,   activeFilter, attrs),
        _buildFilterBtn(context, ref, 'stale',      'Veraltet',      'Outdated',       filterCounts.stale,      activeFilter, attrs),
        _buildFilterBtn(context, ref, 'translated', 'Übersetzt',     'Translated',     filterCounts.translated, activeFilter, attrs),
        _buildFilterBtn(context, ref, 'ignored',    'Ignoriert',     'Ignored',        filterCounts.ignored,    activeFilter, attrs),
      ],
    );
  }
}
