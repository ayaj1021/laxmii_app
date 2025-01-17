class UpdateInventoryRequest {
  final String productName;
  final String description;
  final int quantity;
  final int sellingPrice;
  final int costPrice;

  UpdateInventoryRequest({
    required this.productName,
    required this.description,
    required this.quantity,
    required this.sellingPrice,
    required this.costPrice,
  });

  UpdateInventoryRequest copyWith({
    String? productName,
    String? description,
    int? quantity,
    int? sellingPrice,
    int? costPrice,
  }) =>
      UpdateInventoryRequest(
        productName: productName ?? this.productName,
        description: description ?? this.description,
        quantity: quantity ?? this.quantity,
        sellingPrice: sellingPrice ?? this.sellingPrice,
        costPrice: costPrice ?? this.costPrice,
      );

  factory UpdateInventoryRequest.fromJson(Map<String, dynamic> json) =>
      UpdateInventoryRequest(
        productName: json["productName"],
        description: json["description"],
        quantity: json["quantity"],
        sellingPrice: json["sellingPrice"],
        costPrice: json["costPrice"],
      );

  Map<String, dynamic> toJson() => {
        "productName": productName,
        "description": description,
        "quantity": quantity,
        "sellingPrice": sellingPrice,
        "costPrice": costPrice,
      };
}
