import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/data/model/get_graph_details_request.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/data/model/week_cashflow_response.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/presentation/notifier/get_cashflow_details_notifier.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// Your data classes
class _ChartData {
  final String day;
  final double invoice;
  final double expense;

  _ChartData(this.day, this.invoice, this.expense);
}

class CashFlowWeekChart extends ConsumerStatefulWidget {
  const CashFlowWeekChart({super.key, required this.cashWeekFlow});

  final List<WeeklyCashflowData> cashWeekFlow;

  static const Map<String, String> weekAbbreviations = {
    'Monday': 'Mon',
    'Tuesday': 'Tue',
    'Wednesday': 'Wed',
    'Thursday': 'Thu',
    'Friday': 'Fri',
    'Saturday': 'Sat',
    'Sunday': 'Sun',
  };

  @override
  ConsumerState<CashFlowWeekChart> createState() => _CashFlowWeekChartState();
}

class _CashFlowWeekChartState extends ConsumerState<CashFlowWeekChart> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  List<_ChartData> _generateChartData(Week? week) {
    final List<_ChartData> chartData = [];

    if (week == null) return chartData;

    week.days.forEach((day, data) {
      final shortDay = CashFlowWeekChart.weekAbbreviations[day] ?? day;

      final income = ((data?.invoice ?? 0) + (data?.shopify ?? 0)).toDouble();
      final expense = (data?.expense ?? 0).toDouble();

      chartData.add(_ChartData(shortDay, income, expense));
    });

    return chartData;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final allWeeks = widget.cashWeekFlow
        .expand((weekData) => weekData.allWeeks)
        .where((w) => w != null)
        .toList();

    // if (allWeeks.isEmpty) {
    //   return const Center(child: Text("No data available"));
    // }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: allWeeks.length,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                final week = allWeeks[index];
                final chartData = _generateChartData(week);

                return SfCartesianChart(
                  primaryXAxis: const CategoryAxis(
                    majorGridLines: MajorGridLines(width: 0),
                    majorTickLines: MajorTickLines(width: 0),
                    interval: 1,
                  ),
                  plotAreaBorderWidth: 0,
                  primaryYAxis: NumericAxis(
                    isVisible: false,
                    numberFormat: NumberFormat.compact(),
                    majorGridLines: MajorGridLines(
                      width: 1,
                      dashArray: const [4, 4],
                      color: colorScheme.onSurface.withAlpha(20),
                    ),
                    majorTickLines: const MajorTickLines(width: 0),
                  ),
                  legend: const Legend(isVisible: false),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <CartesianSeries<_ChartData, String>>[
                    ColumnSeries<_ChartData, String>(
                      onPointTap: (pointInteractionDetails) {
                        final now = DateTime.now();
                        final request = GetGraphDetailsRequest(
                            type: 'income', queryBy: 'week', date: now);
                        ref
                            .read(getCashFlowDetailsNotifierProvider.notifier)
                            .getCashFlowDetails(request: request);
                      },
                      name: "Income",
                      dataSource: chartData,
                      xValueMapper: (data, _) => data.day,
                      yValueMapper: (data, _) => data.invoice,
                      color: AppColors.primary075427,
                      animationDuration: 1500,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                      ),
                      //  width: 17,
                    ),
                    ColumnSeries<_ChartData, String>(
                      onPointTap: (pointInteractionDetails) {
                        final now = DateTime.now();
                        final request = GetGraphDetailsRequest(
                            type: 'expense', queryBy: 'week', date: now);
                        ref
                            .read(getCashFlowDetailsNotifierProvider.notifier)
                            .getCashFlowDetails(request: request);
                      },
                      name: "Expense",
                      dataSource: chartData,
                      xValueMapper: (data, _) => data.day,
                      yValueMapper: (data, _) => data.expense,
                      color: AppColors.primary861919,
                      animationDuration: 1500,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          // const SizedBox(height: 8),
          // Text(
          //   "Current Week: Week ${_currentPage + 1}",
          //   style: Theme.of(context).textTheme.bodyLarge,
          // ),
        ],
      ),
    );
  }
}

extension WeekExtension on Week {
  Map<String, Day?> get days => {
        "Monday": monday,
        "Tuesday": tuesday,
        "Wednesday": wednesday,
        "Thursday": thursday,
        "Friday": friday,
        "Saturday": saturday,
        "Sunday": sunday,
      };
}

extension WeeklyCashflowDataExtension on WeeklyCashflowData {
  List<Week?> get allWeeks => [week1, week2, week4, week5];
}
