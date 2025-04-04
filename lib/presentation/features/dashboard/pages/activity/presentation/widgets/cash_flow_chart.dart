// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
// import 'package:laxmii_app/core/theme/app_colors.dart';
// import 'package:laxmii_app/presentation/features/dashboard/pages/activity/data/model/get_cashflow_response.dart';

// class CashFlowChart extends StatefulWidget {
//   const CashFlowChart({super.key, required this.cashflow});

//   final Color invoiceBarColor = AppColors.primary075427; // Green for invoice
//   final Color expenseBarColor = AppColors.primary861919; // Red for expense
//   final List<CashFlowData> cashflow;

//   @override
//   State<StatefulWidget> createState() => CashFlowChartState();
// }

// class CashFlowChartState extends State<CashFlowChart> {
//   final double width = 7;

//   late List<BarChartGroupData> rawBarGroups;
//   late List<BarChartGroupData> showingBarGroups;
//   double maxY = 0; // Dynamic maxY based on data

//   @override
//   void initState() {
//     super.initState();
//     rawBarGroups = [];
//     showingBarGroups = [];
//     _processData();
//   }

//   void _processData() {
//     if (widget.cashflow.isEmpty) {
//       debugPrint("Cashflow data is empty!");
//       return;
//     }

//     final cashflowData = widget.cashflow.first;
//     final months = [
//       cashflowData.january,
//       cashflowData.february,
//       cashflowData.march,
//       cashflowData.april,
//       cashflowData.may,
//       cashflowData.june,
//       cashflowData.july,
//       cashflowData.august,
//       cashflowData.september,
//       cashflowData.october,
//       cashflowData.november,
//       cashflowData.december,
//     ];

//     // Find the maximum value in the data
//     for (var monthData in months) {
//       if (monthData is April) {
//         if ((monthData.invoice ?? 0) > maxY) {
//           maxY = monthData.invoice!.toDouble();
//         }
//         if ((monthData.expense ?? 0) > maxY) maxY = monthData.expense!;
//       } else if (monthData is February) {
//         if ((monthData.invoice ?? 0) > maxY) {
//           maxY = monthData.invoice!.toDouble();
//         }
//         if ((monthData.expense ?? 0) > maxY) {
//           maxY = monthData.expense!.toDouble();
//         }
//       }
//     }

//     // Add some padding to the maxY value
//     maxY = maxY * 1.1; // Add 10% padding

//     final newBarGroups = List.generate(months.length, (index) {
//       final monthData = months[index];
//       double invoice = 0;
//       double expense = 0;

//       // Check the type of monthData and cast it accordingly
//       if (monthData is April) {
//         invoice = monthData.invoice?.toDouble() ?? 0;
//         expense = monthData.expense ?? 0;
//       } else if (monthData is February) {
//         invoice = monthData.invoice?.toDouble() ?? 0;
//         expense = monthData.expense?.toDouble() ?? 0;
//       }

//       debugPrint("Month $index - Invoice: $invoice, Expense: $expense");

//       return makeGroupData(index, invoice, expense); // Two bars per month
//     });

//     setState(() {
//       rawBarGroups = newBarGroups;
//       showingBarGroups = newBarGroups;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double interval = maxY > 0 ? maxY / 6 : 1;
//     return SizedBox(
//       height: MediaQuery.of(context).size.height * 0.25,
//       child: BarChart(
//         BarChartData(
//           maxY: maxY, // Use dynamic maxY
//           barTouchData: BarTouchData(
//             touchTooltipData: BarTouchTooltipData(
//               getTooltipColor: (group) => Colors.grey,
//             ),
//           ),
//           titlesData: FlTitlesData(
//             show: true,
//             rightTitles: const AxisTitles(
//               sideTitles: SideTitles(showTitles: false),
//             ),
//             topTitles: const AxisTitles(
//               sideTitles: SideTitles(showTitles: false),
//             ),
//             bottomTitles: AxisTitles(
//               sideTitles: SideTitles(
//                 showTitles: true,
//                 getTitlesWidget: bottomTitles,
//                 reservedSize: 20, // Reduced reserved size for bottom titles
//               ),
//             ),
//             leftTitles: AxisTitles(
//               sideTitles: SideTitles(
//                 showTitles: true,
//                 reservedSize: 38.w, // Reduced reserved size for left titles
//                 interval: interval,
//                 getTitlesWidget: leftTitles,
//               ),
//             ),
//           ),
//           borderData: FlBorderData(show: false),
//           barGroups: showingBarGroups,
//           gridData: const FlGridData(show: false),
//         ),
//       ),
//     );
//   }

