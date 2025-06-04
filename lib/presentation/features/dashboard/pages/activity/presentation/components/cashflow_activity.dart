// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
// import 'package:laxmii_app/core/theme/app_colors.dart';
// import 'package:laxmii_app/core/utils/enums.dart';
// import 'package:laxmii_app/presentation/features/dashboard/pages/activity/presentation/notifier/get_cashflow_notifier.dart';
// import 'package:laxmii_app/presentation/features/dashboard/pages/activity/presentation/widgets/cash_flow_week_chart.dart';
// import 'package:laxmii_app/presentation/features/dashboard/pages/activity/presentation/widgets/cash_flow_year_chart.dart';
// import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
// import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

// class CashFlowActivity extends ConsumerStatefulWidget {
//   const CashFlowActivity({
//     super.key,
//     // required this.cashFlow,
//   });
// //  final List<CashFlowData> cashFlow;

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _CashFlowActivityState();
// }

// class _CashFlowActivityState extends ConsumerState<CashFlowActivity> {
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       await ref
//           .read(getCashFlowNotifierProvider.notifier)
//           .getCashFlow(query: 'week');

//       await ref.read(getAccessTokenNotifier.notifier).accessToken();
//     });
//     super.initState();
//   }

//   int _selectedIndex = 0;

//   final String _selectedType = cashFlowOptions.first;

//   @override
//   Widget build(BuildContext context) {
//     final cashFlowYearList = ref.watch(getCashFlowNotifierProvider
//         .select((v) => v.getCashFlow.data?.cashflow ?? []));

//     final cashFlowWeekList = ref.watch(getCashFlowNotifierProvider
//         .select((v) => v.getCashFlow.data?.cashWeekflow ?? []));

//     final isLoading = ref.watch(
//         getCashFlowNotifierProvider.select((v) => v.loadState.isLoading));
//     final colorScheme = Theme.of(context);
//     return Animate(
//       effects: const [
//         FadeEffect(
//           duration: Duration(milliseconds: 500),
//           begin: 0.5,
//         ),
//         ScaleEffect(
//           begin: Offset(0, 5),
//           duration: Duration(
//             milliseconds: 500,
//           ),
//         )
//       ],
//       child: GestureDetector(
//         onTap: () {
//           //  context.pushNamed(TransactionsView.routeName);
//         },
//         child: Container(
//           height: MediaQuery.of(context).size.height * 0.35,
//           padding: const EdgeInsets.symmetric(vertical: 19, horizontal: 10),
//           width: double.infinity,
//           decoration: BoxDecoration(
//               color: colorScheme.cardColor,
//               borderRadius: BorderRadius.circular(16)),
//           child: Column(
//             children: [
//               SizedBox(
//                   width: MediaQuery.sizeOf(context).width * 0.23,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(vertical: 2),
//                     decoration: BoxDecoration(
//                         color: const Color(0xFF1B1A1F),
//                         borderRadius: BorderRadius.circular(8)),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: List.generate(cashFlowOptions.length, (index) {
//                         return GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               _selectedIndex = index;
//                             });
//                             ref
//                                 .read(getCashFlowNotifierProvider.notifier)
//                                 .getCashFlow(query: cashFlowOptions[index]);
//                           },
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                                 vertical: 4, horizontal: 10),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(6),
//                               color: _selectedIndex == index
//                                   ? const Color(0xFF525158)
//                                   : Colors.transparent,
//                             ),
//                             child: Center(
//                               child: Text(
//                                 cashFlow[index].toUpperCase(),
//                                 style: const TextStyle(color: Colors.white
//                                     //colorScheme.colorScheme.onSurface,
//                                     ),
//                               ),
//                             ),
//                           ),
//                         );
//                       }),
//                     ),
//                   )),
//               const VerticalSpacing(30),
//               TextButton(
//                   onPressed: () {
//                     // log('This is month data ${cashFlowList.map((e) => e).first.monthData.length}');
//                     log('This empty is month data ${cashFlowYearList.isNotEmpty}');

