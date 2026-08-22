import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_client.dart';
import '../services/token_storage.dart';
import 'language_provider.dart';

// Represents the User model
class User {
  final String id;
  final String username;
  final String? name;
  final String? email;
  final String? avatarUrl;
  final String? role;
  final String userType; // 'translator' or 'reviewer'
  final List<String> targetLanguages;
  final String? googleAiKey;
  final int aiBatchLimit;
  final String? aiPrompt;
  final String? deeplApiKey;
  final String? lastReviewedProject;

  User({
    required this.id,
    required this.username,
    this.name,
    this.email,
    this.avatarUrl,
    this.role,
    this.userType = 'translator',
    this.targetLanguages = const [],
    this.googleAiKey,
    this.aiBatchLimit = 5,
    this.aiPrompt,
    this.deeplApiKey,
    this.lastReviewedProject,
  });

  bool get isReviewer => userType == 'reviewer' || role == 'admin';
  bool get isAdmin => role == 'admin';

  factory User.fromJson(Map<String, dynamic> json) {
    final langs = json['target_languages'];
    return User(
      id: json['id']?.toString() ?? '',
      username: json['username'] ?? '',
      name: json['name'],
      email: json['email'],
      avatarUrl: json['avatar_url'],
      role: json['role'],
      userType: json['user_type'] ?? 'translator',
      targetLanguages: langs is List ? List<String>.from(langs) : [],
      googleAiKey: json['google_ai_key'],
      aiBatchLimit: json['ai_batch_limit'] ?? 5,
      aiPrompt: json['ai_prompt'],
      deeplApiKey: json['deepl_api_key'],
      lastReviewedProject: json['last_reviewed_project'],
    );
  }
}

// State for the Auth Provider
class AuthState {
  final bool isLoading;
  final User? user;
  final String? error;

  AuthState({this.isLoading = false, this.user, this.error});

  AuthState copyWith({bool? isLoading, User? user, String? error}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      user: user,
      error: error,
    );
  }
}

class AuthNotifier extends Notifier<AuthState> {
  final ApiClient _api = ApiClient();

  @override
  AuthState build() {
    Future.microtask(() => _checkAuthStatus());
    return AuthState(isLoading: true);
  }

  Future<void> refreshProfile() async {
    await _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final token = await TokenStorage.getToken();

    if (token != null) {
      try {
        final res = await _api.dio.get('/auth/me');
        state = AuthState(isLoading: false, user: User.fromJson(res.data));
      } catch (e) {
        // If request fails (invalid token, server down, etc.)
        state = AuthState(isLoading: false, user: null);
      }
    } else {
      state = AuthState(isLoading: false, user: null);
    }
  }

  Future<bool> login(String username, String password, {bool remember = false}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final res = await _api.dio.post('/auth/login', data: {
        'username': username,
        'password': password,
      });

      final token = res.data['token'];
      final userData = res.data['user'];

      await TokenStorage.saveToken(token, remember);

      state = AuthState(isLoading: false, user: User.fromJson(userData));
      return true;
    } catch (e) {
      final isGerman = ref.read(languageProvider).targetLanguage.code == 'de';
      state = AuthState(
        isLoading: false,
        error: isGerman
            ? 'Login fehlgeschlagen. Bitte überprüfe deine Daten.'
            : 'Login failed. Please check your details.',
        user: null
      );
      return false;
    }
  }

  Future<void> logout() async {
    await TokenStorage.clearToken();
    state = AuthState(isLoading: false, user: null);
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});
