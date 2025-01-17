class ResendOtpRequest {
  final String email;

  ResendOtpRequest({
    required this.email,
  });

  ResendOtpRequest copyWith({
    String? email,
  }) =>
      ResendOtpRequest(
        email: email ?? this.email,
      );

  factory ResendOtpRequest.fromJson(Map<String, dynamic> json) =>
      ResendOtpRequest(
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
      };
}