//                     cashFlowYearList.first.monthData.forEach((month, data) {
//                       log('Month key: "$month"');
//                     });
//                   },
//                   child: Text('data')),
//               isLoading
//                   ? const Center(
//                       child: CircularProgressIndicator(
//                         color: AppColors.primaryColor,
//                       ),
//                     )
//                   : cashFlowYearList.isEmpty
//                       ? Column(
//                           children: [
//                             Text(
//                               'No Activity yet',
//                               style: context.textTheme.s16w400.copyWith(
//                                 color: AppColors.primary5E5E5E,
//                               ),
//                             ),
//                             const VerticalSpacing(9),
//                             Text(
//                               'Create sales and expenses to see activities',
//                               style: context.textTheme.s14w400.copyWith(
//                                 color: AppColors.primary5E5E5E,
//                               ),
//                             ),
//                           ],
//                         )
//                       : _selectedType == 'week'
//                           ? CashFlowWeekChart(
//                               cashWeekFlow: cashFlowWeekList,
//                             )
//                           : CashFlowYearChart(
//                               cashflow: cashFlowYearList,
//                             ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// final List<String> cashFlowOptions = ['week', 'year'];
// final List<String> cashFlow = ['w', 'y'];

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/presentation/notifier/get_cashflow_notifier.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/presentation/widgets/cash_flow_week_chart.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/presentation/widgets/cash_flow_year_chart.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class CashFlowActivity extends ConsumerStatefulWidget {
  const CashFlowActivity({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CashFlowActivityState();
}

class _CashFlowActivityState extends ConsumerState<CashFlowActivity> {
  int _selectedIndex = 0;
  @override
  void initState() {
    getUserCurrency();
    _selectedIndex = 0;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // First load with week data
      await ref
          .read(getCashFlowNotifierProvider.notifier)
          .getCashFlow(query: 'week');

      await ref.read(getAccessTokenNotifier.notifier).accessToken();
    });
    super.initState();
  }

  // Default to 'week' (index 0)

  String userCurrency = '\$';

  void getUserCurrency() async {
    final currency = await AppDataStorage().getUserCurrency();

    setState(() {
      userCurrency = currency ?? '\$';
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get data from providers
    final cashFlowYearList = ref.watch(getCashFlowNotifierProvider
        .select((v) => v.getCashFlow.data?.cashflow ?? []));

    final cashFlowWeekList = ref.watch(getCashFlowNotifierProvider
        .select((v) => v.getCashFlow.data?.cashWeekflow ?? []));

    final isLoading = ref.watch(
        getCashFlowNotifierProvider.select((v) => v.loadState.isLoading));

    // Get current selected type
    final selectedType = cashFlowOptions[_selectedIndex];

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
        height: MediaQuery.of(context).size.height *
            0.4, // Increased height for better chart visibility
        padding: const EdgeInsets.symmetric(vertical: 19, horizontal: 10),
        width: double.infinity,
        decoration: BoxDecoration(
            color: colorScheme.cardColor,
            borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.23,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  decoration: BoxDecoration(
                      color: const Color(0xFF1B1A1F),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(cashFlowOptions.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndex = index;
                          });
                          ref
                              .read(getCashFlowNotifierProvider.notifier)
                              .getCashFlow(query: cashFlowOptions[index]);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: _selectedIndex == index
                                ? const Color(0xFF525158)
                                : Colors.transparent,
                          ),
                          child: Center(
                            child: Text(
                              cashFlow[index].toUpperCase(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                )),
            const VerticalSpacing(20), // Reduced spacing

            Expanded(
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    )
                  : selectedType == 'week'
                      ? cashFlowWeekList.isEmpty
                          ? _buildEmptyState(context)
                          : CashFlowWeekChart(
                              cashWeekFlow: cashFlowWeekList,
                            )
                      : cashFlowYearList.isEmpty
                          ? _buildEmptyState(context)
                          : CashFlowYearChart(
                              currency: userCurrency,
                              cashflow: cashFlowYearList,
                            ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }
}

final List<String> cashFlowOptions = ['week', 'year'];
final List<String> cashFlow = ['w', 'y'];
