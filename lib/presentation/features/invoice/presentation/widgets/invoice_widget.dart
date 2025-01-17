import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';

class InvoiceWidget extends StatelessWidget {
  const InvoiceWidget({super.key, required this.title, required this.subTitle});
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: context.textTheme.s14w500.copyWith(
            color: AppColors.primary5E5E5E,
          ),
        ),
        Text(
          subTitle,
          style: context.textTheme.s14w400.copyWith(
            color: AppColors.primary5E5E5E,
          ),
        ),
      ],
    );
  }
}
