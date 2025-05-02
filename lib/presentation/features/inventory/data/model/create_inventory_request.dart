class CreateInventoryRequest {
  final String type;
  final String productName;
  final String description;
  final int? quantity;
  final String? supplierName;
  final num? sellingPrice;
  final num costPrice;

  CreateInventoryRequest({
    required this.type,
    required this.productName,
    required this.description,
    this.quantity,
    this.supplierName,
    this.sellingPrice,
    required this.costPrice,
  });

  CreateInventoryRequest copyWith({
    String? type,
    String? productName,
    String? description,
    int? quantity,
    String? supplierName,
    int? sellingPrice,
    int? costPrice,
  }) =>
      CreateInventoryRequest(
        type: type ?? this.type,
        productName: productName ?? this.productName,
        description: description ?? this.description,
        quantity: quantity ?? this.quantity,
        supplierName: supplierName ?? this.supplierName,
        sellingPrice: sellingPrice ?? this.sellingPrice,
        costPrice: costPrice ?? this.costPrice,
      );

  factory CreateInventoryRequest.fromJson(Map<String, dynamic> json) =>
      CreateInventoryRequest(
        type: json["type"],
        productName: json["productName"],
        description: json["description"],
        quantity: json["quantity"],
        supplierName: json["supplierName"],
        sellingPrice: json["sellingPrice"],
        costPrice: json["costPrice"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "productName": productName,
        "description": description,
        "quantity": quantity,
        "supplierName": supplierName,
        "sellingPrice": sellingPrice,
        "costPrice": costPrice,
      };
}

// To parse this JSON data, do
//
//     final createInventoryRequest = createInventoryRequestFromJson(jsonString);

// class CreateInventoryRequest {
//   final String? type;
//   final String productName;
//   final String description;
//   final num costPrice;

//   CreateInventoryRequest({
//     required this.type,
//     required this.productName,
//     required this.description,
//     required this.costPrice,
//   });

//   CreateInventoryRequest copyWith({
//     String? type,
//     String? productName,
//     String? description,
//     num? costPrice,
//   }) =>
//       CreateInventoryRequest(
//         type: type ?? this.type,
//         productName: productName ?? this.productName,
//         description: description ?? this.description,
//         costPrice: costPrice ?? this.costPrice,
//       );

//   factory CreateInventoryRequest.fromJson(Map<String, dynamic> json) =>
//       CreateInventoryRequest(
//         type: json["type"],
//         productName: json["productName"],
//         description: json["description"],
//         costPrice: json["costPrice"],
//       );

//   Map<String, dynamic> toJson() => {
//         "type": type,
//         "productName": productName,
//         "description": description,
//         "costPrice": costPrice,
//       };
// }
