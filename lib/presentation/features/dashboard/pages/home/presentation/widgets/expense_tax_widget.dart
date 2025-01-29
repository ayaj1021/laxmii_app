import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/general_widgets/app_button.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class ExpensesTaxWidget extends StatelessWidget {
  const ExpensesTaxWidget(
      {super.key, required this.title, required this.subTitle});
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      decoration: BoxDecoration(
          color: AppColors.primary101010,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textTheme.s16w500.copyWith(
              color: AppColors.white,
            ),
          ),
          const VerticalSpacing(5),
          Text(
            subTitle,
            style: context.textTheme.s10w300.copyWith(
              color: AppColors.primary5E5E5E,
            ),
          ),
          const VerticalSpacing(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5.33),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.primary075427,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Text(
                              '%12',
                              style: context.textTheme.s10w600.copyWith(
                                color: AppColors.primary1FCB4F,
                              ),
                            ),
                            const HorizontalSpacing(5),
                            SvgPicture.asset('assets/icons/arrow_up.svg'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const HorizontalSpacing(16),
                  SvgPicture.asset('assets/icons/expense_icon.svg')
                ],
              ),
              SizedBox(
                  width: 47.w,
                  height: 26.w,
                  child: LaxmiiSendButton(
                      borderColor: AppColors.primary3B3522,
                      textColor: AppColors.white,
                      hasBorder: true,
                      onTap: () {},
                      title: 'View'))
            ],
          )
        ],
      ),
    );
  }
}
