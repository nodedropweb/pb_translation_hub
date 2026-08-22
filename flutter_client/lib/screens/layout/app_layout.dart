import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import '../../providers/theme_provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/language_provider.dart';
import '../../theme/app_theme.dart';
import '../../services/api_client.dart';
import '../../services/token_storage.dart';
import '../../widgets/glass_container.dart';
import '../../utils/ck_glossary.dart';
import '../../l10n/app_localizations.dart';

// ── Breakpoint ────────────────────────────────────────────────────────────────
// Unter 750 dp (Portrait-Modus des M986-EEA ~600–800 dp) wechselt das Layout
// von der dauerhaft sichtbaren Sidebar zu einem Hamburger + Drawer.
const double _kSidebarBreakpoint = 750.0;

class AppLayout extends ConsumerWidget {
  final Widget child;

  const AppLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final authState = ref.watch(authProvider);
    final langState = ref.watch(languageProvider);

    final attrs = AppTheme.getAttributes(themeState.themeId);

    // CKEditor-Tooltip und Glossar-Highlight ans aktive Theme anpassen
    setCkEditorTheme(themeState.themeId);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= _kSidebarBreakpoint;

        // ── Hintergrundbild (mit Cache) ──────────────────────────────────────
        final Widget background = themeState.bgImageUrl != null
            ? RepaintBoundary(
                child: CachedNetworkImage(
                  imageUrl: themeState.bgImageUrl!,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, err) =>
                      Container(color: const Color(0xFF0F1114)),
                ),
              )
            : Container(color: const Color(0xFF0F1114));

        // ── Sidebar-Inhalt (shared zwischen Wide-Layout und Drawer) ──────────
        final Widget sidebarContent = _SidebarContent(
          attrs: attrs,
          themeState: themeState,
          authState: authState,
          langState: langState,
          ref: ref,
        );

        return Scaffold(
          // Im schmalen Modus (Portrait) öffnet der Hamburger-Button diesen Drawer.
          drawer: isWide
              ? null
              : Drawer(
                  backgroundColor: Colors.transparent,
                  width: 300,
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: attrs.glassBlur,
                        sigmaY: attrs.glassBlur,
                      ),
                      child: Container(
                        color: attrs.bgSidebar,
                        child: sidebarContent,
                      ),
                    ),
                  ),
                ),

          body: Stack(
            children: [
              // 1. Hintergrundbild
              Positioned.fill(child: background),

              // 2. Dunkel-Overlay
              Positioned.fill(
                child: Container(color: attrs.overlayColor),
              ),

              // 3. Haupt-Layout
              Positioned.fill(
                child: Column(
                  children: [
                    // Schmaler Modus: Glassmorphism Top-Bar mit Hamburger
                    if (!isWide)
                      _NarrowTopBar(
                        attrs: attrs,
                        authState: authState,
                      ),

                    // Inhalt: Sidebar (nur Wide) + Content
                    Expanded(
                      child: Row(
                        children: [
                          // Breiter Modus: Sidebar dauerhaft sichtbar
                          if (isWide)
                            ClipRRect(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: attrs.glassBlur,
                                  sigmaY: attrs.glassBlur,
                                ),
                                child: Container(
                                  width: 280,
                                  decoration: BoxDecoration(
                                    color: attrs.bgSidebar,
                                    border: Border(
                                      right:
                                          BorderSide(color: attrs.borderMain),
                                    ),
                                  ),
                                  child: sidebarContent,
                                ),
                              ),
                            ),

                          // Content-Bereich
                          Expanded(
                            child: ClipRRect(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: attrs.glassBlur,
                                  sigmaY: attrs.glassBlur,
                                ),
                                child: Container(
                                  color: Colors.transparent,
                                  child: child,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ── Schmale Top-Bar (Portrait-Modus) ─────────────────────────────────────────

class _NarrowTopBar extends StatelessWidget {
  final ThemeAttributes attrs;
  final AuthState authState;

  const _NarrowTopBar({
    required this.attrs,
    required this.authState,
  });

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final l10n = AppLocalizations.of(context)!;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          height: 56 + topPadding,
          padding: EdgeInsets.only(top: topPadding),
          decoration: BoxDecoration(
            color: attrs.bgSidebar,
            border: Border(bottom: BorderSide(color: attrs.borderMain)),
          ),
          child: Row(
            children: [
              // Hamburger — öffnet den Drawer
              Builder(
                builder: (ctx) => IconButton(
                  icon: Icon(LucideIcons.menu, color: attrs.textMain, size: 22),
                  tooltip: l10n.layoutMenu,
                  onPressed: () => Scaffold.of(ctx).openDrawer(),
                ),
              ),

              // Mini-Logo
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 34,
                  height: 34,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),

              // App-Titel
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PROJECT BROWSER',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 10,
                        letterSpacing: 0.5,
                        color: attrs.textMain,
                      ),
                    ),
                    Text(
                      'TRANSLATION SUITE',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 8,
                        color: attrs.brand600,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),

              // User-Avatar (führt zu /profile)
              if (authState.user != null)
                GestureDetector(
                  onTap: () => context.go('/profile'),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: CircleAvatar(
                      radius: 17,
                      backgroundColor: attrs.brand600.withOpacity(0.2),
                      backgroundImage: authState.user!.avatarUrl != null
                          ? CachedNetworkImageProvider(
                              ApiClient.serverOrigin +
                                  authState.user!.avatarUrl!,
                            )
                          : null,
                      child: authState.user!.avatarUrl == null
                          ? Text(
                              (authState.user!.name ??
                                      authState.user!.username)
                                  .substring(0, 1)
                                  .toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            )
                          : null,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Sidebar-Inhalt (wird im Wide-Modus direkt und im Narrow-Modus im Drawer gerendert) ──

class _SidebarContent extends StatelessWidget {
  final ThemeAttributes attrs;
  final ThemeState themeState;
  final AuthState authState;
  final LanguageState langState;
  final WidgetRef ref;

  const _SidebarContent({
    required this.attrs,
    required this.themeState,
    required this.authState,
    required this.langState,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Logo-Bereich ────────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: InkWell(
            onTap: () {
              context.go('/');
              // Drawer schließen, falls offen
              if (Scaffold.of(context).isDrawerOpen) {
                Navigator.of(context).pop();
              }
            },
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 44,
                    height: 44,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PROJECT BROWSER',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 11,
                          letterSpacing: 0.5,
                          color: attrs.textMain,
                        ),
                      ),
                      Text(
                        'TRANSLATION HUB',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 9,
                          color: attrs.brand600,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(color: Colors.white10, height: 1),

        // ── Navigation ──────────────────────────────────────────────────────
        Expanded(
          child: ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            children: [
              _NavItem(
                icon: LucideIcons.layoutDashboard,
                label: 'Dashboard',
                route: '/',
                isActive:
                    GoRouterState.of(context).uri.path == '/',
                attrs: attrs,
              ),
              _NavItem(
                icon: LucideIcons.chartColumnBig,
                label: l10n.layoutNavAnalytics,
                route: '/analytics',
                isActive:
                    GoRouterState.of(context).uri.path == '/analytics',
                attrs: attrs,
              ),
              if (ref.watch(authProvider).user?.isReviewer == true) ...[
                _NavItem(
                  icon: LucideIcons.shieldCheck,
                  label: l10n.layoutNavReviewQueue,
                  route: '/review-list',
                  isActive: GoRouterState.of(context).uri.path ==
                      '/review-list',
                  attrs: attrs,
                ),
                _NavItem(
                  icon: LucideIcons.bookOpen,
                  label: l10n.layoutNavGlossary,
                  route: '/glossary',
                  isActive: GoRouterState.of(context).uri.path == '/glossary',
                  attrs: attrs,
                ),
              ],
              _NavItem(
                icon: LucideIcons.filter,
                label: l10n.layoutNavCategories,
                route: '/categories',
                isActive: GoRouterState.of(context).uri.path ==
                    '/categories',
                attrs: attrs,
              ),
              _NavItem(
                icon: LucideIcons.helpCircle,
                label: l10n.layoutNavHelp,
                route: '/help',
                isActive:
                    GoRouterState.of(context).uri.path == '/help',
                attrs: attrs,
              ),
              _NavItem(
                icon: LucideIcons.settings,
                label: l10n.layoutNavSettings,
                route: '/settings',
                isActive: GoRouterState.of(context).uri.path ==
                    '/settings',
                attrs: attrs,
              ),
            ],
          ),
        ),

        // ── Unsplash-Attribution ────────────────────────────────────────────
        if (themeState.bgImageUrl != null &&
            themeState.photographer != null) ...[
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: Colors.white.withOpacity(0.1)),
              ),
              child: Row(
                children: [
                  Icon(LucideIcons.camera,
                      size: 12, color: attrs.brand600),
                  const SizedBox(width: 8),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: attrs.textMuted,
                          fontSize: 10,
                          fontFamily: 'Inter',
                        ),
                        children: [
                          TextSpan(
                              text: l10n.layoutPhotoBy),
                          WidgetSpan(
                            alignment:
                                PlaceholderAlignment.middle,
                            child: MouseRegion(
                              cursor:
                                  SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  final link =
                                      themeState.photographer![
                                              'link'] ??
                                          '';
                                  final fullLink = link.contains(
                                          'utm_source')
                                      ? link
                                      : '$link${link.contains('?') ? '&' : '?'}utm_source=pb_translation_hub&utm_medium=referral';
                                  TokenStorage.openUrl(
                                      fullLink);
                                },
                                child: Text(
                                  themeState.photographer![
                                          'name'] ??
                                      '',
                                  style: TextStyle(
                                    color: attrs.textMain,
                                    fontWeight:
                                        FontWeight.bold,
                                    decoration: TextDecoration
                                        .underline,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TextSpan(
                              text: l10n.layoutPhotoOn),
                          WidgetSpan(
                            alignment:
                                PlaceholderAlignment.middle,
                            child: MouseRegion(
                              cursor:
                                  SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  TokenStorage.openUrl(
                                      'https://unsplash.com/?utm_source=pb_translation_hub&utm_medium=referral');
                                },
                                child: Text(
                                  'Unsplash',
                                  style: TextStyle(
                                    color: attrs.textMain,
                                    fontWeight:
                                        FontWeight.bold,
                                    decoration: TextDecoration
                                        .underline,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],

        // ── DeepL Usage ─────────────────────────────────────────────────────
        if (authState.user?.deeplApiKey != null) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: _DeeplUsageWidget(attrs: attrs),
          ),
          const SizedBox(height: 8),
        ],

        // ── Benutzer-Karte ──────────────────────────────────────────────────
        if (authState.user != null) ...[
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 20.0, vertical: 4.0),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  context.go('/profile');
                  if (Scaffold.of(context).isDrawerOpen) {
                    Navigator.of(context).pop();
                  }
                },
                child: GlassContainer(
                  padding: const EdgeInsets.all(10),
                  borderRadius: 12,
                  border: Border.all(color: attrs.borderMain),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor:
                            attrs.brand600.withOpacity(0.2),
                        // ✅ Fix: ApiClient.serverOrigin statt http://localhost:9901
                        backgroundImage:
                            authState.user!.avatarUrl != null
                                ? CachedNetworkImageProvider(
                                    ApiClient.serverOrigin +
                                        authState.user!.avatarUrl!,
                                  )
                                : null,
                        child:
                            authState.user!.avatarUrl == null
                                ? Text(
                                    (authState.user!.name ??
                                            authState
                                                .user!.username)
                                        .substring(0, 1)
                                        .toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight:
                                          FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  )
                                : null,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              authState.user!.name ??
                                  authState.user!.username,
                              style: TextStyle(
                                color: attrs.textMain,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              l10n.layoutEditProfile,
                              style: TextStyle(
                                color: attrs.textMuted,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(LucideIcons.logOut,
                            size: 14),
                        color: attrs.textMuted,
                        hoverColor:
                            Colors.redAccent.withOpacity(0.15),
                        onPressed: () {
                          ref
                              .read(authProvider.notifier)
                              .logout();
                        },
                        tooltip: l10n.layoutLogout,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],

        // ── Theme & Sprache ─────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Theme-Auswahl
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: attrs.bgCard,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: attrs.borderMain),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(LucideIcons.palette,
                                size: 14, color: attrs.brand600),
                            const SizedBox(width: 6),
                            Text(
                              l10n.layoutThemeLabel,
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1,
                                color: attrs.textMuted,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          constraints: const BoxConstraints(),
                          padding: EdgeInsets.zero,
                          icon: themeState.isLoadingBg
                              ? const SizedBox(
                                  width: 12,
                                  height: 12,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 1.5))
                              : Icon(LucideIcons.refreshCw,
                                  size: 12, color: attrs.textMuted),
                          onPressed: () => ref
                              .read(themeProvider.notifier)
                              .fetchNewBackground(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    GridView.count(
                      shrinkWrap: true,
                      physics:
                          const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 6,
                      childAspectRatio: 2.2,
                      children: [
                        _themeBtn(ref, 'pearl',
                            l10n.layoutThemePearl,
                            LucideIcons.sun,
                            themeState.themeId, attrs),
                        _themeBtn(ref, 'dark',
                            l10n.layoutThemeDark,
                            LucideIcons.moon,
                            themeState.themeId, attrs),
                        _themeBtn(ref, 'glassy',
                            l10n.layoutThemeGlassy,
                            LucideIcons.palette,
                            themeState.themeId, attrs),
                        _themeBtn(ref, 'nature',
                            l10n.layoutThemeNature,
                            LucideIcons.droplets,
                            themeState.themeId, attrs),
                        _themeBtn(ref, 'liquid',
                            l10n.layoutThemeLiquid,
                            LucideIcons.zap,
                            themeState.themeId, attrs),
                        _themeBtn(ref, 'stage',
                            l10n.layoutThemeStage,
                            LucideIcons.music2,
                            themeState.themeId, attrs),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Zielsprache
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: attrs.bgCard,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: attrs.borderMain),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(LucideIcons.globe,
                            size: 14, color: attrs.brand600),
                        const SizedBox(width: 6),
                        Text(
                          l10n.layoutTargetLanguage,
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                            color: attrs.textMuted,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10),
                      decoration: BoxDecoration(
                        color: attrs.bgInput,
                        borderRadius: BorderRadius.circular(8),
                        border:
                            Border.all(color: attrs.borderMain),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value:
                              langState.targetLanguage.code,
                          dropdownColor: attrs.bgSidebar,
                          isExpanded: true,
                          icon: Icon(LucideIcons.chevronDown,
                              size: 14, color: attrs.textMuted),
                          items: langState.languages.map((lang) {
                            return DropdownMenuItem<String>(
                              value: lang.code,
                              child: Text(
                                lang.name,
                                style: TextStyle(
                                  color: attrs.textMain,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (code) {
                            if (code != null) {
                              final selected = langState.languages
                                  .firstWhere(
                                      (l) => l.code == code);
                              ref
                                  .read(languageProvider.notifier)
                                  .setTargetLanguage(selected);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _themeBtn(WidgetRef ref, String id, String label,
      IconData icon, String activeId, ThemeAttributes attrs) {
    final isSelected = activeId == id;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => ref.read(themeProvider.notifier).setTheme(id),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          decoration: BoxDecoration(
            color: isSelected ? attrs.brand600 : attrs.bgInput,
            border: Border.all(
                color:
                    isSelected ? attrs.brand600 : attrs.borderMain),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  size: 12,
                  color: isSelected ? Colors.white : attrs.textMuted),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color:
                        isSelected ? Colors.white : attrs.textMuted,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── DeepL Usage Widget ────────────────────────────────────────────────────────

class _DeeplUsageWidget extends ConsumerStatefulWidget {
  final ThemeAttributes attrs;

  const _DeeplUsageWidget({required this.attrs});

  @override
  ConsumerState<_DeeplUsageWidget> createState() => _DeeplUsageWidgetState();
}

class _DeeplUsageWidgetState extends ConsumerState<_DeeplUsageWidget> {
  Map<String, dynamic>? _data;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  Future<void> _fetch() async {
    setState(() { _loading = true; _error = null; });
    try {
      final res = await ApiClient().dio.get('/ai/deepl-usage');
      if (mounted) setState(() { _data = res.data as Map<String, dynamic>; _loading = false; });
    } catch (_) {
      if (mounted) setState(() { _error = '—'; _loading = false; });
    }
  }

  String _fmt(dynamic n) {
    if (n == null) return '?';
    final num = (n is int) ? n : int.tryParse(n.toString()) ?? 0;
    if (num >= 1000000000) return '∞'; // DeepL sentinel for "no limit"
    if (num >= 1000000) return '${(num / 1000000).toStringAsFixed(1)}M';
    if (num >= 1000) return '${(num / 1000).toStringAsFixed(0)}K';
    return num.toString();
  }

  @override
  Widget build(BuildContext context) {
    final attrs = widget.attrs;
    final l10n = AppLocalizations.of(context)!;

    final count = _data?['character_count'] as int?;
    final limit = _data?['character_limit'] as int?;
    // sentinel: DeepL returns 1 000 000 000 000 for "unlimited"
    final isUnlimited = limit != null && limit >= 1000000000000;
    final progress = (count != null && limit != null && !isUnlimited && limit > 0)
        ? (count / limit).clamp(0.0, 1.0)
        : 0.0;
    final pct = (progress * 100).toStringAsFixed(1);

    // Colour: green → amber → red
    final barColor = progress > 0.9
        ? Colors.redAccent
        : progress > 0.7
            ? Colors.amber
            : Colors.teal;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: attrs.bgCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: attrs.borderMain),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(LucideIcons.activity, size: 13, color: Colors.teal),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  l10n.layoutDeeplUsage,
                  style: TextStyle(
                    fontSize: 9, fontWeight: FontWeight.w900,
                    letterSpacing: 0.5, color: attrs.textMuted,
                  ),
                ),
              ),
              // Refresh button
              SizedBox(
                width: 22, height: 22,
                child: _loading
                    ? Padding(
                        padding: const EdgeInsets.all(4),
                        child: CircularProgressIndicator(
                            strokeWidth: 1.5, color: Colors.teal),
                      )
                    : IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Icon(LucideIcons.refreshCw,
                            size: 12, color: attrs.textMuted),
                        onPressed: _fetch,
                        tooltip: l10n.commonRefresh,
                      ),
              ),
            ],
          ),

          if (_error != null) ...[
            const SizedBox(height: 6),
            Text(
              l10n.layoutUnavailable,
              style: TextStyle(color: attrs.textMuted, fontSize: 10),
            ),
          ] else if (!_loading && _data != null) ...[
            const SizedBox(height: 8),

            // Count / Limit text
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _fmt(count),
                  style: TextStyle(
                    color: barColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  isUnlimited
                      ? l10n.layoutUnlimited
                      : '/ ${_fmt(limit)}',
                  style: TextStyle(color: attrs.textMuted, fontSize: 10),
                ),
              ],
            ),

            if (!isUnlimited) ...[
              const SizedBox(height: 6),
              // Progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 5,
                  backgroundColor: attrs.borderMain,
                  valueColor: AlwaysStoppedAnimation<Color>(barColor),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$pct % ${l10n.layoutUsed}',
                style: TextStyle(color: attrs.textMuted, fontSize: 9),
              ),
            ],

            // Pro: per-product breakdown
            if (_data!.containsKey('products')) ...[
              const SizedBox(height: 8),
              ...(_data!['products'] as List<dynamic>).map((p) {
                final type = (p['product_type'] as String?) ?? '';
                final c = p['api_key_character_count'] as int? ?? 0;
                return Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        type == 'translate'
                            ? l10n.layoutTranslate
                            : 'Write',
                        style: TextStyle(color: attrs.textMuted, fontSize: 9),
                      ),
                      Text(
                        _fmt(c),
                        style: TextStyle(
                            color: attrs.textMain,
                            fontSize: 9,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ],
        ],
      ),
    );
  }
}

// ── Nav-Item ──────────────────────────────────────────────────────────────────

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? route;
  final bool isActive;
  final ThemeAttributes attrs;

  const _NavItem({
    required this.icon,
    required this.label,
    this.route,
    this.isActive = false,
    required this.attrs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: isActive ? attrs.brand600 : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        boxShadow: isActive
            ? [
                BoxShadow(
                    color: attrs.brand600.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4))
              ]
            : [],
      ),
      child: ListTile(
        leading: Icon(icon,
            color: isActive ? Colors.white : attrs.textMuted, size: 18),
        title: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : attrs.textMuted,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        dense: true,
        horizontalTitleGap: 8,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)),
        onTap: () {
          if (route != null) {
            context.go(route!);
            // Drawer schließen, falls offen (Portrait-Modus)
            if (Scaffold.of(context).isDrawerOpen) {
              Navigator.of(context).pop();
            }
          }
        },
      ),
    );
  }
}
