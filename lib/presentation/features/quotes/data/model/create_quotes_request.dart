class CreateQuotesRequest {
  final String customerName;
  final String quoteNumber;
  final String issueDate;
  final String expiryDate;
  final List<Item> items;
  final num totalAmount;

  CreateQuotesRequest({
    required this.customerName,
    required this.quoteNumber,
    required this.issueDate,
    required this.expiryDate,
    required this.items,
    required this.totalAmount,
  });

  CreateQuotesRequest copyWith({
    String? customerName,
    String? quoteNumber,
    String? issueDate,
    String? expiryDate,
    List<Item>? items,
    num? totalAmount,
  }) =>
      CreateQuotesRequest(
        customerName: customerName ?? this.customerName,
        quoteNumber: quoteNumber ?? this.quoteNumber,
        issueDate: issueDate ?? this.issueDate,
        expiryDate: expiryDate ?? this.expiryDate,
        items: items ?? this.items,
        totalAmount: totalAmount ?? this.totalAmount,
      );

  factory CreateQuotesRequest.fromJson(Map<String, dynamic> json) =>
      CreateQuotesRequest(
        customerName: json["customerName"],
        quoteNumber: json["quoteNumber"],
        issueDate: json["issueDate"],
        expiryDate: json["expiryDate"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        totalAmount: json["totalAmount"],
      );

  Map<String, dynamic> toJson() => {
        "customerName": customerName,
        "quoteNumber": quoteNumber,
        "issueDate": issueDate,
        "expiryDate": expiryDate,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "totalAmount": totalAmount,
      };
}

class Item {
  final String description;
  final num quantity;
  final num price;

  Item({
    required this.description,
    required this.quantity,
    required this.price,
  });

  Item copyWith({
    String? description,
    int? quantity,
    int? price,
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

class ProductItem {
  final String itemName;
  final num itemQuantity;
  final num itemPrice;

  ProductItem({
    required this.itemName,
    required this.itemPrice,
    required this.itemQuantity,
  });
}

extension ProductItemsConverter on ProductItem {
  Item toItem() {
    return Item(
        description: itemName, quantity: itemQuantity, price: itemPrice);
  }
}

List<Item> convertProductItemsToQuoteItems(List<ProductItem> productItems) {
  return productItems.map((product) => product.toItem()).toList();
}
