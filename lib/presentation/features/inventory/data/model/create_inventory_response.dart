class CreateInventoryResponse {
  final bool? status;
  final String? message;
  final SavedInventory? savedInventory;

  CreateInventoryResponse({
    this.status,
    this.message,
    this.savedInventory,
  });

  CreateInventoryResponse copyWith({
    bool? status,
    String? message,
    SavedInventory? savedInventory,
  }) =>
      CreateInventoryResponse(
        status: status ?? this.status,
        message: message ?? this.message,
        savedInventory: savedInventory ?? this.savedInventory,
      );

  factory CreateInventoryResponse.fromJson(Map<String, dynamic> json) =>
      CreateInventoryResponse(
        status: json["status"],
        message: json["message"],
        savedInventory: json["savedInventory"] == null
            ? null
            : SavedInventory.fromJson(json["savedInventory"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "savedInventory": savedInventory?.toJson(),
      };
}

class SavedInventory {
  final String? user;
  final String? productName;
  final String? description;
  final int? quantity;
  final num? sellingPrice;
  final num? costPrice;
  final String? id;
  final DateTime? createdAt;
  final int? v;

  SavedInventory({
    this.user,
    this.productName,
    this.description,
    this.quantity,
    this.sellingPrice,
    this.costPrice,
    this.id,
    this.createdAt,
    this.v,
  });

  SavedInventory copyWith({
    String? user,
    String? productName,
    String? description,
    int? quantity,
    num? sellingPrice,
    num? costPrice,
    String? id,
    DateTime? createdAt,
    int? v,
  }) =>
      SavedInventory(
        user: user ?? this.user,
        productName: productName ?? this.productName,
        description: description ?? this.description,
        quantity: quantity ?? this.quantity,
        sellingPrice: sellingPrice ?? this.sellingPrice,
        costPrice: costPrice ?? this.costPrice,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        v: v ?? this.v,
      );

  factory SavedInventory.fromJson(Map<String, dynamic> json) => SavedInventory(
        user: json["user"],
        productName: json["productName"],
        description: json["description"],
        quantity: json["quantity"],
        sellingPrice: json["sellingPrice"],
        costPrice: json["costPrice"],
        id: json["_id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "productName": productName,
        "description": description,
        "quantity": quantity,
        "sellingPrice": sellingPrice,
        "costPrice": costPrice,
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
      };
}
