class CreateInvoiceRequest {
  final String customerName;
  final String invoiceNumber;
  final String issueDate;
  final String dueDate;
  final List<CreateInvoiceItem> items;
  final num totalAmount;
  final String status;

  CreateInvoiceRequest({
    required this.customerName,
    required this.invoiceNumber,
    required this.issueDate,
    required this.dueDate,
    required this.items,
    required this.totalAmount,
    required this.status,
  });

  CreateInvoiceRequest copyWith({
    String? customerName,
    String? invoiceNumber,
    String? issueDate,
    String? dueDate,
    List<CreateInvoiceItem>? items,
    double? totalAmount,
    String? status,
  }) =>
      CreateInvoiceRequest(
        customerName: customerName ?? this.customerName,
        invoiceNumber: invoiceNumber ?? this.invoiceNumber,
        issueDate: issueDate ?? this.issueDate,
        dueDate: dueDate ?? this.dueDate,
        items: items ?? this.items,
        totalAmount: totalAmount ?? this.totalAmount,
        status: status ?? this.status,
      );

  factory CreateInvoiceRequest.fromJson(Map<String, dynamic> json) =>
      CreateInvoiceRequest(
        customerName: json["customerName"],
        invoiceNumber: json["invoiceNumber"],
        issueDate: json["issueDate"],
        dueDate: json["dueDate"],
        items: List<CreateInvoiceItem>.from(
            json["items"].map((x) => CreateInvoiceItem.fromJson(x))),
        totalAmount: json["totalAmount"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "customerName": customerName,
        "invoiceNumber": invoiceNumber,
        "issueDate": issueDate,
        "dueDate": dueDate,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "totalAmount": totalAmount,
        "status": status,
      };
}

class CreateInvoiceItem {
  final String description;
  final num quantity;
  final num price;

  CreateInvoiceItem({
    required this.description,
    required this.quantity,
    required this.price,
  });

  CreateInvoiceItem copyWith({
    String? description,
    int? quantity,
    double? price,
  }) =>
      CreateInvoiceItem(
        description: description ?? this.description,
        quantity: quantity ?? this.quantity,
        price: price ?? this.price,
      );

  factory CreateInvoiceItem.fromJson(Map<String, dynamic> json) =>
      CreateInvoiceItem(
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
