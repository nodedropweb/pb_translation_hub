import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_client.dart';
import 'language_provider.dart';

/// Eine Woche im Verlauf: Anzahl + (gekürzte) Modulliste.
class WeekBucket {
  final String weekStart; // YYYY-MM-DD (Montag der ISO-Woche)
  final int count;
  final List<String> modules;
  final bool truncated;

  WeekBucket({
    required this.weekStart,
    required this.count,
    required this.modules,
    required this.truncated,
  });

  factory WeekBucket.fromJson(Map<String, dynamic> j) => WeekBucket(
        weekStart: j['week_start']?.toString() ?? '',
        count: j['count'] ?? 0,
        modules: (j['modules'] as List?)?.map((e) => e.toString()).toList() ??
            const [],
        truncated: j['truncated'] == true,
      );
}

class AnalyticsState {
  final bool isLoading;
  final String? error;
  final List<WeekBucket> weeklyNew;   // neue Projektbeschreibungen
  final List<WeekBucket> weeklyStale; // veraltet markiert

  AnalyticsState({
    this.isLoading = false,
    this.error,
    this.weeklyNew = const [],
    this.weeklyStale = const [],
  });
}

class AnalyticsNotifier extends Notifier<AnalyticsState> {
  final ApiClient _api = ApiClient();
  int _weeks = 12;
  int get weeks => _weeks;

  @override
  AnalyticsState build() {
    // Sprache beobachten — Stale-Verlauf ist sprachabhängig.
    final langcode = ref.watch(languageProvider).targetLanguage.code;
    Future.microtask(() => _fetch(langcode));
    return AnalyticsState(isLoading: true);
  }

  void setWeeks(int w) {
    if (w == _weeks) return;
    _weeks = w;
    _fetch(ref.read(languageProvider).targetLanguage.code);
  }

  Future<void> refresh() =>
      _fetch(ref.read(languageProvider).targetLanguage.code);

  Future<void> _fetch(String langcode) async {
    state = AnalyticsState(isLoading: true);
    try {
      final results = await Future.wait([
        _api.dio.get('/dashboard/weekly', queryParameters: {
          'type': 'new_description',
          'weeks': _weeks,
        }),
        _api.dio.get('/dashboard/weekly', queryParameters: {
          'type': 'stale',
          'weeks': _weeks,
          'langcode': langcode,
        }),
      ]);

      List<WeekBucket> parse(dynamic resp) =>
          ((resp.data['data'] as List?) ?? [])
              .map((e) => WeekBucket.fromJson(e as Map<String, dynamic>))
              .toList();

      state = AnalyticsState(
        isLoading: false,
        weeklyNew: parse(results[0]),
        weeklyStale: parse(results[1]),
      );
    } catch (e) {
      state = AnalyticsState(isLoading: false, error: e.toString());
    }
  }
}

final analyticsProvider =
    NotifierProvider<AnalyticsNotifier, AnalyticsState>(() => AnalyticsNotifier());
