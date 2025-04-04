import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/ai_chat/presentation/view/ai_assistant.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class LaxmiAiTabWidget extends StatelessWidget {
  const LaxmiAiTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context);
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
                      color: colorScheme.colorScheme.onSurface,
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
          GestureDetector(
            onTap: () => context.pushNamed(AiAssistant.routeName),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                'Start chat',
                style: context.textTheme.s12w400
                    .copyWith(color: colorScheme.scaffoldBackgroundColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}
