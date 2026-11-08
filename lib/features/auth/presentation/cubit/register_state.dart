
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final String email;

  RegisterSuccess({required this.email});
}

class RegisterFailure extends RegisterState {
  final String msg;

  RegisterFailure({required this.msg});
}
