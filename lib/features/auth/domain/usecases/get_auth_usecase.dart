import '../entities/auth_entity.dart';
import '../repositories/auth_repository.dart';

class GetAuthUseCase {
  final AuthRepository repository;

  GetAuthUseCase(this.repository);

  Future<AuthEntity> call({required String email, required String password}) {
    return repository.login(email: email, password: password);
  }
}
