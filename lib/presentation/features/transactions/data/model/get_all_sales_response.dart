class GetAllSalesResponse {
  final bool? status;
  final List<Sale>? sales;

  GetAllSalesResponse({
    this.status,
    this.sales,
  });

  GetAllSalesResponse copyWith({
    bool? status,
    List<Sale>? sales,
  }) =>
      GetAllSalesResponse(
        status: status ?? this.status,
        sales: sales ?? this.sales,
      );

  factory GetAllSalesResponse.fromJson(Map<String, dynamic> json) =>
      GetAllSalesResponse(
        status: json["status"],
        sales: json["sales"] == null
            ? []
            : List<Sale>.from(json["sales"]!.map((x) => Sale.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "sales": sales == null
            ? []
            : List<dynamic>.from(sales!.map((x) => x.toJson())),
      };
}

class Sale {
  final String? id;
  final String? user;
  final String? inventory;
  final num? amount;
  final String? customerName;
  final DateTime? createdAt;
  final int? v;

  Sale({
    this.id,
    this.user,
    this.inventory,
    this.amount,
    this.customerName,
    this.createdAt,
    this.v,
  });

  Sale copyWith({
    String? id,
    String? user,
    String? inventory,
    num? amount,
    String? customerName,
    DateTime? createdAt,
    int? v,
  }) =>
      Sale(
        id: id ?? this.id,
        user: user ?? this.user,
        inventory: inventory ?? this.inventory,
        amount: amount ?? this.amount,
        customerName: customerName ?? this.customerName,
        createdAt: createdAt ?? this.createdAt,
        v: v ?? this.v,
      );

  factory Sale.fromJson(Map<String, dynamic> json) => Sale(
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
