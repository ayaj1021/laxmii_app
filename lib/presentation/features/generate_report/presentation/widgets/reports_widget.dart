import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';

class ReportsWidget extends StatelessWidget {
  const ReportsWidget({super.key, required this.report, this.color});
  final String report;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              report,
              style: context.textTheme.s14w400.copyWith(
                  color: AppColors.white, fontWeight: FontWeight.w300),
            ),
            Icon(
              Icons.star,
              color: color,
            ),
          ],
        )
      ],
    );
  }
}
