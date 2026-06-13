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
  bool _unignoringAll = false;
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

  // ── Unignore all ────────────────────────────────────────────────────────

  Future<void> _handleUnignoreAll(bool isGerman) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        final attrs = AppTheme.getAttributes(
            ref.read(themeProvider).themeId);
        return AlertDialog(
          backgroundColor: const Color(0xFF1A1F26),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: attrs.borderMain)),
          title: Text(
            isGerman ? 'Alle ignorieren aufheben?' : 'Unignore all modules?',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: Text(
            isGerman
                ? 'Alle ignorierten Module werden wieder in die aktive Liste aufgenommen und stehen erneut zur Übersetzung bereit.'
                : 'All ignored modules will be returned to the active list and will be available for translation again.',
            style: TextStyle(color: attrs.textMuted),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(isGerman ? 'Abbrechen' : 'Cancel',
                  style: TextStyle(color: attrs.textMuted)),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx, true),
              style: ElevatedButton.styleFrom(
                  backgroundColor: attrs.brand600),
              child: Text(isGerman ? 'Alle einreihen' : 'Unignore all'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    setState(() => _unignoringAll = true);
    try {
      final api = ApiClient();
      await api.dio.delete('/projects/ignore-all');
      if (mounted) {
        final attrs = AppTheme.getAttributes(ref.read(themeProvider).themeId);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(isGerman
              ? 'Alle ignorierten Module wurden wieder eingereiht.'
              : 'All ignored modules have been unignored.'),
          backgroundColor: attrs.brand600,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ));
        ref.read(projectProvider.notifier).setFilter('all', force: true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(isGerman
              ? 'Fehler beim Einreihen der Module.'
              : 'Failed to unignore modules.'),
          backgroundColor: Colors.redAccent,
        ));
      }
    } finally {
      if (mounted) setState(() => _unignoringAll = false);
    }
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
            backgroundColor: const Color(0xFF2E7D32),
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
            backgroundColor: const Color(0xFF2E7D32),
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
    final isGerman = ref.watch(languageProvider).targetLanguage.code == 'de';
    final syncStatus = ref.watch(syncProvider);
    final user = ref.watch(authProvider).user;
    final isMobile = MediaQuery.of(context).size.width < 500;

    if (isMobile) {
      return _buildMobileDashboard(
          projectState, activeFilter, attrs, syncStatus, user, isGerman);
    }

    return CustomScrollView(
      slivers: [
        // ── All header content ────────────────────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(32, 32, 32, 12),
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
                      label: Text(isGerman ? 'AI Massen-Übersetzung' : 'AI Bulk Translation',
                          style: const TextStyle(
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
              padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 12 : 16, vertical: 12),
              borderRadius: 12,
              border: Border.all(color: attrs.brand600.withOpacity(0.3)),
              backgroundColor: attrs.brand600.withOpacity(0.08),
              child: Row(
                children: [
                  Icon(LucideIcons.clock, size: 16, color: attrs.brand600),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text.rich(
                      TextSpan(children: [
                        TextSpan(
                          text: isMobile ? '' : 'Zuletzt: ',
                          style: TextStyle(
                              color: attrs.textMuted,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                        TextSpan(
                          text: user!.lastReviewedProject!,
                          style: TextStyle(
                              color: attrs.brand600,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'monospace',
                              fontSize: 13),
                        ),
                      ]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton.icon(
                    onPressed: () =>
                        context.go('/edit/${user.lastReviewedProject}'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: attrs.brand600,
                      padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 10 : 14, vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    icon: const Icon(LucideIcons.chevronRight, size: 14),
                    label: Text(
                      isMobile ? 'Weiter' : 'Weitermachen',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 28),

          // ── Filter buttons ────────────────────────────────────────────────
          const DashboardFilters(),

          // ── "Unignore all" action bar — only shown when filter = ignored ──
          if (activeFilter == 'ignored') ...[
            const SizedBox(height: 12),
            Builder(builder: (context) {
              final isGerman =
                  ref.read(languageProvider).targetLanguage.code == 'de';
              final attrs2 = AppTheme.getAttributes(themeState.themeId);
              return Row(
                children: [
                  OutlinedButton.icon(
                    onPressed: _unignoringAll
                        ? null
                        : () => _handleUnignoreAll(isGerman),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      side: BorderSide(color: attrs2.brand600),
                      foregroundColor: attrs2.brand600,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: _unignoringAll
                        ? SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: attrs2.brand600))
                        : const Icon(LucideIcons.eyeOff, size: 14),
                    label: Text(
                      isGerman
                          ? 'Alle wieder einreihen'
                          : 'Unignore all modules',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              );
            }),
          ],

          const SizedBox(height: 16),

          // ── Search + Sync controls row ────────────────────────────────────
          if (isMobile) ...[
            // Mobile: Suchfeld in voller Breite, Sync-Buttons darunter
            SearchWithAutocomplete(
              initialValue: ref.read(projectProvider.notifier).searchQuery,
              activeFilter: activeFilter,
              onSearchChanged: (val) =>
                  ref.read(projectProvider.notifier).setSearch(val),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Tooltip(
                    message: 'Schnelles Update (letzte 7 Tage)',
                    child: OutlinedButton.icon(
                      onPressed: syncStatus.active ? null : _handleQuickUpdate,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 13),
                        foregroundColor: attrs.textMain,
                        side: BorderSide(color: attrs.borderMain),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      icon: Icon(LucideIcons.zap,
                          size: 16, color: Colors.amber[500]),
                      label: const Text('Schnell',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Tooltip(
                    message: 'Vollständiger Datenbank-Sync von Drupal.org',
                    child: ElevatedButton.icon(
                      onPressed: syncStatus.active ? null : _handleFullSync,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 13),
                        backgroundColor: attrs.brand600,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      icon: syncStatus.active
                          ? const SizedBox(
                              width: 14,
                              height: 14,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white),
                            )
                          : const Icon(LucideIcons.refreshCw, size: 14),
                      label: const Text('Sync',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Tooltip(
                  message: 'Einzelnes Modul manuell von Drupal.org laden',
                  child: OutlinedButton(
                    onPressed: () =>
                        setState(() => _showManualAdd = !_showManualAdd),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 13),
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
                    child: AnimatedRotation(
                      turns: _showManualAdd ? 0.125 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(LucideIcons.plus,
                          size: 18,
                          color: _showManualAdd
                              ? attrs.brand600
                              : attrs.textMuted),
                    ),
                  ),
                ),
              ],
            ),
          ] else ...[
            // Desktop: Alles in einer Zeile
            Row(
              children: [
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
          ],

          const SizedBox(height: 8),

          // ── Count + Per-page row ──────────────────────────────────────────
          Wrap(
            spacing: 12,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: attrs.bgCard,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: attrs.borderMain),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
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
              padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 14 : 20, vertical: 16),
              decoration: BoxDecoration(
                color: attrs.bgCard,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: attrs.borderMain),
              ),
              child: isMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(children: [
                          Icon(LucideIcons.download,
                              size: 18, color: attrs.brand600),
                          const SizedBox(width: 10),
                          Text('Modul manuell hinzufügen',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: attrs.textMain)),
                        ]),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _manualNameController,
                          style:
                              TextStyle(color: attrs.textMain, fontSize: 13),
                          onSubmitted: (_) => _handleManualSync(),
                          decoration: InputDecoration(
                            hintText: 'machine_name (z. B. pathauto)',
                            hintStyle: TextStyle(
                                color: attrs.textMuted.withOpacity(0.8),
                                fontSize: 13),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 12),
                            filled: true,
                            fillColor: attrs.bgInput,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: attrs.borderMain),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: attrs.borderMain),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: attrs.brand600, width: 2),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton.icon(
                          onPressed:
                              _syncingManual ? null : _handleManualSync,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: attrs.brand600,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 13),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          icon: _syncingManual
                              ? const SizedBox(
                                  width: 14,
                                  height: 14,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white),
                                )
                              : const Icon(LucideIcons.plus, size: 15),
                          label: const Text('Hinzufügen',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Icon(LucideIcons.download,
                            size: 18, color: attrs.brand600),
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
                              Text(
                                  'Direkt von Drupal.org per Machine Name laden.',
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: attrs.textMuted)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        SizedBox(
                          width: 240,
                          height: 42,
                          child: TextField(
                            controller: _manualNameController,
                            style: TextStyle(
                                color: attrs.textMain, fontSize: 13),
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
                                borderSide:
                                    BorderSide(color: attrs.borderMain),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: attrs.borderMain),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: attrs.brand600, width: 2),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton.icon(
                          onPressed:
                              _syncingManual ? null : _handleManualSync,
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
                                      strokeWidth: 2,
                                      color: Colors.white),
                                )
                              : const Icon(LucideIcons.plus, size: 15),
                          label: const Text('Hinzufügen',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                      ],
                    ),
            ),
          ],

              ],
            ),
          ),
        ),

        // ── Project grid ──────────────────────────────────────────────────
        if (projectState.isLoading)
          SliverFillRemaining(
            child: Center(child: CircularProgressIndicator(color: attrs.brand600)),
          )
        else if (projectState.error != null)
          SliverFillRemaining(
            child: Center(
                child: Text(projectState.error!,
                    style: const TextStyle(color: Colors.redAccent))),
          )
        else if (projectState.projects.isEmpty)
          SliverFillRemaining(
            child: Center(
                child: Text('Keine Projekte gefunden.',
                    style: TextStyle(color: attrs.textMuted))),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            sliver: SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 420,
                childAspectRatio: 0.78,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
              ),
              itemCount: projectState.projects.length,
              itemBuilder: (context, index) => ProjectCard(
                project: projectState.projects[index],
                attrs: attrs,
                filter: activeFilter,
                search: ref.read(projectProvider.notifier).searchQuery,
              ),
            ),
          ),

        // ── Pagination ────────────────────────────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
            child: !projectState.isLoading &&
                    projectState.totalItems >
                        ref.watch(projectProvider.notifier).limit
                ? Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(LucideIcons.chevronsLeft,
                              color: Colors.white),
                          onPressed:
                              ref.watch(projectProvider.notifier).currentPage >
                                      1
                                  ? () => ref
                                      .read(projectProvider.notifier)
                                      .goToPage(1)
                                  : null,
                          tooltip: 'Erste Seite',
                        ),
                        IconButton(
                          icon: const Icon(LucideIcons.chevronLeft,
                              color: Colors.white),
                          onPressed:
                              ref.watch(projectProvider.notifier).currentPage >
                                      1
                                  ? () => ref
                                      .read(projectProvider.notifier)
                                      .prevPage()
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
                          onPressed: ref
                                      .watch(projectProvider.notifier)
                                      .currentPage <
                                  (projectState.totalItems /
                                          ref
                                              .watch(projectProvider.notifier)
                                              .limit)
                                      .ceil()
                              ? () => ref
                                  .read(projectProvider.notifier)
                                  .nextPage()
                              : null,
                          tooltip: 'Nächste Seite',
                        ),
                        IconButton(
                          icon: const Icon(LucideIcons.chevronsRight,
                              color: Colors.white),
                          onPressed: ref
                                      .watch(projectProvider.notifier)
                                      .currentPage <
                                  (projectState.totalItems /
                                          ref
                                              .watch(projectProvider.notifier)
                                              .limit)
                                      .ceil()
                              ? () => ref.read(projectProvider.notifier).goToPage(
                                  (projectState.totalItems /
                                          ref
                                              .watch(projectProvider.notifier)
                                              .limit)
                                      .ceil())
                              : null,
                          tooltip: 'Letzte Seite',
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }

  // ──────────────────────────────── Mobile Dashboard ──────────────────────

  /// Vollständig scrollbare Dashboard-Ansicht für schmale Displays (< 500dp).
  /// Verwendet SingleChildScrollView + shrinkWrap GridView statt Expanded.
  Widget _buildMobileDashboard(
    ProjectState projectState,
    String activeFilter,
    ThemeAttributes attrs,
    SyncStatus syncStatus,
    dynamic user,
    bool isGerman,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ─────────────────────────────────────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: attrs.brand600,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(LucideIcons.droplets,
                    color: Colors.white, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Projekt-Beschreibungen',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: attrs.textMain,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Text(
                      'Übersetzung von Drupal Modulen.',
                      style:
                          TextStyle(fontSize: 12, color: attrs.textMuted),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // AI-Button (wenn nicht review/released/translated)
          if (activeFilter != 'review' &&
              activeFilter != 'released' &&
              activeFilter != 'translated') ...[
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _showBulkTranslateDialog(
                    context, ref, activeFilter, attrs),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: attrs.brand600,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                icon: const Icon(LucideIcons.sparkles, size: 16),
                label: Text(isGerman ? 'AI Massen-Übersetzung' : 'AI Bulk Translation',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 13)),
              ),
            ),
          ],

          // Last reviewed banner
          if (user?.lastReviewedProject != null) ...[
            const SizedBox(height: 10),
            GlassContainer(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              borderRadius: 12,
              border:
                  Border.all(color: attrs.brand600.withOpacity(0.3)),
              backgroundColor: attrs.brand600.withOpacity(0.08),
              child: Row(children: [
                Icon(LucideIcons.clock, size: 14, color: attrs.brand600),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    user!.lastReviewedProject!,
                    style: TextStyle(
                        color: attrs.brand600,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'monospace',
                        fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: () =>
                      context.go('/edit/${user.lastReviewedProject}'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: attrs.brand600,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  icon: const Icon(LucideIcons.chevronRight, size: 13),
                  label: const Text('Weiter',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 11)),
                ),
              ]),
            ),
          ],

          const SizedBox(height: 14),

          // ── Filter buttons (Wrap, already responsive) ───────────────
          const DashboardFilters(),
          const SizedBox(height: 12),

          // ── Search ─────────────────────────────────────────────────
          SearchWithAutocomplete(
            initialValue:
                ref.read(projectProvider.notifier).searchQuery,
            activeFilter: activeFilter,
            onSearchChanged: (val) =>
                ref.read(projectProvider.notifier).setSearch(val),
          ),
          const SizedBox(height: 8),

          // ── Sync buttons ───────────────────────────────────────────
          Row(children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: syncStatus.active ? null : _handleQuickUpdate,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 12),
                  foregroundColor: attrs.textMain,
                  side: BorderSide(color: attrs.borderMain),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                icon: Icon(LucideIcons.zap,
                    size: 15, color: Colors.amber[500]),
                label: const Text('Schnell',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 12)),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: syncStatus.active ? null : _handleFullSync,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 12),
                  backgroundColor: attrs.brand600,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                icon: syncStatus.active
                    ? const SizedBox(
                        width: 14,
                        height: 14,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white))
                    : const Icon(LucideIcons.refreshCw, size: 14),
                label: const Text('Sync',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 12)),
              ),
            ),
            const SizedBox(width: 8),
            OutlinedButton(
              onPressed: () =>
                  setState(() => _showManualAdd = !_showManualAdd),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 12),
                foregroundColor: _showManualAdd
                    ? attrs.brand600
                    : attrs.textMain,
                side: BorderSide(
                    color: _showManualAdd
                        ? attrs.brand600
                        : attrs.borderMain),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                backgroundColor: _showManualAdd
                    ? attrs.brand600.withOpacity(0.2)
                    : Colors.transparent,
              ),
              child: AnimatedRotation(
                turns: _showManualAdd ? 0.125 : 0,
                duration: const Duration(milliseconds: 200),
                child: Icon(LucideIcons.plus,
                    size: 18,
                    color: _showManualAdd
                        ? attrs.brand600
                        : attrs.textMuted),
              ),
            ),
          ]),

          const SizedBox(height: 8),

          // ── Count + per-page ───────────────────────────────────────
          Row(children: [
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: attrs.bgCard,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: attrs.borderMain),
              ),
              child: Row(children: [
                Text('Gefunden: ',
                    style: TextStyle(
                        color: attrs.textMuted,
                        fontWeight: FontWeight.bold,
                        fontSize: 12)),
                Text('${projectState.totalItems}',
                    style: TextStyle(
                        color: attrs.brand600,
                        fontWeight: FontWeight.w900,
                        fontSize: 14)),
                Text(' Module',
                    style: TextStyle(
                        color: attrs.textMuted,
                        fontWeight: FontWeight.bold,
                        fontSize: 12)),
              ]),
            ),
            const SizedBox(width: 10),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
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
                      color: attrs.textMuted, size: 14),
                  onChanged: (val) {
                    if (val != null) {
                      ref
                          .read(projectProvider.notifier)
                          .setLimit(val);
                    }
                  },
                  items: [50, 100, 250, 500].map((v) {
                    return DropdownMenuItem<int>(
                      value: v,
                      child: Text('$v / Seite',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12)),
                    );
                  }).toList(),
                ),
              ),
            ),
          ]),

          const SizedBox(height: 8),
          const SyncProgressBar(),

          // ── Manual module add ──────────────────────────────────────
          if (_showManualAdd) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: attrs.bgCard,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: attrs.borderMain),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(children: [
                    Icon(LucideIcons.download,
                        size: 16, color: attrs.brand600),
                    const SizedBox(width: 8),
                    Text('Modul hinzufügen',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: attrs.textMain)),
                  ]),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _manualNameController,
                    style: TextStyle(
                        color: attrs.textMain, fontSize: 13),
                    onSubmitted: (_) => _handleManualSync(),
                    decoration: InputDecoration(
                      hintText: 'machine_name (z. B. pathauto)',
                      hintStyle: TextStyle(
                          color: attrs.textMuted.withOpacity(0.8),
                          fontSize: 13),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 12),
                      filled: true,
                      fillColor: attrs.bgInput,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: attrs.borderMain),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: attrs.borderMain),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: attrs.brand600, width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed:
                        _syncingManual ? null : _handleManualSync,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: attrs.brand600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 13),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: _syncingManual
                        ? const SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white))
                        : const Icon(LucideIcons.plus, size: 15),
                    label: const Text('Hinzufügen',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13)),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 12),

          // ── Project grid (shrinkWrap — scrolled by outer SCV) ──────
          if (projectState.isLoading)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Center(
                  child: CircularProgressIndicator(
                      color: attrs.brand600)),
            )
          else if (projectState.error != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                  child: Text(projectState.error!,
                      style:
                          const TextStyle(color: Colors.redAccent))),
            )
          else if (projectState.projects.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Center(
                  child: Text('Keine Projekte gefunden.',
                      style:
                          TextStyle(color: attrs.textMuted))),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate:
                  const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 420,
                childAspectRatio: 0.82,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: projectState.projects.length,
              itemBuilder: (context, index) => ProjectCard(
                project: projectState.projects[index],
                attrs: attrs,
                filter: activeFilter,
                search:
                    ref.read(projectProvider.notifier).searchQuery,
              ),
            ),

          // ── Pagination ─────────────────────────────────────────────
          if (!projectState.isLoading &&
              projectState.totalItems >
                  ref.watch(projectProvider.notifier).limit) ...[
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(LucideIcons.chevronsLeft,
                      color: Colors.white, size: 20),
                  onPressed:
                      ref.watch(projectProvider.notifier).currentPage >
                              1
                          ? () => ref
                              .read(projectProvider.notifier)
                              .goToPage(1)
                          : null,
                ),
                IconButton(
                  icon: const Icon(LucideIcons.chevronLeft,
                      color: Colors.white, size: 20),
                  onPressed:
                      ref.watch(projectProvider.notifier).currentPage >
                              1
                          ? () => ref
                              .read(projectProvider.notifier)
                              .prevPage()
                          : null,
                ),
                const SizedBox(width: 8),
                Text(
                  '${ref.watch(projectProvider.notifier).currentPage} / '
                  '${(projectState.totalItems / ref.watch(projectProvider.notifier).limit).ceil()}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(LucideIcons.chevronRight,
                      color: Colors.white, size: 20),
                  onPressed: ref
                              .watch(projectProvider.notifier)
                              .currentPage <
                          (projectState.totalItems /
                                  ref
                                      .watch(projectProvider.notifier)
                                      .limit)
                              .ceil()
                      ? () => ref
                          .read(projectProvider.notifier)
                          .nextPage()
                      : null,
                ),
                IconButton(
                  icon: const Icon(LucideIcons.chevronsRight,
                      color: Colors.white, size: 20),
                  onPressed: ref
                              .watch(projectProvider.notifier)
                              .currentPage <
                          (projectState.totalItems /
                                  ref
                                      .watch(projectProvider.notifier)
                                      .limit)
                              .ceil()
                      ? () => ref
                          .read(projectProvider.notifier)
                          .goToPage((projectState.totalItems /
                                  ref
                                      .watch(projectProvider.notifier)
                                      .limit)
                              .ceil())
                      : null,
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
    // Stale filter gets its own specialised flow — fetch all stale names first.
    if (activeFilter == 'stale') {
      _showStaleBulkTranslateDialog(context, ref, attrs);
      return;
    }

    final langcode    = ref.read(languageProvider).targetLanguage.code;
    final isGerman    = langcode == 'de';
    final coreVersion = ref.read(projectProvider).coreVersion;

    int selectedCount = 25;
    bool prioritizeDrupal11 = true;

    String filterName;
    switch (activeFilter) {
      case 'all':
        filterName = isGerman ? 'Alle Projekte' : 'All Projects';
        break;
      case 'priority':
        filterName = 'Drupal 11';
        break;
      case 'missing':
        filterName = isGerman ? 'Fehlende Übersetzungen' : 'Missing Translations';
        break;
      case 'review':
        filterName = isGerman ? 'Review-Warteschlange' : 'Review Queue';
        break;
      case 'translated':
        filterName = isGerman ? 'Übersetzte Projekte' : 'Translated Projects';
        break;
      case 'released':
        filterName = isGerman ? 'Freigegebene Projekte' : 'Released Projects';
        break;
      default:
        filterName = activeFilter;
    }
    if (coreVersion != null) filterName += ' · D$coreVersion';

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
                        Expanded(
                          child: Text(
                            isGerman ? 'AI Massen-Übersetzung' : 'AI Bulk Translation',
                            style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      isGerman
                          ? 'Übersetze mehrere Module aus dem ausgewählten Filter automatisch mit Google Gemini.'
                          : 'Automatically translate multiple modules from the selected filter using Google Gemini.',
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
                              Text(isGerman ? 'Aktiver Filter' : 'Active Filter',
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
                                child: Tooltip(
                                  message: filterName,
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
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ],
                                  ),
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
                              Text(isGerman ? 'Anzahl Module' : 'Module Count',
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
                                    Text(
                                        isGerman ? 'Drupal 11 Module priorisieren' : 'Prioritise Drupal 11 modules',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            color: Colors.white)),
                                    const SizedBox(height: 2),
                                    Text(
                                      isGerman
                                          ? 'Übersetzt bevorzugt Drupal 11 kompatible Module zuerst'
                                          : 'Translates Drupal 11 compatible modules first',
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
                          _buildCostRow(isGerman ? 'Modell' : 'Model', 'Gemini 3.1 Flash-Lite', attrs),
                          Divider(color: attrs.borderMain, height: 24),
                          _buildCostRow(isGerman ? 'Module gesamt' : 'Total modules', '$selectedCount', attrs),
                          _buildCostRow(isGerman ? 'Eingabe-Tokens (Schätzung)' : 'Input tokens (est.)', '$estInputTokens', attrs),
                          _buildCostRow(isGerman ? 'Ausgabe-Tokens (Schätzung)' : 'Output tokens (est.)', '$estOutputTokens', attrs),
                          Divider(color: attrs.borderMain, height: 24),
                          _buildCostRow(isGerman ? 'Preis pro 1M Input' : 'Price per 1M input', '\$0.25', attrs, isValueColorMuted: true),
                          _buildCostRow(isGerman ? 'Preis pro 1M Output' : 'Price per 1M output', '\$1.50', attrs, isValueColorMuted: true),
                          Divider(color: attrs.borderMain, height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(isGerman ? 'Geschätzte Gesamtkosten' : 'Estimated total cost',
                                  style: const TextStyle(
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
                      isGerman
                          ? '* Die Übersetzung wird in ressourcenschonenden Batches ausgeführt, um Timeouts zu verhindern.'
                          : '* Translation is executed in resource-efficient batches to prevent timeouts.',
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
                          child: Text(isGerman ? 'Abbrechen' : 'Cancel',
                              style: const TextStyle(fontWeight: FontWeight.bold)),
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
                          child: Text(isGerman ? 'Massen-Übersetzung starten' : 'Start Bulk Translation',
                              style: const TextStyle(fontWeight: FontWeight.bold)),
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
          context, ref, activeFilter, selectedCount, prioritizeDrupal11, attrs,
          coreVersion: coreVersion, isGerman: isGerman);
    }
  }

  // ── Stale-spezifischer Bulk-Dialog ──────────────────────────────────────────
  void _showStaleBulkTranslateDialog(
    BuildContext context,
    WidgetRef ref,
    ThemeAttributes attrs,
  ) async {
    final ApiClient api = ApiClient();
    final langcode = ref.read(languageProvider).targetLanguage.code;
    final isGerman = langcode == 'de';

    // Fetch all stale machine names before showing the dialog.
    List<String> staleMachineNames = [];
    String? fetchError;
    try {
      final res = await api.dio.get(
        '/ai/stale-machine-names',
        queryParameters: {'langcode': langcode},
      );
      staleMachineNames = List<String>.from(res.data['machineNames'] as List);
    } catch (e) {
      fetchError = e.toString();
    }

    if (!context.mounted) return;

    if (fetchError != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(isGerman
            ? 'Fehler beim Laden der veralteten Module: $fetchError'
            : 'Error loading outdated modules: $fetchError'),
        backgroundColor: Colors.redAccent,
      ));
      return;
    }

    if (staleMachineNames.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(isGerman
            ? 'Keine veralteten Module gefunden — alles aktuell! ✨'
            : 'No outdated modules found — everything is up to date! ✨'),
        backgroundColor: const Color(0xFF2E7D32),
      ));
      return;
    }

    final count = staleMachineNames.length;
    final estInputTokens = count * 500;
    final estOutputTokens = count * 300;
    final estTotalCost =
        (estInputTokens * 0.00000025) + (estOutputTokens * 0.00000150);

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => Dialog(
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
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(LucideIcons.refreshCw,
                        color: Colors.orange, size: 24),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      isGerman ? 'Veraltete Module neu übersetzen' : 'Re-translate Outdated Modules',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                isGerman
                    ? 'Alle Übersetzungen, deren englische Quelle sich seit der letzten Übersetzung geändert hat, werden automatisch mit Google Gemini neu übersetzt. Kein manuelles Öffnen jedes Moduls nötig.'
                    : 'All translations whose English source has changed since the last translation will be automatically re-translated using Google Gemini. No need to open each module manually.',
                style: TextStyle(
                    color: attrs.textMuted.withOpacity(0.8),
                    fontSize: 14,
                    height: 1.5),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.orange.withOpacity(0.3)),
                ),
                child: Column(
                  children: [
                    _buildCostRow(isGerman ? 'Modell' : 'Model', 'Gemini 3.1 Flash-Lite', attrs),
                    Divider(color: attrs.borderMain, height: 24),
                    _buildCostRow(
                        isGerman ? 'Veraltete Module' : 'Outdated modules', '$count', attrs),
                    _buildCostRow(isGerman ? 'Eingabe-Tokens (Schätzung)' : 'Input tokens (est.)',
                        '$estInputTokens', attrs),
                    _buildCostRow(isGerman ? 'Ausgabe-Tokens (Schätzung)' : 'Output tokens (est.)',
                        '$estOutputTokens', attrs),
                    Divider(color: attrs.borderMain, height: 24),
                    _buildCostRow(isGerman ? 'Preis pro 1M Input' : 'Price per 1M input', '\$0.25', attrs,
                        isValueColorMuted: true),
                    _buildCostRow(isGerman ? 'Preis pro 1M Output' : 'Price per 1M output', '\$1.50', attrs,
                        isValueColorMuted: true),
                    Divider(color: attrs.borderMain, height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(isGerman ? 'Geschätzte Gesamtkosten' : 'Estimated total cost',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.white)),
                        Text(
                          '\$${estTotalCost.toStringAsFixed(4)} USD',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.orange),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                isGerman
                    ? '* Die Übersetzung ersetzt den bisherigen Text und setzt is_reviewed zurück. Ausführung in Batches à 4 Modulen.'
                    : '* Translation replaces existing text and resets is_reviewed. Executed in batches of 4 modules.',
                style: TextStyle(
                    fontSize: 11,
                    color: attrs.textMuted,
                    fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
                        foregroundColor: attrs.textMuted),
                    child: Text(isGerman ? 'Abbrechen' : 'Cancel',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.of(context).pop(true),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: const Icon(LucideIcons.refreshCw, size: 16),
                    label: Text(
                        isGerman ? 'Alle $count Module neu übersetzen' : 'Re-translate all $count modules',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    if (confirmed == true && context.mounted) {
      _executeBulkTranslationWithNames(
          context, ref, staleMachineNames, attrs,
          isGerman: isGerman,
          title: isGerman ? 'Veraltete Module werden neu übersetzt…' : 'Re-translating outdated modules…');
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
    ThemeAttributes attrs, {
    int? coreVersion,
    bool isGerman = true,
  }) async {
    final ApiClient api = ApiClient();
    final langcode = ref.read(languageProvider).targetLanguage.code;

    final progressNotifier =
        ValueNotifier<Map<String, dynamic>>({
      'status': isGerman ? 'Projekte werden vom Server abgerufen…' : 'Fetching projects from server…',
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
                        Text(isGerman ? 'AI Massen-Übersetzung' : 'AI Bulk Translation',
                            style: const TextStyle(
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
          if (coreVersion != null) 'core_version': coreVersion,
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
            SnackBar(
              content: Text(isGerman
                  ? 'Keine übersetzbaren Projekte in diesem Filter gefunden.'
                  : 'No translatable projects found for this filter.'),
              backgroundColor: Colors.amber,
            ),
          );
        }
        return;
      }

      progressNotifier.value = {
        'status': isGerman ? 'Übersetzung wird gestartet…' : 'Starting translation…',
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
          'status': isGerman
              ? 'Übersetze Modul ${i + 1}–$end von $totalCount …'
              : 'Translating module ${i + 1}–$end of $totalCount …',
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
          'status': isGerman
              ? '$end von $totalCount Modulen abgeschlossen.'
              : '$end of $totalCount modules completed.',
          'progress': end / totalCount,
          'processed': end,
          'total': totalCount,
        };

        await Future.delayed(const Duration(milliseconds: 400));
      }

      progressNotifier.value = {
        'status': isGerman ? 'Übersetzung erfolgreich abgeschlossen! ✨' : 'Translation completed successfully! ✨',
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
            content: Text(isGerman
                ? 'Massen-Übersetzung von $totalCount Modulen erfolgreich! ✨'
                : 'Bulk translation of $totalCount modules successful! ✨'),
            backgroundColor: const Color(0xFF2E7D32),
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
            content: Text(isGerman ? 'Fehler bei der Massen-Übersetzung: $e' : 'Bulk translation error: $e'),
            backgroundColor: Colors.redAccent,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }

  // ── Bulk-Übersetzung mit expliziter Machine-Name-Liste (für Stale) ──────────
  void _executeBulkTranslationWithNames(
    BuildContext context,
    WidgetRef ref,
    List<String> machineNames,
    ThemeAttributes attrs, {
    String title = 'AI Bulk Translation',
    bool isGerman = true,
  }) async {
    final ApiClient api = ApiClient();
    final langcode = ref.read(languageProvider).targetLanguage.code;
    final totalCount = machineNames.length;

    final progressNotifier = ValueNotifier<Map<String, dynamic>>({
      'status': isGerman ? 'Übersetzung wird gestartet…' : 'Starting translation…',
      'progress': 0.0,
      'processed': 0,
      'total': totalCount,
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
              final total = data['total'] as int;

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
                        const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.orange),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(title,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
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
                      color: Colors.orange,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          isGerman
                              ? '$processedCount von $total Modulen verarbeitet'
                              : '$processedCount of $total modules processed',
                          style: TextStyle(
                              color: attrs.textMuted, fontSize: 12),
                        ),
                        Text(
                          '${(progress * 100).toInt()} %',
                          style: const TextStyle(
                              color: Colors.orange,
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
      const batchSize = 4;
      for (int i = 0; i < totalCount; i += batchSize) {
        final end = i + batchSize > totalCount ? totalCount : i + batchSize;
        final batch = machineNames.sublist(i, end);

        progressNotifier.value = {
          'status': isGerman
              ? 'Übersetze Modul ${i + 1}–$end von $totalCount …'
              : 'Translating module ${i + 1}–$end of $totalCount …',
          'progress': i / totalCount,
          'processed': i,
          'total': totalCount,
        };

        await api.dio.post(
          '/ai/translate-bulk',
          data: {'machineNames': batch, 'langcode': langcode},
          options: Options(receiveTimeout: const Duration(minutes: 10)),
        );

        progressNotifier.value = {
          'status': isGerman
              ? '$end von $totalCount Modulen abgeschlossen.'
              : '$end of $totalCount modules completed.',
          'progress': end / totalCount,
          'processed': end,
          'total': totalCount,
        };

        await Future.delayed(const Duration(milliseconds: 400));
      }

      progressNotifier.value = {
        'status': isGerman
            ? 'Alle $totalCount Module erfolgreich neu übersetzt! ✨'
            : 'All $totalCount modules successfully re-translated! ✨',
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
        ref.read(projectProvider.notifier).setFilter('stale', force: true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isGerman
                ? '$totalCount veraltete Module erfolgreich neu übersetzt! ✨'
                : '$totalCount outdated modules successfully re-translated! ✨'),
            backgroundColor: const Color(0xFF2E7D32),
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
            content: Text(isGerman
                ? 'Fehler bei der Stale-Übersetzung: $e'
                : 'Error during re-translation: $e'),
            backgroundColor: Colors.redAccent,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }
}
