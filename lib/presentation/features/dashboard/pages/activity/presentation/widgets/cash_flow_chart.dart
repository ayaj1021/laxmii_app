import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/data/model/get_cashflow_response.dart';

class CashFlowChart extends StatefulWidget {
  const CashFlowChart({super.key, required this.cashflow});

  final Color invoiceBarColor = AppColors.primary075427; // Green for invoice
  final Color expenseBarColor = AppColors.primary861919; // Red for expense
  final List<CashFlowData> cashflow;

  @override
  State<StatefulWidget> createState() => CashFlowChartState();
}

class CashFlowChartState extends State<CashFlowChart> {
  final double width = 7;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;
  double maxY = 0; // Dynamic maxY based on data

  @override
  void initState() {
    super.initState();
    rawBarGroups = [];
    showingBarGroups = [];
    _processData();
  }

  void _processData() {
    if (widget.cashflow.isEmpty) {
      debugPrint("Cashflow data is empty!");
      return;
    }

    final cashflowData = widget.cashflow.first;
    final months = [
      cashflowData.january,
      cashflowData.february,
      cashflowData.march,
      cashflowData.april,
      cashflowData.may,
      cashflowData.june,
      cashflowData.july,
      cashflowData.august,
      cashflowData.september,
      cashflowData.october,
      cashflowData.november,
      cashflowData.december,
    ];

    // Find the maximum value in the data
    for (var monthData in months) {
      if (monthData is April) {
        if ((monthData.invoice ?? 0) > maxY) {
          maxY = monthData.invoice!.toDouble();
        }
        if ((monthData.expense ?? 0) > maxY) maxY = monthData.expense!;
      } else if (monthData is February) {
        if ((monthData.invoice ?? 0) > maxY) {
          maxY = monthData.invoice!.toDouble();
        }
        if ((monthData.expense ?? 0) > maxY) {
          maxY = monthData.expense!.toDouble();
        }
      }
    }

    // Add some padding to the maxY value
    maxY = maxY * 1; // Add 10% padding

    final newBarGroups = List.generate(months.length, (index) {
      final monthData = months[index];
      double invoice = 1;
      double expense = 1;

      // Check the type of monthData and cast it accordingly
      if (monthData is April) {
        invoice = monthData.invoice?.toDouble() ?? 0;
        expense = monthData.expense ?? 0;
      } else if (monthData is February) {
        invoice = monthData.invoice?.toDouble() ?? 0;
        expense = monthData.expense?.toDouble() ?? 0;
      }

      debugPrint("Month $index - Invoice: $invoice, Expense: $expense");

      return makeGroupData(index, invoice, expense); // Two bars per month
    });

    setState(() {
      rawBarGroups = newBarGroups;
      showingBarGroups = newBarGroups;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double interval = maxY > 0 ? maxY / 6 : 1;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      child: BarChart(
        BarChartData(
          maxY: maxY, // Use dynamic maxY
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (group) => Colors.grey,
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: bottomTitles,
                reservedSize: 20, // Reduced reserved size for bottom titles
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 38.w, // Reduced reserved size for left titles
                interval: interval,

                //maxY / 6, // Dynamic interval based on maxY
                getTitlesWidget: leftTitles,
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          barGroups: showingBarGroups,
          gridData: const FlGridData(show: false),
        ),
      ),
    );
  }

  // Widget leftTitles(double value, TitleMeta meta) {
  //   String text;
  //   if (value == 0) {
  //     text = '\$0K';
  //   } else if (value == maxY / 6) {
  //     text = '\$${(maxY / 6).toStringAsFixed(0)}K';
  //   } else if (value == maxY / 3) {
  //     text = '\$${(maxY / 3).toStringAsFixed(0)}K';
  //   } else if (value == maxY / 2) {
  //     text = '\$${(maxY / 2).toStringAsFixed(0)}K';
  //   } else if (value == (maxY * 2 / 3)) {
  //     text = '\$${(maxY * 2 / 3).toStringAsFixed(0)}K';
  //   } else if (value == (maxY * 5 / 6)) {
  //     text = '\$${(maxY * 5 / 6).toStringAsFixed(0)}K';
  //   } else if (value == maxY) {
  //     text = '\$${maxY.toStringAsFixed(0)}K';
  //   } else {
  //     return Container();
  //   }
  //   return SideTitleWidget(
  //     meta: meta,
  //     space: 0,
  //     child: Text(
  //       text,
  //       style: context.textTheme.s10w400.copyWith(
  //         fontSize: 10, // Reduced font size for Y-axis labels
  //         color: AppColors.primary5E5E5E,
  //       ),
  //     ),
  //   );
  // }

  Widget leftTitles(double value, TitleMeta meta) {
    String text;
    if (value == 0) {
      text = '\$0K';
    } else if (value == maxY / 6) {
      text = '\$${(maxY / 6000).toStringAsFixed(0)}K';
    } else if (value == maxY / 3) {
      text = '\$${(maxY / 3000).toStringAsFixed(0)}K';
    } else if (value == maxY / 2) {
      text = '\$${(maxY / 2000).toStringAsFixed(0)}K';
    } else if (value == (maxY * 2 / 3)) {
      text = '\$${(maxY * 2 / 3000).toStringAsFixed(0)}K';
    } else if (value == (maxY * 5 / 6)) {
      text = '\$${(maxY * 5 / 6000).toStringAsFixed(0)}K';
    } else if (value == maxY) {
      text = '\$${(maxY / 1000).toStringAsFixed(0)}K';
    } else {
      return Container();
    }
    return SideTitleWidget(
      meta: meta,
      space: 0,
      child: Text(
        text,
        style: context.textTheme.s12w400.copyWith(
          // Reduced font size for Y-axis labels
          color: AppColors.primaryC4C4C4,
        ),
      ),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    final Widget text = Text(
      months[value.toInt()],
      style: context.textTheme.s12w400.copyWith(
        fontSize: 10, // Reduced font size for X-axis labels
        color: AppColors.primaryC4C4C4,
      ),
    );

    return SideTitleWidget(
      meta: meta,
      space: 4,
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double invoice, double expense) {
    return BarChartGroupData(
      barsSpace: 4, // Space between the two bars
      x: x,
      barRods: [
        BarChartRodData(
          toY: invoice,
          color: widget.invoiceBarColor, // Green for invoice
          width: width,
        ),
        BarChartRodData(
          toY: expense,
          color: widget.expenseBarColor, // Red for expense
          width: width,
        ),
      ],
    );
  }
}
