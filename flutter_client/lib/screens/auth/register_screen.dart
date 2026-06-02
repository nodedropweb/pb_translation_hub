import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';

import '../../providers/theme_provider.dart';
import '../../theme/app_theme.dart';
import '../../services/api_client.dart';
import '../../services/token_storage.dart';
import '../../widgets/glass_container.dart';

// ── Step model ────────────────────────────────────────────────────────────────

enum _Step { account, role, languages, apiKeys, done }

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen>
    with TickerProviderStateMixin {
  final ApiClient _api = ApiClient();

  _Step _currentStep = _Step.account;
  bool _isSubmitting = false;
  String? _errorMessage;

  // Step 1 – Account
  final _usernameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _password2Ctrl = TextEditingController();
  bool _showPassword = false;
  String? _avatarDataUrl; // base64 data URL for preview

  // Step 2 – Role
  String _userType = 'translator'; // 'translator' | 'reviewer'

  // Step 3 – Languages
  List<Map<String, String>> _availableLanguages = [];
  final Set<String> _selectedLanguages = {};
  bool _loadingLanguages = true;

  // Step 4 – API Keys
  final _googleKeyCtrl = TextEditingController();
  final _deeplKeyCtrl = TextEditingController();

  late final AnimationController _progressCtrl;

  @override
  void initState() {
    super.initState();
    _progressCtrl = AnimationController(vsync: this, duration: 400.ms);
    _loadLanguages();
  }

  @override
  void dispose() {
    _progressCtrl.dispose();
    _usernameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _password2Ctrl.dispose();
    _googleKeyCtrl.dispose();
    _deeplKeyCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadLanguages() async {
    try {
      final res = await _api.dio.get('/languages');
      final list = (res.data as List).cast<Map<String, dynamic>>();
      setState(() {
        _availableLanguages = list
            .map((l) => {'code': l['code'].toString(), 'name': l['name'].toString()})
            .toList();
        _loadingLanguages = false;
      });
    } catch (_) {
      setState(() => _loadingLanguages = false);
    }
  }

  Future<void> _pickAvatar() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );
    if (result == null || result.files.single.bytes == null) return;
    final bytes = result.files.single.bytes!;
    // Convert to base64 data URL for preview
    final b64 = base64Encode(bytes);
    final ext = result.files.single.extension ?? 'jpg';
    setState(() => _avatarDataUrl = 'data:image/$ext;base64,$b64');
  }

  int get _stepIndex => _Step.values.indexOf(_currentStep);
  int get _totalSteps => _Step.values.length - 1; // exclude 'done'

  void _goNext() {
    setState(() => _errorMessage = null);
    switch (_currentStep) {
      case _Step.account:
        if (_usernameCtrl.text.trim().isEmpty ||
            _emailCtrl.text.trim().isEmpty ||
            _passwordCtrl.text.isEmpty) {
          setState(() => _errorMessage = 'Bitte alle Pflichtfelder ausfüllen.');
          return;
        }
        if (_passwordCtrl.text != _password2Ctrl.text) {
          setState(() => _errorMessage = 'Passwörter stimmen nicht überein.');
          return;
        }
        if (_passwordCtrl.text.length < 8) {
          setState(() => _errorMessage = 'Passwort muss mindestens 8 Zeichen haben.');
          return;
        }
        setState(() => _currentStep = _Step.role);
      case _Step.role:
        setState(() => _currentStep = _Step.languages);
      case _Step.languages:
        if (_selectedLanguages.isEmpty) {
          setState(() => _errorMessage = 'Bitte mindestens eine Sprache wählen.');
          return;
        }
        setState(() => _currentStep = _Step.apiKeys);
      case _Step.apiKeys:
        _submitRegistration();
      case _Step.done:
        break;
    }
  }

  void _goBack() {
    setState(() => _errorMessage = null);
    final idx = _stepIndex;
    if (idx > 0) setState(() => _currentStep = _Step.values[idx - 1]);
  }

  Future<void> _submitRegistration() async {
    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });
    try {
      await _api.dio.post('/auth/register', data: {
        'username': _usernameCtrl.text.trim(),
        'email': _emailCtrl.text.trim(),
        'password': _passwordCtrl.text,
        'user_type': _userType,
        'target_languages': _selectedLanguages.toList(),
      });

      // If an avatar was picked, upload it after registration (no auth needed for
      // pending users, so we just store locally — admin can't set it either way).
      // We skip the avatar upload here since the account is pending; it can be set
      // in profile after approval.

      setState(() {
        _isSubmitting = false;
        _currentStep = _Step.done;
      });
    } on DioException catch (e) {
      final msg = e.response?.data?['error'] ?? 'Registrierung fehlgeschlagen.';
      setState(() {
        _isSubmitting = false;
        _errorMessage = msg.toString();
      });
    } catch (_) {
      setState(() {
        _isSubmitting = false;
        _errorMessage = 'Registrierung fehlgeschlagen.';
      });
    }
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final themeState = ref.watch(themeProvider);
    final attrs = AppTheme.getAttributes(themeState.themeId);

    return Scaffold(
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: themeState.bgImageUrl != null
                ? CachedNetworkImage(
                    imageUrl: themeState.bgImageUrl!,
                    fit: BoxFit.cover,
                    errorWidget: (_, __, ___) => Container(color: attrs.bgSidebar),
                  )
                : Container(color: attrs.bgSidebar),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withValues(alpha: 0.55)),
          ),

          // Content
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
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
                        _buildHeader(attrs),
                        const SizedBox(height: 28),
                        if (_currentStep != _Step.done) _buildProgressBar(attrs),
                        const SizedBox(height: 32),
                        _buildStepContent(attrs),
                        if (_errorMessage != null) ...[
                          const SizedBox(height: 16),
                          _buildError(),
                        ],
                        if (_currentStep != _Step.done) ...[
                          const SizedBox(height: 28),
                          _buildNavButtons(attrs),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Unsplash attribution
          if (themeState.bgImageUrl != null && themeState.photographer != null)
            Positioned(
              bottom: 16,
              right: 16,
              child: _buildUnsplashCredit(themeState),
            ),
        ],
      ),
    );
  }

  Widget _buildHeader(ThemeAttributes attrs) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: attrs.brand600,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [BoxShadow(color: attrs.brand600.withValues(alpha: 0.4), blurRadius: 16)],
          ),
          child: const Icon(LucideIcons.userPlus, color: Colors.white, size: 28),
        ).animate().scale(duration: 400.ms, curve: Curves.easeOutBack),
        const SizedBox(height: 16),
        const Text(
          'REGISTRIERUNG',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 2),
        ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.2, end: 0),
        const SizedBox(height: 6),
        Text(
          'PB Translation Hub',
          style: TextStyle(color: attrs.textMuted, fontSize: 13),
        ).animate().fadeIn(delay: 100.ms, duration: 400.ms),
      ],
    );
  }

  Widget _buildProgressBar(ThemeAttributes attrs) {
    final labels = ['Account', 'Rolle', 'Sprachen', 'API-Keys'];
    final stepIdx = _stepIndex.clamp(0, labels.length - 1);

    return Row(
      children: List.generate(labels.length, (i) {
        final done = i < stepIdx;
        final active = i == stepIdx;
        return Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  if (i > 0)
                    Expanded(
                      child: Container(
                        height: 2,
                        color: done ? attrs.brand600 : attrs.borderMain,
                      ),
                    ),
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: done || active ? attrs.brand600 : Colors.transparent,
                      border: Border.all(
                        color: done || active ? attrs.brand600 : attrs.borderMain,
                        width: 2,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: done
                          ? const Icon(LucideIcons.check, size: 14, color: Colors.white)
                          : Text(
                              '${i + 1}',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: active ? Colors.white : attrs.textMuted,
                              ),
                            ),
                    ),
                  ),
                  if (i < labels.length - 1)
                    Expanded(
                      child: Container(
                        height: 2,
                        color: done ? attrs.brand600 : attrs.borderMain,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                labels[i],
                style: TextStyle(
                  fontSize: 10,
                  color: active ? attrs.brand600 : attrs.textMuted,
                  fontWeight: active ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        );
      }),
    ).animate().fadeIn(duration: 300.ms);
  }

  Widget _buildStepContent(ThemeAttributes attrs) {
    return AnimatedSwitcher(
      duration: 350.ms,
      transitionBuilder: (child, anim) => FadeTransition(
        opacity: anim,
        child: SlideTransition(
          position: Tween<Offset>(begin: const Offset(0.05, 0), end: Offset.zero).animate(anim),
          child: child,
        ),
      ),
      child: KeyedSubtree(
        key: ValueKey(_currentStep),
        child: switch (_currentStep) {
          _Step.account   => _buildAccountStep(attrs),
          _Step.role      => _buildRoleStep(attrs),
          _Step.languages => _buildLanguagesStep(attrs),
          _Step.apiKeys   => _buildApiKeysStep(attrs),
          _Step.done      => _buildDoneStep(attrs),
        },
      ),
    );
  }

  // ── Step 1: Account ────────────────────────────────────────────────────────

  Widget _buildAccountStep(ThemeAttributes attrs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _stepTitle('Dein Account', LucideIcons.user, attrs),
        const SizedBox(height: 20),

        // Avatar picker
        Center(
          child: GestureDetector(
            onTap: _pickAvatar,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Stack(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: attrs.bgSidebar,
                      border: Border.all(color: attrs.brand600, width: 2),
                      image: _avatarDataUrl != null
                          ? DecorationImage(
                              image: NetworkImage(_avatarDataUrl!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: _avatarDataUrl == null
                        ? Icon(LucideIcons.camera, color: attrs.textMuted, size: 28)
                        : null,
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: attrs.brand600,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(LucideIcons.plus, size: 14, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text('Avatar (optional)', style: TextStyle(fontSize: 11, color: attrs.textMuted)),
          ),
        ),
        const SizedBox(height: 20),

        _textField(_usernameCtrl, 'Benutzername *', LucideIcons.atSign, attrs),
        const SizedBox(height: 14),
        _textField(_emailCtrl, 'E-Mail-Adresse *', LucideIcons.mail, attrs,
            keyboardType: TextInputType.emailAddress),
        const SizedBox(height: 14),
        _passwordField(_passwordCtrl, 'Passwort *', attrs),
        const SizedBox(height: 14),
        _passwordField(_password2Ctrl, 'Passwort wiederholen *', attrs),
      ],
    );
  }

  // ── Step 2: Role ───────────────────────────────────────────────────────────

  Widget _buildRoleStep(ThemeAttributes attrs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _stepTitle('Deine Rolle', LucideIcons.shield, attrs),
        const SizedBox(height: 8),
        Text(
          'Übersetzer können Texte übersetzen, haben aber keinen Zugriff auf die Review-Warteschlange. '
          'Reviewer prüfen und geben übersetzte Inhalte frei.',
          style: TextStyle(fontSize: 12, color: attrs.textMuted, height: 1.5),
        ),
        const SizedBox(height: 24),
        _roleCard(
          value: 'translator',
          icon: LucideIcons.penLine,
          title: 'Übersetzer',
          subtitle: 'Erstelle und bearbeite Übersetzungen.',
          attrs: attrs,
        ),
        const SizedBox(height: 12),
        _roleCard(
          value: 'reviewer',
          icon: LucideIcons.checkCircle,
          title: 'Reviewer',
          subtitle: 'Prüfe und gebe Übersetzungen frei.',
          attrs: attrs,
        ),
      ],
    );
  }

  Widget _roleCard({
    required String value,
    required IconData icon,
    required String title,
    required String subtitle,
    required ThemeAttributes attrs,
  }) {
    final selected = _userType == value;
    return GestureDetector(
      onTap: () => setState(() => _userType = value),
      child: AnimatedContainer(
        duration: 200.ms,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? attrs.brand600.withValues(alpha: 0.15) : Colors.transparent,
          border: Border.all(
            color: selected ? attrs.brand600 : attrs.borderMain,
            width: selected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: selected ? attrs.brand600 : attrs.bgSidebar,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 20, color: selected ? Colors.white : attrs.textMuted),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: TextStyle(fontSize: 12, color: attrs.textMuted)),
                ],
              ),
            ),
            if (selected)
              Icon(LucideIcons.checkCircle2, color: attrs.brand600, size: 20),
          ],
        ),
      ),
    );
  }

  // ── Step 3: Languages ──────────────────────────────────────────────────────

  Widget _buildLanguagesStep(ThemeAttributes attrs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _stepTitle('Zielsprachen', LucideIcons.languages, attrs),
        const SizedBox(height: 8),
        Text(
          'Wähle alle Sprachen, für die du tätig sein möchtest.',
          style: TextStyle(fontSize: 12, color: attrs.textMuted),
        ),
        const SizedBox(height: 20),
        if (_loadingLanguages)
          const Center(child: CircularProgressIndicator())
        else if (_availableLanguages.isEmpty)
          Text('Keine Sprachen verfügbar.', style: TextStyle(color: attrs.textMuted))
        else
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _availableLanguages.map((lang) {
              final code = lang['code']!;
              final name = lang['name']!;
              final selected = _selectedLanguages.contains(code);
              return GestureDetector(
                onTap: () => setState(() {
                  if (selected) {
                    _selectedLanguages.remove(code);
                  } else {
                    _selectedLanguages.add(code);
                  }
                }),
                child: AnimatedContainer(
                  duration: 180.ms,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: selected ? attrs.brand600 : Colors.transparent,
                    border: Border.all(
                      color: selected ? attrs.brand600 : attrs.borderMain,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (selected) ...[
                        const Icon(LucideIcons.check, size: 12, color: Colors.white),
                        const SizedBox(width: 6),
                      ],
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 13,
                          color: selected ? Colors.white : attrs.textMuted,
                          fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }

  // ── Step 4: API Keys ───────────────────────────────────────────────────────

  Widget _buildApiKeysStep(ThemeAttributes attrs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _stepTitle('API-Keys', LucideIcons.key, attrs),
        const SizedBox(height: 8),
        Text(
          'Trage deine eigenen API-Keys ein. Jeder Nutzer verwendet ausschließlich seine eigenen Keys. '
          'Du kannst diese auch später in deinem Profil nachtragen.',
          style: TextStyle(fontSize: 12, color: attrs.textMuted, height: 1.5),
        ),
        const SizedBox(height: 20),
        _keySection(
          icon: LucideIcons.brain,
          label: 'Google AI (Gemini) Key',
          hint: 'AIza...',
          controller: _googleKeyCtrl,
          attrs: attrs,
        ),
        const SizedBox(height: 14),
        _keySection(
          icon: LucideIcons.languages,
          label: 'DeepL API Key',
          hint: 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx:fx',
          controller: _deeplKeyCtrl,
          attrs: attrs,
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: attrs.brand600.withValues(alpha: 0.08),
            border: Border.all(color: attrs.brand600.withValues(alpha: 0.3)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(LucideIcons.info, size: 14, color: attrs.brand600),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Keys werden verschlüsselt gespeichert und niemals mit anderen Nutzern geteilt.',
                  style: TextStyle(fontSize: 11, color: attrs.textMuted, height: 1.4),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _keySection({
    required IconData icon,
    required String label,
    required String hint,
    required TextEditingController controller,
    required ThemeAttributes attrs,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: attrs.textMuted),
            const SizedBox(width: 6),
            Text(label, style: TextStyle(fontSize: 12, color: attrs.textMuted)),
            Text(' (optional)', style: TextStyle(fontSize: 11, color: attrs.textMuted.withValues(alpha: 0.6))),
          ],
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          decoration: InputDecoration(hintText: hint),
          style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
        ),
      ],
    );
  }

  // ── Done ───────────────────────────────────────────────────────────────────

  Widget _buildDoneStep(ThemeAttributes attrs) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: const Color(0xFF10B981).withValues(alpha: 0.15),
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFF10B981), width: 2),
          ),
          child: const Icon(LucideIcons.checkCircle2, color: Color(0xFF10B981), size: 36),
        )
            .animate()
            .scale(duration: 500.ms, curve: Curves.easeOutBack)
            .fadeIn(duration: 400.ms),
        const SizedBox(height: 20),
        const Text(
          'Registrierung erfolgreich!',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ).animate().fadeIn(delay: 200.ms, duration: 400.ms).slideY(begin: 0.2, end: 0),
        const SizedBox(height: 12),
        Text(
          'Dein Account wurde angelegt und wartet auf die Freischaltung durch einen Administrator. '
          'Du wirst benachrichtigt, sobald dein Zugang aktiviert wurde.',
          style: TextStyle(color: attrs.textMuted, fontSize: 13, height: 1.6),
          textAlign: TextAlign.center,
        ).animate().fadeIn(delay: 300.ms, duration: 400.ms),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton.icon(
            icon: const Icon(LucideIcons.logIn, size: 16),
            label: const Text('Zur Anmeldung'),
            onPressed: () => context.go('/login'),
          ),
        ).animate().fadeIn(delay: 500.ms, duration: 400.ms).slideY(begin: 0.2, end: 0),
      ],
    );
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  Widget _buildNavButtons(ThemeAttributes attrs) {
    final isFirst = _stepIndex == 0;
    final isLast = _currentStep == _Step.apiKeys;

    return Row(
      children: [
        if (!isFirst)
          Expanded(
            child: OutlinedButton.icon(
              icon: const Icon(LucideIcons.arrowLeft, size: 16),
              label: const Text('Zurück'),
              onPressed: _goBack,
            ),
          ),
        if (!isFirst) const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: ElevatedButton.icon(
            icon: _isSubmitting
                ? const SizedBox(
                    width: 16, height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                : Icon(isLast ? LucideIcons.send : LucideIcons.arrowRight, size: 16),
            label: Text(isLast ? 'Registrieren' : 'Weiter'),
            onPressed: _isSubmitting ? null : _goNext,
          ),
        ),
        if (isFirst) ...[
          const SizedBox(height: 16),
        ],
      ],
    );
  }

  Widget _buildError() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.redAccent.withValues(alpha: 0.1),
        border: Border.all(color: Colors.redAccent.withValues(alpha: 0.5)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        _errorMessage!,
        style: const TextStyle(color: Colors.redAccent, fontSize: 12),
        textAlign: TextAlign.center,
      ),
    ).animate().fadeIn(duration: 300.ms).shake(hz: 3, offset: const Offset(4, 0));
  }

  Widget _stepTitle(String title, IconData icon, ThemeAttributes attrs) {
    return Row(
      children: [
        Icon(icon, size: 18, color: attrs.brand600),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _textField(
    TextEditingController ctrl,
    String label,
    IconData icon,
    ThemeAttributes attrs, {
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: ctrl,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
      ),
    );
  }

  Widget _passwordField(TextEditingController ctrl, String label, ThemeAttributes attrs) {
    return TextField(
      controller: ctrl,
      obscureText: !_showPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(LucideIcons.lock),
        suffixIcon: IconButton(
          icon: Icon(_showPassword ? LucideIcons.eyeOff : LucideIcons.eye, size: 18),
          onPressed: () => setState(() => _showPassword = !_showPassword),
        ),
      ),
    );
  }

  Widget _buildUnsplashCredit(ThemeState themeState) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(LucideIcons.camera, size: 11, color: Colors.white70),
              const SizedBox(width: 5),
              Text(
                'Foto von ${themeState.photographer!['name'] ?? ''} auf Unsplash',
                style: const TextStyle(color: Colors.white70, fontSize: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
