import 'package:flutter/material.dart';
import 'package:laxmii_app/presentation/features/invoice/data/model/create_invoice_request.dart';

class ProductItems {
  final String itemName;
  final int itemQuantity;
  final double itemPrice;

  ProductItems({
    required this.itemName,
    required this.itemPrice,
    required this.itemQuantity,
  });
}

ValueNotifier<List<ProductItems>> itemsNotifier =
    ValueNotifier<List<ProductItems>>([]);

extension ProductItemsConverter on ProductItems {
  Item toItem() {
    return Item(
        description: itemName, quantity: itemQuantity, price: itemPrice);
  }
}

List<Item> convertProductItemsToItems(List<ProductItems> productItems) {
  return productItems.map((product) => product.toItem()).toList();
}
