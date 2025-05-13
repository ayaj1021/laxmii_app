// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:laxmii_app/core/theme/app_colors.dart';
// import 'package:laxmii_app/presentation/features/dashboard/pages/activity/data/model/month_cashflow_response.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class CashFlowYearChart extends StatefulWidget {
//   const CashFlowYearChart({super.key, required this.cashflow});

//   final List<GetMonthlyCashflow> cashflow;

//   @override
//   State<CashFlowYearChart> createState() => _CashFlowYearChartState();
// }

// class _CashFlowYearChartState extends State<CashFlowYearChart> {
//   @override
//   void initState() {
//     log('This is cashflow ${widget.cashflow}');
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context);
//     // if (cashflow.isEmpty) {
//     //   return const Center(child: Text("No data available"));
//     // }

//     const monthAbbreviations = {
//       'January': 'Jan',
//       'February': 'Feb',
//       'March': 'Mar',
//       'April': 'Apr',
//       'May': 'May',
//       'June': 'Jun',
//       'July': 'Jul',
//       'August': 'Aug',
//       'September': 'Sep',
//       'October': 'Oct',
//       'November': 'Nov',
//       'December': 'Dec',
//     };

//     final List<_ChartData> chartData = [];

//     if (widget.cashflow.isNotEmpty) {
//       widget.cashflow.first.monthData.forEach((month, data) {
//         final shortMonth = monthAbbreviations[month] ?? month;

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
//       child: Column(
//         children: [
//           TextButton(
//               onPressed: () {
//                 log('This is month data ${widget.cashflow.map((e) => e).first.monthData.length}');
//                 log('This empty is month data ${widget.cashflow.isNotEmpty}');
//               },
//               child: Text('data')),
//           SfCartesianChart(
//             primaryXAxis: const CategoryAxis(
//               majorGridLines: MajorGridLines(width: 0),
//               majorTickLines: MajorTickLines(width: 0),
//               interval: 1,
//             ),
//             plotAreaBorderWidth: 0,
//             primaryYAxis: NumericAxis(
//               numberFormat: NumberFormat.compact(),
//               majorGridLines: MajorGridLines(
//                   width: 1,
//                   dashArray: const [4.4],
//                   color: colorScheme.colorScheme.onSurface.withAlpha(20)),
//               majorTickLines: const MajorTickLines(width: 0),
//             ),
//             legend: const Legend(isVisible: false),
//             tooltipBehavior: TooltipBehavior(enable: true),
//             series: <CartesianSeries<_ChartData, String>>[
//               ColumnSeries<_ChartData, String>(
//                 name: "Invoice",
//                 dataSource: chartData,
//                 xValueMapper: (data, _) => data.month,
//                 yValueMapper: (data, _) => data.invoice,
//                 color: AppColors.primary075427,
//                 animationDuration: 1500,
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(2),
//                   topRight: Radius.circular(2),
//                 ),
//               ),
//               ColumnSeries<_ChartData, String>(
//                 name: "Expense",
//                 dataSource: chartData,
//                 xValueMapper: (data, _) => data.month,
//                 yValueMapper: (data, _) => data.expense,
//                 color: AppColors.primary861919,
//                 animationDuration: 1500,
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(2),
//                   topRight: Radius.circular(2),
//                 ),
//               ),
//             ],
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

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/data/model/get_graph_details_request.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/data/model/month_cashflow_response.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/presentation/notifier/get_cashflow_details_notifier.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CashFlowYearChart extends ConsumerWidget {
  const CashFlowYearChart({super.key, required this.cashflow});

  final List<GetMonthlyCashflow> cashflow;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (cashflow.isEmpty) {
      log('No cashflow data available');
      return const Center(child: Text("No data available"));
    }

    // Define month order for proper sorting
    final monthOrder = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    const monthAbbreviations = {
      'January': 'Jan',
      'February': 'Feb',
      'March': 'Mar',
      'April': 'Apr',
      'May': 'May',
      'June': 'Jun',
      'July': 'Jul',
      'August': 'Aug',
      'September': 'Sep',
      'October': 'Oct',
      'November': 'Nov',
      'December': 'Dec',
    };

    // Create chart data from cashflow - include all months even with zero values
    final List<_ChartData> chartData = [];
    final monthDataMap = cashflow.first.monthData;

    // Sort months chronologically
    final sortedMonths = monthDataMap.keys.toList()
      ..sort((a, b) => monthOrder.indexOf(a) - monthOrder.indexOf(b));

    // Process each month's data - include all months
    for (final month in sortedMonths) {
      final data = monthDataMap[month];
      if (data != null) {
        final shortMonth = monthAbbreviations[month] ?? month;

        // Include all months regardless of values
        chartData.add(
          _ChartData(
            shortMonth,
            (data.invoice ?? 0).toDouble(),
            (data.expense ?? 0).toDouble(),
          ),
        );
      }
    }

    // If no chart data, show a message
    if (chartData.isEmpty) {
      return const Center(child: Text("No activity data to display"));
    }

    // Calculate a visible viewport width based on the number of items

    return SizedBox(
      height: 200,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          // Set a minimum width to ensure scrollability
          width:
              max(MediaQuery.of(context).size.width, chartData.length * 70.0),
          child: SfCartesianChart(
            primaryXAxis: const CategoryAxis(
              majorGridLines: MajorGridLines(width: 0),
              majorTickLines: MajorTickLines(width: 0),
              interval: 1,
              labelStyle: TextStyle(fontSize: 10),
            ),
            plotAreaBorderWidth: 0,
            primaryYAxis: NumericAxis(
              numberFormat: NumberFormat.compact(),
              majorGridLines: MajorGridLines(
                width: 1,
                dashArray: const [4, 4],
                color: Theme.of(context).colorScheme.onSurface.withAlpha(20),
              ),
              majorTickLines: const MajorTickLines(width: 0),
              axisLine: const AxisLine(width: 0),
              labelStyle: const TextStyle(
                color: Colors.transparent, // Make Y-axis labels invisible
              ),
              // Make the axis line invisible
              axisLabelFormatter: (AxisLabelRenderDetails details) {
                return ChartAxisLabel(
                    '', const TextStyle(color: Colors.transparent));
              },
            ),
            margin: const EdgeInsets.all(10),
            legend: const Legend(
              isVisible: false,
              position: LegendPosition.bottom,
              overflowMode: LegendItemOverflowMode.wrap,
            ),
            tooltipBehavior: TooltipBehavior(
              enable: true,
              format: 'point.x: \$point.y',
              // Enhanced tooltip to show formatted currency
              builder: (dynamic data, dynamic point, dynamic series,
                  int pointIndex, int seriesIndex) {
                final chartData = data as _ChartData;
                final seriesName = seriesIndex == 0 ? 'Income' : 'Expense';
                final value =
                    seriesIndex == 0 ? chartData.invoice : chartData.expense;
                final formattedValue =
                    NumberFormat.currency(symbol: '\$').format(value);

                return Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '$seriesName: $formattedValue',
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
            zoomPanBehavior: ZoomPanBehavior(
              enablePanning: true,
              zoomMode: ZoomMode.x,
            ),
            series: <CartesianSeries<_ChartData, String>>[
              ColumnSeries<_ChartData, String>(
                onPointTap: (pointInteractionDetails) {
                  final now = DateTime.now();
                  final request = GetGraphDetailsRequest(
                      type: 'income', queryBy: 'year', date: now);
                  ref
                      .read(getCashFlowDetailsNotifierProvider.notifier)
                      .getCashFlowDetails(request: request);
                },
                name: "Income",
                dataSource: chartData,
                xValueMapper: (data, _) => data.month,
                yValueMapper: (data, _) => data.invoice,
                color: AppColors.primary075427,
                animationDuration: 1000,
                width: 0.9,
                spacing: 0.2,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
              ),
              ColumnSeries<_ChartData, String>(
                onPointTap: (pointInteractionDetails) {
                  final now = DateTime.now();
                  final request = GetGraphDetailsRequest(
                      type: 'expense', queryBy: 'year', date: now);
                  ref
                      .read(getCashFlowDetailsNotifierProvider.notifier)
                      .getCashFlowDetails(request: request);
                },
                name: "Expense",
                dataSource: chartData,
                xValueMapper: (data, _) => data.month,
                yValueMapper: (data, _) => data.expense,
                color: AppColors.primary861919,
                animationDuration: 1000,
                width: 0.9,
                spacing: 0.2,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function for math operations
  double max(double a, double b) {
    return a > b ? a : b;
  }
}

class _ChartData {
  _ChartData(this.month, this.invoice, this.expense);

  final String month;
  final double invoice;
  final double expense;
}
