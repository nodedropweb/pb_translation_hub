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
    'pearl': ThemeAttributes(
      // Weiß-Lavendel — inspiriert vom Clean-SaaS-Design mit festem Hintergrund
      // overlayColor ist 100 % deckend → Hintergrundbild vollständig versteckt
      bgSidebar:    const Color(0xFFFCFAFF), // nahezu weißes Lavendel — opake Sidebar
      bgCard:       const Color(0xFFFFFFFF), // reines Weiß — „Papier"-Karten
      bgInput:      const Color(0xFFF0ECFB), // zartes Lavendel für Eingabefelder
      textMain:     const Color(0xFF1C1A2E), // tiefes Indigo-Anthrazit
      textMuted:    const Color(0xFF6B6A8E), // mittleres Lila-Grau
      borderMain:   const Color(0xFFE2DCF8), // weiches Lavendel-Border
      brand600:     const Color(0xFF8B7FD4), // sanftes Mittel-Lila
      brand700:     const Color(0xFF7566C4), // tieferes Lila
      overlayColor: const Color(0xFFECE8F9), // 100 % deckend → Lavender-Festfarbe
      glassBlur:    1.0,  // minimaler Blur → flacher, cleaner Look wie im Referenz-Design
      brightness:   Brightness.light,
    ),
    'stage': ThemeAttributes(
      // Dunkles Smaragd-Teal — inspiriert vom Concert/Event-App-Design
      bgSidebar:    const Color(0xF00C2222), // 94 % dunkles Teal — klare Sidebar
      bgCard:       const Color(0xCC0F2A28), // 80 % dunkles Teal-Card
      bgInput:      const Color(0xFF091A1A), // solides sehr dunkles Teal für Inputs
      textMain:     Colors.white,
      textMuted:    const Color(0xFF7AA09C), // gedecktes Teal-Grau
      borderMain:   const Color(0x3326504A), // 20 % Teal-Border
      brand600:     const Color(0xFFF58620), // warmes Orange — Haupt-Akzent
      brand700:     const Color(0xFFD97010), // tieferes Orange
      overlayColor: const Color(0xCC0B1E1C), // 80 % dunkles Teal-Overlay
      glassBlur:    20.0,
      brightness:   Brightness.dark,
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
      autoAutop: false,
    ));
  }
}
