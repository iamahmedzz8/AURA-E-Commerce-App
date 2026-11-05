import 'package:aura_maison_e_commerce/core/error/error_handler.dart';
import 'package:aura_maison_e_commerce/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Supported OTP verification scenarios.
enum OtpPurpose { signup, resetPassword }

/// States for [OtpCubit].
abstract class OtpState {}

class OtpInitial extends OtpState {}

class OtpLoading extends OtpState {}

class OtpSuccess extends OtpState {
  final OtpPurpose purpose;
  final String email;
  final String otp;

  OtpSuccess({required this.purpose, required this.email, required this.otp});
}

class OtpResendLoading extends OtpState {}

class OtpResendSuccess extends OtpState {
  final String message;
  OtpResendSuccess({
    this.message = 'A fresh security code has been dispatched.',
  });
}

class OtpFailure extends OtpState {
  final String message;
  OtpFailure(this.message);
}

class OtpResendFailure extends OtpState {
  final String message;
  OtpResendFailure(this.message);
}

/// Cubit managing OTP verification and resend logic.
/// Communicates directly with [AuthRemoteDataSource] without an intermediate repository.
class OtpCubit extends Cubit<OtpState> {
  final AuthRemoteDataSource _remoteDataSource;

  OtpCubit(this._remoteDataSource) : super(OtpInitial());

  /// Verifies OTP based on intended purpose (signup vs resetPassword).
  Future<void> verifyOtp({
    required String email,
    required String otp,
    required OtpPurpose purpose,
  }) async {
    final cleanEmail = email.trim();
    final cleanOtp = otp.trim();

    if (cleanOtp.length != 6) {
      emit(OtpFailure('Please enter the complete 6-digit security code.'));
      return;
    }

    emit(OtpLoading());
    try {
      if (purpose == OtpPurpose.signup) {
        await _remoteDataSource.verifyEmail(cleanEmail, cleanOtp);
      } else {
        await _remoteDataSource.validateOtp(cleanEmail, cleanOtp);
      }
      emit(OtpSuccess(purpose: purpose, email: cleanEmail, otp: cleanOtp));
    } on ErrorHandler catch (e) {
      emit(OtpFailure(e.failure.message));
    } catch (e) {
      emit(OtpFailure(e.toString()));
    }
  }

  /// Requests a new OTP code for the given email.
  Future<void> resendOtp(String email) async {
    final cleanEmail = email.trim();
    if (cleanEmail.isEmpty) {
      emit(OtpResendFailure('Member email address is required.'));
      return;
    }

    emit(OtpResendLoading());
    try {
      await _remoteDataSource.resendOtp(cleanEmail);
      emit(OtpResendSuccess());
    } on ErrorHandler catch (e) {
      emit(OtpResendFailure(e.failure.message));
    } catch (e) {
      emit(OtpResendFailure(e.toString()));
    }
  }
}
