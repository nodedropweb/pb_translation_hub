import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class TokenStorage {
  static const String _key = 'pb-token';
  static const String _rememberKey = 'pb-remember';

  // ── In-memory cache — avoids SharedPreferences round-trips and prevents
  //    race conditions where getToken() returns null on the first async tick
  //    before the prefs instance has been fully initialised.
  static String? _cachedToken;
  static bool    _cacheReady = false;

  /// Warms the cache exactly once. Called by [getToken] if not yet loaded.
  static Future<void> _ensureCache() async {
    if (_cacheReady) return;
    final prefs = await SharedPreferences.getInstance();
    _cachedToken = prefs.getString(_key);
    _cacheReady  = true;
  }

  // Save token
  static Future<void> saveToken(String token, bool remember) async {
    _cachedToken = token;
    _cacheReady  = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, token);
    await prefs.setBool(_rememberKey, remember);
  }

  // Get token — returns from cache after first load; never returns stale null
  static Future<String?> getToken() async {
    await _ensureCache();
    return _cachedToken;
  }

  // Clear token
  static Future<void> clearToken() async {
    _cachedToken = null;
    _cacheReady  = true;        // cache is valid — it just holds null now
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
    await prefs.remove(_rememberKey);
  }

  // Get remember status
  static Future<bool> getRemember() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_rememberKey) ?? false;
  }

  // Open URL safely
  static void openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
