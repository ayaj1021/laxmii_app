class GetIncomeGraphDetailsResponse {
  final bool? status;
  final List<Income>? income;
  final List<Expense>? expenses;

  GetIncomeGraphDetailsResponse({
    this.status,
    this.income,
    this.expenses,
  });

  GetIncomeGraphDetailsResponse copyWith({
    bool? status,
    List<Income>? income,
    List<Expense>? expenses,
  }) =>
      GetIncomeGraphDetailsResponse(
        status: status ?? this.status,
        income: income ?? this.income,
        expenses: expenses ?? this.expenses,
      );

  factory GetIncomeGraphDetailsResponse.fromJson(Map<String, dynamic> json) =>
      GetIncomeGraphDetailsResponse(
        status: json["status"],
        income: json["income"] == null
            ? []
            : List<Income>.from(json["income"]!.map((x) => Income.fromJson(x))),
        expenses: json["expenses"] == null
            ? []
            : List<Expense>.from(
                json["expenses"]!.map((x) => Expense.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "income": income == null
            ? []
            : List<dynamic>.from(income!.map((x) => x.toJson())),
        "expenses": income == null
            ? []
            : List<dynamic>.from(income!.map((x) => x.toJson())),
      };
}

class Expense {
  final String? id;
  final String? user;
  final String? expenseType;
  final int? amount;
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

class Income {
  final String? id;
  final String? user;
  final String? inventory;
  final int? amount;
  final String? customerName;
  final DateTime? createdAt;
  final int? v;

  Income({
    this.id,
    this.user,
    this.inventory,
    this.amount,
    this.customerName,
    this.createdAt,
    this.v,
  });

  Income copyWith({
    String? id,
    String? user,
    String? inventory,
    int? amount,
    String? customerName,
    DateTime? createdAt,
    int? v,
  }) =>
      Income(
        id: id ?? this.id,
        user: user ?? this.user,
        inventory: inventory ?? this.inventory,
        amount: amount ?? this.amount,
        customerName: customerName ?? this.customerName,
        createdAt: createdAt ?? this.createdAt,
        v: v ?? this.v,
      );

  factory Income.fromJson(Map<String, dynamic> json) => Income(
        id: json["_id"],
        user: json["user"],
        inventory: json["inventory"],
        amount: json["amount"],
        customerName: json["customerName"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "inventory": inventory,
        "amount": amount,
        "customerName": customerName,
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
      };
}

class Item {
  final String? description;
  final int? quantity;
  final double? price;
  final String? id;

  Item({
    this.description,
    this.quantity,
    this.price,
    this.id,
  });

  Item copyWith({
    String? description,
    int? quantity,
    double? price,
    String? id,
  }) =>
      Item(
        description: description ?? this.description,
        quantity: quantity ?? this.quantity,
        price: price ?? this.price,
        id: id ?? this.id,
      );

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        description: json["description"],
        quantity: json["quantity"],
        price: json["price"]?.toDouble(),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "quantity": quantity,
        "price": price,
        "_id": id,
      };
}
