class UpdateInventoryResponse {
  final bool? status;
  final String? message;
  final UpdatedInventory? updatedInventory;

  UpdateInventoryResponse({
    this.status,
    this.message,
    this.updatedInventory,
  });

  UpdateInventoryResponse copyWith({
    bool? status,
    String? message,
    UpdatedInventory? updatedInventory,
  }) =>
      UpdateInventoryResponse(
        status: status ?? this.status,
        message: message ?? this.message,
        updatedInventory: updatedInventory ?? this.updatedInventory,
      );

  factory UpdateInventoryResponse.fromJson(Map<String, dynamic> json) =>
      UpdateInventoryResponse(
        status: json["status"],
        message: json["message"],
        updatedInventory: json["updatedInventory"] == null
            ? null
            : UpdatedInventory.fromJson(json["updatedInventory"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "updatedInventory": updatedInventory?.toJson(),
      };
}

class UpdatedInventory {
  final String? id;
  final String? user;
  final String? productName;
  final String? description;
  final num? quantity;
  final num? sellingPrice;
  final num? costPrice;
  final DateTime? createdAt;
  final int? v;

  UpdatedInventory({
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

  UpdatedInventory copyWith({
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
      UpdatedInventory(
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

  factory UpdatedInventory.fromJson(Map<String, dynamic> json) =>
      UpdatedInventory(
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
