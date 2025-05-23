class UpdateInventoryRequest {
  final String productName;
  final String description;
  final String? supplierName;
  final int? quantity;
  final int? sellingPrice;
  final int? costPrice;

  UpdateInventoryRequest({
    required this.productName,
    required this.description,
    this.quantity,
    this.sellingPrice,
    this.costPrice,
    this.supplierName,
  });

  UpdateInventoryRequest copyWith({
    String? productName,
    String? description,
    int? quantity,
    int? sellingPrice,
    int? costPrice,
    String? supplierName,
  }) =>
      UpdateInventoryRequest(
        productName: productName ?? this.productName,
        description: description ?? this.description,
        quantity: quantity ?? this.quantity,
        sellingPrice: sellingPrice ?? this.sellingPrice,
        supplierName: supplierName ?? this.supplierName,
        costPrice: costPrice ?? this.costPrice,
      );

  factory UpdateInventoryRequest.fromJson(Map<String, dynamic> json) =>
      UpdateInventoryRequest(
        productName: json["productName"],
        description: json["description"],
        quantity: json["quantity"],
        sellingPrice: json["sellingPrice"],
        supplierName: json["supplierName"],
        costPrice: json["costPrice"],
      );

  Map<String, dynamic> toJson() => {
        "productName": productName,
        "description": description,
        "quantity": quantity,
        "sellingPrice": sellingPrice,
        "supplierName": supplierName,
        "costPrice": costPrice,
      };
}
