import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/strings.dart';
import 'package:laxmii_app/presentation/general_widgets/app_button.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class SuccessWidget extends StatelessWidget {
  const SuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.h,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(
        bottom: 51,
        top: 85,
        left: 20,
        right: 20,
      ),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/icons/success_image.png'),
        ),
      ),
      child: Column(
        children: [
          Text(
            Strings.successfulTransaction,
            style: context.textTheme.s20w600.copyWith(
              color: AppColors.black,
            ),
          ),
          const VerticalSpacing(12),
          Text(
            Strings.thisIsToConfirmTransactionSuccessful,
            style: context.textTheme.s12w400.copyWith(
              color: AppColors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const VerticalSpacing(60),
          LaxmiiSendButton(
            backgroundColor: AppColors.primaryFFCBBA,
            textColor: AppColors.primary101010,
            onTap: () {
              Navigator.pop(context);
            },
            title: 'Make Another Transaction',
          ),
          const VerticalSpacing(24),
          LaxmiiSendButton(
            onTap: () {
              //  context.pushReplacementNamed(Dashboard.routeName);
            },
            title: 'Go to Homepage',
          ),
        ],
      ),
    );
  }
}
