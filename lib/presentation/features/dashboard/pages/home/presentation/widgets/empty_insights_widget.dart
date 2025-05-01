import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class EmptyInsightsWidget extends StatelessWidget {
  const EmptyInsightsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context);
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.1,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      decoration: BoxDecoration(
        color: colorScheme.cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'No Insight Yet',
            style: context.textTheme.s16w500.copyWith(
              color: colorScheme.colorScheme.onSurface,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const VerticalSpacing(5),
          Text(
            'Your insight will be populated once there is an activity in your account',
            style: context.textTheme.s10w300.copyWith(
              color: AppColors.primary5E5E5E,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const VerticalSpacing(20),
          SvgPicture.asset('assets/icons/expense_icon.svg')
        ],
      ),
    );
  }
}
