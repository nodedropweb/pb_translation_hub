import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../services/api_client.dart';

// Represents the current state of the theme, typography, backgrounds and user preferences.
class ThemeState {
  final String themeId;
  final String fontStyle; // 'inter', 'outfit', 'sora'
  final bool confettiEnabled;
  final bool largeUi;
  final String? bgImageUrl;
  final bool isLoadingBg;
  final Map<String, dynamic>? photographer;

  ThemeState({
    required this.themeId,
    required this.fontStyle,
    required this.confettiEnabled,
    required this.largeUi,
    this.bgImageUrl,
    this.isLoadingBg = false,
    this.photographer,
  });

  ThemeState copyWith({
    String? themeId,
    String? fontStyle,
    bool? confettiEnabled,
    bool? largeUi,
    String? bgImageUrl,
    bool? isLoadingBg,
    Map<String, dynamic>? photographer,
  }) {
    return ThemeState(
      themeId: themeId ?? this.themeId,
      fontStyle: fontStyle ?? this.fontStyle,
      confettiEnabled: confettiEnabled ?? this.confettiEnabled,
      largeUi: largeUi ?? this.largeUi,
      bgImageUrl: bgImageUrl ?? this.bgImageUrl,
      isLoadingBg: isLoadingBg ?? this.isLoadingBg,
      photographer: photographer ?? this.photographer,
    );
  }
}

class ThemeNotifier extends Notifier<ThemeState> {
  // ApiClient.baseUrl wird zur Laufzeit ausgewertet — funktioniert lokal
  // (localhost:9901) und auf Produktion (https://pb.drupaltutorials.de/api).
  // Eigenes Dio-Objekt damit der ThemeNotifier unabhängig vom Auth-State lädt.

  @override
  ThemeState build() {
    // Fire off async load, but return initial state synchronously
    _loadInitialState();
    return ThemeState(
      themeId: 'glassy',
      fontStyle: 'inter',
      confettiEnabled: true,
      largeUi: false,
    );
  }

  Future<void> _loadInitialState() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString('pb-theme') ?? 'glassy';
    final savedFont = prefs.getString('pb-fontStyle') ?? 'inter';
    final savedConfetti = prefs.getBool('pb-confettiEnabled') ?? true;
    final savedLargeUi = prefs.getBool('pb-largeUi') ?? false;
    final savedBg = prefs.getString('pb-bgImage');
    
    Map<String, dynamic>? savedPhotographer;
    final photoJson = prefs.getString('pb-photographer');
    if (photoJson != null) {
      try {
        savedPhotographer = jsonDecode(photoJson) as Map<String, dynamic>;
      } catch (_) {}
    }
    
    state = ThemeState(
      themeId: savedTheme,
      fontStyle: savedFont,
      confettiEnabled: savedConfetti,
      largeUi: savedLargeUi,
      bgImageUrl: savedBg,
      photographer: savedPhotographer,
    );
    
    if (savedBg == null) {
      fetchNewBackground();
    }
  }

  Future<void> setTheme(String themeId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('pb-theme', themeId);
    state = state.copyWith(themeId: themeId);
    
    // Auto-fetch dynamic backgrounds based on the theme keywords
    fetchNewBackground();
  }

  Future<void> setFontStyle(String fontStyle) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('pb-fontStyle', fontStyle);
    state = state.copyWith(fontStyle: fontStyle);
  }

  Future<void> setConfettiEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('pb-confettiEnabled', enabled);
    state = state.copyWith(confettiEnabled: enabled);
  }

  Future<void> setLargeUi(bool largeUi) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('pb-largeUi', largeUi);
    state = state.copyWith(largeUi: largeUi);
  }

  Future<void> fetchNewBackground() async {
    state = state.copyWith(isLoadingBg: true);
    
    // Choose search keywords based on selected theme
    String keywords = 'abstract,dark,glass';
    if (state.themeId == 'light') {
      keywords = 'minimalist,white,clean';
    } else if (state.themeId == 'dark') {
      keywords = 'midnight,stars,dark';
    } else if (state.themeId == 'nature') {
      keywords = 'forest,mountains,river,nature';
    } else if (state.themeId == 'liquid') {
      keywords = 'liquid,color,flow';
    } else if (state.themeId == 'glassy') {
      keywords = 'glassmorphism,abstract,blurry';
    }

    try {
      final response = await ApiClient().dio.get('/unsplash/random-bg', queryParameters: {'query': keywords});
      
      final url = response.data['url'] as String;
      final photographer = response.data['photographer'];
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('pb-bgImage', url);
      
      if (photographer != null) {
        await prefs.setString('pb-photographer', jsonEncode(photographer));
      } else {
        await prefs.remove('pb-photographer');
      }

      state = state.copyWith(
        bgImageUrl: url,
        isLoadingBg: false,
        photographer: photographer,
      );
    } catch (e) {
      print('Failed to fetch background: $e');
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('pb-photographer');
      
      // Theme-specific fallback images
      String fallbackUrl = 'https://images.unsplash.com/photo-1550684848-fac1c5b4e853?q=80&w=1920&auto=format&fit=crop';
      if (state.themeId == 'light') {
        fallbackUrl = 'https://images.unsplash.com/photo-1497366216548-37526070297c?q=80&w=1920&auto=format&fit=crop';
      } else if (state.themeId == 'nature') {
        fallbackUrl = 'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?q=80&w=1920&auto=format&fit=crop';
      } else if (state.themeId == 'liquid') {
        fallbackUrl = 'https://images.unsplash.com/photo-1541701494587-cb58502866ab?q=80&w=1920&auto=format&fit=crop';
      }
      
      state = state.copyWith(
        isLoadingBg: false,
        bgImageUrl: fallbackUrl,
        photographer: null,
      );
    }
  }
}

final themeProvider = NotifierProvider<ThemeNotifier, ThemeState>(() {
  return ThemeNotifier();
});
