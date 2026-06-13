import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'token_storage.dart';
import 'log_service.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  late final Dio dio;

  /// Ermittelt die API-Basis-URL zur Laufzeit.
  ///
  /// - Lokal (localhost / 127.0.0.1 / nicht-Standard-Port): direkter Zugriff
  ///   auf den Dev-Server auf Port 9901 — funktioniert mit `hubctl.sh start`
  ///   und `dev`, auch wenn via WSL-IP (z.B. 172.x.x.x:5173) zugegriffen wird.
  /// - Produktion (Port 80/443): relativer Pfad `/api`,
  ///   der von Nginx im Container zu `http://server:9901/api/` proxied wird.
  static String get baseUrl {
    if (kIsWeb) {
      final origin = Uri.base;
      final host = origin.host;
      final port = origin.port;
      final isDev = host == 'localhost' ||
          host == '127.0.0.1' ||
          (port != 0 && port != 80 && port != 443);
      if (isDev) {
        return '${origin.scheme}://$host:9901/api';
      }
      // Produktion: gleicher Origin + /api (Nginx-Proxy übernimmt die Weiterleitung)
      return '${origin.scheme}://${origin.host}/api';
    }
    // Fallback für native Builds (Android, Desktop, …)
    return 'http://localhost:9901/api';
  }

  /// Server-Ursprung ohne /api-Pfad — für Uploads, Avatare etc.
  ///
  /// Beispiele:
  ///   Produktion:  'https://pb.drupaltutorials.de'
  ///   Lokal:       'http://localhost:9901'
  static String get serverOrigin {
    if (kIsWeb) {
      final origin = Uri.base;
      final host = origin.host;
      final port = origin.port;
      final isDev = host == 'localhost' ||
          host == '127.0.0.1' ||
          (port != 0 && port != 80 && port != 443);
      if (isDev) {
        return '${origin.scheme}://$host:9901';
      }
      return '${origin.scheme}://${origin.host}';
    }
    return 'http://localhost:9901';
  }

  /// Wraps [rawUrl] in the server-side image-proxy endpoint so Flutter web
  /// can load cross-origin images without CORS restrictions.
  static String proxyImageUrl(String rawUrl) =>
      '$baseUrl/image-proxy?url=${Uri.encodeComponent(rawUrl)}';

  factory ApiClient() {
    return _instance;
  }

  ApiClient._internal() {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl, // getter — wird einmalig beim ersten ApiClient() Aufruf ausgewertet
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
    ));

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          LogService.info('API Request: ${options.method} ${options.path}');
          final token = await TokenStorage.getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          LogService.info('API Response: ${response.statusCode} for ${response.requestOptions.method} ${response.requestOptions.path}');
          return handler.next(response);
        },
        onError: (DioException e, handler) async {
          LogService.error(
            'API Error: ${e.response?.statusCode ?? "no status"} - ${e.message} on ${e.requestOptions.method} ${e.requestOptions.path}',
            error: e.response?.data,
          );
          // Only clear the token when the server explicitly says the token is
          // invalid or expired (403 with matching message).
          // Do NOT clear on plain 401 ("No token provided") — those can be
          // caused by race conditions or server-side bugs and should not log
          // the user out or destroy a valid token.
          if (e.response?.statusCode == 403) {
            final msg = e.response?.data?.toString() ?? '';
            if (msg.contains('Invalid') || msg.contains('expired')) {
              await TokenStorage.clearToken();
            }
          }
          return handler.next(e);
        },
      ),
    );
  }
}
