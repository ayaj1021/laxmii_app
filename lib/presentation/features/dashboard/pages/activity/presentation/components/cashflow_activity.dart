import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/string_extensions.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/presentation/notifier/get_cashflow_notifier.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/presentation/widgets/cash_flow_week_chart.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/presentation/widgets/cash_flow_year_chart.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/features/transactions/presentation/view/transactions_view.dart';
import 'package:laxmii_app/presentation/general_widgets/custom_app_dropdown.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class CashFlowActivity extends ConsumerStatefulWidget {
  const CashFlowActivity({
    super.key,
    // required this.cashFlow,
  });
//  final List<CashFlowData> cashFlow;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CashFlowActivityState();
}

class _CashFlowActivityState extends ConsumerState<CashFlowActivity> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref
          .read(getCashFlowNotifierProvider.notifier)
          .getCashFlow(query: 'week');

      await ref.read(getAccessTokenNotifier.notifier).accessToken();
    });
    super.initState();
  }

  String _selectedType = cashFlowOptions.first;

  @override
  Widget build(BuildContext context) {
    final cashFlowList = ref.watch(getCashFlowNotifierProvider
        .select((v) => v.getCashFlow.data?.cashflow ?? []));

    final cashFlowWeekList = ref.watch(getCashFlowNotifierProvider
        .select((v) => v.getCashFlow.data?.cashWeekflow ?? []));

    final isLoading = ref.watch(
        getCashFlowNotifierProvider.select((v) => v.loadState.isLoading));
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
      child: GestureDetector(
        onTap: () {
          context.pushNamed(TransactionsView.routeName);
        },
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      log('This is year cash flow ${cashFlowWeekList.length}');
                    },
                    child: Text(
                      'Cashflow',
                      style: context.textTheme.s14w400.copyWith(
                        color: colorScheme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.23,
                    child: CustomDropdown(
                      value: _selectedType,
                      items: cashFlowOptions
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.capitalize),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedType = value ?? '';
                        });

                        ref
                            .read(getCashFlowNotifierProvider.notifier)
                            .getCashFlow(query: value.toString());
                      },
                    ),
                  )
                ],
              ),
              const VerticalSpacing(30),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    )
                  : cashFlowList.isEmpty
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
                      : _selectedType == 'week'
                          ? CashFlowWeekChart(
                              cashWeekFlow: cashFlowWeekList,
                            )
                          : CashFlowYearChart(
                              cashflow: cashFlowList,
                            ),
            ],
          ),
        ),
      ),
    );
  }
}

final List<String> cashFlowOptions = ['week', 'year'];
