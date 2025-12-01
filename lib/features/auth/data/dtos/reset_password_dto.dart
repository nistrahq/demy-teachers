class ResetPasswordDto {
  final String emailAddress;
  final String password;
  final String confirmPassword;

  const ResetPasswordDto({
    required this.emailAddress,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'emailAddress': emailAddress,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }
}

class ResetPasswordResponseDto {
  final String message;

  const ResetPasswordResponseDto({
    required this.message,
  });

  factory ResetPasswordResponseDto.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponseDto(
      message: json['message'] as String,
    );
  }
}
