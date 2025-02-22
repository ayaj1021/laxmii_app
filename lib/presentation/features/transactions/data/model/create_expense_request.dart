class CreateExpenseRequest {
  final String expenseType;
  final String expense;
  final int quantity;
  final String amount;
  final String supplierName;

  CreateExpenseRequest({
    required this.expenseType,
    required this.expense,
    required this.quantity,
    required this.amount,
    required this.supplierName,
  });

  CreateExpenseRequest copyWith({
    String? expenseType,
    String? expense,
    int? quantity,
    String? amount,
    String? supplierName,
  }) =>
      CreateExpenseRequest(
        expenseType: expenseType ?? this.expenseType,
        expense: expense ?? this.expense,
        quantity: quantity ?? this.quantity,
        amount: amount ?? this.amount,
        supplierName: supplierName ?? this.supplierName,
      );

  factory CreateExpenseRequest.fromJson(Map<String, dynamic> json) =>
      CreateExpenseRequest(
        expenseType: json["expenseType"],
        expense: json["expense"],
        quantity: json["quantity"],
        amount: json["amount"],
        supplierName: json["supplierName"],
      );

  Map<String, dynamic> toJson() => {
        "expenseType": expenseType,
        "expense": expense,
        "quantity": quantity,
        "amount": amount,
        "supplierName": supplierName,
      };
}
