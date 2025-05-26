import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/data/model/get_graph_details_request.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/data/model/week_cashflow_response.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/presentation/notifier/get_cashflow_details_notifier.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// Your data classes
class _ChartData {
  final String day;
  final double invoice;
  final double expense;
  final String date;

  _ChartData(this.day, this.invoice, this.expense, this.date);
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
  // final PageController _pageController = PageController();
  // int currentPage = 0;

  late PageController _pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    getUserCurrency();

    // Initialize with an index that will be set properly after build
    _pageController = PageController();

    // Set proper page after first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setInitialPage();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  String userCurrency = '\$';

  void getUserCurrency() async {
    final currency = await AppDataStorage().getUserCurrency();

    setState(() {
      userCurrency = currency ?? '\$';
    });
  }

  void _setInitialPage() {
    if (widget.cashWeekFlow.isEmpty) return;

    // Get current week from the data
    final currentWeekName = widget.cashWeekFlow.first.currentWeek;
    if (currentWeekName == null) return;

    // Find the index of the current week
    int weekIndex = _getWeekIndex(currentWeekName);

    // Only jump to the page if it's a valid index
    if (weekIndex >= 0 && mounted) {
      _pageController.jumpToPage(weekIndex);
      setState(() {
        currentPage = weekIndex;
      });
    }
  }

  // Determine the index of the given week name in our allWeeks list
  int _getWeekIndex(String weekName) {
    // Extract week number from string like "Week 3"
    final weekNumberMatch = RegExp(r'Week (\d+)').firstMatch(weekName);
    if (weekNumberMatch == null) return 0;

    final weekNumber = int.tryParse(weekNumberMatch.group(1) ?? "1") ?? 1;

    // Since we're using a 0-based index
    return weekNumber - 1;
  }

