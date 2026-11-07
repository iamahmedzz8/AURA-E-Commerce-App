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
import 'package:aura_maison_e_commerce/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:aura_maison_e_commerce/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:aura_maison_e_commerce/features/auth/data/repositories/auth_repository.dart';
import 'package:aura_maison_e_commerce/features/auth/domain/repositories/auth_repository.dart';
import 'package:aura_maison_e_commerce/features/auth/domain/usecases/get_auth_usecase.dart';
import 'package:aura_maison_e_commerce/features/auth/presentation/cubit/login_cubit.dart';
import 'package:aura_maison_e_commerce/features/auth/domain/usecases/change_password_use_case.dart';
import 'package:aura_maison_e_commerce/features/auth/presentation/cubit/change_password_cubit.dart';
import 'package:aura_maison_e_commerce/features/auth/presentation/cubit/forgot_passcode_cubit.dart';
import 'package:aura_maison_e_commerce/features/auth/presentation/cubit/otp_cubit.dart';
import 'package:aura_maison_e_commerce/features/auth/presentation/cubit/reset_password_cubit.dart';
import 'package:aura_maison_e_commerce/features/addresses/data/datasources/addresses_remote_data_source.dart';
import 'package:aura_maison_e_commerce/features/addresses/data/repositories/addresses_repository_impl.dart';
import 'package:aura_maison_e_commerce/features/addresses/domain/repositories/addresses_repository.dart';
import 'package:aura_maison_e_commerce/features/addresses/domain/usecases/create_address_use_case.dart';
import 'package:aura_maison_e_commerce/features/addresses/domain/usecases/get_address_by_id_use_case.dart';
import 'package:aura_maison_e_commerce/features/addresses/presentation/cubit/addresses_cubit.dart';
import 'package:aura_maison_e_commerce/core/services/selected_address_service.dart';
import 'package:aura_maison_e_commerce/features/addresses/domain/usecases/update_address_use_case.dart';
import 'package:aura_maison_e_commerce/features/addresses/domain/usecases/get_user_addresses_use_case.dart';
import 'package:aura_maison_e_commerce/features/addresses/domain/usecases/delete_address_use_case.dart';
import 'package:aura_maison_e_commerce/features/home/data/datasources/home_remote_data_source.dart';
import 'package:aura_maison_e_commerce/features/home/presentation/cubit/home_cubit.dart';

import '../../features/products/products/data/datasources/products_remote_data_source.dart';
import '../../features/products/products/data/repositories/products_repository_impl.dart';
import '../../features/products/products/domain/repositories/products_repository.dart';
import '../../features/products/products/domain/usecases/add_product_usecase.dart';
import '../../features/products/products/domain/usecases/delete_product_usecase.dart';
import '../../features/products/products/presentation/cubit/products_cubit.dart';

/// Global service locator instance
final GetIt sl = GetIt.instance;

