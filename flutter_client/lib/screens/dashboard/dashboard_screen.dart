import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:go_router/go_router.dart';

import '../../providers/theme_provider.dart';
import '../../providers/project_provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/sync_provider.dart';
import '../../providers/language_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/sync_progress_bar.dart';
import '../../widgets/search_with_autocomplete.dart';
import '../../services/api_client.dart';
import 'widgets/project_card.dart';
import 'widgets/dashboard_filters.dart';



class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  // ── Manual module-add state ──────────────────────────────────────────────
  bool _showManualAdd = false;
  bool _syncingManual = false;
  late final TextEditingController _manualNameController;

  @override
  void initState() {
    super.initState();
    _manualNameController = TextEditingController();
  }

  @override
  void dispose() {
    _manualNameController.dispose();
    super.dispose();
  }

  // ──────────────────────────────── Sync helpers ───────────────────────────

  Future<void> _handleFullSync() async {
    try {
      await ref.read(syncProvider.notifier).startFullSync();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Fehler beim Starten des Syncs: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  Future<void> _handleQuickUpdate() async {
    try {
      await ref.read(syncProvider.notifier).quickUpdate(days: 7);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Schnell-Update (7 Tage) gestartet ⚡'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Fehler beim Schnell-Update: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  Future<void> _handleManualSync() async {
    final name = _manualNameController.text.trim();
    if (name.isEmpty) return;
    setState(() => _syncingManual = true);
    try {
      final title = await ref.read(syncProvider.notifier).manualSync(name);
      _manualNameController.clear();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erfolgreich synchronisiert: ${title ?? name}'),
            backgroundColor: Colors.green,
          ),
        );
        // Refresh the project list
        final activeFilter =
            ref.read(projectProvider.notifier).activeFilter;
        ref.read(projectProvider.notifier).setFilter(activeFilter, force: true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Modul nicht auf Drupal.org gefunden.'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _syncingManual = false);
    }
  }

  // ──────────────────────────────── Build ──────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final projectState = ref.watch(projectProvider);
    final activeFilter = ref.watch(projectProvider.notifier).activeFilter;
    final themeState = ref.watch(themeProvider);
    final attrs = AppTheme.getAttributes(themeState.themeId);
    final syncStatus = ref.watch(syncProvider);
    final user = ref.watch(authProvider).user;

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header — LayoutBuilder für schmale Portrait-Screens ───────────
          LayoutBuilder(
            builder: (context, constraints) {
              final showAiInline = constraints.maxWidth > 560;
              final showAiButton = activeFilter != 'review' &&
                  activeFilter != 'released' &&
                  activeFilter != 'translated';

              final aiButton = showAiButton
                  ? ElevatedButton.icon(
                      onPressed: () => _showBulkTranslateDialog(
                          context, ref, activeFilter, attrs),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 18),
                        backgroundColor: attrs.brand600,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                        shadowColor: attrs.brand600.withOpacity(0.2),
                        elevation: 8,
                      ),
                      icon: const Icon(LucideIcons.sparkles, size: 18),
                      label: const Text('AI Massen-Übersetzung',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14)),
                    )
                  : null;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: attrs.brand600,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: attrs.brand600.withOpacity(0.2),
                              blurRadius: 16,
                            ),
                          ],
                        ),
                        child: const Icon(LucideIcons.droplets,
                            color: Colors.white, size: 28),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Projekt-Beschreibungen',
                              style: TextStyle(
                                fontSize: constraints.maxWidth > 500 ? 32 : 24,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -0.5,
                              ),
                            ),
                            Text(
                              'Übersetzung von Drupal Modulen in das Deutsche. '
                              'Hilf mit, das Ökosystem zugänglicher zu machen.',
                              style: TextStyle(
                                  fontSize: 14, color: attrs.textMuted),
                            ),
                          ],
                        ),
                      ),
                      // AI-Button inline (breiter Screen)
                      if (showAiInline && aiButton != null) ...[
                        const SizedBox(width: 24),
                        aiButton,
                      ],
                    ],
                  ),
                  // AI-Button unter dem Header (schmaler Screen)
                  if (!showAiInline && aiButton != null) ...[
                    const SizedBox(height: 12),
                    aiButton,
                  ],
                ],
              );
            },
          ),

          // ── Last reviewed project banner ─────────────────────────────────
          if (user?.lastReviewedProject != null) ...[
            const SizedBox(height: 16),
            GlassContainer(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              borderRadius: 12,
              border: Border.all(color: attrs.brand600.withOpacity(0.3)),
              backgroundColor: attrs.brand600.withOpacity(0.08),
              child: Row(
                children: [
                  Icon(LucideIcons.clock, size: 16, color: attrs.brand600),
                  const SizedBox(width: 12),
                  Text(
                    'Zuletzt bearbeitet: ',
                    style: TextStyle(
                        color: attrs.textMuted,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                  Text(
                    user!.lastReviewedProject!,
                    style: TextStyle(
                        color: attrs.brand600,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'monospace',
                        fontSize: 13),
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: () =>
                        context.go('/edit/${user.lastReviewedProject}'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: attrs.brand600,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    icon: const Icon(LucideIcons.chevronRight, size: 14),
                    label: const Text('Weitermachen',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 28),

          // ── Filter buttons ────────────────────────────────────────────────
          const DashboardFilters(),

          const SizedBox(height: 16),

          // ── Search + Sync controls row ────────────────────────────────────
          Row(
            children: [
              // Search with autocomplete (full flex)
              Expanded(
                child: SearchWithAutocomplete(
                  initialValue:
                      ref.read(projectProvider.notifier).searchQuery,
                  activeFilter: activeFilter,
                  onSearchChanged: (val) =>
                      ref.read(projectProvider.notifier).setSearch(val),
                ),
              ),
              const SizedBox(width: 12),

              // Quick Update (7 days)
              Tooltip(
                message: 'Schnelles Update (letzte 7 Tage)',
                child: OutlinedButton.icon(
                  onPressed: syncStatus.active ? null : _handleQuickUpdate,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 15),
                    foregroundColor: attrs.textMain,
                    side: BorderSide(color: attrs.borderMain),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: Icon(LucideIcons.zap,
                      size: 16, color: Colors.amber[500]),
                  label: const Text('Schnell',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 8),

              // Full Sync
              Tooltip(
                message: 'Vollständiger Datenbank-Sync von Drupal.org',
                child: ElevatedButton.icon(
                  onPressed: syncStatus.active ? null : _handleFullSync,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 15),
                    backgroundColor: attrs.brand600,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    shadowColor: attrs.brand600.withOpacity(0.2),
                    elevation: 4,
                  ),
                  icon: syncStatus.active
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : const Icon(LucideIcons.refreshCw, size: 16),
                  label: const Text('Sync',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 8),

              // Toggle manual module add
              Tooltip(
                message: 'Einzelnes Modul manuell von Drupal.org laden',
                child: OutlinedButton.icon(
                  onPressed: () =>
                      setState(() => _showManualAdd = !_showManualAdd),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 15),
                    foregroundColor: _showManualAdd
                        ? attrs.brand600
                        : attrs.textMain,
                    side: BorderSide(
                      color: _showManualAdd
                          ? attrs.brand600
                          : attrs.borderMain,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    backgroundColor: _showManualAdd
                        ? attrs.brand600.withOpacity(0.2)
                        : Colors.transparent,
                  ),
                  icon: AnimatedRotation(
                    turns: _showManualAdd ? 0.125 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(LucideIcons.plus,
                        size: 16,
                        color: _showManualAdd
                            ? attrs.brand600
                            : attrs.textMuted),
                  ),
                  label: Text(
                    'Modul',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _showManualAdd
                            ? attrs.brand600
                            : attrs.textMain),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // ── Count + Per-page row ──────────────────────────────────────────
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: attrs.bgCard,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: attrs.borderMain),
                ),
                child: Row(
                  children: [
                    Text('Gefunden: ',
                        style: TextStyle(
                            color: attrs.textMuted,
                            fontWeight: FontWeight.bold,
                            fontSize: 13)),
                    Text(
                      '${projectState.totalItems}',
                      style: TextStyle(
                          color: attrs.brand600,
                          fontWeight: FontWeight.w900,
                          fontSize: 15),
                    ),
                    Text(' Module',
                        style: TextStyle(
                            color: attrs.textMuted,
                            fontWeight: FontWeight.bold,
                            fontSize: 13)),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: attrs.bgInput,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: attrs.borderMain),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: ref.watch(projectProvider.notifier).limit,
                    dropdownColor: attrs.bgCard,
                    icon: Icon(LucideIcons.chevronDown,
                        color: attrs.textMuted, size: 16),
                    onChanged: (val) {
                      if (val != null) {
                        ref.read(projectProvider.notifier).setLimit(val);
                      }
                    },
                    items: [50, 100, 250, 500].map((v) {
                      return DropdownMenuItem<int>(
                        value: v,
                        child: Text('$v pro Seite',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13)),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // ── Sync progress bar (auto-hides when inactive) ──────────────────
          const SyncProgressBar(),

          // ── Manual module add form ────────────────────────────────────────
          if (_showManualAdd) ...[
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: attrs.bgCard,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: attrs.borderMain),
              ),
              child: Row(
                children: [
                  Icon(LucideIcons.download, size: 18, color: attrs.brand600),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Modul manuell hinzufügen',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: attrs.textMain)),
                        Text('Direkt von Drupal.org per Machine Name laden.',
                            style: TextStyle(
                                fontSize: 11, color: attrs.textMuted)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Input field
                  SizedBox(
                    width: 240,
                    height: 42,
                    child: TextField(
                      controller: _manualNameController,
                      style: TextStyle(color: attrs.textMain, fontSize: 13),
                      onSubmitted: (_) => _handleManualSync(),
                      decoration: InputDecoration(
                        hintText: 'machine_name (z. B. pathauto)',
                        hintStyle: TextStyle(
                            color: attrs.textMuted.withOpacity(0.8),
                            fontSize: 13),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10),
                        filled: true,
                        fillColor: attrs.bgInput,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: attrs.borderMain),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: attrs.borderMain),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: attrs.brand600, width: 2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: _syncingManual ? null : _handleManualSync,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: attrs.brand600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: _syncingManual
                        ? const SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white),
                          )
                        : const Icon(LucideIcons.plus, size: 15),
                    label: const Text('Hinzufügen',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13)),
                  ),
                ],
              ),
            ),
          ],

          // ── Project grid ──────────────────────────────────────────────────
          Expanded(
            child: projectState.isLoading
                ? Center(
                    child: CircularProgressIndicator(color: attrs.brand600))
                : projectState.error != null
                    ? Center(
                        child: Text(projectState.error!,
                            style: const TextStyle(color: Colors.redAccent)))
                    : projectState.projects.isEmpty
                        ? Center(
                            child: Text('Keine Projekte gefunden.',
                                style: TextStyle(color: attrs.textMuted)))
                        : GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 420,
                              childAspectRatio: 0.78,
                              crossAxisSpacing: 24,
                              mainAxisSpacing: 24,
                            ),
                            itemCount: projectState.projects.length,
                            itemBuilder: (context, index) =>
                                ProjectCard(
                                  project: projectState.projects[index],
                                  attrs: attrs,
                                  filter: activeFilter,
                                  search: ref.read(projectProvider.notifier).searchQuery,
                                ),
                          ),
          ),

          // ── Pagination ────────────────────────────────────────────────────
          if (!projectState.isLoading &&
              projectState.totalItems >
                  ref.watch(projectProvider.notifier).limit) ...[
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(LucideIcons.chevronsLeft,
                      color: Colors.white),
                  onPressed: ref.watch(projectProvider.notifier).currentPage >
                          1
                      ? () => ref.read(projectProvider.notifier).goToPage(1)
                      : null,
                  tooltip: 'Erste Seite',
                ),
                IconButton(
                  icon: const Icon(LucideIcons.chevronLeft,
                      color: Colors.white),
                  onPressed: ref.watch(projectProvider.notifier).currentPage >
                          1
                      ? () =>
                          ref.read(projectProvider.notifier).prevPage()
                      : null,
                  tooltip: 'Vorherige Seite',
                ),
                const SizedBox(width: 16),
                Text(
                  'Seite ${ref.watch(projectProvider.notifier).currentPage} '
                  'von ${(projectState.totalItems / ref.watch(projectProvider.notifier).limit).ceil()}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(LucideIcons.chevronRight,
                      color: Colors.white),
                  onPressed: ref.watch(projectProvider.notifier).currentPage <
                          (projectState.totalItems /
                                  ref.watch(projectProvider.notifier).limit)
                              .ceil()
                      ? () =>
                          ref.read(projectProvider.notifier).nextPage()
                      : null,
                  tooltip: 'Nächste Seite',
                ),
                IconButton(
                  icon: const Icon(LucideIcons.chevronsRight,
                      color: Colors.white),
                  onPressed: ref.watch(projectProvider.notifier).currentPage <
                          (projectState.totalItems /
                                  ref.watch(projectProvider.notifier).limit)
                              .ceil()
                      ? () => ref.read(projectProvider.notifier).goToPage(
                          (projectState.totalItems /
                                  ref.watch(projectProvider.notifier).limit)
                              .ceil())
                      : null,
                  tooltip: 'Letzte Seite',
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  // ──────────────────────────────── AI Bulk translate ──────────────────────

  void _showBulkTranslateDialog(
    BuildContext context,
    WidgetRef ref,
    String activeFilter,
    ThemeAttributes attrs,
  ) async {
    int selectedCount = 25;
    bool prioritizeDrupal11 = true;

    String filterName;
    switch (activeFilter) {
      case 'all':
        filterName = 'Alle Projekte';
        break;
      case 'priority':
        filterName = 'Drupal 11';
        break;
      case 'missing':
        filterName = 'Fehlende Übersetzungen';
        break;
      case 'review':
        filterName = 'Review-Warteschlange';
        break;
      case 'stale':
        filterName = 'Veraltete Übersetzungen';
        break;
      case 'translated':
        filterName = 'Übersetzte Projekte';
        break;
      case 'released':
        filterName = 'Freigegebene Projekte';
        break;
      default:
        filterName = activeFilter;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            final estInputTokens = selectedCount * 500;
            final estOutputTokens = selectedCount * 300;
            final estInputCost = estInputTokens * 0.00000025;
            final estOutputCost = estOutputTokens * 0.00000150;
            final estTotalCost = estInputCost + estOutputCost;

            return Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: GlassContainer(
                borderRadius: 24,
                backgroundColor: attrs.bgCard.withOpacity(0.85),
                padding: const EdgeInsets.all(32.0),
                width: 520,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Title
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: attrs.brand600.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(LucideIcons.sparkles,
                              color: attrs.brand600, size: 24),
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Text(
                            'AI Massen-Übersetzung',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Übersetze mehrere Module aus dem ausgewählten Filter '
                      'automatisch mit Google Gemini.',
                      style: TextStyle(
                          color: attrs.textMuted.withOpacity(0.8),
                          fontSize: 14,
                          height: 1.5),
                    ),
                    const SizedBox(height: 24),

                    // Filter + Count row
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Aktiver Filter',
                                  style: TextStyle(
                                      color: attrs.textMuted, fontSize: 12)),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 14),
                                decoration: BoxDecoration(
                                  color: attrs.bgInput,
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: attrs.borderMain),
                                ),
                                child: Row(
                                  children: [
                                    Icon(LucideIcons.filter,
                                        size: 14, color: attrs.textMuted),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(filterName,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Anzahl Module',
                                  style: TextStyle(
                                      color: attrs.textMuted, fontSize: 12)),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8),
                                decoration: BoxDecoration(
                                  color: attrs.bgInput,
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: attrs.borderMain),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<int>(
                                    value: selectedCount,
                                    dropdownColor: attrs.bgInput,
                                    icon: Icon(LucideIcons.chevronDown,
                                        size: 16, color: attrs.textMuted),
                                    isExpanded: true,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                    onChanged: (val) {
                                      if (val != null) {
                                        setState(() =>
                                            selectedCount = val);
                                      }
                                    },
                                    items: [25, 50, 100, 150].map((c) {
                                      return DropdownMenuItem<int>(
                                        value: c,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0),
                                          child: Text('$c Module'),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Drupal 11 priority toggle
                    if (activeFilter != 'priority') ...[
                      GestureDetector(
                        onTap: () => setState(
                            () => prioritizeDrupal11 = !prioritizeDrupal11),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: prioritizeDrupal11
                                ? attrs.brand600.withOpacity(0.2)
                                : attrs.bgInput.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: prioritizeDrupal11
                                  ? attrs.brand600.withOpacity(0.2)
                                  : attrs.borderMain,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                prioritizeDrupal11
                                    ? LucideIcons.checkCircle2
                                    : LucideIcons.circle,
                                size: 18,
                                color: prioritizeDrupal11
                                    ? attrs.brand600
                                    : attrs.textMuted,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    const Text('Drupal 11 Module priorisieren',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            color: Colors.white)),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Übersetzt bevorzugt Drupal 11 '
                                      'kompatible Module zuerst',
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: attrs.textMuted
                                              .withOpacity(0.1)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],

                    // Cost breakdown
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: attrs.bgInput.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: attrs.borderMain),
                      ),
                      child: Column(
                        children: [
                          _buildCostRow('Modell', 'Gemini 3.1 Flash-Lite', attrs),
                          Divider(color: attrs.borderMain, height: 24),
                          _buildCostRow('Module gesamt', '$selectedCount', attrs),
                          _buildCostRow('Eingabe-Tokens (Schätzung)', '$estInputTokens', attrs),
                          _buildCostRow('Ausgabe-Tokens (Schätzung)', '$estOutputTokens', attrs),
                          Divider(color: attrs.borderMain, height: 24),
                          _buildCostRow('Preis pro 1M Input', '\$0.25', attrs, isValueColorMuted: true),
                          _buildCostRow('Preis pro 1M Output', '\$1.50', attrs, isValueColorMuted: true),
                          Divider(color: attrs.borderMain, height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Geschätzte Gesamtkosten',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.white)),
                              Text(
                                '\$${estTotalCost.toStringAsFixed(4)} USD',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: attrs.brand600),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '* Die Übersetzung wird in ressourcenschonenden Batches '
                      'ausgeführt, um Timeouts zu verhindern.',
                      style: TextStyle(
                          fontSize: 11,
                          color: attrs.textMuted,
                          fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 32),

                    // Actions
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () =>
                              Navigator.of(context).pop(false),
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 16),
                              foregroundColor: attrs.textMuted),
                          child: const Text('Abbrechen',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () =>
                              Navigator.of(context).pop(true),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                            backgroundColor: attrs.brand600,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Text('Massen-Übersetzung starten',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    if (confirmed == true) {
      _executeBulkTranslation(
          context, ref, activeFilter, selectedCount, prioritizeDrupal11, attrs);
    }
  }

  Widget _buildCostRow(
    String label,
    String value,
    ThemeAttributes attrs, {
    bool isValueColorMuted = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(color: attrs.textMuted, fontSize: 13)),
          Text(
            value,
            style: TextStyle(
              color: isValueColorMuted ? attrs.textMuted : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  void _executeBulkTranslation(
    BuildContext context,
    WidgetRef ref,
    String activeFilter,
    int limitCount,
    bool prioritizeDrupal11,
    ThemeAttributes attrs,
  ) async {
    final ApiClient api = ApiClient();
    final langcode = ref.read(languageProvider).targetLanguage.code;

    final progressNotifier =
        ValueNotifier<Map<String, dynamic>>({
      'status': 'Projekte werden vom Server abgerufen…',
      'progress': 0.0,
      'processed': 0,
      'total': 0,
    });

    bool isTaskCompleted = false;
    BuildContext? dialogContext;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        dialogContext = ctx;
        if (isTaskCompleted) {
          Future.microtask(() {
            if (ctx.mounted) Navigator.of(ctx).pop();
          });
        }
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: ValueListenableBuilder<Map<String, dynamic>>(
            valueListenable: progressNotifier,
            builder: (context, data, child) {
              final currentStatus = data['status'] as String;
              final progress = data['progress'] as double;
              final processedCount = data['processed'] as int;
              final totalCount = data['total'] as int;

              return GlassContainer(
                borderRadius: 24,
                backgroundColor: attrs.bgCard.withOpacity(0.85),
                padding: const EdgeInsets.all(32.0),
                width: 440,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: attrs.brand600),
                        ),
                        const SizedBox(width: 16),
                        const Text('AI Massen-Übersetzung',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(currentStatus,
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 14)),
                    const SizedBox(height: 16),
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: attrs.bgInput,
                      color: attrs.brand600,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$processedCount von $totalCount Modulen verarbeitet',
                          style: TextStyle(
                              color: attrs.textMuted, fontSize: 12),
                        ),
                        Text(
                          '${(progress * 100).toInt()} %',
                          style: TextStyle(
                              color: attrs.brand600,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );

    try {
      final projectsRes = await api.dio.get(
        '/projects',
        queryParameters: {
          'filter': activeFilter,
          'limit': limitCount,
          'langcode': langcode,
          'prioritize_drupal11': prioritizeDrupal11,
        },
      );

      final rawData = projectsRes.data['data'] as List<dynamic>;
      final List<String> machineNames = rawData
          .map((p) =>
              p['attributes']['field_project_machine_name'] as String)
          .toList();

      final totalCount = machineNames.length;
      if (totalCount == 0) {
        isTaskCompleted = true;
        if (dialogContext != null && dialogContext!.mounted) {
          Navigator.of(dialogContext!).pop();
        }
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'Keine übersetzbaren Projekte in diesem Filter gefunden.'),
              backgroundColor: Colors.amber,
            ),
          );
        }
        return;
      }

      progressNotifier.value = {
        'status': 'Übersetzung wird gestartet…',
        'progress': 0.0,
        'processed': 0,
        'total': totalCount,
      };

      const batchSize = 4;
      for (int i = 0; i < totalCount; i += batchSize) {
        final end =
            i + batchSize > totalCount ? totalCount : i + batchSize;
        final batch = machineNames.sublist(i, end);

        progressNotifier.value = {
          'status': 'Übersetze Modul ${i + 1}–$end von $totalCount …',
          'progress': i / totalCount,
          'processed': i,
          'total': totalCount,
        };

        await api.dio.post('/ai/translate-bulk',
          data: {
            'machineNames': batch,
            'langcode': langcode,
          },
          options: Options(receiveTimeout: const Duration(minutes: 10)),
        );

        progressNotifier.value = {
          'status': '$end von $totalCount Modulen abgeschlossen.',
          'progress': end / totalCount,
          'processed': end,
          'total': totalCount,
        };

        await Future.delayed(const Duration(milliseconds: 400));
      }

      progressNotifier.value = {
        'status': 'Übersetzung erfolgreich abgeschlossen! ✨',
        'progress': 1.0,
        'processed': totalCount,
        'total': totalCount,
      };

      await Future.delayed(const Duration(seconds: 1));
      isTaskCompleted = true;
      if (dialogContext != null && dialogContext!.mounted) {
        Navigator.of(dialogContext!).pop();
      }

      if (context.mounted) {
        ref.read(projectProvider.notifier).setFilter(activeFilter, force: true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Massen-Übersetzung von $totalCount Modulen erfolgreich! ✨'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      isTaskCompleted = true;
      if (dialogContext != null && dialogContext!.mounted) {
        Navigator.of(dialogContext!).pop();
      }
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Fehler bei der Massen-Übersetzung: $e'),
            backgroundColor: Colors.redAccent,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }
}
