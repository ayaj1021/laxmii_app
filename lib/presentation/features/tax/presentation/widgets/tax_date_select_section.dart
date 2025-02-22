import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class TaxDateSelectSection extends StatelessWidget {
  const TaxDateSelectSection(
      {super.key,
      required this.fromDate,
      required this.toDate,
      required this.fromDateTap,
      required this.toDateTap});
  final String fromDate;
  final String toDate;
  final Function() fromDateTap;
  final Function() toDateTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TaxDateWidget(
          title: 'From',
          selectedDate: fromDate,
          onTap: fromDateTap,
        ),
        TaxDateWidget(
          title: 'To',
          selectedDate: toDate,
          onTap: toDateTap,
        )
      ],
    );
  }
}

class TaxDateWidget extends StatelessWidget {
  const TaxDateWidget(
      {super.key,
      required this.title,
      required this.selectedDate,
      required this.onTap});
  final String title;
  final String selectedDate;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.s14w400.copyWith(
            color: AppColors.primary5E5E5E,
          ),
        ),
        const VerticalSpacing(5),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                width: 1.5,
                color: AppColors.primary5E5E5E.withValues(alpha: 0.5),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedDate,
                  style: context.textTheme.s14w500.copyWith(
                    color: AppColors.primary5E5E5E,
                  ),
                ),
                SvgPicture.asset('assets/icons/date.svg')
              ],
            ),
          ),
        )
      ],
    );
  }
}
