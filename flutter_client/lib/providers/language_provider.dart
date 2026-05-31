import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../services/api_client.dart';

class Language {
  final String code;
  final String name;

  Language({required this.code, required this.name});

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      code: json['code'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'name': name,
      };
}

class LanguageState {
  final List<Language> languages;
  final Language targetLanguage;
  final bool isLoading;

  LanguageState({
    required this.languages,
    required this.targetLanguage,
    this.isLoading = false,
  });

  LanguageState copyWith({
    List<Language>? languages,
    Language? targetLanguage,
    bool? isLoading,
  }) {
    return LanguageState(
      languages: languages ?? this.languages,
      targetLanguage: targetLanguage ?? this.targetLanguage,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class LanguageNotifier extends Notifier<LanguageState> {
  final ApiClient _api = ApiClient();

  @override
  LanguageState build() {
    Future.microtask(() => _init());
    return LanguageState(
      languages: [Language(code: 'de', name: 'German')],
      targetLanguage: Language(code: 'de', name: 'German'),
      isLoading: true,
    );
  }

  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Read saved target language
    Language savedLang = Language(code: 'de', name: 'German');
    final savedJson = prefs.getString('targetLanguage');
    if (savedJson != null) {
      try {
        final Map<String, dynamic> parsed = jsonDecode(savedJson);
        savedLang = Language.fromJson(parsed);
      } catch (_) {}
    }

    state = LanguageState(
      languages: [savedLang],
      targetLanguage: savedLang,
      isLoading: true,
    );

    await fetchLanguages();
  }

  Future<void> fetchLanguages() async {
    try {
      final response = await _api.dio.get('/languages');
      final List<dynamic> list = response.data;
      final List<Language> parsedLanguages =
          list.map((l) => Language.fromJson(l)).toList();

      // Find if our saved target language exists in the fetched list
      Language currentTarget = state.targetLanguage;
      final exists = parsedLanguages.any((l) => l.code == currentTarget.code);
      if (!exists && parsedLanguages.isNotEmpty) {
        currentTarget = parsedLanguages.firstWhere(
          (l) => l.code == 'de',
          orElse: () => parsedLanguages.first,
        );
      }

      state = LanguageState(
        languages: parsedLanguages,
        targetLanguage: currentTarget,
        isLoading: false,
      );
    } catch (e) {
      print('Failed to fetch languages: $e');
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> setTargetLanguage(Language language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('targetLanguage', jsonEncode(language.toJson()));
    state = state.copyWith(targetLanguage: language);
  }
}

final languageProvider = NotifierProvider<LanguageNotifier, LanguageState>(() {
  return LanguageNotifier();
});
