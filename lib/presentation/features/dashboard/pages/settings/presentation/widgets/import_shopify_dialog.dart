import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class ImportShopifyDialog extends StatelessWidget {
  const ImportShopifyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: colorScheme.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Import Shopify Store',
            style: context.textTheme.s15w400.copyWith(
                color: colorScheme.colorScheme.tertiary, fontSize: 18),
          ),
          const VerticalSpacing(14),
          Text(
            'Link Shopify account to Laxmii',
            style: context.textTheme.s12w500.copyWith(
              color: AppColors.primary5E5E5E,
            ),
          ),
          const VerticalSpacing(14),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: context.textTheme.s15w400.copyWith(
                    color: colorScheme.colorScheme.tertiary,
                  ),
                ),
              ),
              const HorizontalSpacing(10),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Yes, Import',
                    style: context.textTheme.s15w400.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
