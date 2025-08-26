import 'package:flutter/material.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  final bool isActive;
  final Color color;

  const ProgressIndicatorWidget({
    super.key,
    required this.isActive,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 7,
        decoration: BoxDecoration(
          color: isActive ? color : AppColors.primary212121,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}
