import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'log_downloader_stub.dart'
    if (dart.library.html) 'log_downloader_web.dart';

class LogEntry {
  final DateTime timestamp;
  final String level; // 'INFO', 'WARNING', 'ERROR'
  final String message;
  final String? details;

  LogEntry({
    required this.timestamp,
    required this.level,
    required this.message,
    this.details,
  });

  Map<String, dynamic> toJson() => {
    'timestamp': timestamp.toIso8601String(),
    'level': level,
    'message': message,
    'details': details,
  };

  factory LogEntry.fromJson(Map<String, dynamic> json) {
    return LogEntry(
      timestamp: DateTime.parse(json['timestamp'] as String),
      level: json['level'] as String,
      message: json['message'] as String,
      details: json['details'] as String?,
    );
  }

  @override
  String toString() {
    return '[${timestamp.toLocal().toString().split('.').first}] [$level] $message${details != null ? '\nDetails: $details' : ''}';
  }
}

class LogService {
  static final List<LogEntry> _logs = [];
  static final List<VoidCallback> _listeners = [];
  static int _maxEntries = 500;
  static bool _loaded = false;

  static void _ensureLoaded() {
    if (!_loaded) {
      _loaded = true;
      // Logs are in-memory only. No localStorage persistence.
    }
  }

  static List<LogEntry> get logs {
    _ensureLoaded();
    return List.unmodifiable(_logs);
  }

  static int get maxEntries {
    _ensureLoaded();
    return _maxEntries;
  }

  static void setMaxEntries(int limit) {
    _ensureLoaded();
    _maxEntries = limit;
    _enforceLimit();
    _notify();
  }

  static void _enforceLimit() {
    while (_logs.length > _maxEntries) {
      _logs.removeAt(0);
    }
  }

  static void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  static void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  static void info(String message, {String? details}) {
    _add('INFO', message, details);
  }

  static void warning(String message, {String? details}) {
    _add('WARNING', message, details);
  }

  static void error(String message, {Object? error, StackTrace? stack}) {
    String? details;
    if (error != null) {
      details = error.toString();
      if (stack != null) {
        details += '\n$stack';
      }
    }
    _add('ERROR', message, details);
  }

  static void _add(String level, String message, String? details) {
    _ensureLoaded();
    final entry = LogEntry(
      timestamp: DateTime.now(),
      level: level,
      message: message,
      details: details,
    );
    _logs.add(entry);
    _enforceLimit();
    _notify();
  }

  static void _notify() {
    for (final listener in _listeners) {
      try {
        listener();
      } catch (_) {}
    }
  }

  /// Exports logs as a downloadable file (web only) and clears the log.
  /// On desktop: simply clears the in-memory log.
  static void rotate() {
    _ensureLoaded();
    if (_logs.isEmpty) return;
    try {
      final text = _logs.map((e) => e.toString()).join('\n');
      final bytes = utf8.encode(text);
      downloadLogBytes(
        bytes,
        'pb_logs_${DateTime.now().toIso8601String().replaceAll(':', '-')}.txt',
      );
    } catch (_) {}
    clear();
  }

  static void clear() {
    _ensureLoaded();
    _logs.clear();
    _notify();
  }
}
