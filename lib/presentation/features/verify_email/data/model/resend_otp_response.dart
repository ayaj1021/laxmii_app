class ResendOtpResponse {
  final bool? status;
  final String? message;

  ResendOtpResponse({
    this.status,
    this.message,
  });

  ResendOtpResponse copyWith({
    bool? status,
    String? message,
  }) =>
      ResendOtpResponse(
        status: status ?? this.status,
        message: message ?? this.message,
      );

  factory ResendOtpResponse.fromJson(Map<String, dynamic> json) =>
      ResendOtpResponse(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
