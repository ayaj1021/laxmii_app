class GetInvoiceByNameResponse {
  final bool? status;
  final InventoryItem? inventoryItem;

  GetInvoiceByNameResponse({
    this.status,
    this.inventoryItem,
  });

  GetInvoiceByNameResponse copyWith({
    bool? status,
    InventoryItem? inventoryItem,
  }) =>
      GetInvoiceByNameResponse(
        status: status ?? this.status,
        inventoryItem: inventoryItem ?? this.inventoryItem,
      );

  factory GetInvoiceByNameResponse.fromJson(Map<String, dynamic> json) =>
      GetInvoiceByNameResponse(
        status: json["status"],
        inventoryItem: json["inventoryItem"] == null
            ? null
            : InventoryItem.fromJson(json["inventoryItem"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "inventoryItem": inventoryItem?.toJson(),
      };
}

class InventoryItem {
  final String? id;
  final String? user;
  final String? productName;
  final String? description;
  final num? quantity;
  final num? sellingPrice;
  final num? costPrice;
  final DateTime? createdAt;
  final int? v;

  InventoryItem({
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

  InventoryItem copyWith({
    String? id,
    String? user,
    String? productName,
    String? description,
    num? quantity,
    num? sellingPrice,
    num? costPrice,
    DateTime? createdAt,
    int? v,
  }) =>
      InventoryItem(
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

  factory InventoryItem.fromJson(Map<String, dynamic> json) => InventoryItem(
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
