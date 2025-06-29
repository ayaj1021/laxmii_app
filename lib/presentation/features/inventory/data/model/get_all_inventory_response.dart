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
  final String? type;
  final String? productName;
  final String? description;
  final String? supplierName;
  final num? quantity;
  final num? sellingPrice;
  final num? costPrice;
  final DateTime? createdAt;
  final int? v;

  Inventory({
    this.id,
    this.user,
    this.type,
    this.productName,
    this.description,
    this.supplierName,
    this.quantity,
    this.sellingPrice,
    this.costPrice,
    this.createdAt,
    this.v,
  });

  Inventory copyWith({
    String? id,
    String? user,
    String? type,
    String? productName,
    String? description,
    String? supplierName,
    num? quantity,
    num? sellingPrice,
    num? costPrice,
    DateTime? createdAt,
    int? v,
  }) =>
      Inventory(
        id: id ?? this.id,
        user: user ?? this.user,
        type: type ?? this.type,
        productName: productName ?? this.productName,
        description: description ?? this.description,
        supplierName: supplierName ?? this.supplierName,
        quantity: quantity ?? this.quantity,
        sellingPrice: sellingPrice ?? this.sellingPrice,
        costPrice: costPrice ?? this.costPrice,
        createdAt: createdAt ?? this.createdAt,
        v: v ?? this.v,
      );

  factory Inventory.fromJson(Map<String, dynamic> json) => Inventory(
        id: json["_id"],
        user: json["user"],
        type: json["type"],
        productName: json["productName"],
        description: json["description"],
        supplierName: json["supplierName"],
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
        "type": type,
        "productName": productName,
        "description": description,
        "supplierName": supplierName,
        "quantity": quantity,
        "sellingPrice": sellingPrice,
        "costPrice": costPrice,
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
      };
}
