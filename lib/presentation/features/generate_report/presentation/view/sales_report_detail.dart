import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/presentation/features/generate_report/presentation/widgets/report_dropdown_widget.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_app_bar.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class SalesReportDetail extends ConsumerStatefulWidget {
  const SalesReportDetail({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SalesReportDetailState();
}

class _SalesReportDetailState extends ConsumerState<SalesReportDetail> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: LaxmiiAppBar(
        centerTitle: true,
        title: 'Sales Report',
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 23),
            child: ReportDropDownWidget(),
          ),
          VerticalSpacing(20)
        ],
      )),
    );
  }
}
