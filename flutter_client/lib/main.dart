import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'l10n/app_localizations.dart';
import 'theme/app_theme.dart';
import 'providers/language_provider.dart';
import 'providers/theme_provider.dart';
import 'services/token_storage.dart';
import 'router.dart';

void main() async {
  // Pflicht vor SystemChrome-Aufrufen und async-Initialisierungen.
  WidgetsFlutterBinding.ensureInitialized();

  // Token-Cache vorladen — stellt sicher dass der erste API-Request (z.B.
  // beim AuthProvider-Check) bereits das Token aus dem Cache lesen kann,
  // ohne auf SharedPreferences zu warten (Race-Condition-Schutz).
  await TokenStorage.getToken();

  // Alle Orientierungen erlauben — das Tablet (M986-EEA) wird
  // sowohl im Portrait als auch im Landscape betrieben.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(
    // ProviderScope is required for Riverpod
    const ProviderScope(
      child: TranslationHubApp(),
    ),
  );
}

class TranslationHubApp extends ConsumerWidget {
  const TranslationHubApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeState = ref.watch(themeProvider);

    // The app's own interface language follows the target language selected
    // in the language dropdown — a translator working on French content sees
    // a French interface, not just French content in a German UI. Only
    // 'de' has a full native translation right now; every other target
    // language falls back to English (the closest thing to a lingua franca
    // for the module descriptions themselves) rather than staying German.
    final targetLangCode = ref.watch(languageProvider).targetLanguage.code;
    final appLocale = targetLangCode == 'de' ? const Locale('de') : const Locale('en');

    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      theme: AppTheme.getTheme(themeState),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      locale: appLocale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
