import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aura_maison_e_commerce/core/error/failure.dart';
import '../../domain/usecases/change_password_use_case.dart';
part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordUseCase changePasswordUseCase;

  ChangePasswordCubit({
    required this.changePasswordUseCase,
  }) : super(ChangePasswordInitial());

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    emit(ChangePasswordLoading());

    try {
      await changePasswordUseCase(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmNewPassword: confirmNewPassword,
      );

      emit(ChangePasswordSuccess());
    } catch (e) {
      if (e is Failure) {
        emit(ChangePasswordFailure(e.message));
      } else {
        emit(
          ChangePasswordFailure(
            'Something went wrong. Please try again.',
          ),
        );
      }
    }
  }
}