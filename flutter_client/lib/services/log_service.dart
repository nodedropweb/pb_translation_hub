// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:convert';
import 'package:flutter/foundation.dart';

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
  static int _maxEntries = -1; // Lazy-initialized
  static bool _loaded = false;

  static void _ensureLoaded() {
    if (!_loaded) {
      _loaded = true;
      _loadMaxEntries();
      _loadLogs();
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

  static void _loadLogs() {
    try {
      final stored = html.window.localStorage['pb_logs'];
      if (stored != null) {
        final decoded = jsonDecode(stored) as List;
        _logs.clear();
        for (final item in decoded) {
          _logs.add(LogEntry.fromJson(item as Map<String, dynamic>));
        }
      }
    } catch (_) {}
  }

  static void _saveLogs() {
    try {
      final encoded = jsonEncode(_logs.map((e) => e.toJson()).toList());
      html.window.localStorage['pb_logs'] = encoded;
    } catch (_) {}
  }

  static void _loadMaxEntries() {
    try {
      final stored = html.window.localStorage['pb_log_max_entries'];
      if (stored != null) {
        _maxEntries = int.tryParse(stored) ?? 500;
      } else {
        _maxEntries = 500;
      }
    } catch (_) {
      _maxEntries = 500;
    }
  }

  static void setMaxEntries(int limit) {
    _ensureLoaded();
    _maxEntries = limit;
    try {
      html.window.localStorage['pb_log_max_entries'] = limit.toString();
    } catch (_) {}
    _enforceLimit();
    _saveLogs();
    _notify();
  }

  static void _enforceLimit() {
    final limit = maxEntries;
    while (_logs.length > limit) {
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
    _saveLogs();
    _notify();
  }

  static void _notify() {
    for (final listener in _listeners) {
      try {
        listener();
      } catch (_) {}
    }
  }

  static void rotate() {
    _ensureLoaded();
    if (_logs.isEmpty) return;
    try {
      final text = _logs.map((e) => e.toString()).join('\n');
      final bytes = utf8.encode(text);
      final blob = html.Blob([bytes], 'text/plain');
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.document.createElement('a') as html.AnchorElement
        ..href = url
        ..style.display = 'none'
        ..download = 'pb_logs_${DateTime.now().toIso8601String().replaceAll(':', '-')}.txt';
      html.document.body?.children.add(anchor);
      anchor.click();
      html.document.body?.children.remove(anchor);
      html.Url.revokeObjectUrl(url);
    } catch (_) {}
    clear();
  }

  static void clear() {
    _ensureLoaded();
    _logs.clear();
    _saveLogs();
    _notify();
  }
}
