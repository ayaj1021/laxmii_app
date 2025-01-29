import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';

class ActivityHeader extends StatelessWidget {
  const ActivityHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Activity',
          style: context.textTheme.s24w400.copyWith(
            color: AppColors.primaryC4C4C4,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: AppColors.primary5E5E5E)),
          child: PopupMenuButton(
              child: Text(
                'Customize widget',
                style: context.textTheme.s11w600.copyWith(
                  color: AppColors.primary737373,
                ),
              ),
              // icon: Icon(Icons.keyboard_arrow_down),
              itemBuilder: (_) {
                return [];
              }),
        )
      ],
    );
  }
}
