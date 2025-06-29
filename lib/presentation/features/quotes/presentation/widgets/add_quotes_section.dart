import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/widgets/invoice_new_product_widget.dart';
import 'package:laxmii_app/presentation/features/quotes/data/model/create_quotes_request.dart';
import 'package:laxmii_app/presentation/features/quotes/presentation/view/quotes_inventory_view.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class AddQuotesSection extends StatefulWidget {
  const AddQuotesSection({
    super.key,
    required this.addItem,
    required this.quoteItemsNotifier,
  });
  final Function(ProductItem newItem) addItem;
  final ValueNotifier<List<ProductItem>> quoteItemsNotifier;

  @override
  State<AddQuotesSection> createState() => _AddQuotesSectionState();
}

class _AddQuotesSectionState extends State<AddQuotesSection> {
  @override
  void initState() {
    getUserCurrency();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String userCurrency = '\$';

  void getUserCurrency() async {
    final currency = await AppDataStorage().getUserCurrency();

    setState(() {
      userCurrency = currency ?? '\$';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder(
            valueListenable: widget.quoteItemsNotifier,
            builder: (context, items, child) {
              return items.isEmpty
                  ? const SizedBox.shrink()
                  : SizedBox(
                      height: MediaQuery.of(context).size.height * 0.23,
                      child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: items.length,
                          itemBuilder: (_, index) {
                            final item = items[index];
                            final price = item.itemQuantity == 0
                                ? 1
                                : item.itemQuantity * item.itemPrice;
                            return Column(
                              children: [
                                InvoiceNewProductWidget(
                                  currency: userCurrency,
                                  itemName: item.itemName,
                                  itemQuantity: item.itemQuantity,
                                  itemPrice: item.itemPrice.toDouble(),
                                  totalItemPrice: price.toDouble(),
                                  onItemDelete: () {
                                    List<ProductItem> updatedItems = List.from(
                                        widget.quoteItemsNotifier.value);
                                    updatedItems.remove(item);
                                    widget.quoteItemsNotifier.value =
                                        updatedItems;
                                  },
                                ),
                                const VerticalSpacing(5),
                                if (index < items.length - 1)
                                  const Divider(
                                    color: AppColors.primary3B3522,
                                  )
                              ],
                            );
                          }),
                    );
            }),
        InkWell(
          onTap: () async {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => QuoteInventoryListView(
                          addItem: widget.addItem,
                          itemsNotifier: widget.quoteItemsNotifier,
                        )));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add_circle,
                color: AppColors.primaryColor,
              ),
              const HorizontalSpacing(5),
              Text(
                'ADD ITEM',
                style: context.textTheme.s14w500.copyWith(
                  color: AppColors.primaryColor,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
