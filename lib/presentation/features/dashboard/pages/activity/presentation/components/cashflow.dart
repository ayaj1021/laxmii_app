import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/data/model/get_cashflow_response.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/presentation/widgets/cash_flow_chart.dart';

import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class CashFlowActivity extends ConsumerStatefulWidget {
  const CashFlowActivity({
    super.key,
    required this.cashFlow,
  });
  final List<CashFlowData> cashFlow;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CashflowState();
}

class _CashflowState extends ConsumerState<CashFlowActivity> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.38,
      padding: const EdgeInsets.symmetric(vertical: 19, horizontal: 10),
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.primary101010,
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Cashflow',
                style: context.textTheme.s14w400.copyWith(
                  color: AppColors.primaryC4C4C4,
                ),
              ),
            ],
          ),
          const VerticalSpacing(30),
          CashFlowChart(
            cashflow: widget.cashFlow,
          )
        ],
      ),
    );
  }
}
