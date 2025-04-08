import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/string_extensions.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class InvoiceViewWidget extends StatelessWidget {
  const InvoiceViewWidget(
      {super.key,
      required this.invoiceName,
      required this.invoiceNumber,
      required this.invoiceAmount,
      required this.invoiceStatus,
      required this.invoiceDate,
      this.invoiceStatusColor});
  final String invoiceName;
  final String invoiceNumber;
  final String invoiceAmount;
  final String invoiceStatus;
  final String invoiceDate;
  final Color? invoiceStatusColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: colorScheme.cardColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                invoiceName.capitalize,
                style: context.textTheme.s14w500.copyWith(
                  color: colorScheme.colorScheme.onSurface,
                ),
              ),
              Row(
                children: [
                  Text(
                    'Invoice $invoiceNumber',
                    style: context.textTheme.s12w300.copyWith(
                      color: AppColors.primary5E5E5E,
                    ),
                  ),
                  const HorizontalSpacing(4),
                  Container(
                    height: 5,
                    width: 5,
                    decoration: const BoxDecoration(
                      color: AppColors.primary5E5E5E,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const HorizontalSpacing(4),
                  Text(
                    invoiceDate,
                    style: context.textTheme.s12w300.copyWith(
                      color: AppColors.primary5E5E5E,
                    ),
                  ),
                ],
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                invoiceAmount,
                style: context.textTheme.s14w500.copyWith(
                  color: colorScheme.colorScheme.onSurface,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                decoration: BoxDecoration(
                    color: invoiceStatusColor ?? AppColors.primaryC4C4C4,
                    borderRadius: BorderRadius.circular(6)),
                child: Text(
                  invoiceStatus.capitalize,
                  style: context.textTheme.s12w300.copyWith(
                    color: AppColors.white,

                    // AppColors.primary5E5E5E,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
