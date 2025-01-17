class ChangePasswordResponse {
  final bool? status;
  final String? message;

  ChangePasswordResponse({
    this.status,
    this.message,
  });

  ChangePasswordResponse copyWith({
    bool? status,
    String? message,
  }) =>
      ChangePasswordResponse(
        status: status ?? this.status,
        message: message ?? this.message,
      );

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) =>
      ChangePasswordResponse(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
