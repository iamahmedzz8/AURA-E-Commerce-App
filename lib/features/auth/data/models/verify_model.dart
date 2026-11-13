class VerifyEmailModel {
  final String email;
  final String otp;

  VerifyEmailModel({required this.email, required this.otp});

  Map<String, dynamic> toJson() {
    return {'email': email, 'otp': otp};
  }
}
