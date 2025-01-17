class CreateExpenseRequest {
  final String expenseType;
  final String amount;
  final String supplierName;

  CreateExpenseRequest({
    required this.expenseType,
    required this.amount,
    required this.supplierName,
  });

  CreateExpenseRequest copyWith({
    String? expenseType,
    String? amount,
    String? supplierName,
  }) =>
      CreateExpenseRequest(
        expenseType: expenseType ?? this.expenseType,
        amount: amount ?? this.amount,
        supplierName: supplierName ?? this.supplierName,
      );

  factory CreateExpenseRequest.fromJson(Map<String, dynamic> json) =>
      CreateExpenseRequest(
        expenseType: json["expenseType"],
        amount: json["amount"],
        supplierName: json["supplierName"],
      );

  Map<String, dynamic> toJson() => {
        "expenseType": expenseType,
        "amount": amount,
        "supplierName": supplierName,
      };
}
