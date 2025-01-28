import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/generate_report/data/model/get_single_report_request.dart';
import 'package:laxmii_app/presentation/features/generate_report/presentation/notifier/get_single_report_notifier.dart';
import 'package:laxmii_app/presentation/features/generate_report/presentation/widgets/bottom_section.dart';
import 'package:laxmii_app/presentation/features/generate_report/presentation/widgets/report_dropdown_widget.dart';
import 'package:laxmii_app/presentation/features/generate_report/presentation/widgets/table_section.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_app_bar.dart';
import 'package:laxmii_app/presentation/general_widgets/page_loader.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class SalesReportDetail extends ConsumerStatefulWidget {
  const SalesReportDetail({required this.reportType, super.key});
  final String reportType;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SalesReportDetailState();
}

class _SalesReportDetailState extends ConsumerState<SalesReportDetail> {
  DateTimeRange? _selectedStartDate;

  String selectedPeriod = reportOptions[0];
  @override
  void initState() {
    final data = GetSingleReportRequest(
        type: widget.reportType.toLowerCase(),
        period: selectedPeriod.toLowerCase(),
        startDate: _selectedStartDate?.start ?? DateTime.now(),
        endDate: _selectedStartDate?.end ?? DateTime.now());
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(getAccessTokenNotifier.notifier).accessToken();
      await ref.read(getSingleReportNotifier.notifier).getSingleReport(
            data: data,
            onError: (error) {
              context.showError(message: error);
            },
          );
      _refetchData();
    });
    super.initState();
  }

  void _refetchData() async {
    final data = GetSingleReportRequest(
        type: widget.reportType.toLowerCase(),
        period: selectedPeriod.toLowerCase(),
        startDate: _selectedStartDate?.start ?? DateTime.now(),
        endDate: _selectedStartDate?.end ?? DateTime.now());
    await ref.read(getSingleReportNotifier.notifier).getSingleReport(
          data: data,
          onError: (error) {
            context.showError(message: error);
          },
        );
  }

  Future<void> _selectStartDate() async {
    final now = DateTime.now();
    final DateTimeRange? picked = await showDateRangePicker(
      helpText: 'Select date range',
      context: context,
      initialDateRange: _selectedStartDate,
      firstDate: DateTime(2000),
      barrierColor: Colors.white,
      lastDate: DateTime(now.year, now.month, now.day),
      saveText: 'Done',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor: Colors.white,
            colorScheme: const ColorScheme.dark(
              primary: AppColors.primaryColor,

              surface: AppColors.white, // Background color
              onSurface: Colors.white, // Text color
              secondary: AppColors.primaryColor,
            ),
            dialogBackgroundColor: AppColors.white,
            scaffoldBackgroundColor: AppColors.primary101010,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedStartDate) {
      setState(() {
        _selectedStartDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final headers = ref.watch(getSingleReportNotifier
        .select((v) => v.getSingleReportResponse.headers ?? []));

    final reports = ref.watch(getSingleReportNotifier
        .select((v) => v.getSingleReportResponse.data ?? []));

    final isLoading = ref.watch(getSingleReportNotifier
        .select((v) => v.getSingleReportState.isLoading));
    const initialValue = 0.0;
    final totalAmount = reports.fold<double>(initialValue,
        (previousValue, element) => previousValue + element.amount!.toDouble());
    return PageLoader(
      isLoading: isLoading,
      child: Scaffold(
        appBar: const LaxmiiAppBar(
          centerTitle: true,
          title: 'Sales Report',
        ),
        body: SafeArea(
            child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23),
                  child: ReportDropDownWidget(
                    onChanged: (String? value) {
                      selectedPeriod = value.toString();
                      setState(() {});
                      _refetchData();
                    },
                    onTap: () {
                      _selectStartDate();
                      _refetchData();
                    },
                    selectedStartDate: _selectedStartDate,
                    selectedPeriod: selectedPeriod,
                  ),
                ),
                const VerticalSpacing(20),
                TableSection(
                  headers: headers,
                  report: reports,
                )
              ],
            ),
            Positioned(
              bottom: 0,
              child: BottomSection(
                totalAmount: '$totalAmount ',
              ),
            )
          ],
        )),
      ),
    );
  }
}

List<String> reportOptions = [
  'Weekly',
  'Monthly',
  'Yearly',
  'Custom',
];
