import 'package:aura_maison_e_commerce/core/error/error_handler.dart';
import 'package:aura_maison_e_commerce/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// States for [ResetPasswordCubit].
abstract class ResetPasswordState {}

class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordLoading extends ResetPasswordState {}

class ResetPasswordSuccess extends ResetPasswordState {}

class ResetPasswordFailure extends ResetPasswordState {
  final String message;
  ResetPasswordFailure(this.message);
}

/// Cubit managing Password Reset / Set New Seal flow.
/// Communicates directly with [AuthRemoteDataSource] without an intermediate repository.
class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final AuthRemoteDataSource _remoteDataSource;

  ResetPasswordCubit(this._remoteDataSource) : super(ResetPasswordInitial());

  /// Submits the new passphrase with email and validated OTP.
  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    final cleanEmail = email.trim();
    final cleanOtp = otp.trim();

    if (cleanEmail.isEmpty || cleanOtp.isEmpty || newPassword.isEmpty) {
      emit(
        ResetPasswordFailure('Missing required credentials to complete reset.'),
      );
      return;
    }

    emit(ResetPasswordLoading());
    try {
      await _remoteDataSource.resetPassword(
        email: cleanEmail,
        otp: cleanOtp,
        newPassword: newPassword,
      );
      emit(ResetPasswordSuccess());
    } on ErrorHandler catch (e) {
      emit(ResetPasswordFailure(e.failure.message));
    } catch (e) {
      emit(ResetPasswordFailure(e.toString()));
    }
  }
}
