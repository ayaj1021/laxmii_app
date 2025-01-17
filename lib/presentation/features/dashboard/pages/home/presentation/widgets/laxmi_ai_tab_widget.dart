import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/general_widgets/app_button.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class LaxmiAiTabWidget extends StatelessWidget {
  const LaxmiAiTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.primary212121,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'LAXMII AI Assistant',
                    style: context.textTheme.s16w500.copyWith(
                      color: AppColors.primaryC4C4C4,
                    ),
                  ),
                  const HorizontalSpacing(5),
                  SizedBox(
                      height: 16,
                      child: Image.asset('assets/logo/laxmii_image_logo.png'))
                ],
              ),
              const VerticalSpacing(3),
              SizedBox(
                width: 202,
                child: Text(
                  'Ask AI Assistant any question on your finance',
                  style: context.textTheme.s10w300.copyWith(
                    color: AppColors.primary5E5E5E,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
              width: 92.w,
              child: LaxmiiSendButton(
                onTap: () {},
                title: 'Start Chat',
                textColor: AppColors.black,
              ))
        ],
      ),
    );
  }
}
