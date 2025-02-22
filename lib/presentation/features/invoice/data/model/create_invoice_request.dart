class CreateInvoiceRequest {
  final String customerName;
  final String invoiceNumber;
  final String issueDate;
  final String dueDate;
  final List<Item> items;
  final double totalAmount;

  CreateInvoiceRequest({
    required this.customerName,
    required this.invoiceNumber,
    required this.issueDate,
    required this.dueDate,
    required this.items,
    required this.totalAmount,
  });

  CreateInvoiceRequest copyWith({
    String? customerName,
    String? invoiceNumber,
    String? issueDate,
    String? dueDate,
    List<Item>? items,
    double? totalAmount,
  }) =>
      CreateInvoiceRequest(
        customerName: customerName ?? this.customerName,
        invoiceNumber: invoiceNumber ?? this.invoiceNumber,
        issueDate: issueDate ?? this.issueDate,
        dueDate: dueDate ?? this.dueDate,
        items: items ?? this.items,
        totalAmount: totalAmount ?? this.totalAmount,
      );

  factory CreateInvoiceRequest.fromJson(Map<String, dynamic> json) =>
      CreateInvoiceRequest(
        customerName: json["customerName"],
        invoiceNumber: json["invoiceNumber"],
        issueDate: json["issueDate"],
        dueDate: json["dueDate"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        totalAmount: json["totalAmount"],
      );

  Map<String, dynamic> toJson() => {
        "customerName": customerName,
        "invoiceNumber": invoiceNumber,
        "issueDate": issueDate,
        "dueDate": dueDate,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "totalAmount": totalAmount,
      };
}

class Item {
  final String description;
  final int quantity;
  final double price;

  Item({
    required this.description,
    required this.quantity,
    required this.price,
  });

  Item copyWith({
    String? description,
    int? quantity,
    double? price,
  }) =>
      Item(
        description: description ?? this.description,
        quantity: quantity ?? this.quantity,
        price: price ?? this.price,
      );

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        description: json["description"],
        quantity: json["quantity"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "quantity": quantity,
        "price": price,
      };
}
