class GetRecurringExpensesResponse {
  final bool? status;
  final List<RecurringExpense>? recurringExpenses;

  GetRecurringExpensesResponse({
    this.status,
    this.recurringExpenses,
  });

  GetRecurringExpensesResponse copyWith({
    bool? status,
    List<RecurringExpense>? recurringExpenses,
  }) =>
      GetRecurringExpensesResponse(
        status: status ?? this.status,
        recurringExpenses: recurringExpenses ?? this.recurringExpenses,
      );

  factory GetRecurringExpensesResponse.fromJson(Map<String, dynamic> json) =>
      GetRecurringExpensesResponse(
        status: json["status"],
        recurringExpenses: json["recurringExpenses"] == null
            ? []
            : List<RecurringExpense>.from(json["recurringExpenses"]!
                .map((x) => RecurringExpense.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "recurringExpenses": recurringExpenses == null
            ? []
            : List<dynamic>.from(recurringExpenses!.map((x) => x.toJson())),
      };
}

class RecurringExpense {
  final String? id;
  final String? user;
  final String? frequency;
  final int? day;
  final int? month;
  final String? expense;
  final int? amount;
  final String? supplierName;
  final DateTime? createdAt;
  final int? v;

  RecurringExpense({
    this.id,
    this.user,
    this.frequency,
    this.day,
    this.month,
    this.expense,
    this.amount,
    this.supplierName,
    this.createdAt,
    this.v,
  });

  RecurringExpense copyWith({
    String? id,
    String? user,
    String? frequency,
    int? day,
    int? month,
    String? expense,
    int? amount,
    String? supplierName,
    DateTime? createdAt,
    int? v,
  }) =>
      RecurringExpense(
        id: id ?? this.id,
        user: user ?? this.user,
        frequency: frequency ?? this.frequency,
        day: day ?? this.day,
        month: month ?? this.month,
        expense: expense ?? this.expense,
        amount: amount ?? this.amount,
        supplierName: supplierName ?? this.supplierName,
        createdAt: createdAt ?? this.createdAt,
        v: v ?? this.v,
      );

  factory RecurringExpense.fromJson(Map<String, dynamic> json) =>
      RecurringExpense(
        id: json["_id"],
        user: json["user"],
        frequency: json["frequency"],
        day: json["day"],
        month: json["month"],
        expense: json["expense"],
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
        "frequency": frequency,
        "day": day,
        "month": month,
        "expense": expense,
        "amount": amount,
        "supplierName": supplierName,
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
      };
}
