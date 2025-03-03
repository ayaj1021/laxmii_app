import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/generate_report/presentation/widgets/reports_share_widget.dart';

class BottomSection extends StatelessWidget {
  const BottomSection({
    super.key,
    required this.totalAmount,
    this.onGeneratePdf,
    this.onGenerateImage,
  });
  final String totalAmount;
  final Function()? onGeneratePdf;
  final Function()? onGenerateImage;

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
                // Text(
                //   totalAmount,
                //   style: context.textTheme.s11w600.copyWith(
                //     color: AppColors.primaryC4C4C4,
                //   ),
                // ),
                // Text(
                //   totalAmount,
                //   style: context.textTheme.s11w600.copyWith(
                //     color: AppColors.primaryC4C4C4,
                //   ),
                // ),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ReportShareWidget(
                icon: 'assets/icons/pdf.svg',
                title: 'PDF',
                onTap: onGeneratePdf,
              ),
              // ReportShareWidget(
              //   icon: 'assets/icons/excel.svg',
              //   title: 'Excel',
              // ),
              ReportShareWidget(
                icon: 'assets/icons/image.svg',
                title: 'Image',
                onTap: onGenerateImage,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
