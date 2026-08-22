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

// Maps our internal language codes (from languages.json, e.g. 'pt-br',
// 'zh-hans') to the Flutter Locale their app_<code>.arb file was generated
// for. Keep in sync with lib/l10n/app_*.arb.
const _nativeUiLocales = <String, Locale>{
  'de': Locale('de'),
  'fr': Locale('fr'),
  'ja': Locale('ja'),
  'ru': Locale('ru'),
  'es': Locale('es'),
  'tr': Locale('tr'),
  'pt-br': Locale('pt', 'BR'),
  'pt-pt': Locale('pt'),
  'zh-hans': Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
  'uk': Locale('uk'),
  'nl': Locale('nl'),
  'nb': Locale('nb'),
  'hu': Locale('hu'),
  'ca': Locale('ca'),
  'it': Locale('it'),
  'sv': Locale('sv'),
  'da': Locale('da'),
  'pl': Locale('pl'),
  'ro': Locale('ro'),
  'lt': Locale('lt'),
  'et': Locale('et'),
  'az': Locale('az'),
  'id': Locale('id'),
  'ar': Locale('ar'),
  'ko': Locale('ko'),
};

class TranslationHubApp extends ConsumerWidget {
  const TranslationHubApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeState = ref.watch(themeProvider);

    // The app's own interface language follows the target language selected
    // in the language dropdown — a translator working on French content sees
    // a French interface, not just French content in a German UI. Only the
    // locales below have a full native translation right now; every other
    // target language falls back to English (the closest thing to a lingua
    // franca for the module descriptions themselves) rather than staying
    // German. Add an entry here once its app_<code>.arb file exists — the
    // map key is our internal language code (from languages.json), the value
    // is the actual Flutter Locale AppLocalizations was generated for.
    final targetLangCode = ref.watch(languageProvider).targetLanguage.code;
    final appLocale = _nativeUiLocales[targetLangCode] ?? const Locale('en');

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
