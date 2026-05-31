import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme/app_theme.dart';
import 'providers/theme_provider.dart';
import 'router.dart';

void main() async {
  // Pflicht vor SystemChrome-Aufrufen und async-Initialisierungen.
  WidgetsFlutterBinding.ensureInitialized();

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

    return MaterialApp.router(
      title: 'PB Translation Hub',
      theme: AppTheme.getTheme(themeState),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
