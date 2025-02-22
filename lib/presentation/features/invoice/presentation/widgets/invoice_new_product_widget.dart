import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';

class InvoiceNewProductWidget extends StatelessWidget {
  const InvoiceNewProductWidget(
      {super.key,
      required this.itemName,
      required this.itemQuantity,
      required this.itemPrice});
  final String itemName;
  final int itemQuantity;
  final double itemPrice;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            itemName,
            style: context.textTheme.s14w400.copyWith(
              color: AppColors.primary5E5E5E,
            ),
          ),
          Text(
            '\$$itemPrice',
            style: context.textTheme.s14w400.copyWith(
              color: AppColors.primary5E5E5E,
            ),
          ),
        ],
      ),
      Text(
        '$itemQuantity x \$$itemPrice',
        style: context.textTheme.s12w400.copyWith(
          color: AppColors.primaryC4C4C4,
        ),
      ),
    ]);
  }
}
