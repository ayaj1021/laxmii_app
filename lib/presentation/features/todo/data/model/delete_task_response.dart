class DeleteTaskResponse {
  final bool? status;
  final String? message;

  DeleteTaskResponse({
    this.status,
    this.message,
  });

  DeleteTaskResponse copyWith({
    bool? status,
    String? message,
  }) =>
      DeleteTaskResponse(
        status: status ?? this.status,
        message: message ?? this.message,
      );

  factory DeleteTaskResponse.fromJson(Map<String, dynamic> json) =>
      DeleteTaskResponse(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
