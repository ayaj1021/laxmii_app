class GetInvoiceByNameRequest {
  final String productName;

  GetInvoiceByNameRequest({
    required this.productName,
  });

  GetInvoiceByNameRequest copyWith({
    String? productName,
  }) =>
      GetInvoiceByNameRequest(
        productName: productName ?? this.productName,
      );

  factory GetInvoiceByNameRequest.fromJson(Map<String, dynamic> json) =>
      GetInvoiceByNameRequest(
        productName: json["productName"],
      );

  Map<String, dynamic> toJson() => {
        "productName": productName,
      };
}
