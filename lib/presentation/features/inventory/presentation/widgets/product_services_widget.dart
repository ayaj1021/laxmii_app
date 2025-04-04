import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';

class ProductServicesWidget extends StatelessWidget {
  const ProductServicesWidget(
      {super.key,
      required this.itemName,
      required this.itemType,
      required this.itemPrice,
      required this.itemQuantity});
  final String itemName;
  final String itemType;
  final String itemPrice;
  final String itemQuantity;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        color: colorScheme.cardColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                itemName,
                style: context.textTheme.s18w500.copyWith(
                  color: colorScheme.colorScheme.onSurface,
                ),
              ),
              Text(
                itemType,
                style: context.textTheme.s14w400.copyWith(
                  color: AppColors.primary5E5E5E,
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                itemPrice,
                style: context.textTheme.s14w500.copyWith(
                  color: colorScheme.colorScheme.onSurface,
                ),
              ),
              Text(
                itemQuantity,
                style: context.textTheme.s12w300.copyWith(
                  color: AppColors.primary5E5E5E,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
