class CreateInventoryRequest {
  final String productName;
  final String description;
  final int quantity;
  final String supplierName;
  final num sellingPrice;
  final num costPrice;

  CreateInventoryRequest({
    required this.productName,
    required this.description,
    required this.quantity,
    required this.supplierName,
    required this.sellingPrice,
    required this.costPrice,
  });

  CreateInventoryRequest copyWith({
    String? productName,
    String? description,
    int? quantity,
    String? supplierName,
    int? sellingPrice,
    int? costPrice,
  }) =>
      CreateInventoryRequest(
        productName: productName ?? this.productName,
        description: description ?? this.description,
        quantity: quantity ?? this.quantity,
        supplierName: supplierName ?? this.supplierName,
        sellingPrice: sellingPrice ?? this.sellingPrice,
        costPrice: costPrice ?? this.costPrice,
      );

  factory CreateInventoryRequest.fromJson(Map<String, dynamic> json) =>
      CreateInventoryRequest(
        productName: json["productName"],
        description: json["description"],
        quantity: json["quantity"],
        supplierName: json["supplierName"],
        sellingPrice: json["sellingPrice"],
        costPrice: json["costPrice"],
      );

  Map<String, dynamic> toJson() => {
        "productName": productName,
        "description": description,
        "quantity": quantity,
        "supplierName": supplierName,
        "sellingPrice": sellingPrice,
        "costPrice": costPrice,
      };
}
