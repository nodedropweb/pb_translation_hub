import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/theme_provider.dart';

class ThemeAttributes {
  final Color bgSidebar;
  final Color bgCard;
  final Color bgInput;
  final Color textMain;
  final Color textMuted;
  final Color borderMain;
  final Color brand600;
  final Color brand700;
  final Color overlayColor;
  final double glassBlur;
  final Brightness brightness;

  ThemeAttributes({
    required this.bgSidebar,
    required this.bgCard,
    required this.bgInput,
    required this.textMain,
    required this.textMuted,
    required this.borderMain,
    required this.brand600,
    required this.brand700,
    required this.overlayColor,
    required this.glassBlur,
    required this.brightness,
  });
}

class AppTheme {
  static final Map<String, ThemeAttributes> themes = {
    'light': ThemeAttributes(
      bgSidebar: const Color(0xCCFFFFFF),
      bgCard: const Color(0xB3FFFFFF),
      bgInput: const Color(0x80F1F5F9),
      textMain: const Color(0xFF0F172A),
      textMuted: const Color(0xFF475569),
      borderMain: const Color(0x1A000000),
      brand600: const Color(0xFF7F56D9),
      brand700: const Color(0xFF6941C6),
      overlayColor: const Color(0x4DFFFFFF),
      glassBlur: 16.0,
      brightness: Brightness.light,
    ),
    'dark': ThemeAttributes(
      bgSidebar: const Color(0xBF0F1114),
      bgCard: const Color(0xA6191C20),
      bgInput: const Color(0x660A0A0B),
      textMain: Colors.white,
      textMuted: const Color(0xB3FFFFFF),
      borderMain: const Color(0x26FFFFFF),
      brand600: const Color(0xFF8B5CF6),
      brand700: const Color(0xFF7C3AED),
      overlayColor: const Color(0x80000000),
      glassBlur: 20.0,
      brightness: Brightness.dark,
    ),
    'glassy': ThemeAttributes(
      bgSidebar: const Color(0xD912285F),
      bgCard: const Color(0x33006AA9),
      bgInput: const Color(0x8012285F),
      textMain: Colors.white,
      textMuted: const Color(0xCCCEEDF9),
      borderMain: const Color(0x66009CDE),
      brand600: const Color(0xFF009CDE),
      brand700: const Color(0xFF006AA9),
      overlayColor: const Color(0x6612285F),
      glassBlur: 20.0,
      brightness: Brightness.dark,
    ),
    'nature': ThemeAttributes(
      bgSidebar: const Color(0x99050A05),
      bgCard: const Color(0x73000000),
      bgInput: const Color(0x80000000),
      textMain: Colors.white,
      textMuted: const Color(0xC0FFFFFF),
      borderMain: const Color(0x33FFFFFF),
      brand600: const Color(0xFF10B981),
      brand700: const Color(0xFF047857),
      overlayColor: const Color(0x59000000),
      glassBlur: 24.0,
      brightness: Brightness.dark,
    ),
    'liquid': ThemeAttributes(
      bgSidebar: const Color(0xCC070A14),
      bgCard: const Color(0xB30F172A),
      bgInput: const Color(0x66070A14),
      textMain: const Color(0xFFF8FAFC),
      textMuted: const Color(0xFF94A3B8),
      borderMain: const Color(0x4038BDF8),
      brand600: const Color(0xFF0EA5E9),
      brand700: const Color(0xFF0284C7),
      overlayColor: const Color(0x73060A14),
      glassBlur: 24.0,
      brightness: Brightness.dark,
    ),
  };

  static ThemeAttributes getAttributes(String themeId) {
    return themes[themeId] ?? themes['glassy']!;
  }

  static ThemeData getTheme(ThemeState state) {
    final attrs = getAttributes(state.themeId);
    
    // Choose font family
    TextTheme baseTextTheme;
    if (state.fontStyle == 'outfit') {
      baseTextTheme = GoogleFonts.outfitTextTheme(
        ThemeData(brightness: attrs.brightness).textTheme,
      );
    } else if (state.fontStyle == 'sora') {
      baseTextTheme = GoogleFonts.soraTextTheme(
        ThemeData(brightness: attrs.brightness).textTheme,
      );
    } else {
      baseTextTheme = GoogleFonts.interTextTheme(
        ThemeData(brightness: attrs.brightness).textTheme,
      );
    }

    // Apply scale for Large UI if toggled
    if (state.largeUi) {
      baseTextTheme = baseTextTheme.copyWith(
        displayLarge: baseTextTheme.displayLarge?.copyWith(fontSize: 64),
        displayMedium: baseTextTheme.displayMedium?.copyWith(fontSize: 48),
        displaySmall: baseTextTheme.displaySmall?.copyWith(fontSize: 36),
        headlineLarge: baseTextTheme.headlineLarge?.copyWith(fontSize: 32),
        headlineMedium: baseTextTheme.headlineMedium?.copyWith(fontSize: 28),
        headlineSmall: baseTextTheme.headlineSmall?.copyWith(fontSize: 24),
        titleLarge: baseTextTheme.titleLarge?.copyWith(fontSize: 22),
        titleMedium: baseTextTheme.titleMedium?.copyWith(fontSize: 18),
        titleSmall: baseTextTheme.titleSmall?.copyWith(fontSize: 16),
        bodyLarge: baseTextTheme.bodyLarge?.copyWith(fontSize: 18),
        bodyMedium: baseTextTheme.bodyMedium?.copyWith(fontSize: 16),
        bodySmall: baseTextTheme.bodySmall?.copyWith(fontSize: 14),
        labelLarge: baseTextTheme.labelLarge?.copyWith(fontSize: 16),
        labelMedium: baseTextTheme.labelMedium?.copyWith(fontSize: 14),
        labelSmall: baseTextTheme.labelSmall?.copyWith(fontSize: 12),
      );
    }

    return ThemeData(
      brightness: attrs.brightness,
      primaryColor: attrs.brand600,
      scaffoldBackgroundColor: Colors.transparent,
      colorScheme: ColorScheme(
        brightness: attrs.brightness,
        primary: attrs.brand600,
        onPrimary: attrs.brightness == Brightness.dark ? Colors.white : Colors.black,
        secondary: attrs.brand700,
        onSecondary: Colors.white,
        error: Colors.redAccent,
        onError: Colors.white,
        surface: attrs.bgCard,
        onSurface: attrs.textMain,
      ),
      cardTheme: CardThemeData(
        color: attrs.bgCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: attrs.borderMain, width: 1),
        ),
      ),
      textTheme: baseTextTheme.copyWith(
        bodyLarge: baseTextTheme.bodyLarge?.copyWith(color: attrs.textMain),
        bodyMedium: baseTextTheme.bodyMedium?.copyWith(color: attrs.textMain),
        labelLarge: baseTextTheme.labelLarge?.copyWith(color: attrs.textMuted),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: attrs.bgInput,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: attrs.borderMain),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: attrs.borderMain),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: attrs.brand600, width: 2),
        ),
        labelStyle: TextStyle(color: attrs.textMuted),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: attrs.brand600,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  // Backwards compatibility getter
  static ThemeData get darkTheme {
    return getTheme(ThemeState(
      themeId: 'dark',
      fontStyle: 'inter',
      confettiEnabled: true,
      largeUi: false,
    ));
  }
}
