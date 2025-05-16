import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/profile_setup/presentation/notifier/select_financial_goals_notifier.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_checkbox.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class FinancialGoalsSetupView extends ConsumerWidget {
  const FinancialGoalsSetupView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkboxState = ref.watch(checkboxStateProvider);
    final colorScheme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Financial Goals',
          style: context.textTheme.s24w400.copyWith(
            color: colorScheme.colorScheme.onSurface,
          ),
        ),
        Text(
          'Select all that applies',
          style: context.textTheme.s14w400.copyWith(
            color: colorScheme.colorScheme.onSurface,
          ),
        ),
        const VerticalSpacing(48),
        // FinancialGoalsListWidget(
        //   icon: '💰',
        //   name: 'Increase Savings',
        //   isChecked: checkboxState['increaseSavings'] ?? false,
        //   onChecked: (v) {
        //     ref.read(checkboxStateProvider.notifier).toggleCheckbox(
        //           'increaseSavings',
        //           v ?? false,
        //         );
        //   },
        // ),
        // const VerticalSpacing(26),
        FinancialGoalsListWidget(
          icon: '📉',
          name: 'Reduce Expenses',
          isChecked: checkboxState['reduceExpenses'] ?? false,
          onChecked: (v) {
            ref
                .read(checkboxStateProvider.notifier)
                .toggleCheckbox('reduceExpenses', v ?? false);
          },
        ),
        const VerticalSpacing(26),
        FinancialGoalsListWidget(
          icon: '📊',
          name: 'Optimize Tax Deductions',
          isChecked: checkboxState['optimizeTaxDeductions'] ?? false,
          onChecked: (v) {
            ref
                .read(checkboxStateProvider.notifier)
                .toggleCheckbox('optimizeTaxDeductions', v ?? false);
          },
        ),
        const VerticalSpacing(26),
        FinancialGoalsListWidget(
          icon: '🏠',
          name: 'Track Business/Freelance Income',
          isChecked: checkboxState['trackBusinessIncome'] ?? false,
          onChecked: (v) {
            ref
                .read(checkboxStateProvider.notifier)
                .toggleCheckbox('trackBusinessIncome', v ?? false);
          },
        ),
        const VerticalSpacing(26),
        // FinancialGoalsListWidget(
        //   icon: '🚀',
        //   name: 'Invest Smarter',
        //   isChecked: checkboxState['investSmarter'] ?? false,
        //   onChecked: (v) {
        //     ref
        //         .read(checkboxStateProvider.notifier)
        //         .toggleCheckbox('investSmarter', v ?? false);
        //   },
        // ),
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
      required this.onChecked});
  final String icon;
  final String name;
  final bool isChecked;
  final void Function(bool?) onChecked;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChecked(!isChecked);
      },
      child: Row(
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
          OnboardLaxmiiCheckbox(isChecked: isChecked, onChecked: onChecked),
        ],
      ),
    );
  }
}
