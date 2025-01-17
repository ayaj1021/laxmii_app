class CreateSalesRequest {
  final String inventory;
  final String amount;
  final String customerName;

  CreateSalesRequest({
    required this.inventory,
    required this.amount,
    required this.customerName,
  });

  CreateSalesRequest copyWith({
    String? inventory,
    String? amount,
    String? customerName,
  }) =>
      CreateSalesRequest(
        inventory: inventory ?? this.inventory,
        amount: amount ?? this.amount,
        customerName: customerName ?? this.customerName,
      );

  factory CreateSalesRequest.fromJson(Map<String, dynamic> json) =>
      CreateSalesRequest(
        inventory: json["inventory"],
        amount: json["amount"],
        customerName: json["customerName"],
      );

  Map<String, dynamic> toJson() => {
        "inventory": inventory,
        "amount": amount,
        "customerName": customerName,
      };
}
