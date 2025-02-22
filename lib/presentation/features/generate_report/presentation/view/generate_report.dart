import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/presentation/features/generate_report/presentation/widgets/all_reports_tab.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_app_bar.dart';

class GenerateReport extends ConsumerStatefulWidget {
  const GenerateReport({super.key});
  static const String routeName = '/generateReport';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GenerateReportState();
}

class _GenerateReportState extends ConsumerState<GenerateReport> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: LaxmiiAppBar(
        centerTitle: true,
        title: 'Reports',
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 22, horizontal: 16),
          child: AllReportsTab(),
        ),
      ),
    );
  }
}
