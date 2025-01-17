class CreateSalesResponse {
  final bool? status;
  final String? message;
  final SavedSales? savedSales;

  CreateSalesResponse({
    this.status,
    this.message,
    this.savedSales,
  });

  CreateSalesResponse copyWith({
    bool? status,
    String? message,
    SavedSales? savedSales,
  }) =>
      CreateSalesResponse(
        status: status ?? this.status,
        message: message ?? this.message,
        savedSales: savedSales ?? this.savedSales,
      );

  factory CreateSalesResponse.fromJson(Map<String, dynamic> json) =>
      CreateSalesResponse(
        status: json["status"],
        message: json["message"],
        savedSales: json["savedSales"] == null
            ? null
            : SavedSales.fromJson(json["savedSales"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "savedSales": savedSales?.toJson(),
      };
}

class SavedSales {
  final String? user;
  final String? inventory;
  final int? amount;
  final String? customerName;
  final DateTime? createdAt;
  final String? id;
  final int? v;

  SavedSales({
    this.user,
    this.inventory,
    this.amount,
    this.customerName,
    this.createdAt,
    this.id,
    this.v,
  });

  SavedSales copyWith({
    String? user,
    String? inventory,
    int? amount,
    String? customerName,
    DateTime? createdAt,
    String? id,
    int? v,
  }) =>
      SavedSales(
        user: user ?? this.user,
        inventory: inventory ?? this.inventory,
        amount: amount ?? this.amount,
        customerName: customerName ?? this.customerName,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
        v: v ?? this.v,
      );

  factory SavedSales.fromJson(Map<String, dynamic> json) => SavedSales(
        user: json["user"],
        inventory: json["inventory"],
        amount: json["amount"],
        customerName: json["customerName"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        id: json["_id"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "inventory": inventory,
        "amount": amount,
        "customerName": customerName,
        "createdAt": createdAt?.toIso8601String(),
        "_id": id,
        "__v": v,
      };
}
