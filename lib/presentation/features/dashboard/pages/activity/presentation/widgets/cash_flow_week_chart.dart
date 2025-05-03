// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:laxmii_app/core/theme/app_colors.dart';
// import 'package:laxmii_app/presentation/features/dashboard/pages/activity/data/model/cashflow_response.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class CashFlowWeekChart extends StatelessWidget {
//   const CashFlowWeekChart({super.key, required this.cashWeekFlow});

//   final List<WeeklyCashflowData> cashWeekFlow;

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context);
//     if (cashWeekFlow.isEmpty) {
//       return const Center(child: Text("No data available"));
//     }

//     const weekAbbreviations = {
//       'Monday': 'Mon',
//       'Tuesday': 'Tue',
//       'Wednesday': 'Wed',
//       'Thursday': 'Thur',
//       'Friday': 'Fri',
//       'Saturday': 'Sat',
//       'Sunday': 'Sun',
//     };

//     final List<_ChartData> chartData = [];
//     if (cashWeekFlow.isNotEmpty && cashWeekFlow.first.weekData != null) {
//       cashWeekFlow.first.weekData!.forEach((week, data) {
//         final shortMonth = weekAbbreviations[week] ?? week;

//         chartData.add(
//           _ChartData(
//             shortMonth,
//             (data.invoice ?? 0).toDouble(),
//             (data.expense ?? 0).toDouble(),
//           ),
//         );
//       });
//     }

//     return SizedBox(
//       height: MediaQuery.of(context).size.height * 0.2,
//       child: SfCartesianChart(
//         primaryXAxis: const CategoryAxis(
//           majorGridLines: MajorGridLines(width: 0),
//           majorTickLines: MajorTickLines(width: 0),
//           interval: 1,
//         ),
//         plotAreaBorderWidth: 0,
//         primaryYAxis: NumericAxis(
//           numberFormat: NumberFormat.compact(),
//           majorGridLines: MajorGridLines(
//               width: 1,
//               dashArray: const [4.4],
//               color: colorScheme.colorScheme.onSurface.withAlpha(20)),
//           majorTickLines: const MajorTickLines(width: 0),
//         ),
//         legend: const Legend(isVisible: false),
//         tooltipBehavior: TooltipBehavior(enable: true),
//         series: <CartesianSeries<_ChartData, String>>[
//           ColumnSeries<_ChartData, String>(
//             name: "Invoice",
//             dataSource: chartData,
//             xValueMapper: (data, _) => data.month,
//             yValueMapper: (data, _) => data.invoice,
//             color: AppColors.primary075427,
//             animationDuration: 1500,
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(2),
//               topRight: Radius.circular(2),
//             ),
//           ),
//           ColumnSeries<_ChartData, String>(
//             name: "Expense",
//             dataSource: chartData,
//             xValueMapper: (data, _) => data.month,
//             yValueMapper: (data, _) => data.expense,
//             color: AppColors.primary861919,
//             animationDuration: 1500,
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(2),
//               topRight: Radius.circular(2),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _ChartData {
//   _ChartData(this.month, this.invoice, this.expense);

//   final String month;
//   final double invoice;
//   final double expense;
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/data/model/cashflow_response.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// Your data classes
class _ChartData {
  final String day;
  final double invoice;
  final double expense;

  _ChartData(this.day, this.invoice, this.expense);
}

class CashFlowWeekChart extends StatefulWidget {
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
  State<CashFlowWeekChart> createState() => _CashFlowWeekChartState();
}

class _CashFlowWeekChartState extends State<CashFlowWeekChart> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<_ChartData> _generateChartData(Week? week) {
    final List<_ChartData> chartData = [];

    if (week == null) return chartData;

    week.days.forEach((day, data) {
      final shortDay = CashFlowWeekChart.weekAbbreviations[day] ?? day;
      chartData.add(
        _ChartData(
          shortDay,
          (data?.invoice ?? 0).toDouble(),
          (data?.expense ?? 0).toDouble(),
        ),
      );
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

    if (allWeeks.isEmpty) {
      return const Center(child: Text("No data available"));
    }

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
                  _currentPage = index;
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
                      name: "Invoice",
                      dataSource: chartData,
                      xValueMapper: (data, _) => data.day,
                      yValueMapper: (data, _) => data.invoice,
                      color: AppColors.primary075427,
                      animationDuration: 1500,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                      ),
                    ),
                    ColumnSeries<_ChartData, String>(
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
          const SizedBox(height: 8),
          Text(
            "Current Week: Week ${_currentPage + 1}",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
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
  List<Week?> get allWeeks => [week1, week2, week3, week4, week5];
}
