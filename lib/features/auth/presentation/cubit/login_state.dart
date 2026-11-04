part of 'login_cubit.dart';

sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final AuthEntity auth;

  LoginSuccess(this.auth);
}

final class LoginFailure extends LoginState {
  final String message;

  LoginFailure(this.message);
}