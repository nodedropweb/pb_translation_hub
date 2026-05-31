// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:dio/dio.dart';
import '../../providers/auth_provider.dart';
import '../../providers/theme_provider.dart';
import '../../providers/language_provider.dart';
import '../../theme/app_theme.dart';
import '../../services/api_client.dart';
import '../../services/log_service.dart';
import '../../widgets/glass_container.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final ApiClient _api = ApiClient();
  bool _syncing = false;
  bool _isUploading = false;
  double _uploadProgress = 0.0;
  
  // Admin fields
  bool _loadingAdmin = false;
  List<dynamic> _pendingUsers = [];
  List<dynamic> _activeUsers = [];
  // Per-user role override while approving (id → 'translator' | 'reviewer')
  final Map<String, String> _pendingUserTypes = {};
  Map<String, dynamic> _adminSettings = {'registration_enabled': '1'};
  String _logLevelFilter = 'ALL';

  @override
  void initState() {
    super.initState();
    LogService.addListener(_onLogChanged);
    final user = ref.read(authProvider).user;
    if (user != null && user.role == 'admin') {
      Future.microtask(() => _fetchAdminData());
    }
  }

  void _onLogChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    LogService.removeListener(_onLogChanged);
    super.dispose();
  }

  Future<void> _fetchAdminData() async {
    setState(() {
      _loadingAdmin = true;
    });

    try {
      final results = await Future.wait([
        _api.dio.get('/admin/users/pending'),
        _api.dio.get('/admin/users/active'),
        _api.dio.get('/admin/settings'),
      ]);

      setState(() {
        _pendingUsers = results[0].data as List<dynamic>;
        _activeUsers  = results[1].data as List<dynamic>;
        _adminSettings = results[2].data as Map<String, dynamic>;
        _loadingAdmin = false;
      });
    } catch (e) {
      print('Failed to fetch admin settings: $e');
      setState(() {
        _loadingAdmin = false;
      });
    }
  }

  Future<void> _toggleRegistration() async {
    final isGerman = ref.read(languageProvider).targetLanguage.code == 'de';
    final currentVal = _adminSettings['registration_enabled']?.toString() ?? '1';
    final newVal = currentVal == '1' ? '0' : '1';

    try {
      await _api.dio.put('/admin/settings', data: {'registration_enabled': newVal});
      setState(() {
        _adminSettings['registration_enabled'] = newVal;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isGerman 
              ? 'Registrierungseinstellung aktualisiert' 
              : 'Registration setting updated'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isGerman ? 'Update fehlgeschlagen.' : 'Update failed.'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  Future<void> _handleUserAction(String userId, String action, {String? userType}) async {
    final isGerman = ref.read(languageProvider).targetLanguage.code == 'de';
    try {
      if (action == 'approve') {
        await _api.dio.post(
          '/admin/users/$userId/approve',
          data: userType != null ? {'user_type': userType} : null,
        );
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(isGerman ? 'Nutzer freigeschaltet!' : 'User approved!'),
            backgroundColor: Colors.green,
          ));
        }
        setState(() {
          _pendingUsers.removeWhere((u) => u['id']?.toString() == userId);
        });
        // Aktive Liste neu laden damit neuer User erscheint
        _fetchAdminData();
      } else if (action == 'deactivate') {
        await _api.dio.patch('/admin/users/$userId/deactivate');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(isGerman ? 'Konto gesperrt.' : 'Account deactivated.'),
            backgroundColor: Colors.orange,
          ));
        }
        setState(() {
          _activeUsers.removeWhere((u) => u['id']?.toString() == userId);
        });
      } else if (action == 'delete') {
        await _api.dio.delete('/admin/users/$userId');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(isGerman ? 'Nutzer gelöscht.' : 'User deleted.'),
            backgroundColor: Colors.redAccent,
          ));
        }
        setState(() {
          _pendingUsers.removeWhere((u) => u['id']?.toString() == userId);
          _activeUsers.removeWhere((u) => u['id']?.toString() == userId);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Aktion fehlgeschlagen.'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  Future<void> _confirmAndAct({
    required String id,
    required String username,
    required String action,
    required bool isGerman,
    required ThemeAttributes attrs,
  }) async {
    final isDelete = action == 'delete';
    final title = isDelete
        ? (isGerman ? 'Konto löschen?' : 'Delete account?')
        : (isGerman ? 'Konto sperren?' : 'Deactivate account?');
    final body = isDelete
        ? (isGerman
            ? 'Das Konto von "$username" wird unwiderruflich gelöscht. Fortfahren?'
            : 'The account "$username" will be permanently deleted. Continue?')
        : (isGerman
            ? 'Das Konto von "$username" wird gesperrt. Der Nutzer kann sich nicht mehr anmelden, das Konto bleibt aber erhalten.'
            : 'The account "$username" will be locked. The user cannot log in anymore, but the account is kept.');

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E222B),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: Text(body, style: const TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(isGerman ? 'Abbrechen' : 'Cancel',
                style: const TextStyle(color: Colors.white70)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isDelete ? Colors.redAccent : Colors.orange,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(isDelete
                ? (isGerman ? 'Löschen' : 'Delete')
                : (isGerman ? 'Sperren' : 'Deactivate')),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      _handleUserAction(id, action);
    }
  }

  Future<void> _handleSync() async {
    setState(() {
      _syncing = true;
    });

    final isGerman = ref.read(languageProvider).targetLanguage.code == 'de';

    try {
      final res = await _api.dio.post('/sync/translations');
      final count = res.data['count'] ?? 0;
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isGerman 
              ? '$count Übersetzungen synchronisiert!' 
              : '$count translations synced!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isGerman ? 'Fehler bei der Synchronisation' : 'Sync error: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      setState(() {
        _syncing = false;
      });
    }
  }

  Future<void> _handlePrioritySync() async {
    setState(() {
      _syncing = true;
    });

    final isGerman = ref.read(languageProvider).targetLanguage.code == 'de';

    try {
      final res = await _api.dio.post('/sync/priority');
      final count = res.data['count'] ?? 0;
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isGerman 
              ? '$count Priority-Module synchronisiert!' 
              : '$count priority modules synced!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isGerman 
              ? 'Fehler beim Synchronisieren der Priority-Liste. Wurde die Liste schon generiert?' 
              : 'Error syncing priority list: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      setState(() {
        _syncing = false;
      });
    }
  }

  void _pickAndUploadBackup(ThemeAttributes attrs, bool isGerman) {
    final uploadInput = html.FileUploadInputElement();
    uploadInput.accept = '.zip';
    uploadInput.click();

    uploadInput.onChange.listen((e) async {
      final files = uploadInput.files;
      if (files != null && files.isNotEmpty) {
        final file = files[0];
        final reader = html.FileReader();
        reader.readAsArrayBuffer(file);
        
        setState(() {
          _isUploading = true;
          _uploadProgress = 0.0;
        });

        reader.onLoadEnd.listen((loadEvent) async {
          try {
            final bytes = reader.result as List<int>;
            
            final formData = FormData.fromMap({
              'file': MultipartFile.fromBytes(
                bytes,
                filename: file.name,
              ),
            });

            final response = await _api.dio.post(
              '/upload-backup',
              data: formData,
              onSendProgress: (sent, total) {
                if (total > 0) {
                  setState(() {
                    _uploadProgress = sent / total;
                  });
                }
              },
            );

            final count = response.data['count'] ?? 0;
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isGerman 
                    ? 'Backup erfolgreich: $count Dateien verarbeitet.'
                    : 'Backup successful: $count files processed.'),
                  backgroundColor: Colors.green,
                ),
              );
            }
          } catch (err) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isGerman ? 'Upload fehlgeschlagen.' : 'Upload failed.'),
                  backgroundColor: Colors.redAccent,
                ),
              );
            }
          } finally {
            setState(() {
              _isUploading = false;
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider).user;
    final themeState = ref.watch(themeProvider);
    final langState = ref.watch(languageProvider);
    final attrs = AppTheme.getAttributes(themeState.themeId);
    final isGerman = langState.targetLanguage.code == 'de';

    final isAdmin = user != null && user.role == 'admin';
    final isRegEnabled = _adminSettings['registration_enabled']?.toString() == '1';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: attrs.brand600,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(LucideIcons.settings, size: 28, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isGerman ? 'Einstellungen' : 'Settings',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: attrs.textMain,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isGerman ? 'SYSTEM-KONFIGURATION' : 'SYSTEM CONFIGURATION',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: attrs.brand600,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Admin Row if User is Admin
          if (isAdmin) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Registration Switch Card
                Expanded(
                  child: GlassContainer(
                    border: Border.all(color: attrs.borderMain),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(LucideIcons.lock, size: 20, color: attrs.brand600),
                                const SizedBox(width: 8),
                                Text(
                                  isGerman ? 'Registrierung' : 'Registration',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: attrs.textMain,
                                  ),
                                ),
                              ],
                            ),
                            Switch(
                              value: isRegEnabled,
                              onChanged: (_) => _toggleRegistration(),
                              activeThumbColor: attrs.brand600,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          isGerman 
                              ? 'Schalte das Registrierungsformular global an oder aus.' 
                              : 'Toggle the global registration form visibility.',
                          style: TextStyle(color: attrs.textMuted, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                
                // Pending Users Card
                Expanded(
                  child: GlassContainer(
                    border: Border.all(color: attrs.borderMain),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(LucideIcons.userPlus, size: 20, color: attrs.brand600),
                            const SizedBox(width: 8),
                            Text(
                              isGerman ? 'Wartende Nutzer' : 'Pending Users',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: attrs.textMain,
                              ),
                            ),
                            if (_pendingUsers.isNotEmpty) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: attrs.brand600,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  '${_pendingUsers.length}',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        // User List
                        if (_loadingAdmin)
                          const Center(child: CircularProgressIndicator())
                        else if (_pendingUsers.isEmpty)
                          Text(
                            isGerman ? 'Keine neuen Anfragen.' : 'No new requests.',
                            style: TextStyle(
                              color: attrs.textMuted,
                              fontStyle: FontStyle.italic,
                              fontSize: 13,
                            ),
                          )
                        else
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _pendingUsers.length,
                            itemBuilder: (context, index) {
                              final pending = _pendingUsers[index];
                              final id = pending['id']?.toString() ?? '';
                              final username = pending['username']?.toString() ?? '';
                              final email = pending['email']?.toString() ?? '';
                              final requestedRole = pending['requested_role']?.toString() ?? 'translator';
                              final wantsReviewer = requestedRole == 'reviewer';
                              final langs = (pending['target_languages'] as List?)
                                      ?.map((l) => l.toString())
                                      .join(', ') ??
                                  '–';
                              // Dropdown startet immer auf 'translator' — Admin kann manuell auf reviewer hochstufen
                              final approveType = (_pendingUserTypes[id] ?? 'translator');

                              return Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: attrs.bgSidebar,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: attrs.borderMain),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(LucideIcons.user, size: 14, color: attrs.textMuted),
                                        const SizedBox(width: 6),
                                        Text(username,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: attrs.textMain,
                                                fontSize: 13)),
                                        if (wantsReviewer) ...[
                                          const SizedBox(width: 8),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: Colors.amber.withValues(alpha: 0.15),
                                              border: Border.all(color: Colors.amber.withValues(alpha: 0.6)),
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Icon(LucideIcons.star, size: 10, color: Colors.amber),
                                                const SizedBox(width: 4),
                                                Text(
                                                  isGerman ? 'Möchte Reviewer werden' : 'Wants to be Reviewer',
                                                  style: const TextStyle(fontSize: 10, color: Colors.amber, fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                        const SizedBox(width: 8),
                                        Text(email,
                                            style: TextStyle(
                                                color: attrs.textMuted, fontSize: 11)),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        Icon(LucideIcons.languages, size: 12, color: attrs.textMuted),
                                        const SizedBox(width: 4),
                                        Text(langs,
                                            style: TextStyle(
                                                fontSize: 11, color: attrs.textMuted)),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: DropdownButtonFormField<String>(
                                            value: approveType,
                                            decoration: InputDecoration(
                                              labelText: isGerman ? 'Rolle zuweisen' : 'Assign role',
                                              isDense: true,
                                              contentPadding: const EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 8),
                                            ),
                                            items: [
                                              DropdownMenuItem(
                                                value: 'translator',
                                                child: Text(isGerman ? 'Übersetzer' : 'Translator',
                                                    style: const TextStyle(fontSize: 13)),
                                              ),
                                              DropdownMenuItem(
                                                value: 'reviewer',
                                                child: Text(isGerman ? 'Reviewer' : 'Reviewer',
                                                    style: const TextStyle(fontSize: 13)),
                                              ),
                                            ],
                                            onChanged: (val) {
                                              if (val != null) {
                                                setState(() => _pendingUserTypes[id] = val);
                                              }
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        IconButton(
                                          icon: const Icon(LucideIcons.checkCircle,
                                              size: 20, color: Colors.green),
                                          onPressed: () =>
                                              _handleUserAction(id, 'approve', userType: approveType),
                                          tooltip: isGerman ? 'Freischalten' : 'Approve',
                                        ),
                                        IconButton(
                                          icon: const Icon(LucideIcons.trash2,
                                              size: 18, color: Colors.redAccent),
                                          onPressed: () => _handleUserAction(id, 'delete'),
                                          tooltip: isGerman ? 'Ablehnen' : 'Reject',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Active Users Card
            GlassContainer(
              border: Border.all(color: attrs.borderMain),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(LucideIcons.users, size: 20, color: attrs.brand600),
                      const SizedBox(width: 8),
                      Text(
                        isGerman ? 'Aktive Benutzer' : 'Active Users',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      const SizedBox(width: 10),
                      if (_activeUsers.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: attrs.brand600,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text('${_activeUsers.length}',
                              style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (_loadingAdmin)
                    const Center(child: CircularProgressIndicator())
                  else if (_activeUsers.isEmpty)
                    Text(isGerman ? 'Keine aktiven Benutzer.' : 'No active users.',
                        style: TextStyle(color: attrs.textMuted, fontSize: 13))
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _activeUsers.length,
                      itemBuilder: (context, index) {
                        final user = _activeUsers[index];
                        final id = user['id']?.toString() ?? '';
                        final username = user['username']?.toString() ?? '';
                        final email = user['email']?.toString() ?? '';
                        final userType = user['user_type']?.toString() ?? 'translator';
                        final langs = (user['target_languages'] as List?)
                                ?.map((l) => l.toString())
                                .join(', ') ??
                            '–';

                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: attrs.bgSidebar,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: attrs.borderMain),
                          ),
                          child: Row(
                            children: [
                              // Avatar / initial
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: attrs.brand600.withValues(alpha: 0.2),
                                child: Text(
                                  username.isNotEmpty ? username[0].toUpperCase() : '?',
                                  style: TextStyle(color: attrs.brand600, fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Info
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(username,
                                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                        const SizedBox(width: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: userType == 'reviewer'
                                                ? Colors.green.withValues(alpha: 0.15)
                                                : attrs.brand600.withValues(alpha: 0.12),
                                            borderRadius: BorderRadius.circular(4),
                                            border: Border.all(
                                              color: userType == 'reviewer'
                                                  ? Colors.green.withValues(alpha: 0.4)
                                                  : attrs.brand600.withValues(alpha: 0.3),
                                            ),
                                          ),
                                          child: Text(
                                            userType == 'reviewer'
                                                ? (isGerman ? 'Reviewer' : 'Reviewer')
                                                : (isGerman ? 'Übersetzer' : 'Translator'),
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: userType == 'reviewer' ? Colors.green : attrs.brand600,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    Text(email,
                                        style: TextStyle(fontSize: 11, color: attrs.textMuted)),
                                    if (langs.isNotEmpty && langs != '–')
                                      Text(langs,
                                          style: TextStyle(fontSize: 10, color: attrs.textMuted)),
                                  ],
                                ),
                              ),
                              // Actions
                              IconButton(
                                icon: Icon(LucideIcons.lock, size: 17, color: Colors.orange.shade400),
                                tooltip: isGerman ? 'Konto sperren' : 'Deactivate',
                                onPressed: () => _confirmAndAct(
                                  id: id,
                                  username: username,
                                  action: 'deactivate',
                                  isGerman: isGerman,
                                  attrs: attrs,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(LucideIcons.trash2, size: 17, color: Colors.redAccent),
                                tooltip: isGerman ? 'Konto löschen' : 'Delete account',
                                onPressed: () => _confirmAndAct(
                                  id: id,
                                  username: username,
                                  action: 'delete',
                                  isGerman: isGerman,
                                  attrs: attrs,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],

          // Preferences & Configurations
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Column 1: Appearance & Styles
              Expanded(
                child: Column(
                  children: [
                    // Dynamic Theme Settings
                    GlassContainer(
                      border: Border.all(color: attrs.borderMain),
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(LucideIcons.palette, size: 20, color: attrs.brand600),
                              const SizedBox(width: 8),
                              Text(
                                isGerman ? 'Erscheinungsbild' : 'Appearance',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: attrs.textMain,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          ...['light', 'dark', 'glassy', 'nature', 'liquid'].map((themeId) {
                            final isSel = themeState.themeId == themeId;
                            String tName = themeId.toUpperCase();
                            if (themeId == 'light') tName = isGerman ? 'HELL' : 'LIGHT';
                            if (themeId == 'dark') tName = isGerman ? 'DUNKEL' : 'DARK';
                            if (themeId == 'glassy') tName = isGerman ? 'GLASIG' : 'GLASSY';
                            if (themeId == 'nature') tName = isGerman ? 'NATUR' : 'NATURE';
                            if (themeId == 'liquid') tName = isGerman ? 'FLÜSSIG' : 'LIQUID';

                            IconData tIcon = LucideIcons.palette;
                            if (themeId == 'light') tIcon = LucideIcons.sun;
                            if (themeId == 'dark') tIcon = LucideIcons.moon;
                            if (themeId == 'nature') tIcon = LucideIcons.droplets;
                            if (themeId == 'liquid') tIcon = LucideIcons.zap;

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: InkWell(
                                onTap: () => ref.read(themeProvider.notifier).setTheme(themeId),
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: isSel ? attrs.brand600.withOpacity(0.2) : attrs.bgInput,
                                    border: Border.all(color: isSel ? attrs.brand600 : attrs.borderMain),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(tIcon, size: 16, color: isSel ? attrs.brand600 : attrs.textMuted),
                                          const SizedBox(width: 12),
                                          Text(
                                            tName,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: isSel ? attrs.brand600 : attrs.textMain,
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (isSel)
                                        CircleAvatar(radius: 4, backgroundColor: attrs.brand600),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Typography
                    GlassContainer(
                      border: Border.all(color: attrs.borderMain),
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(LucideIcons.type, size: 20, color: attrs.brand600),
                              const SizedBox(width: 8),
                              Text(
                                isGerman ? 'Typografie' : 'Typography',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: attrs.textMain,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            isGerman 
                                ? 'Schriftstil der Benutzeroberfläche ändern.'
                                : 'Modify interface font family.',
                            style: TextStyle(color: attrs.textMuted, fontSize: 13),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              _fontButton('inter', 'Inter', isGerman ? 'Klar' : 'Clean', themeState.fontStyle, attrs),
                              const SizedBox(width: 8),
                              _fontButton('outfit', 'Outfit', isGerman ? 'Futuristisch' : 'Futuristic', themeState.fontStyle, attrs),
                              const SizedBox(width: 8),
                              _fontButton('sora', 'Sora', isGerman ? 'Tech' : 'Tech', themeState.fontStyle, attrs),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),

              // Column 2: Workflow, Sync & Backups
              Expanded(
                child: Column(
                  children: [
                    // Workflow, Confetti, and large UI
                    GlassContainer(
                      border: Border.all(color: attrs.borderMain),
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(LucideIcons.zap, size: 20, color: attrs.brand600),
                              const SizedBox(width: 8),
                              Text(
                                isGerman ? 'Workflow & Spaß' : 'Workflow & Fun',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: attrs.textMain,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          
                          // Confetti
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      isGerman ? 'Erfolgs-Feier (Konfetti)' : 'Success Celebration (Confetti)',
                                      style: TextStyle(fontWeight: FontWeight.bold, color: attrs.textMain),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      isGerman 
                                          ? 'Zeigt eine kleine Animation beim erfolgreichen Speichern.' 
                                          : 'Shows a small animation when successfully saving.',
                                      style: TextStyle(color: attrs.textMuted, fontSize: 11),
                                    ),
                                  ],
                                ),
                              ),
                              Switch(
                                value: themeState.confettiEnabled,
                                onChanged: (val) => ref.read(themeProvider.notifier).setConfettiEnabled(val),
                                activeThumbColor: attrs.brand600,
                              ),
                            ],
                          ),
                          const Divider(height: 32),

                          // Large UI
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      isGerman ? 'Verbesserte Lesbarkeit (Große Schrift)' : 'Enhanced Readability (Large Font)',
                                      style: TextStyle(fontWeight: FontWeight.bold, color: attrs.textMain),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      isGerman 
                                          ? 'Vergrößert die Schrift und Badges für bessere Sichtbarkeit.' 
                                          : 'Increases the fonts and badges sizing for readability.',
                                      style: TextStyle(color: attrs.textMuted, fontSize: 11),
                                    ),
                                  ],
                                ),
                              ),
                              Switch(
                                value: themeState.largeUi,
                                onChanged: (val) => ref.read(themeProvider.notifier).setLargeUi(val),
                                activeThumbColor: attrs.brand600,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (isAdmin) ...[
                    const SizedBox(height: 24),

                    // Database Synchronization Controls
                    GlassContainer(
                      border: Border.all(color: attrs.borderMain),
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(LucideIcons.database, size: 20, color: attrs.brand600),
                                  const SizedBox(width: 8),
                                  Text(
                                    isGerman ? 'Datenbank-Sync' : 'Database Sync',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: attrs.textMain,
                                    ),
                                  ),
                                ],
                              ),
                              Tooltip(
                                message: isGerman 
                                    ? 'Gleicht die DB mit den JSON-Dateien auf dem Server ab.'
                                    : 'Synchronizes db entries with json translation files.',
                                child: Icon(LucideIcons.helpCircle, size: 16, color: attrs.textMuted),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            isGerman 
                                ? 'Gleicht die internen Datenbank-Einträge mit den JSON-Dateien auf dem Server ab.' 
                                : 'Syncs internal database entries with translation JSONs on the server.',
                            style: TextStyle(color: attrs.textMuted, fontSize: 13),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: _syncing ? null : _handleSync,
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    backgroundColor: attrs.brand600,
                                  ),
                                  icon: _syncing 
                                      ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                                      : const Icon(LucideIcons.refreshCw, size: 16),
                                  label: Text(
                                    _syncing 
                                        ? (isGerman ? 'Synchronisiere...' : 'Syncing...')
                                        : (isGerman ? 'Jetzt synchronisieren' : 'Sync Now'),
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: _syncing ? null : _handlePrioritySync,
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    side: BorderSide(color: attrs.borderMain),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  ),
                                  icon: Icon(LucideIcons.zap, size: 16, color: Colors.amber[600]),
                                  label: Text(
                                    isGerman ? 'D11 Liste einlesen' : 'Sync D11 List',
                                    style: TextStyle(color: attrs.textMain, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Backup Upload Card
                    GlassContainer(
                      border: Border.all(color: attrs.borderMain),
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(LucideIcons.upload, size: 20, color: attrs.brand600),
                              const SizedBox(width: 8),
                              Text(
                                isGerman ? 'Backup einspielen (.zip)' : 'Upload Backup (.zip)',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: attrs.textMain,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          if (!_isUploading)
                            ElevatedButton.icon(
                              onPressed: () => _pickAndUploadBackup(attrs, isGerman),
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(50),
                                backgroundColor: attrs.bgInput,
                                foregroundColor: attrs.textMain,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(color: attrs.borderMain),
                                ),
                              ),
                              icon: const Icon(LucideIcons.plus, size: 18),
                              label: Text(
                                isGerman ? 'ZIP Datei auswählen' : 'Select ZIP File',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )
                          else
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      isGerman ? 'Lade hoch...' : 'Uploading...',
                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: attrs.textMuted),
                                    ),
                                    Text(
                                      '${(_uploadProgress * 100).toStringAsFixed(0)}%',
                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: attrs.brand600),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                LinearProgressIndicator(
                                  value: _uploadProgress,
                                  color: attrs.brand600,
                                  backgroundColor: attrs.bgInput,
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // System Diagnostic Logs
                    GlassContainer(
                      border: Border.all(color: attrs.borderMain),
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(LucideIcons.terminal, size: 20, color: attrs.brand600),
                                  const SizedBox(width: 8),
                                  Text(
                                    isGerman ? 'Fehler-Diagnose & System-Logs' : 'Error Diagnostics & System Logs',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: attrs.textMain,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  TextButton.icon(
                                    onPressed: () {
                                      final text = LogService.logs.map((e) => e.toString()).join('\n');
                                      html.window.navigator.clipboard?.writeText(text);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(isGerman ? 'Logs in Zwischenablage kopiert! 📋' : 'Logs copied to clipboard! 📋'),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                    },
                                    icon: const Icon(LucideIcons.copy, size: 14),
                                    label: Text(isGerman ? 'Kopieren' : 'Copy Logs'),
                                    style: TextButton.styleFrom(foregroundColor: attrs.textMuted),
                                  ),
                                  const SizedBox(width: 8),
                                  TextButton.icon(
                                    onPressed: () {
                                      LogService.rotate();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(isGerman ? 'Logs archiviert und rotiert! 📁' : 'Logs archived and rotated! 📁'),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                    },
                                    icon: const Icon(LucideIcons.archive, size: 14),
                                    label: Text(isGerman ? 'Rotieren' : 'Rotate'),
                                    style: TextButton.styleFrom(foregroundColor: attrs.brand600),
                                  ),
                                  const SizedBox(width: 8),
                                  TextButton.icon(
                                    onPressed: () {
                                      LogService.clear();
                                    },
                                    icon: const Icon(LucideIcons.trash2, size: 14),
                                    label: Text(isGerman ? 'Löschen' : 'Clear'),
                                    style: TextButton.styleFrom(foregroundColor: Colors.redAccent),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Log level filters
                              Row(
                                children: ['ALL', 'INFO', 'WARNING', 'ERROR'].map((level) {
                                  final isSel = _logLevelFilter == level;
                                  Color btnColor = attrs.textMuted;
                                  if (isSel) {
                                    if (level == 'INFO') btnColor = Colors.green;
                                    if (level == 'WARNING') btnColor = Colors.orange;
                                    if (level == 'ERROR') btnColor = Colors.redAccent;
                                    if (level == 'ALL') btnColor = attrs.brand600;
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _logLevelFilter = level;
                                        });
                                      },
                                      borderRadius: BorderRadius.circular(8),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: isSel ? btnColor.withOpacity(0.15) : Colors.transparent,
                                          border: Border.all(color: isSel ? btnColor : attrs.borderMain),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          level,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: isSel ? btnColor : attrs.textMuted,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                              // Max log entries (Logrotation limit dropdown)
                              Row(
                                children: [
                                  Text(
                                    isGerman ? 'Loglimit: ' : 'Log Limit: ',
                                    style: TextStyle(fontSize: 12, color: attrs.textMuted, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: attrs.bgInput,
                                      border: Border.all(color: attrs.borderMain),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: DropdownButton<int>(
                                      value: LogService.maxEntries,
                                      items: [50, 100, 200, 500, 1000].map((limit) {
                                        return DropdownMenuItem<int>(
                                          value: limit,
                                          child: Text(
                                            limit.toString(),
                                            style: TextStyle(color: attrs.textMain, fontSize: 12, fontWeight: FontWeight.bold),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (val) {
                                        if (val != null) {
                                          setState(() {
                                            LogService.setMaxEntries(val);
                                          });
                                        }
                                      },
                                      underline: const SizedBox(),
                                      dropdownColor: attrs.bgInput,
                                      iconEnabledColor: attrs.brand600,
                                      style: TextStyle(color: attrs.textMain),
                                      isDense: true,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Container(
                            height: 300,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: attrs.borderMain),
                            ),
                            child: () {
                              final filteredLogs = LogService.logs.where((entry) {
                                if (_logLevelFilter == 'ALL') return true;
                                return entry.level == _logLevelFilter;
                              }).toList();

                              if (filteredLogs.isEmpty) {
                                return Center(
                                  child: Text(
                                    isGerman ? 'Keine Logs vorhanden' : 'No logs recorded',
                                    style: TextStyle(color: attrs.textMuted, fontFamily: 'monospace'),
                                  ),
                                );
                              }

                              return ListView.builder(
                                padding: const EdgeInsets.all(12),
                                itemCount: filteredLogs.length,
                                itemBuilder: (context, index) {
                                  final entry = filteredLogs[filteredLogs.length - 1 - index];
                                  Color levelColor = Colors.green;
                                  if (entry.level == 'WARNING') levelColor = Colors.orange;
                                  if (entry.level == 'ERROR') levelColor = Colors.redAccent;

                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: SelectableText.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: '[${entry.timestamp.toLocal().toString().split('.').first}] ',
                                            style: TextStyle(color: attrs.textMuted, fontSize: 12, fontFamily: 'monospace'),
                                          ),
                                          TextSpan(
                                            text: '[${entry.level}] ',
                                            style: TextStyle(color: levelColor, fontWeight: FontWeight.bold, fontSize: 12, fontFamily: 'monospace'),
                                          ),
                                          TextSpan(
                                            text: entry.message,
                                            style: TextStyle(color: attrs.textMain, fontSize: 12, fontFamily: 'monospace'),
                                          ),
                                          if (entry.details != null)
                                            TextSpan(
                                              text: '\n${entry.details}',
                                              style: TextStyle(color: Colors.red.shade200, fontSize: 11, fontFamily: 'monospace'),
                                            ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }(),
                          ),
                        ],
                      ),
                    ),
                    ], // end if (isAdmin)
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _fontButton(String id, String label, String desc, String activeId, ThemeAttributes attrs) {
    final isSel = activeId == id;
    return Expanded(
      child: InkWell(
        onTap: () => ref.read(themeProvider.notifier).setFontStyle(id),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSel ? attrs.brand600.withOpacity(0.2) : attrs.bgInput,
            border: Border.all(color: isSel ? attrs.brand600 : attrs.borderMain),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isSel ? attrs.brand600 : attrs.textMain,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                desc,
                style: TextStyle(
                  fontSize: 10,
                  color: attrs.textMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
