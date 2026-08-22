import 'dart:async';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../l10n/app_localizations.dart';
import '../../providers/auth_provider.dart';
import '../../providers/theme_provider.dart';
import '../../theme/app_theme.dart';
import '../../services/api_client.dart';
import '../../services/token_storage.dart';
import '../../widgets/glass_container.dart';

// ── Slide model ───────────────────────────────────────────────────────────────

class _Slide {
  final String url;
  final String? photographerName;
  final String? photographerLink;
  const _Slide({required this.url, this.photographerName, this.photographerLink});
}

// Fallback-Bilder wenn die API nicht erreichbar ist (generische Unsplash-URLs)
const List<String> _kFallbackUrls = [
  'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?q=85&w=1920&auto=format&fit=crop',
  'https://images.unsplash.com/photo-1531366936337-7c912a4589a7?q=85&w=1920&auto=format&fit=crop',
  'https://images.unsplash.com/photo-1448375240586-882707db888b?q=85&w=1920&auto=format&fit=crop',
  'https://images.unsplash.com/photo-1477959858617-67f85cf4f1df?q=85&w=1920&auto=format&fit=crop',
];

// ── Screen ────────────────────────────────────────────────────────────────────

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = true;

  // ── Slideshow state ─────────────────────────────────────────────────────────
  final List<_Slide> _slides = [];
  int _current = 0;
  bool _fetching = false;
  bool _autoPlay = false;
  Timer? _autoTimer;

  @override
  void initState() {
    super.initState();
    _fetchSlide(); // Erstes Bild beim Start laden
  }

  @override
  void dispose() {
    _autoTimer?.cancel();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // ── API-gestütztes Bild laden (mit Autoreninfo) ─────────────────────────────

  Future<void> _fetchSlide() async {
    if (_fetching) return;
    setState(() => _fetching = true);
    try {
      final res = await ApiClient().dio.get(
        '/unsplash/random-bg',
        queryParameters: {'query': 'landscape,nature,architecture,cityscape'},
      );
      final url = res.data['url'] as String;
      final photo = res.data['photographer'] as Map<String, dynamic>?;
      if (mounted) {
        setState(() {
          _slides.add(_Slide(
            url: url,
            photographerName: photo?['name'] as String?,
            photographerLink: photo?['link'] as String?,
          ));
          _current = _slides.length - 1;
          _fetching = false;
        });
      }
    } catch (_) {
      // Fallback ohne Attribution
      if (mounted) {
        final fb = _kFallbackUrls[_slides.length % _kFallbackUrls.length];
        setState(() {
          _slides.add(_Slide(url: fb));
          _current = _slides.length - 1;
          _fetching = false;
        });
      }
    }
  }

  // ── Navigation ──────────────────────────────────────────────────────────────

  void _prev() {
    if (_current > 0) setState(() => _current--);
  }

  void _next() {
    if (_current < _slides.length - 1) {
      setState(() => _current++);
    } else {
      _fetchSlide(); // Neues Bild von der API laden
    }
  }

  void _toggleAuto() {
    setState(() => _autoPlay = !_autoPlay);
    if (_autoPlay) {
      _autoTimer = Timer.periodic(const Duration(seconds: 6), (_) => _next());
    } else {
      _autoTimer?.cancel();
      _autoTimer = null;
    }
  }

  // ── UTM-Link für Unsplash-Attribution ──────────────────────────────────────

  String _utmLink(String baseLink) {
    const utm = 'utm_source=pb_translation_hub&utm_medium=referral';
    return baseLink.contains('utm_source')
        ? baseLink
        : '$baseLink${baseLink.contains('?') ? '&' : '?'}$utm';
  }

  // ── Login ───────────────────────────────────────────────────────────────────

  Future<void> _handleLogin() async {
    final success = await ref.read(authProvider.notifier).login(
      _usernameController.text.trim(),
      _passwordController.text,
      remember: _rememberMe,
    );
    if (success && mounted) context.go('/');
  }

  // ── Build ───────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final authState = ref.watch(authProvider);
    final themeState = ref.watch(themeProvider);
    final attrs = AppTheme.getAttributes(themeState.themeId);

    final hasSlide = _slides.isNotEmpty;
    final slide = hasSlide ? _slides[_current] : null;

    return Scaffold(
      body: Stack(
        children: [
          // ── Hintergrundbild mit Crossfade ─────────────────────────────────
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 1200),
              transitionBuilder: (child, anim) =>
                  FadeTransition(opacity: anim, child: child),
              child: slide != null
                  ? RepaintBoundary(
                      key: ValueKey(slide.url),
                      child: CachedNetworkImage(
                        imageUrl: slide.url,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        errorWidget: (_, __, ___) =>
                            Container(color: attrs.bgSidebar),
                      ),
                    )
                  : Container(color: attrs.bgSidebar),
            ),
          ),

          // Overlay
          Positioned.fill(
            child: Container(color: Colors.black.withValues(alpha: 0.52)),
          ),

          // ── Slider-Steuerung (Pfeile + Punkte + Auto) — unten ─────────────
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Auto-Button + Pfeile
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Zurück
                    _SliderBtn(
                      icon: LucideIcons.chevronLeft,
                      onTap: _current > 0 ? _prev : null,
                    ),
                    const SizedBox(width: 12),

                    // Auto-Toggle
                    GestureDetector(
                      onTap: _toggleAuto,
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: _autoPlay
                                ? Colors.white.withValues(alpha: 0.25)
                                : Colors.white.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withValues(
                                  alpha: _autoPlay ? 0.5 : 0.2),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _autoPlay
                                    ? LucideIcons.pause
                                    : LucideIcons.play,
                                size: 11,
                                color: Colors.white.withValues(
                                    alpha: _autoPlay ? 1.0 : 0.6),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                _autoPlay ? 'Pause' : 'Auto',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white.withValues(
                                      alpha: _autoPlay ? 1.0 : 0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Vor / Neues Bild laden
                    _SliderBtn(
                      icon: _fetching
                          ? LucideIcons.loader
                          : LucideIcons.chevronRight,
                      spinning: _fetching,
                      onTap: _fetching ? null : _next,
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Punkte-Indikator
                if (_slides.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_slides.length, (i) {
                      final active = i == _current;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 280),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: active ? 22 : 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: active
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      );
                    }),
                  ),
              ],
            ),
          ),

          // ── Fotografen-Attribution — unten links ──────────────────────────
          if (slide?.photographerName != null)
            Positioned(
              bottom: 16,
              left: 16,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.28),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(LucideIcons.camera,
                            size: 11,
                            color: Colors.white.withValues(alpha: 0.7)),
                        const SizedBox(width: 5),
                        Text(
                          l10n.loginPhotoBy,
                          style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.6),
                              fontSize: 10),
                        ),
                        GestureDetector(
                          onTap: () {
                            final link = slide!.photographerLink ?? '';
                            if (link.isNotEmpty) {
                              TokenStorage.openUrl(_utmLink(link));
                            } else {
                              TokenStorage.openUrl(
                                'https://unsplash.com/?utm_source=pb_translation_hub&utm_medium=referral',
                              );
                            }
                          },
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Text(
                              slide!.photographerName!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          l10n.loginPhotoOn,
                          style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.6),
                              fontSize: 10),
                        ),
                        GestureDetector(
                          onTap: () => TokenStorage.openUrl(
                            'https://unsplash.com/?utm_source=pb_translation_hub&utm_medium=referral',
                          ),
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: const Text(
                              'Unsplash',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          // ── Login-Formular ────────────────────────────────────────────────
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 460),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: GlassContainer(
                    padding: const EdgeInsets.all(40),
                    backgroundColor: attrs.bgCard,
                    borderRadius: 24,
                    border: Border.all(color: attrs.borderMain),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Logo
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: attrs.brand600,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: attrs.brand600.withValues(alpha: 0.5),
                                blurRadius: 16,
                              ),
                            ],
                          ),
                          child: const Icon(LucideIcons.droplets,
                              color: Colors.white, size: 32),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'PB TRANSLATION HUB',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          l10n.loginPleaseSignIn,
                          style: TextStyle(color: attrs.textMuted),
                        ),
                        const SizedBox(height: 32),

                        // Fehlermeldung
                        if (authState.error != null) ...[
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.redAccent.withValues(alpha: 0.1),
                              border: Border.all(
                                  color: Colors.redAccent
                                      .withValues(alpha: 0.5)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              authState.error!,
                              style: const TextStyle(
                                  color: Colors.redAccent, fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],

                        // Formularfelder
                        TextField(
                          controller: _usernameController,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: l10n.loginUsername,
                            prefixIcon: const Icon(LucideIcons.user),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => _handleLogin(),
                          decoration: InputDecoration(
                            labelText: l10n.loginPassword,
                            prefixIcon: const Icon(LucideIcons.lock),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Angemeldet bleiben
                        Row(
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Checkbox(
                                value: _rememberMe,
                                activeColor: attrs.brand600,
                                checkColor: Colors.white,
                                onChanged: (val) =>
                                    setState(() => _rememberMe = val ?? false),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              l10n.loginRememberMe,
                              style: TextStyle(
                                  color: attrs.textMuted, fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),

                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed:
                                authState.isLoading ? null : _handleLogin,
                            child: authState.isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : Text(
                                    l10n.loginSignIn,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const _RegistrationLinkButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Kleiner runder Pfeil-Button ───────────────────────────────────────────────

class _SliderBtn extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final bool spinning;
  const _SliderBtn({required this.icon, this.onTap, this.spinning = false});

  @override
  State<_SliderBtn> createState() => _SliderBtnState();
}

class _SliderBtnState extends State<_SliderBtn>
    with SingleTickerProviderStateMixin {
  late AnimationController _spin;

  @override
  void initState() {
    super.initState();
    _spin = AnimationController(
        vsync: this, duration: const Duration(seconds: 1))
      ..repeat();
  }

  @override
  void dispose() {
    _spin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onTap != null;
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        cursor:
            enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white
                .withValues(alpha: enabled ? 0.18 : 0.06),
            border: Border.all(
              color: Colors.white.withValues(alpha: enabled ? 0.4 : 0.15),
            ),
          ),
          child: Center(
            child: widget.spinning
                ? RotationTransition(
                    turns: _spin,
                    child: Icon(widget.icon,
                        size: 16,
                        color: Colors.white.withValues(alpha: 0.8)),
                  )
                : Icon(widget.icon,
                    size: 16,
                    color: Colors.white
                        .withValues(alpha: enabled ? 0.9 : 0.3)),
          ),
        ),
      ),
    );
  }
}

// ── Registrierungs-Link (unten im Formular) ───────────────────────────────────

class _RegistrationLinkButton extends ConsumerStatefulWidget {
  const _RegistrationLinkButton();

  @override
  ConsumerState<_RegistrationLinkButton> createState() =>
      _RegistrationLinkButtonState();
}

class _RegistrationLinkButtonState
    extends ConsumerState<_RegistrationLinkButton> {
  bool? _registrationEnabled;

  @override
  void initState() {
    super.initState();
    _checkRegistrationStatus();
  }

  Future<void> _checkRegistrationStatus() async {
    try {
      final api = ApiClient();
      final res = await api.dio.get('/auth/registration-status');
      if (mounted)
        setState(() => _registrationEnabled = res.data['enabled'] == true);
    } catch (_) {
      if (mounted) setState(() => _registrationEnabled = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_registrationEnabled != true) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context)!;
    final attrs =
        AppTheme.getAttributes(ref.watch(themeProvider).themeId);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          l10n.loginNoAccount,
          style: TextStyle(color: attrs.textMuted, fontSize: 13),
        ),
        GestureDetector(
          onTap: () => context.go('/register'),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Text(
              l10n.loginRegisterNow,
              style: TextStyle(
                color: attrs.brand600,
                fontSize: 13,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
