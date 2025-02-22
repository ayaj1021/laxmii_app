import 'package:flutter/material.dart';

class CreateQuotesRequest {
  final String customerName;
  final String quoteNumber;
  final String issueDate;
  final String expiryDate;
  final List<Item> items;
  final int totalAmount;

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
    int? totalAmount,
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
  final int quantity;
  final int price;

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
  final int itemQuantity;
  final int itemPrice;

  ProductItem({
    required this.itemName,
    required this.itemPrice,
    required this.itemQuantity,
  });
}

ValueNotifier<List<ProductItem>> quoteItemsNotifier =
    ValueNotifier<List<ProductItem>>([]);

extension ProductItemsConverter on ProductItem {
  Item toItem() {
    return Item(
        description: itemName, quantity: itemQuantity, price: itemPrice);
  }
}

List<Item> convertProductItemsToQuoteItems(List<ProductItem> productItems) {
  return productItems.map((product) => product.toItem()).toList();
}
