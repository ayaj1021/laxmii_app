class VerifyEmailOtpResponse {
  final bool? status;
  final String? message;

  VerifyEmailOtpResponse({
    this.status,
    this.message,
  });

  VerifyEmailOtpResponse copyWith({
    bool? status,
    String? message,
  }) =>
      VerifyEmailOtpResponse(
        status: status ?? this.status,
        message: message ?? this.message,
      );

  factory VerifyEmailOtpResponse.fromJson(Map<String, dynamic> json) =>
      VerifyEmailOtpResponse(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
