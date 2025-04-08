import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/data/model/get_cashflow_response.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CashFlowWeekChart extends StatelessWidget {
  const CashFlowWeekChart({super.key, required this.cashWeekFlow});

  final List<CashFlowWeekData> cashWeekFlow;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context);
    if (cashWeekFlow.isEmpty) {
      return const Center(child: Text("No data available"));
    }

    const weekAbbreviations = {
      'Monday': 'Mon',
      'Tuesday': 'Tue',
      'Wednesday': 'Wed',
      'Thursday': 'Thur',
      'Friday': 'Fri',
      'Saturday': 'Sat',
      'Sunday': 'Sun',
    };

    final List<_ChartData> chartData = [];
    if (cashWeekFlow.isNotEmpty && cashWeekFlow.first.weekData != null) {
      cashWeekFlow.first.weekData!.forEach((week, data) {
        final shortMonth = weekAbbreviations[week] ?? week;

        chartData.add(
          _ChartData(
            shortMonth,
            (data.invoice ?? 0).toDouble(),
            (data.expense ?? 0).toDouble(),
          ),
        );
      });
    }

    // final List<_ChartData> chartData = [
    //   _ChartData("Mon", (cashflowData.monday?.invoice ?? 0).toDouble(),
    //       (cashflowData.monday?.expense ?? 0).toDouble()),
    //   _ChartData("Tue", (cashflowData.tuesday?.invoice ?? 0).toDouble(),
    //       (cashflowData.tuesday?.expense ?? 0).toDouble()),
    //   _ChartData("Wed", (cashflowData.wednesday?.invoice ?? 0).toDouble(),
    //       (cashflowData.wednesday?.expense ?? 0).toDouble()),
    //   _ChartData("Thu", (cashflowData.thursday?.invoice ?? 0).toDouble(),
    //       (cashflowData.thursday?.expense ?? 0).toDouble()),
    //   _ChartData("Fri", (cashflowData.friday?.invoice ?? 0).toDouble(),
    //       (cashflowData.friday?.expense ?? 0).toDouble()),
    //   _ChartData("Sat", (cashflowData.saturday?.invoice ?? 0).toDouble(),
    //       (cashflowData.saturday?.expense ?? 0).toDouble()),
    //   _ChartData("Sun", (cashflowData.sunday?.invoice ?? 0).toDouble(),
    //       (cashflowData.sunday?.expense ?? 0).toDouble()),
    // ];

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: SfCartesianChart(
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
              dashArray: const [4.4],
              color: colorScheme.colorScheme.onSurface.withAlpha(20)),
          majorTickLines: const MajorTickLines(width: 0),
        ),
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
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(2),
              topRight: Radius.circular(2),
            ),
          ),
          ColumnSeries<_ChartData, String>(
            name: "Expense",
            dataSource: chartData,
            xValueMapper: (data, _) => data.month,
            yValueMapper: (data, _) => data.expense,
            color: AppColors.primary861919,
            animationDuration: 1500,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(2),
              topRight: Radius.circular(2),
            ),
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
