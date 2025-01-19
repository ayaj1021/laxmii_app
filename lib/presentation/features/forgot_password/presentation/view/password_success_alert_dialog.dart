import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/general_widgets/app_button.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class PasswordSuccessAlertDialog extends StatelessWidget {
  const PasswordSuccessAlertDialog(
      {super.key, required this.message, required this.onTap});
  final String message;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.h,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 25),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.primary101010),
      child: Column(
        children: [
          SvgPicture.asset('assets/icons/service_success.svg'),
          const VerticalSpacing(9),
          Text(
            'Great Job',
            style: context.textTheme.s16w500.copyWith(
              color: AppColors.green,
            ),
          ),
          SizedBox(
            width: 237.w,
            child: Text(
              message,
              style: context.textTheme.s16w500.copyWith(
                color: AppColors.green,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const VerticalSpacing(9),
          LaxmiiSendButton(onTap: onTap, title: 'Continue')
        ],
      ),
    );
  }
}
