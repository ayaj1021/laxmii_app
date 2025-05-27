class UpdateInventoryRequest {
  final String productName;
  final String description;
  final String? supplierName;
  final int? quantity;
  final int? sellingPrice;
  final int? costPrice;
  final String type;

  UpdateInventoryRequest({
    required this.productName,
    required this.description,
    this.quantity,
    this.sellingPrice,
    this.costPrice,
    this.supplierName,
    required this.type,
  });

  UpdateInventoryRequest copyWith({
    String? productName,
    String? description,
    int? quantity,
    int? sellingPrice,
    int? costPrice,
    String? supplierName,
    String? type,
  }) =>
      UpdateInventoryRequest(
        productName: productName ?? this.productName,
        description: description ?? this.description,
        quantity: quantity ?? this.quantity,
        sellingPrice: sellingPrice ?? this.sellingPrice,
        supplierName: supplierName ?? this.supplierName,
        costPrice: costPrice ?? this.costPrice,
        type: type ?? this.type,
      );

  factory UpdateInventoryRequest.fromJson(Map<String, dynamic> json) =>
      UpdateInventoryRequest(
        productName: json["productName"],
        description: json["description"],
        quantity: json["quantity"],
        sellingPrice: json["sellingPrice"],
        supplierName: json["supplierName"],
        costPrice: json["costPrice"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "productName": productName,
      "description": description,
      "costPrice": costPrice,
      "type": type,
    };

    if (quantity != null) {
      data['quantity'] = quantity;
    }
    if (sellingPrice != null) {
      data['sellingPrice'] = sellingPrice;
    }
    if (supplierName != null) {
      data['supplierName'] = supplierName;
    }

    return data;
  }

  // => {
  //       "productName": productName,
  //       "description": description,
  //       //  "quantity": quantity,
  //       //  "sellingPrice": sellingPrice,
  //       //  "supplierName": supplierName,
  //       "costPrice": costPrice,
  //       "type": type,
  //     };
}