/// Initialize all core singletons and dependencies
Future<void> initServiceLocator() async {
  // ── 1. SharedPreferences (Theming, Localization, App State) ──
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<SelectedAddressService>(
    () => SelectedAddressService(
      preferences: sl<SharedPreferences>(),
    ),
  );
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
  // ── 6. Auth Data Sources ────────────────────────────────────
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      dioClient: sl<DioClient>(),
    ),
  );

  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(
      tokenStorageService: sl<TokenStorageService>(),
    ),
  );

  // ── 7. Auth Repository ──────────────────────────────────────
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl<AuthRemoteDataSource>(),
      localDataSource: sl<AuthLocalDataSource>(),
    ),
  );

  // ── 8. Auth UseCase ─────────────────────────────────────────
  sl.registerLazySingleton<GetAuthUseCase>(
    () => GetAuthUseCase(
      sl<AuthRepository>(),
    ),
  );

  // ── 9. Login Cubit ──────────────────────────────────────────
  sl.registerFactory<LoginCubit>(
    () => LoginCubit(
      getAuthUseCase: sl<GetAuthUseCase>(),
    ),
  );

  // ── 10. Change Password UseCase ────────────────────────────
  sl.registerLazySingleton<ChangePasswordUseCase>(
    () => ChangePasswordUseCase(
      repository: sl<AuthRepository>(),
    ),
  );

  // ── 11. Change Password Cubit ─────────────────────────────
  sl.registerFactory<ChangePasswordCubit>(
    () => ChangePasswordCubit(
      changePasswordUseCase: sl<ChangePasswordUseCase>(),
    ),
  );

  // ── 12. Auth Recovery & Verification Cubits ─────────────────
  sl.registerFactory<ForgotPasscodeCubit>(
    () => ForgotPasscodeCubit(sl<AuthRemoteDataSource>()),
  );
  sl.registerFactory<OtpCubit>(
    () => OtpCubit(sl<AuthRemoteDataSource>()),
  );
  sl.registerFactory<ResetPasswordCubit>(
    () => ResetPasswordCubit(sl<AuthRemoteDataSource>()),
  );

  // ── 13. Addresses Remote Data Source ───────────────────────
  sl.registerLazySingleton<AddressesRemoteDataSource>(
    () => AddressesRemoteDataSourceImpl(
      dioClient: sl<DioClient>(),
    ),
  );

  // ── 14. Addresses Repository ───────────────────────────────
  sl.registerLazySingleton<AddressesRepository>(
    () => AddressesRepositoryImpl(
      remoteDataSource: sl<AddressesRemoteDataSource>(),
    ),
  );

  // ── 15. Get Address By ID Use Case ─────────────────────────
  sl.registerLazySingleton<GetAddressByIdUseCase>(
    () => GetAddressByIdUseCase(
      sl<AddressesRepository>(),
    ),
  );

  // ── 16. Get User Addresses Use Case ─────────────────────────
  sl.registerLazySingleton<GetUserAddressesUseCase>(
    () => GetUserAddressesUseCase(
      repository: sl<AddressesRepository>(),
    ),
  );

  // ── 17. Create Address Use Case ────────────────────────────
  sl.registerLazySingleton<CreateAddressUseCase>(
    () => CreateAddressUseCase(
      sl<AddressesRepository>(),
    ),
  );

  // ── 18. Update Address Use Case ────────────────────────────
  sl.registerLazySingleton<UpdateAddressUseCase>(
    () => UpdateAddressUseCase(
      sl<AddressesRepository>(),
    ),
  );

  // ── 19. Delete Address Use Case ────────────────────────────
  sl.registerLazySingleton<DeleteAddressUseCase>(
    () => DeleteAddressUseCase(
      sl<AddressesRepository>(),
    ),
  );

  // ── 20. Addresses Cubit ────────────────────────────────────
  sl.registerFactory<AddressesCubit>(
    () => AddressesCubit(
      getAddressByIdUseCase: sl<GetAddressByIdUseCase>(),
      getUserAddressesUseCase: sl<GetUserAddressesUseCase>(),
      createAddressUseCase: sl<CreateAddressUseCase>(),
      updateAddressUseCase: sl<UpdateAddressUseCase>(),
      deleteAddressUseCase: sl<DeleteAddressUseCase>(),
      selectedAddressService: sl<SelectedAddressService>(),
    ),
  );

  // ── 21. Products Feature ───────────────────────────────────
  sl.registerLazySingleton<ProductsRemoteDataSource>(
    () => ProductsRemoteDataSource(),
  );

  sl.registerLazySingleton<ProductsRepository>(
    () => ProductsRepositoryImpl(sl<ProductsRemoteDataSource>()),
  );

  sl.registerLazySingleton<AddProductUseCase>(
    () => AddProductUseCase(sl<ProductsRepository>()),
  );

  sl.registerLazySingleton<DeleteProductUseCase>(
    () => DeleteProductUseCase(sl<ProductsRepository>()),
  );

  sl.registerFactory<ProductsCubit>(
    () => ProductsCubit(
      addProductUseCase: sl<AddProductUseCase>(),
      deleteProductUseCase: sl<DeleteProductUseCase>(),
    ),
  );

  // ── 22. Home Feature (Offers, Categories & Products) ────────
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSource(dioClient: sl<DioClient>()),
  );

  sl.registerFactory<OffersCubit>(
    () => OffersCubit(sl<HomeRemoteDataSource>()),
  );

  sl.registerFactory<CategoriesCubit>(
    () => CategoriesCubit(sl<HomeRemoteDataSource>()),
  );

  sl.registerFactory<HomeProductsCubit>(
    () => HomeProductsCubit(sl<HomeRemoteDataSource>()),
  );
}
