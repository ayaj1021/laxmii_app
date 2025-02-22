class GetAllExpensesResponse {
  final bool? status;
  final List<Expense>? expenses;

  GetAllExpensesResponse({
    this.status,
    this.expenses,
  });

  GetAllExpensesResponse copyWith({
    bool? status,
    List<Expense>? expenses,
  }) =>
      GetAllExpensesResponse(
        status: status ?? this.status,
        expenses: expenses ?? this.expenses,
      );

  factory GetAllExpensesResponse.fromJson(Map<String, dynamic> json) =>
      GetAllExpensesResponse(
        status: json["status"],
        expenses: json["expenses"] == null
            ? []
            : List<Expense>.from(
                json["expenses"]!.map((x) => Expense.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "expenses": expenses == null
            ? []
            : List<dynamic>.from(expenses!.map((x) => x.toJson())),
      };
}

class Expense {
  final String? id;
  final String? user;
  final String? expenseType;
  final num? amount;
  final String? supplierName;
  final DateTime? createdAt;
  final int? v;

  Expense({
    this.id,
    this.user,
    this.expenseType,
    this.amount,
    this.supplierName,
    this.createdAt,
    this.v,
  });

  Expense copyWith({
    String? id,
    String? user,
    String? expenseType,
    int? amount,
    String? supplierName,
    DateTime? createdAt,
    int? v,
  }) =>
      Expense(
        id: id ?? this.id,
        user: user ?? this.user,
        expenseType: expenseType ?? this.expenseType,
        amount: amount ?? this.amount,
        supplierName: supplierName ?? this.supplierName,
        createdAt: createdAt ?? this.createdAt,
        v: v ?? this.v,
      );

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
        id: json["_id"],
        user: json["user"],
        expenseType: json["expenseType"],
        amount: json["amount"],
        supplierName: json["supplierName"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "expenseType": expenseType,
        "amount": amount,
        "supplierName": supplierName,
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
      };
}
