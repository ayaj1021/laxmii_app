import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class BottomSection extends StatelessWidget {
  const BottomSection({
    super.key,
    required this.totalAmount,
  });
  final String totalAmount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 32),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: AppColors.primary101010,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: context.textTheme.s11w600.copyWith(
                    color: AppColors.primaryC4C4C4,
                  ),
                ),
                Text(
                  totalAmount,
                  style: context.textTheme.s11w600.copyWith(
                    color: AppColors.primaryC4C4C4,
                  ),
                ),
                Text(
                  totalAmount,
                  style: context.textTheme.s11w600.copyWith(
                    color: AppColors.primaryC4C4C4,
                  ),
                ),
                Text(
                  totalAmount,
                  style: context.textTheme.s11w600.copyWith(
                    color: AppColors.primaryC4C4C4,
                  ),
                )
              ],
            )),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 90),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: AppColors.primary382D0B,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ReportShareWidget(
                icon: 'assets/icons/pdf.svg',
                title: 'PDF',
              ),
              ReportShareWidget(
                icon: 'assets/icons/excel.svg',
                title: 'Excel',
              ),
              ReportShareWidget(
                icon: 'assets/icons/image.svg',
                title: 'Image',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ReportShareWidget extends StatelessWidget {
  const ReportShareWidget({super.key, required this.icon, required this.title});
  final String icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(icon),
        const VerticalSpacing(2),
        Text(
          title,
          style: context.textTheme.s12w400.copyWith(
            color: AppColors.white,
          ),
        )
      ],
    );
  }
}
