import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';

class SettingsOptionsButton extends StatelessWidget {
  const SettingsOptionsButton({
    super.key,
    required this.title,
    required this.icon,
    required this.textColor,
    this.prefixIcon,
  });
  final String title;
  final IconData icon;
  final IconData? prefixIcon;

  final Color textColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: colorScheme.cardColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (prefixIcon != null)
                Icon(prefixIcon, color: AppColors.primaryFF5733),
              const SizedBox(width: 8),
              Text(
                title,
                style: context.textTheme.s14w500.copyWith(
                  color: textColor,
                ),
              ),
            ],
          ),
          Icon(
            icon,
            color: AppColors.primaryFF5733,
            size: 18,
          )
        ],
      ),
    );
  }
}
