class DeleteInventoryResponse {
  final bool? status;
  final String? message;

  DeleteInventoryResponse({
    this.status,
    this.message,
  });

  DeleteInventoryResponse copyWith({
    bool? status,
    String? message,
  }) =>
      DeleteInventoryResponse(
        status: status ?? this.status,
        message: message ?? this.message,
      );

  factory DeleteInventoryResponse.fromJson(Map<String, dynamic> json) =>
      DeleteInventoryResponse(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
