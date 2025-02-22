class DeleteQuoteResponse {
  final bool? status;
  final String? message;

  DeleteQuoteResponse({
    this.status,
    this.message,
  });

  DeleteQuoteResponse copyWith({
    bool? status,
    String? message,
  }) =>
      DeleteQuoteResponse(
        status: status ?? this.status,
        message: message ?? this.message,
      );

  factory DeleteQuoteResponse.fromJson(Map<String, dynamic> json) =>
      DeleteQuoteResponse(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
