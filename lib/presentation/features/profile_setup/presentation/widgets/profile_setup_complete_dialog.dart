import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/general_widgets/app_button.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class ProfileSetupCompleteAlertDialog extends StatelessWidget {
  const ProfileSetupCompleteAlertDialog(
      {super.key, required this.message, required this.onTap});
  final String message;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.37,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.primary101010),
      child: Column(
        children: [
          SvgPicture.asset('assets/icons/service_success.svg'),
          const VerticalSpacing(9),
          Text(
            message,
            style: context.textTheme.s16w500.copyWith(
              color: AppColors.green,
            ),
            textAlign: TextAlign.center,
          ),
          const VerticalSpacing(12),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Text(
              'All set! click the button to proceed to your Dashboard',
              style: context.textTheme.s14w400.copyWith(
                color: AppColors.primaryC4C4C4,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const VerticalSpacing(19),
          LaxmiiSendButton(onTap: onTap, title: 'Continue')
        ],
      ),
    );
  }
}
