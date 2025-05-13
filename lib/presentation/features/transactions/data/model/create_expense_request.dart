// class CreateExpenseRequest {
//   final String expenseType;
//   final String expense;
//   final int quantity;
//   final String amount;
//   final String supplierName;

//   CreateExpenseRequest({
//     required this.expenseType,
//     required this.expense,
//     required this.quantity,
//     required this.amount,
//     required this.supplierName,
//   });

//   CreateExpenseRequest copyWith({
//     String? expenseType,
//     String? expense,
//     int? quantity,
//     String? amount,
//     String? supplierName,
//   }) =>
//       CreateExpenseRequest(
//         expenseType: expenseType ?? this.expenseType,
//         expense: expense ?? this.expense,
//         quantity: quantity ?? this.quantity,
//         amount: amount ?? this.amount,
//         supplierName: supplierName ?? this.supplierName,
//       );

//   factory CreateExpenseRequest.fromJson(Map<String, dynamic> json) =>
//       CreateExpenseRequest(
//         expenseType: json["expenseType"],
//         expense: json["expense"],
//         quantity: json["quantity"],
//         amount: json["amount"],
//         supplierName: json["supplierName"],
//       );

//   Map<String, dynamic> toJson() => {
//         "expenseType": expenseType,
//         "expense": expense,
//         "quantity": quantity,
//         "amount": amount,
//         "supplierName": supplierName,
//       };
// }

// To parse this JSON data, do
//
//     final createExpenseRequest = createExpenseRequestFromJson(jsonString);

class CreateExpenseRequest {
  final String? expenseType;
  final String? generalType;
  final String? expense;
  final String? frequency;
  final int? day;
  final int? month;
  final int? amount;
  final String? supplierName;

  CreateExpenseRequest({
    this.expenseType,
    this.generalType,
    this.expense,
    this.frequency,
    this.day,
    this.month,
    this.amount,
    this.supplierName,
  });

  CreateExpenseRequest copyWith({
    String? expenseType,
    String? generalType,
    String? expense,
    String? frequency,
    int? day,
    int? month,
    int? amount,
    String? supplierName,
  }) =>
      CreateExpenseRequest(
        expenseType: expenseType ?? this.expenseType,
        generalType: generalType ?? this.generalType,
        expense: expense ?? this.expense,
        frequency: frequency ?? this.frequency,
        day: day ?? this.day,
        month: month ?? this.month,
        amount: amount ?? this.amount,
        supplierName: supplierName ?? this.supplierName,
      );

  factory CreateExpenseRequest.fromJson(Map<String, dynamic> json) =>
      CreateExpenseRequest(
        expenseType: json["expenseType"],
        generalType: json["generalType"],
        expense: json["expense"],
        frequency: json["frequency"],
        day: json["day"],
        month: json["month"],
        amount: json["amount"],
        supplierName: json["supplierName"],
      );

  Map<String, dynamic> toJson() => {
        "expenseType": expenseType,
        "generalType": generalType,
        "expense": expense,
        "frequency": frequency,
        "day": day,
        "month": month,
        "amount": amount,
        "supplierName": supplierName,
      };
}
