import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_client.dart';

/// Represents the current sync status from /api/sync/status
class SyncStatus {
  final bool active;
  final bool finished;
  final int current;
  final int total;
  final String lastMachineName;
  final String? error;
  final String? lastFullSync;

  const SyncStatus({
    this.active = false,
    this.finished = false,
    this.current = 0,
    this.total = 0,
    this.lastMachineName = '',
    this.error,
    this.lastFullSync,
  });

  factory SyncStatus.fromJson(Map<String, dynamic> json) {
    return SyncStatus(
      active: json['active'] as bool? ?? false,
      finished: json['finished'] as bool? ?? false,
      current: (json['current'] as num?)?.toInt() ?? 0,
      total: (json['total'] as num?)?.toInt() ?? 0,
      lastMachineName: json['lastMachineName'] as String? ?? '',
      error: json['error'] as String?,
      lastFullSync: json['lastFullSync'] as String?,
    );
  }

  /// Progress as a 0.0–1.0 double for ProgressIndicator
  double get progress => total > 0 ? (current / total).clamp(0.0, 1.0) : 0.0;
}

/// Notifier that manages sync state and polls the backend while a sync is active.
class SyncNotifier extends Notifier<SyncStatus> {
  final ApiClient _api = ApiClient();
  Timer? _pollTimer;
  bool _wasActive = false;

  @override
  SyncStatus build() {
    ref.onDispose(() => _pollTimer?.cancel());
    Future.microtask(_fetchStatus);
    return const SyncStatus();
  }

  // ──────────────────────────────── Internal ────────────────────────────────

  Future<void> _fetchStatus() async {
    try {
      final res = await _api.dio.get('/sync/status');
      final newStatus = SyncStatus.fromJson(res.data as Map<String, dynamic>);

      // Sync just finished → stop polling
      if (_wasActive && !newStatus.active) {
        _pollTimer?.cancel();
        _pollTimer = null;
      }

      _wasActive = newStatus.active;
      state = newStatus;

      if (newStatus.active) _ensurePolling();
    } catch (_) {}
  }

  void _ensurePolling() {
    if (_pollTimer != null) return;
    _pollTimer = Timer.periodic(const Duration(seconds: 2), (_) => _fetchStatus());
  }

  // ──────────────────────────────── Public API ──────────────────────────────

  /// Starts a full database sync from Drupal.org (requires auth).
  Future<void> startFullSync() async {
    await _api.dio.post('/sync/start');
    await _fetchStatus();
  }

  /// Stops the running sync (requires auth).
  Future<void> stopSync() async {
    try {
      await _api.dio.post('/sync/stop');
    } catch (_) {}
    await Future.delayed(const Duration(milliseconds: 600));
    await _fetchStatus();
  }

  /// Triggers a quick delta-sync of the last [days] days.
  Future<void> quickUpdate({int days = 7}) async {
    await _api.dio.post('/sync/quick', data: {'days': days});
    await _fetchStatus();
  }

  /// Fetches a single module by machine name from Drupal.org.
  /// Returns the English title on success.
  Future<String?> manualSync(String machineName) async {
    final res = await _api.dio.post('/sync/project/$machineName');
    await _fetchStatus();
    return res.data['title'] as String?;
  }

  /// Force-refreshes the sync status (e.g. after the project list reloads).
  Future<void> refresh() => _fetchStatus();
}

final syncProvider = NotifierProvider<SyncNotifier, SyncStatus>(() => SyncNotifier());
