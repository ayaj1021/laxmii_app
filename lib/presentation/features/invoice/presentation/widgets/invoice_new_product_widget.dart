import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/string_extensions.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class InvoiceNewProductWidget extends StatelessWidget {
  const InvoiceNewProductWidget(
      {super.key,
      required this.itemName,
      required this.currency,
      required this.itemQuantity,
      required this.itemPrice,
      this.onItemDelete,
      this.hasDelete = true,
      required this.totalItemPrice});
  final String itemName;
  final String currency;
  final num itemQuantity;
  final num itemPrice;
  final double totalItemPrice;
  final bool? hasDelete;
  final Function()? onItemDelete;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              itemName.capitalize,
              style: context.textTheme.s14w400.copyWith(
                color: colorScheme.colorScheme.onSurface,
              ),
            ),
            Row(
              children: [
                Text(
                  '$currency$totalItemPrice',
                  style: context.textTheme.s14w400.copyWith(
                    color: AppColors.primary5E5E5E,
                  ),
                ),
                const HorizontalSpacing(2),
                if (hasDelete == true)
                  GestureDetector(
                    onTap: onItemDelete,
                    child: const Icon(
                      Icons.delete,
                      size: 18,
                      color: AppColors.red,
                    ),
                  )
              ],
            ),
          ],
        ),
        Text(
          '${itemQuantity == 0 ? 1 : itemQuantity} x $currency$itemPrice',
          style: context.textTheme.s12w400.copyWith(
            color: AppColors.primaryC4C4C4,
          ),
        ),
      ],
    );
  }
}
