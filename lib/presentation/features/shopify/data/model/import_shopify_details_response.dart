class ImportShopifyDetailsResponse {
  final bool? status;
  final String? message;
  final int? totalOrders;

  ImportShopifyDetailsResponse({
    this.status,
    this.message,
    this.totalOrders,
  });

  ImportShopifyDetailsResponse copyWith({
    bool? status,
    String? message,
    int? totalOrders,
  }) =>
      ImportShopifyDetailsResponse(
        status: status ?? this.status,
        message: message ?? this.message,
        totalOrders: totalOrders ?? this.totalOrders,
      );

  factory ImportShopifyDetailsResponse.fromJson(Map<String, dynamic> json) =>
      ImportShopifyDetailsResponse(
        status: json["status"],
        message: json["message"],
        totalOrders: json["totalOrders"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "totalOrders": totalOrders,
      };
}
