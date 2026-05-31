import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:html' as html;

class TokenStorage {
  static const String _key = 'pb-token';
  static const String _rememberKey = 'pb-remember';

  // Save token
  static Future<void> saveToken(String token, bool remember) async {
    if (kIsWeb) {
      if (remember) {
        html.window.localStorage[_key] = token;
        html.window.sessionStorage.remove(_key);
      } else {
        html.window.sessionStorage[_key] = token;
        html.window.localStorage.remove(_key);
      }
      html.window.localStorage[_rememberKey] = remember.toString();
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_key, token);
      await prefs.setBool(_rememberKey, remember);
    }
  }

  // Get token
  static Future<String?> getToken() async {
    if (kIsWeb) {
      final localToken = html.window.localStorage[_key];
      final sessionToken = html.window.sessionStorage[_key];
      return localToken ?? sessionToken;
    } else {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_key);
    }
  }

  // Clear token
  static Future<void> clearToken() async {
    if (kIsWeb) {
      html.window.localStorage.remove(_key);
      html.window.sessionStorage.remove(_key);
      html.window.localStorage.remove(_rememberKey);
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_key);
      await prefs.remove(_rememberKey);
    }
  }

  // Get remember status
  static Future<bool> getRemember() async {
    if (kIsWeb) {
      final rememberVal = html.window.localStorage[_rememberKey];
      return rememberVal == 'true';
    } else {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_rememberKey) ?? false;
    }
  }

  // Open URL safely
  static void openUrl(String url) {
    if (kIsWeb) {
      print('[Unsplash Attribution] Opening URL: $url');
      html.window.open(url, '_blank');
    }
  }
}
