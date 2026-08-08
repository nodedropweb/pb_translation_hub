import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_client.dart';
import '../screens/dashboard/widgets/project_card.dart';
import 'language_provider.dart';

class ProjectState {
  final bool isLoading;
  final List<Project> projects;
  final int totalItems;
  final String? error;
  final int? coreVersion;

  ProjectState({
    this.isLoading = false,
    this.projects = const [],
    this.totalItems = 0,
    this.error,
    this.coreVersion,
  });

  ProjectState copyWith({
    bool? isLoading,
    List<Project>? projects,
    int? totalItems,
    String? error,
    Object? coreVersion = _sentinel,
  }) {
    return ProjectState(
      isLoading: isLoading ?? this.isLoading,
      projects: projects ?? this.projects,
      totalItems: totalItems ?? this.totalItems,
      error: error ?? this.error,
      coreVersion: coreVersion == _sentinel ? this.coreVersion : coreVersion as int?,
    );
  }
}
// Sentinel damit copyWith(coreVersion: null) null explizit setzen kann
const Object _sentinel = Object();

class ProjectNotifier extends Notifier<ProjectState> {
  final ApiClient _api = ApiClient();
  
  // Keep track of current query parameters
  String _activeFilter = 'missing';
  String _searchQuery = '';
  int _currentPage = 1;
  int _limit = 50;
  int? _coreVersion; // null = alle Versionen

  @override
  ProjectState build() {
    // Watch target language so project list is reactive to language changes
    ref.watch(languageProvider);
    // Initial fetch deferred using Future.microtask to prevent reading uninitialized state
    Future.microtask(() => _fetchProjects());
    return ProjectState(isLoading: true);
  }

  void setFilter(String filter, {bool force = false}) {
    if (!force && _activeFilter == filter) return;
    _activeFilter = filter;
    _currentPage = 1;
    _fetchProjects();
    
    // Refresh filter counts whenever the active filter changes, to keep counts accurate!
    final langcode = ref.read(languageProvider).targetLanguage.code;
    Future.microtask(() {
      ref.read(filterCountsProvider.notifier).fetchCounts(langcode, coreVersion: _coreVersion);
    });
  }

  void setSearch(String search) {
    if (_searchQuery == search) return;
    _searchQuery = search;
    _currentPage = 1;
    _fetchProjects();
  }

  void nextPage() {
    final maxPage = (state.totalItems / _limit).ceil();
    if (_currentPage >= maxPage) return;
    _currentPage++;
    _fetchProjects();
  }

  void prevPage() {
    if (_currentPage <= 1) return;
    _currentPage--;
    _fetchProjects();
  }

  void goToPage(int page) {
    final maxPage = (state.totalItems / _limit).ceil();
    if (page < 1 || page > maxPage) return;
    _currentPage = page;
    _fetchProjects();
  }

  void setLimit(int limit) {
    if (_limit == limit) return;
    _limit = limit;
    _currentPage = 1;
    _fetchProjects();
  }

  String get activeFilter => _activeFilter;
  int get currentPage => _currentPage;
  int get limit => _limit;
  String get searchQuery => _searchQuery;
  int? get coreVersion => _coreVersion;

  void setCoreVersion(int? version) {
    if (_coreVersion == version) return;
    _coreVersion = version;
    _currentPage = 1;
    state = state.copyWith(coreVersion: version);
    _fetchProjects();
    final langcode = ref.read(languageProvider).targetLanguage.code;
    Future.microtask(() => ref.read(filterCountsProvider.notifier).fetchCounts(langcode, coreVersion: version));
  }

  Future<void> _fetchProjects() async {
    // We shouldn't mutate state to isLoading if we already have projects? 
    // Usually it's better to show a loading indicator without clearing the list, 
    // but for simplicity we'll just set isLoading to true.
    state = state.copyWith(isLoading: true, error: null);

    try {
      final offset = (_currentPage - 1) * _limit;
      final response = await _api.dio.get(
        '/projects',
        queryParameters: {
          'search': _searchQuery,
          'langcode': ref.read(languageProvider).targetLanguage.code,
          'filter': _activeFilter,
          'offset': offset,
          'limit': _limit,
          if (_coreVersion != null) 'core_version': _coreVersion,
        },
      );

      final rawData = response.data['data'] as List<dynamic>;
      final meta = response.data['meta'];

      final List<Project> parsedProjects = rawData.map((p) {
        final attributes = p['attributes'] ?? {};
        final projectMeta = p['meta'] ?? {};
        final translation = projectMeta['translation'] ?? {};
        
        final title = translation['title'] ?? attributes['title'] ?? 'Unknown';
        
        // Try to get translation summary first, fallback to original body summary
        String summary = translation['summary'] ?? '';
        if (summary.isEmpty && attributes['body'] != null) {
          summary = attributes['body']['summary'] ?? '';
        }
        if (summary.isEmpty) {
          summary = 'Keine Zusammenfassung verfügbar.';
        }

        return Project(
          machineName: attributes['field_project_machine_name'] ?? '',
          title: title,
          summary: _stripHtml(summary),
          status: projectMeta['translation_status'] ?? 'missing',
          logoUrl: projectMeta['logo_url'] as String?,
        );
      }).toList();

      state = state.copyWith(
        isLoading: false,
        projects: parsedProjects,
        totalItems: meta['count'] ?? 0,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Fehler beim Laden der Projekte: $e',
      );
    }
  }

