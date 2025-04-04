import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/data/model/get_cashflow_response.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/presentation/notifier/get_cashflow_notifier.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/presentation/widgets/cash_flow_chart.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class CashFlowActivity extends ConsumerStatefulWidget {
  const CashFlowActivity({
    super.key,
    required this.cashFlow,
  });
  final List<CashFlowData> cashFlow;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CashFlowActivityState();
}

class _CashFlowActivityState extends ConsumerState<CashFlowActivity> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(getCashFlowNotifierProvider.notifier).getCashFlow();

      await ref.read(getAccessTokenNotifier.notifier).accessToken();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context);
    return Animate(
      effects: const [
        FadeEffect(
          duration: Duration(milliseconds: 500),
          begin: 0.5,
        ),
        ScaleEffect(
          begin: Offset(0, 5),
          duration: Duration(
            milliseconds: 500,
          ),
        )
      ],
      child: Container(
        height: MediaQuery.of(context).size.height * 0.35,
        padding: const EdgeInsets.symmetric(vertical: 19, horizontal: 10),
        width: double.infinity,
        decoration: BoxDecoration(
            color: colorScheme.cardColor,
            borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Cashflow',
                  style: context.textTheme.s14w400.copyWith(
                    color: colorScheme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            const VerticalSpacing(30),
            widget.cashFlow.isEmpty
                ? Column(
                    children: [
                      Text(
                        'No Activity yet',
                        style: context.textTheme.s16w400.copyWith(
                          color: AppColors.primary5E5E5E,
                        ),
                      ),
                      const VerticalSpacing(9),
                      Text(
                        'Create sales and expenses to see activities',
                        style: context.textTheme.s14w400.copyWith(
                          color: AppColors.primary5E5E5E,
                        ),
                      ),
                    ],
                  )
                : CashFlowChart(
                    cashflow: widget.cashFlow,
                  )
          ],
        ),
      ),
    );
  }
}
