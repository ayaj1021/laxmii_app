class ChangePasswordRequest {
  final String email;
  final String otp;
  final String newPassword;

  ChangePasswordRequest({
    required this.email,
    required this.otp,
    required this.newPassword,
  });

  ChangePasswordRequest copyWith({
    String? email,
    String? otp,
    String? newPassword,
  }) =>
      ChangePasswordRequest(
        email: email ?? this.email,
        otp: otp ?? this.otp,
        newPassword: newPassword ?? this.newPassword,
      );

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) =>
      ChangePasswordRequest(
        email: json["email"],
        otp: json["otp"],
        newPassword: json["newPassword"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "otp": otp,
        "newPassword": newPassword,
      };
}
