import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class GetQuotesWidget extends StatelessWidget {
  const GetQuotesWidget(
      {super.key,
      required this.quoteTitle,
      required this.quoteDate,
      required this.quoteAmount});
  final String quoteTitle;
  final String quoteDate;
  final String quoteAmount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      decoration: BoxDecoration(
        color: AppColors.primary101010,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                quoteTitle,
                style: context.textTheme.s14w500.copyWith(
                  color: AppColors.primaryC4C4C4,
                ),
              ),
              const VerticalSpacing(3),
              Text(
                quoteDate,
                style: context.textTheme.s12w300.copyWith(
                  color: AppColors.primary5E5E5E,
                ),
              ),
            ],
          ),
          Text(
            quoteAmount,
            style: context.textTheme.s14w400.copyWith(
              color: AppColors.primary5E5E5E,
            ),
          ),
        ],
      ),
    );
  }
}
