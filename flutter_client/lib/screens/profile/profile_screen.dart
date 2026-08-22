import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';
import '../../l10n/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context)!;
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
          _profileSuccess = l10n.profileUpdateSuccess;
        });
      } else {
        setState(() {
          _profileError = l10n.profileUpdateFailed;
        });
      }
    } catch (e) {
      setState(() {
        _profileError = l10n.profileSaveError(e.toString());
      });
    } finally {
      setState(() {
        _isSavingProfile = false;
      });
    }
  }

  Future<void> _changePassword() async {
    final l10n = AppLocalizations.of(context)!;
    if (_newPasswordController.text != _confirmPasswordController.text) {
      setState(() {
        _passwordError = l10n.profilePasswordMismatch;
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
          _passwordSuccess = l10n.profilePasswordChangeSuccess;
          _currentPasswordController.clear();
          _newPasswordController.clear();
          _confirmPasswordController.clear();
        });
      }
    } catch (e) {
      setState(() {
        _passwordError = l10n.profilePasswordChangeError;
      });
    } finally {
      setState(() {
        _isSavingPassword = false;
      });
    }
  }

  Future<void> _pickAndUploadAvatar() async {
    final l10n = AppLocalizations.of(context)!;
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );

    if (result == null || result.files.single.bytes == null) return;

    final bytes = result.files.single.bytes!;
    final filename = result.files.single.name;

    setState(() {
      _isUploadingAvatar = true;
      _profileError = null;
      _profileSuccess = null;
    });

    try {
      final formData = FormData.fromMap({
        'avatar': MultipartFile.fromBytes(bytes, filename: filename),
      });

      final res = await _api.dio.post('/user/avatar', data: formData);
      if (res.data['success'] == true) {
        await ref.read(authProvider.notifier).refreshProfile();
        setState(() {
          _profileSuccess = l10n.profileAvatarUploadSuccess;
        });
      }
    } catch (e) {
      setState(() {
        _profileError = l10n.profileAvatarUploadError;
      });
    } finally {
      setState(() {
        _isUploadingAvatar = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final user = ref.watch(authProvider).user;
    final themeState = ref.watch(themeProvider);
    final attrs = AppTheme.getAttributes(themeState.themeId);

    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isMobile ? 14.0 : 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page Header
            Row(
              children: [
                // Zurück-Button auf Mobile (kein persistent Sidebar-Link)
                if (isMobile) ...[
                  IconButton(
                    icon: Icon(LucideIcons.arrowLeft,
                        color: attrs.textMuted, size: 22),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    tooltip: l10n.commonBack,
                    onPressed: () {
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      } else {
                        context.go('/');
                      }
                    },
                  ),
                  const SizedBox(width: 10),
                ],
                Icon(LucideIcons.user, color: attrs.brand600,
                    size: isMobile ? 22 : 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    l10n.profileTitle,
                    style: TextStyle(
                      fontSize: isMobile ? 18 : 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            if (!isMobile) ...[
              const SizedBox(height: 8),
              Text(
                l10n.profileSubtitle,
                style: TextStyle(color: attrs.textMuted, fontSize: 14),
              ),
            ],
            SizedBox(height: isMobile ? 16 : 32),

            // Profile Header Glass Card
            GlassContainer(
              padding: EdgeInsets.all(isMobile ? 14 : 24),
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
                              (user.role ?? l10n.profileRoleUser).toUpperCase(),
                              style: TextStyle(color: attrs.brand600, fontSize: 12, fontWeight: FontWeight.w900),
                            ),
                            const SizedBox(width: 12),
                            Icon(LucideIcons.mail, color: attrs.textMuted, size: 14),
                            const SizedBox(width: 6),
                            Text(
                              user.email ?? l10n.profileNoEmail,
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
                tabs: [
                  Tab(text: l10n.profileTabDetails),
                  Tab(text: l10n.profileTabGemini),
                  Tab(text: l10n.profileTabDeepl),
                  Tab(text: l10n.profileTabPassword),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Tab content view — auf Mobile mehr Höhe, da Felder mehr Platz brauchen
            SizedBox(
              height: isMobile ? 720 : 580,
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
    final l10n = AppLocalizations.of(context)!;

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
              Text(l10n.profileSectionInfo, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 24),
              _buildTextField(
                controller: _nameController,
                label: l10n.profileFieldName,
                hint: l10n.profileFieldNameHint,
                icon: LucideIcons.user,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _emailController,
                label: l10n.profileFieldEmail,
                hint: l10n.profileFieldEmailHint,
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
                  label: Text(l10n.commonSave, style: const TextStyle(fontWeight: FontWeight.bold)),
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
    final l10n = AppLocalizations.of(context)!;

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
                Text(l10n.profileSectionGemini, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 24),

                // Google AI Key Input
                _buildTextField(
                  controller: _googleAiKeyController,
                  label: l10n.profileFieldGeminiKey,
                  hint: l10n.profileFieldGeminiKeyHint,
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
                  label: l10n.profileFieldAiPrompt,
                  hint: l10n.profileFieldAiPromptHint,
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
                    label: Text(l10n.commonSave, style: const TextStyle(fontWeight: FontWeight.bold)),
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
    final l10n = AppLocalizations.of(context)!;

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
                    Text(
                      l10n.profileSectionDeepl,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.profileDeeplDescription,
                  style: TextStyle(color: attrs.textMuted, fontSize: 13, height: 1.5),
                ),
                const SizedBox(height: 24),

                // DeepL API Key Input
                _buildTextField(
                  controller: _deeplApiKeyController,
                  label: l10n.profileFieldDeeplKey,
                  hint: l10n.profileFieldDeeplKeyHint,
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
                          l10n.profileDeeplInfo,
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
                    label: Text(l10n.commonSave, style: const TextStyle(fontWeight: FontWeight.bold)),
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
    final l10n = AppLocalizations.of(context)!;
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
              Text(l10n.profileSectionSecurity, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 24),
              _buildTextField(
                controller: _currentPasswordController,
                label: l10n.profileFieldCurrentPassword,
                hint: l10n.profileFieldCurrentPasswordHint,
                icon: LucideIcons.lock,
                obscureText: true,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _newPasswordController,
                label: l10n.profileFieldNewPassword,
                hint: l10n.profileFieldNewPasswordHint,
                icon: LucideIcons.lock,
                obscureText: true,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _confirmPasswordController,
                label: l10n.profileFieldConfirmPassword,
                hint: l10n.profileFieldConfirmPasswordHint,
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
                  label: Text(l10n.profileChangePasswordButton, style: const TextStyle(fontWeight: FontWeight.bold)),
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
