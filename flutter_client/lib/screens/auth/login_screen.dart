import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../providers/auth_provider.dart';
import '../../providers/theme_provider.dart';
import '../../theme/app_theme.dart';
import '../../services/api_client.dart';
import '../../services/token_storage.dart';
import '../../widgets/glass_container.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = true; // Default is true, matching React app behavior
  
  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final success = await ref.read(authProvider.notifier).login(
      _usernameController.text.trim(),
      _passwordController.text,
      remember: _rememberMe,
    );
    if (success && mounted) {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final themeState = ref.watch(themeProvider);
    final attrs = AppTheme.getAttributes(themeState.themeId);

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: themeState.bgImageUrl != null
                ? RepaintBoundary(
                    child: CachedNetworkImage(
                      imageUrl: themeState.bgImageUrl!,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, err) =>
                          Container(color: attrs.bgSidebar),
                    ),
                  )
                : Container(color: attrs.bgSidebar),
          ),
          
          // Overlay
          Positioned.fill(
            child: Container(color: Colors.black.withValues(alpha: 0.5)),
          ),
          
          // Glass Card Content — SingleChildScrollView damit die Tastatur
          // das Formular auf dem Tablet nicht verdeckt.
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
                            )
                          ],
                        ),
                        child: const Icon(LucideIcons.droplets, color: Colors.white, size: 32),
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
                      Text('Bitte melde dich an', style: TextStyle(color: attrs.textMuted),
                      ),
                      const SizedBox(height: 32),
                      
                      // Error Message
                      if (authState.error != null) ...[
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.redAccent.withValues(alpha: 0.1),
                            border: Border.all(color: Colors.redAccent.withValues(alpha: 0.5)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            authState.error!,
                            style: const TextStyle(color: Colors.redAccent, fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],

                      // Form
                      TextField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: 'Benutzername',
                          prefixIcon: Icon(LucideIcons.user),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Passwort',
                          prefixIcon: Icon(LucideIcons.lock),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Remember Me Checkbox
                      Row(
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: Checkbox(
                              value: _rememberMe,
                              activeColor: attrs.brand600,
                              checkColor: Colors.white,
                              onChanged: (val) {
                                setState(() {
                                  _rememberMe = val ?? false;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text('Angemeldet bleiben', style: TextStyle(color: attrs.textMuted, fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),
                      
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: authState.isLoading ? null : _handleLogin,
                          child: authState.isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text('ANMELDEN', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _RegistrationLinkButton(),
                    ],
                  ),         // Column
                ),           // GlassContainer
              ),             // Padding
            ),               // ConstrainedBox
          ),                 // SingleChildScrollView
        ),                   // Center

          // Unsplash Attribution
          if (themeState.bgImageUrl != null && themeState.photographer != null)
            Positioned(
              bottom: 16,
              right: 16,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(LucideIcons.camera, size: 12, color: Colors.white70),
                        const SizedBox(width: 6),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 10,
                              fontFamily: 'Inter',
                            ),
                            children: [
                              const TextSpan(text: 'Foto von '),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () {
                                      final link = themeState.photographer!['link'] ?? '';
                                      final fullLink = link.contains('utm_source') 
                                          ? link 
                                          : '$link${link.contains('?') ? '&' : '?'}utm_source=pb_translation_hub&utm_medium=referral';
                                      TokenStorage.openUrl(fullLink);
                                    },
                                    child: Text(
                                      themeState.photographer!['name'] ?? '',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const TextSpan(text: ' auf '),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () {
                                      TokenStorage.openUrl('https://unsplash.com/?utm_source=pb_translation_hub&utm_medium=referral');
                                    },
                                    child: const Text(
                                      'Unsplash',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                      ),
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
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ── Registration link — shown below login button if registration is open ─────

class _RegistrationLinkButton extends ConsumerStatefulWidget {
  @override
  ConsumerState<_RegistrationLinkButton> createState() => _RegistrationLinkButtonState();
}

class _RegistrationLinkButtonState extends ConsumerState<_RegistrationLinkButton> {
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
      if (mounted) setState(() => _registrationEnabled = res.data['enabled'] == true);
    } catch (_) {
      if (mounted) setState(() => _registrationEnabled = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_registrationEnabled != true) return const SizedBox.shrink();
    final attrs = AppTheme.getAttributes(ref.watch(themeProvider).themeId);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Noch kein Account? ', style: TextStyle(color: attrs.textMuted, fontSize: 13)),
        GestureDetector(
          onTap: () => context.go('/register'),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Text(
              'Jetzt registrieren',
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
