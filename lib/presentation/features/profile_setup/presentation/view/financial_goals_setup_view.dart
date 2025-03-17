import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_checkbox.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class FinancialGoalsSetupView extends StatelessWidget {
  const FinancialGoalsSetupView({super.key, required this.increaseSavingsBool});
  final bool increaseSavingsBool;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Financial Goals',
          style: context.textTheme.s24w400.copyWith(
            color: AppColors.white,
          ),
        ),
        Text(
          'Select all that applies',
          style: context.textTheme.s14w400.copyWith(
            color: AppColors.primaryC4C4C4,
          ),
        ),
        const VerticalSpacing(48),
        const FinancialGoalsListWidget(
          icon: '💰',
          name: 'Increase Savings',
          isChecked: false,
        ),
        const VerticalSpacing(26),
        const FinancialGoalsListWidget(
          icon: '📉',
          name: 'Reduce Expenses',
          isChecked: false,
        ),
        const VerticalSpacing(26),
        const FinancialGoalsListWidget(
          icon: '📊',
          name: 'Optimize Tax Deductions',
          isChecked: false,
        ),
        const VerticalSpacing(26),
        const FinancialGoalsListWidget(
          icon: '🏠',
          name: 'Track Business/Freelance Income',
          isChecked: false,
        ),
        const VerticalSpacing(26),
        const FinancialGoalsListWidget(
          icon: '🚀',
          name: 'Invest Smarter',
          isChecked: false,
        ),
      ],
    );
  }
}

class FinancialGoalsListWidget extends StatelessWidget {
  const FinancialGoalsListWidget(
      {super.key,
      required this.icon,
      required this.name,
      required this.isChecked,
      this.onChecked});
  final String icon;
  final String name;
  final bool isChecked;
  final void Function(bool?)? onChecked;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(icon),
            const HorizontalSpacing(5),
            Text(
              name,
              style: context.textTheme.s14w400.copyWith(
                color: AppColors.primary444444,
              ),
            )
          ],
        ),
        LaxmiiCheckbox(isChecked: isChecked, onChecked: onChecked ?? (v) {}),
      ],
    );
  }
}