//   Widget leftTitles(double value, TitleMeta meta) {
//     // Only show labels for specific intervals to avoid duplicates
//     if (value == 0) {
//       return SideTitleWidget(
//         meta: meta,
//         space: 0,
//         child: Text(
//           '\$0K',
//           style: context.textTheme.s12w400.copyWith(
//             color: AppColors.primaryC4C4C4,
//           ),
//         ),
//       );
//     } else if (value == maxY) {
//       return SideTitleWidget(
//         meta: meta,
//         space: 0,
//         child: Text(
//           '\$${(maxY / 1000).toStringAsFixed(0)}K',
//           style: context.textTheme.s12w400.copyWith(
//             color: AppColors.primaryC4C4C4,
//           ),
//         ),
//       );
//     } else {
//       return Container(); // Hide other labels
//     }
//   }

//   Widget bottomTitles(double value, TitleMeta meta) {
//     final months = [
//       'Jan',
//       'Feb',
//       'Mar',
//       'Apr',
//       'May',
//       'Jun',
//       'Jul',
//       'Aug',
//       'Sep',
//       'Oct',
//       'Nov',
//       'Dec',
//     ];

//     final Widget text = Text(
//       months[value.toInt()],
//       style: context.textTheme.s12w400.copyWith(
//         fontSize: 10, // Reduced font size for X-axis labels
//         color: AppColors.primaryC4C4C4,
//       ),
//     );

//     return SideTitleWidget(
//       meta: meta,
//       space: 4,
//       child: text,
//     );
//   }

//   BarChartGroupData makeGroupData(int x, double invoice, double expense) {
//     return BarChartGroupData(
//       barsSpace: 4, // Space between the two bars
//       x: x,
//       barRods: [
//         BarChartRodData(
//           toY: invoice,
//           color: widget.invoiceBarColor, // Green for invoice
//           width: width,
//         ),
//         BarChartRodData(
//           toY: expense,
//           color: widget.expenseBarColor, // Red for expense
//           width: width,
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/data/model/get_cashflow_response.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CashFlowChart extends StatelessWidget {
  const CashFlowChart({super.key, required this.cashflow});

  final List<CashFlowData> cashflow;

  @override
  Widget build(BuildContext context) {
    if (cashflow.isEmpty) {
      return const Center(child: Text("No data available"));
    }

    final cashflowData = cashflow.first;
    final List<_ChartData> chartData = [
      _ChartData("Jan", (cashflowData.january?.invoice ?? 0).toDouble(),
          (cashflowData.january?.expense ?? 0).toDouble()),
      _ChartData("Feb", (cashflowData.february?.invoice ?? 0).toDouble(),
          (cashflowData.february?.expense ?? 0).toDouble()),
      _ChartData("Mar", (cashflowData.march?.invoice ?? 0).toDouble(),
          (cashflowData.march?.expense ?? 0).toDouble()),
      _ChartData("Apr", (cashflowData.april?.invoice ?? 0).toDouble(),
          (cashflowData.april?.expense ?? 0).toDouble()),
      _ChartData("May", (cashflowData.may?.invoice ?? 0).toDouble(),
          (cashflowData.may?.expense ?? 0).toDouble()),
      _ChartData("Jun", (cashflowData.june?.invoice ?? 0).toDouble(),
          (cashflowData.june?.expense ?? 0).toDouble()),
      _ChartData("Jul", (cashflowData.july?.invoice ?? 0).toDouble(),
          (cashflowData.july?.expense ?? 0).toDouble()),
      _ChartData("Aug", (cashflowData.august?.invoice ?? 0).toDouble(),
          (cashflowData.august?.expense ?? 0).toDouble()),
      _ChartData("Sep", (cashflowData.september?.invoice ?? 0).toDouble(),
          (cashflowData.september?.expense ?? 0).toDouble()),
      _ChartData("Oct", (cashflowData.october?.invoice ?? 0).toDouble(),
          (cashflowData.october?.expense ?? 0).toDouble()),
      _ChartData("Nov", (cashflowData.november?.invoice ?? 0).toDouble(),
          (cashflowData.november?.expense ?? 0).toDouble()),
      _ChartData("Dec", (cashflowData.december?.invoice ?? 0).toDouble(),
          (cashflowData.december?.expense ?? 0).toDouble()),
    ];

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        primaryYAxis: const NumericAxis(),
        legend: const Legend(isVisible: false),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries<_ChartData, String>>[
          ColumnSeries<_ChartData, String>(
            name: "Invoice",
            dataSource: chartData,
            xValueMapper: (data, _) => data.month,
            yValueMapper: (data, _) => data.invoice,
            color: AppColors.primary075427,
            animationDuration: 1500,
          ),
          ColumnSeries<_ChartData, String>(
            name: "Expense",
            dataSource: chartData,
            xValueMapper: (data, _) => data.month,
            yValueMapper: (data, _) => data.expense,
            color: AppColors.primary861919,
            animationDuration: 1500,
          ),
        ],
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.month, this.invoice, this.expense);

  final String month;
  final double invoice;
  final double expense;
}
