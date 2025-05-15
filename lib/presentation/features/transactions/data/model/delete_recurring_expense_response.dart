class DeleteRecurringExpensesResponse {
  final bool? status;
  final String? message;

  DeleteRecurringExpensesResponse({
    this.status,
    this.message,
  });

  DeleteRecurringExpensesResponse copyWith({
    bool? status,
    String? message,
  }) =>
      DeleteRecurringExpensesResponse(
        status: status ?? this.status,
        message: message ?? this.message,
      );

  factory DeleteRecurringExpensesResponse.fromJson(Map<String, dynamic> json) =>
      DeleteRecurringExpensesResponse(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
