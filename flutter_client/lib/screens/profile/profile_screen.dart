import 'dart:html' as html;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:dio/dio.dart';
import '../../providers/auth_provider.dart';
import '../../providers/theme_provider.dart';
import '../../services/api_client.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_container.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ApiClient _api = ApiClient();

  // Profile controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  // AI Settings controllers
  final _googleAiKeyController = TextEditingController();
  final _aiPromptController = TextEditingController();
  double _aiBatchLimit = 5;
  bool _obscureAiKey = true;

  // DeepL Settings controllers
  final _deeplApiKeyController = TextEditingController();
  bool _obscureDeeplKey = true;

  // Password controllers
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isSavingProfile = false;
  bool _isSavingPassword = false;
  bool _isUploadingAvatar = false;

  String? _profileError;
  String? _profileSuccess;
  String? _passwordError;
  String? _passwordSuccess;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    
    // Populate fields from current user state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = ref.read(authProvider).user;
      if (user != null) {
        _nameController.text = user.name ?? '';
        _emailController.text = user.email ?? '';
        _googleAiKeyController.text = user.googleAiKey ?? '';
        _aiPromptController.text = user.aiPrompt ?? '';
        _aiBatchLimit = user.aiBatchLimit.toDouble();
        _deeplApiKeyController.text = user.deeplApiKey ?? '';
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _googleAiKeyController.dispose();
    _aiPromptController.dispose();
    _deeplApiKeyController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    setState(() {
      _isSavingProfile = true;
      _profileError = null;
      _profileSuccess = null;
    });

    try {
      final res = await _api.dio.put('/user/profile', data: {
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'google_ai_key': _googleAiKeyController.text.trim(),
        'ai_batch_limit': _aiBatchLimit.toInt(),
        'ai_prompt': _aiPromptController.text.trim(),
        'deepl_api_key': _deeplApiKeyController.text.trim(),
      });

      if (res.statusCode == 200) {
        await ref.read(authProvider.notifier).refreshProfile();
        setState(() {
          _profileSuccess = 'Profil erfolgreich aktualisiert!';
        });
      } else {
        setState(() {
          _profileError = 'Aktualisierung fehlgeschlagen.';
        });
      }
    } catch (e) {
      setState(() {
        _profileError = 'Fehler beim Speichern: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isSavingProfile = false;
      });
    }
  }

  Future<void> _changePassword() async {
    if (_newPasswordController.text != _confirmPasswordController.text) {
      setState(() {
        _passwordError = 'Passwörter stimmen nicht überein!';
      });
      return;
    }

    setState(() {
      _isSavingPassword = true;
      _passwordError = null;
      _passwordSuccess = null;
    });

    try {
      final res = await _api.dio.put('/user/password', data: {
        'currentPassword': _currentPasswordController.text,
        'newPassword': _newPasswordController.text,
      });

      if (res.statusCode == 200) {
        setState(() {
          _passwordSuccess = 'Passwort erfolgreich geändert!';
          _currentPasswordController.clear();
          _newPasswordController.clear();
          _confirmPasswordController.clear();
        });
      }
    } catch (e) {
      setState(() {
        _passwordError = 'Fehler beim Ändern des Passworts: Falsches aktuelles Passwort.';
      });
    } finally {
      setState(() {
        _isSavingPassword = false;
      });
    }
  }

  void _pickAndUploadAvatar() {
    final uploadInput = html.FileUploadInputElement()..accept = 'image/*';
    uploadInput.click();

    uploadInput.onChange.listen((event) async {
      final files = uploadInput.files;
      if (files == null || files.isEmpty) return;

      setState(() {
        _isUploadingAvatar = true;
        _profileError = null;
        _profileSuccess = null;
      });

      final file = files.first;
      final reader = html.FileReader();
      reader.readAsArrayBuffer(file);
      reader.onLoadEnd.listen((loadEvent) async {
        final bytes = reader.result as Uint8List;
        
        try {
          final formData = FormData.fromMap({
            'avatar': MultipartFile.fromBytes(bytes, filename: file.name),
          });
          
          final res = await _api.dio.post('/user/avatar', data: formData);
          if (res.data['success'] == true) {
            await ref.read(authProvider.notifier).refreshProfile();
            setState(() {
              _profileSuccess = 'Profilbild erfolgreich hochgeladen!';
            });
          }
        } catch (e) {
          setState(() {
            _profileError = 'Fehler beim Hochladen des Profilbildes.';
          });
        } finally {
          setState(() {
            _isUploadingAvatar = false;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider).user;
    final themeState = ref.watch(themeProvider);
    final attrs = AppTheme.getAttributes(themeState.themeId);

    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page Header
            Row(
              children: [
                Icon(LucideIcons.user, color: attrs.brand600, size: 28),
                const SizedBox(width: 16),
                const Text(
                  'Profil & Einstellungen',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Verwalte dein Benutzerprofil, deine Übersetzungs-APIs (Gemini & DeepL) und deine Kontosicherheit.',
              style: TextStyle(color: attrs.textMuted, fontSize: 14),
            ),
            const SizedBox(height: 32),

            // Profile Header Glass Card
            GlassContainer(
              padding: const EdgeInsets.all(24),
              borderRadius: 20,
              child: Row(
                children: [
                  // Clickable Avatar with overlay hover
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: _pickAndUploadAvatar,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: 48,
                            backgroundColor: attrs.brand600.withOpacity(0.2),
                            backgroundImage: user.avatarUrl != null
                                ? NetworkImage('${ApiClient.serverOrigin}${user.avatarUrl}')
                                : null,
                            child: user.avatarUrl == null
                                ? Text(
                                    (user.name ?? user.username).substring(0, 1).toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 36,
                                    ),
                                  )
                                : null,
                          ),
                          if (_isUploadingAvatar)
                            Container(
                              width: 96,
                              height: 96,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                shape: BoxShape.circle,
                              ),
                              child: const CircularProgressIndicator(color: Colors.white),
                            )
                          else
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: attrs.brand600,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(LucideIcons.camera, color: Colors.white, size: 14),
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                  // User Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name ?? user.username,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(LucideIcons.shield, color: attrs.brand600, size: 14),
                            const SizedBox(width: 6),
                            Text(
                              (user.role ?? 'Benutzer').toUpperCase(),
                              style: TextStyle(color: attrs.brand600, fontSize: 12, fontWeight: FontWeight.w900),
                            ),
                            const SizedBox(width: 12),
                            Icon(LucideIcons.mail, color: attrs.textMuted, size: 14),
                            const SizedBox(width: 6),
                            Text(
                              user.email ?? 'Keine E-Mail angegeben',
                              style: TextStyle(color: attrs.textMuted, fontSize: 13),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Tab bar layout
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: attrs.borderMain)),
              ),
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                labelColor: attrs.brand600,
                unselectedLabelColor: attrs.textMuted,
                indicatorColor: attrs.brand600,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                tabs: const [
                  Tab(text: 'Profildetails'),
                  Tab(text: 'AI translation (Gemini)'),
                  Tab(text: 'DeepL Übersetzung'),
                  Tab(text: 'Passwort ändern'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Tab content view
            SizedBox(
              height: 580,
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Tab 1: Profile Details Form
                  _buildProfileForm(),

                  // Tab 2: AI Settings Form (Gemini)
                  _buildAiSettingsForm(),

                  // Tab 3: DeepL Settings Form
                  _buildDeeplSettingsForm(),

                  // Tab 4: Change Password Form
                  _buildPasswordForm(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildProfileForm() {
    final themeState = ref.watch(themeProvider);
    final attrs = AppTheme.getAttributes(themeState.themeId);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_profileSuccess != null) ...[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.withOpacity(0.1)),
            ),
            child: Row(
              children: [
                const Icon(LucideIcons.checkCircle, color: Colors.green),
                const SizedBox(width: 12),
                Text(_profileSuccess!, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
        if (_profileError != null) ...[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.red.withOpacity(0.1)),
            ),
            child: Row(
              children: [
                const Icon(LucideIcons.alertCircle, color: Colors.red),
                const SizedBox(width: 12),
                Text(_profileError!, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
        GlassContainer(
          padding: const EdgeInsets.all(24),
          borderRadius: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('PROFIL INFORMATIONEN', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 24),
              _buildTextField(
                controller: _nameController,
                label: 'Name',
                hint: 'Dein voller Name',
                icon: LucideIcons.user,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _emailController,
                label: 'E-Mail Adresse',
                hint: 'Deine E-Mail Adresse',
                icon: LucideIcons.mail,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: 200,
                height: 48,
                child: ElevatedButton.icon(
                  icon: _isSavingProfile 
                      ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : const Icon(LucideIcons.save, size: 18),
                  label: const Text('Speichern', style: TextStyle(fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: attrs.brand600,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _isSavingProfile ? null : _saveProfile,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAiSettingsForm() {
    final themeState = ref.watch(themeProvider);
    final attrs = AppTheme.getAttributes(themeState.themeId);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_profileSuccess != null) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.withOpacity(0.1)),
              ),
              child: Row(
                children: [
                  const Icon(LucideIcons.checkCircle, color: Colors.green),
                  const SizedBox(width: 12),
                  Text(_profileSuccess!, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
          if (_profileError != null) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red.withOpacity(0.1)),
              ),
              child: Row(
                children: [
                  const Icon(LucideIcons.alertCircle, color: Colors.red),
                  const SizedBox(width: 12),
                  Text(_profileError!, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
          GlassContainer(
            padding: const EdgeInsets.all(24),
            borderRadius: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('GEMINI CO-PILOT EINSTELLUNGEN', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 24),
                
                // Google AI Key Input
                _buildTextField(
                  controller: _googleAiKeyController,
                  label: 'Google Gemini API Key',
                  hint: 'Gib deinen gemini-3.1-flash API-Schlüssel ein',
                  icon: LucideIcons.key,
                  obscureText: _obscureAiKey,
                  suffixIcon: IconButton(
                    icon: Icon(_obscureAiKey ? LucideIcons.eyeOff : LucideIcons.eye, color: attrs.textMuted, size: 18),
                    onPressed: () {
                      setState(() {
                        _obscureAiKey = !_obscureAiKey;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),

                // Prompt Template
                _buildTextField(
                  controller: _aiPromptController,
                  label: 'Individueller AI-Prompt',
                  hint: 'Optional: Passe den System-Prompt für Gemini an...',
                  icon: LucideIcons.messageSquare,
                  maxLines: 4,
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: 200,
                  height: 48,
                  child: ElevatedButton.icon(
                    icon: _isSavingProfile 
                        ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                        : const Icon(LucideIcons.save, size: 18),
                    label: const Text('Speichern', style: TextStyle(fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: attrs.brand600,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: _isSavingProfile ? null : _saveProfile,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeeplSettingsForm() {
    final themeState = ref.watch(themeProvider);
    final attrs = AppTheme.getAttributes(themeState.themeId);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_profileSuccess != null) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.withOpacity(0.1)),
              ),
              child: Row(
                children: [
                  const Icon(LucideIcons.checkCircle, color: Colors.green),
                  const SizedBox(width: 12),
                  Text(_profileSuccess!, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
          if (_profileError != null) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red.withOpacity(0.1)),
              ),
              child: Row(
                children: [
                  const Icon(LucideIcons.alertCircle, color: Colors.red),
                  const SizedBox(width: 12),
                  Text(_profileError!, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
          GlassContainer(
            padding: const EdgeInsets.all(24),
            borderRadius: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F2B46),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFF003399).withOpacity(0.4)),
                      ),
                      child: const Text(
                        'DeepL',
                        style: TextStyle(
                          color: Color(0xFF0F62FE),
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'DEEPL ÜBERSETZUNGS-EINSTELLUNGEN',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'DeepL bietet hochwertige maschinelle Übersetzung mit HTML-Tag-Erhaltung. '
                  'Kostenlose Accounts (500.000 Zeichen/Monat) erhalten einen Key mit dem Suffix ":fx".',
                  style: TextStyle(color: attrs.textMuted, fontSize: 13, height: 1.5),
                ),
                const SizedBox(height: 24),

                // DeepL API Key Input
                _buildTextField(
                  controller: _deeplApiKeyController,
                  label: 'DeepL API Key',
                  hint: 'z.B. xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx:fx',
                  icon: LucideIcons.key,
                  obscureText: _obscureDeeplKey,
                  suffixIcon: IconButton(
                    icon: Icon(_obscureDeeplKey ? LucideIcons.eyeOff : LucideIcons.eye,
                        color: attrs.textMuted, size: 18),
                    onPressed: () {
                      setState(() {
                        _obscureDeeplKey = !_obscureDeeplKey;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 12),
                // Info hint about free vs. pro endpoint
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.04),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(LucideIcons.info, size: 14, color: attrs.textMuted),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Free-Keys enden auf ":fx" und verwenden api-free.deepl.com. '
                          'Pro-Keys verwenden api.deepl.com. Die Unterscheidung erfolgt automatisch.',
                          style: TextStyle(color: attrs.textMuted, fontSize: 12, height: 1.5),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: 200,
                  height: 48,
                  child: ElevatedButton.icon(
                    icon: _isSavingProfile
                        ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                        : const Icon(LucideIcons.save, size: 18),
                    label: const Text('Speichern', style: TextStyle(fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: attrs.brand600,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: _isSavingProfile ? null : _saveProfile,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_passwordSuccess != null) ...[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.withOpacity(0.1)),
            ),
            child: Row(
              children: [
                const Icon(LucideIcons.checkCircle, color: Colors.green),
                const SizedBox(width: 12),
                Text(_passwordSuccess!, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
        if (_passwordError != null) ...[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.red.withOpacity(0.1)),
            ),
            child: Row(
              children: [
                const Icon(LucideIcons.alertCircle, color: Colors.red),
                const SizedBox(width: 12),
                Text(_passwordError!, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
        GlassContainer(
          padding: const EdgeInsets.all(24),
          borderRadius: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('KONTOSICHERHEIT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 24),
              _buildTextField(
                controller: _currentPasswordController,
                label: 'Aktuelles Passwort',
                hint: 'Gib dein aktuelles Passwort ein',
                icon: LucideIcons.lock,
                obscureText: true,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _newPasswordController,
                label: 'Neues Passwort',
                hint: 'Mindestens 6 Zeichen',
                icon: LucideIcons.lock,
                obscureText: true,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _confirmPasswordController,
                label: 'Neues Passwort bestätigen',
                hint: 'Passwort wiederholen',
                icon: LucideIcons.lock,
                obscureText: true,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: 200,
                height: 48,
                child: ElevatedButton.icon(
                  icon: _isSavingPassword 
                      ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : const Icon(LucideIcons.lock, size: 18),
                  label: const Text('Passwort ändern', style: TextStyle(fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _isSavingPassword ? null : _changePassword,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    int maxLines = 1,
  }) {
    final themeState = ref.read(themeProvider);
    final attrs = AppTheme.getAttributes(themeState.themeId);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          maxLines: maxLines,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: attrs.textMuted),
            prefixIcon: Icon(icon, color: attrs.textMuted, size: 18),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: attrs.borderMain),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: attrs.brand600, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }
}