  String _stripHtml(String htmlString) {
    final RegExp exp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: true);
    return htmlString.replaceAll(exp, '').trim();
  }
}

final projectProvider = NotifierProvider<ProjectNotifier, ProjectState>(() {
  return ProjectNotifier();
});

class VersionCount {
  final int all;
  final int missing;
  final int review;
  final int released;
  const VersionCount({this.all = 0, this.missing = 0, this.review = 0, this.released = 0});
  factory VersionCount.fromJson(Map<String, dynamic> json) => VersionCount(
    all: json['all'] ?? 0,
    missing: json['missing'] ?? 0,
    review: json['review'] ?? 0,
    released: json['released'] ?? 0,
  );
}

class FilterCounts {
  final int all;
  final int priority;
  final int missing;
  final int review;
  final int released;
  final int stale;
  final int translated;
  final int ignored;
  // keyed by Drupal major version number (9, 10, 11, 12)
  final Map<int, VersionCount> versionCounts;

  FilterCounts({
    this.all = 0,
    this.priority = 0,
    this.missing = 0,
    this.review = 0,
    this.released = 0,
    this.stale = 0,
    this.translated = 0,
    this.ignored = 0,
    this.versionCounts = const {},
  });

  factory FilterCounts.fromJson(Map<String, dynamic> json) {
    final rawVc = json['version_counts'] as Map<String, dynamic>? ?? {};
    final vc = <int, VersionCount>{};
    rawVc.forEach((k, v) {
      final ver = int.tryParse(k);
      if (ver != null && v is Map<String, dynamic>) vc[ver] = VersionCount.fromJson(v);
    });
    return FilterCounts(
      all: json['all'] ?? 0,
      priority: json['priority'] ?? 0,
      missing: json['missing'] ?? 0,
      review: json['review'] ?? 0,
      released: json['released'] ?? 0,
      stale: json['stale'] ?? 0,
      translated: json['translated'] ?? 0,
      ignored: json['ignored'] ?? 0,
      versionCounts: vc,
    );
  }
}

class FilterCountsNotifier extends Notifier<FilterCounts> {
  final ApiClient _api = ApiClient();

  @override
  FilterCounts build() {
    // NOTE: intentionally ref.read, not ref.watch. languageProvider's state
    // changes 2-3 times during app startup (default -> saved-language ->
    // post-fetchLanguages()); watching it here would rerun build() each
    // time, resetting state back to FilterCounts() (all zeros) and racing a
    // fresh fetch against whichever fetch was already in flight — the exact
    // "counts show 0 until F5" bug. React to real language changes via
    // ref.listen instead, which calls fetchCounts() without resetting state.
    final langcode = ref.read(languageProvider).targetLanguage.code;
    Future.microtask(() => fetchCounts(langcode));

    ref.listen(languageProvider, (previous, next) {
      if (previous?.targetLanguage.code != next.targetLanguage.code) {
        fetchCounts(next.targetLanguage.code);
      }
    });

    return FilterCounts();
  }

  Future<void> fetchCounts(String langcode, {int? coreVersion}) async {
    try {
      final response = await _api.dio.get(
        '/projects/filter-counts',
        queryParameters: {
          'langcode': langcode,
          if (coreVersion != null) 'core_version': coreVersion,
        },
      );
      state = FilterCounts.fromJson(response.data);
    } catch (e) {
      // Ignore or log error
    }
  }

  /// Optimistically decrements the review counter by 1 immediately after an
  /// approval so the badge updates without waiting for a server round-trip.
  void decrementReview() {
    if (state.review <= 0) return;
    state = FilterCounts(
      all: state.all > 0 ? state.all - 1 : 0,
      priority: state.priority,
      missing: state.missing,
      review: state.review - 1,
      released: state.released + 1,
      stale: state.stale,
      translated: state.translated,
      ignored: state.ignored,
      versionCounts: state.versionCounts,
    );
  }
}

final filterCountsProvider = NotifierProvider<FilterCountsNotifier, FilterCounts>(() {
  return FilterCountsNotifier();
});
