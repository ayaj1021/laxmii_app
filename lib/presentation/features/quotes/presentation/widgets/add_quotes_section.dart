import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/widgets/invoice_new_product_widget.dart';
import 'package:laxmii_app/presentation/features/quotes/data/model/create_quotes_request.dart';
import 'package:laxmii_app/presentation/features/quotes/presentation/widgets/add_item_section.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class AddQuotesSection extends StatefulWidget {
  const AddQuotesSection({super.key, required this.addItem});
  final Function(ProductItem newItem) addItem;

  @override
  State<AddQuotesSection> createState() => _AddQuotesSectionState();
}

class _AddQuotesSectionState extends State<AddQuotesSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder(
            valueListenable: quoteItemsNotifier,
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
                            final price = item.itemQuantity * item.itemPrice;
                            return InkWell(
                              onLongPress: () {
                                items.remove(item);
                                widget.addItem(item);
                              },
                              child: Column(
                                children: [
                                  InvoiceNewProductWidget(
                                    itemName: item.itemName,
                                    itemQuantity: item.itemQuantity,
                                    itemPrice: price.toDouble(),
                                  ),
                                  const VerticalSpacing(5),
                                  if (index < items.length - 1)
                                    const Divider(
                                      color: AppColors.primary3B3522,
                                    )
                                ],
                              ),
                            );
                          }),
                    );
            }),
        InkWell(
          onTap: () async {
            final item = await context.pushNamed(AddItemSection.routeName);
            if (item != null) {
              quoteItemsNotifier.value = [...quoteItemsNotifier.value, item];
              widget.addItem(item);
            }
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
