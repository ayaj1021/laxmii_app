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

extension ProductItemsConverter on ProductItems {
  CreateInvoiceItem toItem() {
    return CreateInvoiceItem(
        description: itemName, quantity: itemQuantity, price: itemPrice);
  }
}

List<CreateInvoiceItem> convertProductItemsToItems(
    List<ProductItems> productItems) {
  return productItems.map((product) => product.toItem()).toList();
}
