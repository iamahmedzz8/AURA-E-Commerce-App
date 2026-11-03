import 'package:aura_maison_e_commerce/core/network/api_endpoints.dart';
import 'package:aura_maison_e_commerce/core/network/api_interceptors.dart';
import 'package:aura_maison_e_commerce/core/network/dio_client.dart';
import 'package:aura_maison_e_commerce/core/network/network_info.dart';
import 'package:aura_maison_e_commerce/core/services/token_storage_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Global service locator instance
final GetIt sl = GetIt.instance;

/// Initialize all core singletons and dependencies
Future<void> initServiceLocator() async {
  // ── 1. SharedPreferences (Theming, Localization, App State) ──
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // ── 2. FlutterSecureStorage (Encrypted Token Storage) ──────────
  sl.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(
      aOptions: AndroidOptions(
        resetOnError: true,
      ),
      iOptions: IOSOptions(
        accessibility: KeychainAccessibility.first_unlock,
      ),
    ),
  );

  sl.registerLazySingleton<TokenStorageService>(
    () => TokenStorageService(
      secureStorage: sl<FlutterSecureStorage>(),
      prefs: sl<SharedPreferences>(),
    ),
  );

  // ── 3. Network Connectivity Checker ────────────────────────
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(),
  );

  // ── 4. Dio HTTP Client Instance ────────────────────────────
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: ApiEndpoints.connectTimeout,
        receiveTimeout: ApiEndpoints.receiveTimeout,
        sendTimeout: ApiEndpoints.sendTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        responseType: ResponseType.json,
      ),
    );

    // Attach Auth & Token Refresh Interceptor
    dio.interceptors.add(
      AuthInterceptor(
        tokenStorage: sl<TokenStorageService>(),
        dio: dio,
      ),
    );

    // Attach Pretty Logger in Debug Mode
    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
      );
    }

    return dio;
  });

  // ── 5. DioClient Singleton Wrapper ─────────────────────────
  sl.registerLazySingleton<DioClient>(
    () => DioClient(sl<Dio>()),
  );
}
