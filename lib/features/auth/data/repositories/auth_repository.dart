import '../../domain/entities/auth_entity.dart';
import '../../domain/repositories/auth_repository.dart' as domain;
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements domain.AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<AuthEntity> login({
    required String email,
    required String password,
  }) async {
    final response = await remoteDataSource.login(
      email: email,
      password: password,
    );

    final auth = AuthEntity(
      accessToken: response['accessToken'] as String,
      refreshToken: response['refreshToken'] as String,
      expiresAtUtc: DateTime.parse(
        response['expiresAtUtc'] as String,
      ).toUtc(),
    );

    await localDataSource.saveTokens(
      accessToken: auth.accessToken,
      refreshToken: auth.refreshToken,
      expiresAtUtc: auth.expiresAtUtc,
    );

    return auth;
  }
}