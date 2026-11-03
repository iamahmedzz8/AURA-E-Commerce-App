import 'package:aura_maison_e_commerce/core/error/error_handler.dart';
import 'package:aura_maison_e_commerce/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// States for [ForgotPasscodeCubit].
abstract class ForgotPasscodeState {}

class ForgotPasscodeInitial extends ForgotPasscodeState {}

class ForgotPasscodeLoading extends ForgotPasscodeState {}

class ForgotPasscodeSuccess extends ForgotPasscodeState {
  final String email;
  ForgotPasscodeSuccess(this.email);
}

class ForgotPasscodeFailure extends ForgotPasscodeState {
  final String message;
  ForgotPasscodeFailure(this.message);
}

/// Cubit managing the Forgot Password / Private Seal Recovery flow.
/// Connects directly to [AuthRemoteDataSource] without an intermediate repository.
class ForgotPasscodeCubit extends Cubit<ForgotPasscodeState> {
  final AuthRemoteDataSource _remoteDataSource;

  ForgotPasscodeCubit(this._remoteDataSource) : super(ForgotPasscodeInitial());

  /// Dispatches forgot password request to backend.
  Future<void> sendRecoveryLink(String email) async {
    final cleanEmail = email.trim();
    if (cleanEmail.isEmpty) {
      emit(ForgotPasscodeFailure('Please provide a valid email address.'));
      return;
    }

    emit(ForgotPasscodeLoading());
    try {
      await _remoteDataSource.forgotPassword(cleanEmail);
      emit(ForgotPasscodeSuccess(cleanEmail));
    } on ErrorHandler catch (e) {
      emit(ForgotPasscodeFailure(e.failure.message));
    } catch (e) {
      emit(ForgotPasscodeFailure(e.toString()));
    }
  }
}
