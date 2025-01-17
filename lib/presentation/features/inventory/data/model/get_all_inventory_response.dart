class GetInventoryResponse {
  final bool? status;
  final List<Inventory>? inventory;

  GetInventoryResponse({
    this.status,
    this.inventory,
  });

  GetInventoryResponse copyWith({
    bool? status,
    List<Inventory>? inventory,
  }) =>
      GetInventoryResponse(
        status: status ?? this.status,
        inventory: inventory ?? this.inventory,
      );

  factory GetInventoryResponse.fromJson(Map<String, dynamic> json) =>
      GetInventoryResponse(
        status: json["status"],
        inventory: json["inventory"] == null
            ? []
            : List<Inventory>.from(
                json["inventory"]!.map((x) => Inventory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "inventory": inventory == null
            ? []
            : List<dynamic>.from(inventory!.map((x) => x.toJson())),
      };
}

class Inventory {
  final String? id;
  final String? user;
  final String? productName;
  final String? description;
  final int? quantity;
  final int? sellingPrice;
  final int? costPrice;
  final DateTime? createdAt;
  final int? v;

  Inventory({
    this.id,
    this.user,
    this.productName,
    this.description,
    this.quantity,
    this.sellingPrice,
    this.costPrice,
    this.createdAt,
    this.v,
  });

  Inventory copyWith({
    String? id,
    String? user,
    String? productName,
    String? description,
    int? quantity,
    int? sellingPrice,
    int? costPrice,
    DateTime? createdAt,
    int? v,
  }) =>
      Inventory(
        id: id ?? this.id,
        user: user ?? this.user,
        productName: productName ?? this.productName,
        description: description ?? this.description,
        quantity: quantity ?? this.quantity,
        sellingPrice: sellingPrice ?? this.sellingPrice,
        costPrice: costPrice ?? this.costPrice,
        createdAt: createdAt ?? this.createdAt,
        v: v ?? this.v,
      );

  factory Inventory.fromJson(Map<String, dynamic> json) => Inventory(
        id: json["_id"],
        user: json["user"],
        productName: json["productName"],
        description: json["description"],
        quantity: json["quantity"],
        sellingPrice: json["sellingPrice"],
        costPrice: json["costPrice"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "productName": productName,
        "description": description,
        "quantity": quantity,
        "sellingPrice": sellingPrice,
        "costPrice": costPrice,
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
      };
}
