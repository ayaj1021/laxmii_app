class CreateExpenseResponse {
  final bool? status;
  final String? message;
  final SavedExpense? savedExpense;

  CreateExpenseResponse({
    this.status,
    this.message,
    this.savedExpense,
  });

  CreateExpenseResponse copyWith({
    bool? status,
    String? message,
    SavedExpense? savedExpense,
  }) =>
      CreateExpenseResponse(
        status: status ?? this.status,
        message: message ?? this.message,
        savedExpense: savedExpense ?? this.savedExpense,
      );

  factory CreateExpenseResponse.fromJson(Map<String, dynamic> json) =>
      CreateExpenseResponse(
        status: json["status"],
        message: json["message"],
        savedExpense: json["savedExpense"] == null
            ? null
            : SavedExpense.fromJson(json["savedExpense"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "savedExpense": savedExpense?.toJson(),
      };
}

class SavedExpense {
  final String? user;
  final String? expenseType;
  final num? amount;
  final String? supplierName;
  final DateTime? createdAt;
  final String? id;
  final int? v;

  SavedExpense({
    this.user,
    this.expenseType,
    this.amount,
    this.supplierName,
    this.createdAt,
    this.id,
    this.v,
  });

  SavedExpense copyWith({
    String? user,
    String? expenseType,
    num? amount,
    String? supplierName,
    DateTime? createdAt,
    String? id,
    int? v,
  }) =>
      SavedExpense(
        user: user ?? this.user,
        expenseType: expenseType ?? this.expenseType,
        amount: amount ?? this.amount,
        supplierName: supplierName ?? this.supplierName,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
        v: v ?? this.v,
      );

  factory SavedExpense.fromJson(Map<String, dynamic> json) => SavedExpense(
        user: json["user"],
        expenseType: json["expenseType"],
        amount: json["amount"],
        supplierName: json["supplierName"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        id: json["_id"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "expenseType": expenseType,
        "amount": amount,
        "supplierName": supplierName,
        "createdAt": createdAt?.toIso8601String(),
        "_id": id,
        "__v": v,
      };
}
