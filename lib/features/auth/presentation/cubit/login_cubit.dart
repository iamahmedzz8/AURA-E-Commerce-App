import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aura_maison_e_commerce/core/error/failure.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/usecases/get_auth_usecase.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final GetAuthUseCase getAuthUseCase;

  LoginCubit({
    required this.getAuthUseCase,
  }) : super(LoginInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());

    try {
      final auth = await getAuthUseCase(
        email: email.trim(),
        password: password,
      );

      emit(LoginSuccess(auth));
    } catch (e) {
      if (e is Failure) {
        emit(LoginFailure(e.message));
      } else {
        emit(
          LoginFailure(
            'Something went wrong. Please try again.',
          ),
        );
      }
    }
  }
}