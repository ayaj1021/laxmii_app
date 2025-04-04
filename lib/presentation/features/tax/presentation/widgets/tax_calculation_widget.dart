import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';

class TaxCalculationWidget extends StatelessWidget {
  const TaxCalculationWidget(
      {super.key,
      required this.title,
      required this.subTitle,
      this.titleStyle,
      this.subTitleStyle});
  final String title;
  final String subTitle;
  final TextStyle? titleStyle;
  final TextStyle? subTitleStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: titleStyle ??
              context.textTheme.s12w300.copyWith(
                color: AppColors.primary5E5E5E,
              ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.2,
          child: Text(
            subTitle,
            style: subTitleStyle ??
                context.textTheme.s14w400.copyWith(
                  color: AppColors.primary5E5E5E,
                ),
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
