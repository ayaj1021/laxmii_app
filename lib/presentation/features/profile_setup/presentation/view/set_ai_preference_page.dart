import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/profile_setup/presentation/notifier/select_financial_goals_notifier.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class SetAiPreferencePage extends ConsumerStatefulWidget {
  const SetAiPreferencePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SetAiPreferencePageState();
}

class _SetAiPreferencePageState extends ConsumerState<SetAiPreferencePage> {
  @override
  Widget build(BuildContext context) {
    final checkboxState = ref.watch(checkboxStateProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Set AI Preference',
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
        SetAiPreferenceWidget(
          title: 'Budget Alerts',
          subTitle: 'Notify me if I exceed my budget',
          value: checkboxState['budgetAlerts'] ?? false,
          onChanged: (v) {
            ref
                .read(checkboxStateProvider.notifier)
                .toggleCheckbox('budgetAlerts', v);
          },
        ),
        const VerticalSpacing(20),
        SetAiPreferenceWidget(
          title: 'Tax Savings: ',
          subTitle: 'Show me new deductions I qualify for',
          value: checkboxState['taxSavings'] ?? false,
          onChanged: (v) {
            ref
                .read(checkboxStateProvider.notifier)
                .toggleCheckbox('taxSavings', v);
          },
        ),
        const VerticalSpacing(20),
        SetAiPreferenceWidget(
          title: 'Investment Tips:',
          subTitle: 'Suggest low-risk investment opportunities',
          value: checkboxState['investmentTips'] ?? false,
          onChanged: (v) {
            ref
                .read(checkboxStateProvider.notifier)
                .toggleCheckbox('investmentTips', v);
          },
        ),
      ],
    );
  }
}

class SetAiPreferenceWidget extends StatelessWidget {
  const SetAiPreferenceWidget(
      {super.key,
      required this.title,
      required this.subTitle,
      this.onChanged,
      required this.value});
  final String title;
  final String subTitle;
  final Function(bool)? onChanged;
  final bool value;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: context.textTheme.s14w400.copyWith(
                color: AppColors.primaryC4C4C4,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                subTitle,
                style: context.textTheme.s14w400.copyWith(
                  color: AppColors.primary444444,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),

        // Switch.adaptive(
        //     activeTrackColor: AppColors.primaryColor,
        //     inactiveTrackColor: AppColors.primary101010,
        //     value: false,
        //     onChanged: (value) {}),

        Transform.scale(
            scaleY: 0.9,
            scaleX: 1,
            child: Switch(
                // activeTrackColor: AppColors.primaryColor,
                // inactiveTrackColor: AppColors.primary101010,
                thumbColor: WidgetStateProperty.all(AppColors.white),
                trackColor: WidgetStateProperty.all(AppColors.primary3B3522),
                value: value,
                onChanged: onChanged))
      ],
    );
  }
}
