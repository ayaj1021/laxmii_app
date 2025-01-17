class ForgotPasswordResponse {
  final bool? status;
  final String? message;

  ForgotPasswordResponse({
    this.status,
    this.message,
  });

  ForgotPasswordResponse copyWith({
    bool? status,
    String? message,
  }) =>
      ForgotPasswordResponse(
        status: status ?? this.status,
        message: message ?? this.message,
      );

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordResponse(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