  List<_ChartData> _generateChartData(dynamic week) {
    final List<_ChartData> chartData = [];

    if (week == null) return chartData;

    // Handle different week types
    if (week is Week) {
      // Process standard Week type
      week.days.forEach((day, data) {
        final shortDay = CashFlowWeekChart.weekAbbreviations[day] ?? day;
        final income = ((data?.invoice ?? 0) + (data?.shopify ?? 0)).toDouble();
        final expense = (data?.expense ?? 0).toDouble();
        final date = (data?.date ?? '');
        chartData.add(_ChartData(shortDay, income, expense, date));
      });
    } else if (week is Week3) {
      // Process Week3 type specifically
      final days = {
        "Monday": week.monday,
        "Tuesday": week.tuesday,
        "Wednesday": week.wednesday,
        "Thursday": week.thursday,
        "Friday": week.friday,
        "Saturday": week.saturday,
        "Sunday": week.sunday,
      };

      days.forEach((day, data) {
        final shortDay = CashFlowWeekChart.weekAbbreviations[day] ?? day;
        double income = 0;
        double expense = 0;
        String date = "";

        // Handle Monday specifically (different type)
        if (day == "Monday" && data is Monday) {
          income = ((data.invoice ?? 0) + (data.shopify ?? 0)).toDouble();
          expense = (data.expense ?? 0).toDouble();
          date = data.date ?? "";
        } else if (data is Day) {
          // Handle other days (Day type)
          income = ((data.invoice ?? 0) + (data.shopify ?? 0)).toDouble();
          expense = (data.expense ?? 0).toDouble();
          date = data.date ?? "";
        }

        chartData.add(_ChartData(
          shortDay,
          income,
          expense,
          date,
        ));
      });
    }

    return chartData;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // Include week3 in the list of weeks
    List<dynamic> allWeeks = [];

    for (var weekData in widget.cashWeekFlow) {
      if (weekData.week1 != null) allWeeks.add(weekData.week1);
      if (weekData.week2 != null) allWeeks.add(weekData.week2);
      if (weekData.week3 != null) allWeeks.add(weekData.week3); // Include week3
      if (weekData.week4 != null) allWeeks.add(weekData.week4);
      if (weekData.week5 != null) allWeeks.add(weekData.week5);
    }

    allWeeks = allWeeks.where((w) => w != null).toList();

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
                    // Make Y-axis visible to ensure values are displayed
                    isVisible: false,
                    numberFormat: NumberFormat.compact(),
                    majorGridLines: MajorGridLines(
                      width: 1,
                      dashArray: const [4, 4],
                      color: colorScheme.onSurface.withAlpha(20),
                    ),
                    majorTickLines: const MajorTickLines(width: 0),
                  ),
                  legend: const Legend(isVisible: false), // Make legend visible
                  // tooltipBehavior: TooltipBehavior(
                  //   enable: true,
                  // ),
                  tooltipBehavior: TooltipBehavior(
                    enable: true,
                    format: 'point.x: \$point.y',
                    // Enhanced tooltip to show formatted currency
                    builder: (dynamic data, dynamic point, dynamic series,
                        int pointIndex, int seriesIndex) {
                      final chartData = data as _ChartData;
                      final seriesName =
                          seriesIndex == 0 ? 'Income' : 'Expense';
                      final value = seriesIndex == 0
                          ? chartData.invoice
                          : chartData.expense;
                      final formattedValue =
                          NumberFormat.currency(symbol: userCurrency)
                              .format(value);

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
                  series: <CartesianSeries<_ChartData, String>>[
                    ColumnSeries<_ChartData, String>(
                      onPointTap: (pointInteractionDetails) {
                        final int index =
                            pointInteractionDetails.pointIndex ?? 0;

                        // Get the corresponding _ChartData object
                        final tappedData = chartData[index];

                        final String selectedDate = tappedData.date;
                        final date =
                            DateFormat('yyyy-MM-dd').parse(selectedDate);
                        //  final now = DateTime.now();
                        final request = GetGraphDetailsRequest(
                            type: 'income', queryBy: 'week', date: date);
                        // Use the ref to call the notifier
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
                      width: 0.9,
                      spacing: 0.2,
                    ),
                    ColumnSeries<_ChartData, String>(
                      // onPointTap: (pointInteractionDetails) {
                      //   final int index =
                      //       pointInteractionDetails.pointIndex ?? 0;

                      //   // Get the corresponding _ChartData object
                      //   final tappedData = chartData[index];

                      //   final String selectedDate = tappedData.date;
                      //   final date = DateFormat().tryParse(selectedDate);

                      //   if (date != null) {
                      //     final request = GetGraphDetailsRequest(
                      //       type: 'expense',
                      //       queryBy: 'week',
                      //       date: date,
                      //     );
                      //     ref
                      //         .read(getCashFlowDetailsNotifierProvider.notifier)
                      //         .getCashFlowDetails(request: request);
                      //   } else {
                      //     debugPrint('Invalid date format: $selectedDate');
                      //   }
                      // },
                      onPointTap: (pointInteractionDetails) {
                        final int index =
                            pointInteractionDetails.pointIndex ?? 0;

                        final tappedData = chartData[index];
                        final String selectedDate = tappedData.date;

                        final date =
                            DateFormat('yyyy-MM-dd').tryParse(selectedDate);

                        if (date != null) {
                          final request = GetGraphDetailsRequest(
                            type: 'expense',
                            queryBy: 'week',
                            date: date,
                          );

                          ref
                              .read(getCashFlowDetailsNotifierProvider.notifier)
                              .getCashFlowDetails(request: request);
                        } else {
                          debugPrint('Invalid date format: $selectedDate');
                        }
                      },
                      name: "Expense",
                      dataSource: chartData,
                      xValueMapper: (data, _) => data.day,
                      yValueMapper: (data, _) => data.expense,
                      color: AppColors.primary861919,
                      width: 0.9,
                      spacing: 0.2,
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
          // Week indicator
          // Padding(
          //   padding: const EdgeInsets.only(top: 8.0),
          //   child: Text(
          //     "Week ${currentPage + 1}",
          //     style: Theme.of(context).textTheme.bodyMedium,
          //   ),
          // ),
        ],
      ),
    );
  }
}

// Keep the existing extension for Week
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

// Remove the problematic extension that excludes week3
// Instead, we now handle week3 directly in the _generateChartData method
