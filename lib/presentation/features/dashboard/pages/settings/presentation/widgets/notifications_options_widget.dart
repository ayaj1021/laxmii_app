import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';

class NotificationsOptionsWidget extends StatelessWidget {
  const NotificationsOptionsWidget(
      {super.key, required this.title, this.onChanged, required this.value});
  final String title;
  final Function(bool)? onChanged;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.primary010101),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: context.textTheme.s14w500.copyWith(
              color: AppColors.primary5E5E5E,
            ),
          ),
          Transform.scale(
              scaleY: 1,
              scaleX: 1,
              child: Switch(
                  activeTrackColor: AppColors.primaryColor,
                  inactiveTrackColor: AppColors.primary010101,
                  value: value,
                  onChanged: onChanged))
        ],
      ),
    );
  }
}
