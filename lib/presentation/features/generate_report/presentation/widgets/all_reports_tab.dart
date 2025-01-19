import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/generate_report/presentation/view/sales_report_detail.dart';
import 'package:laxmii_app/presentation/features/generate_report/presentation/widgets/reports_widget.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class AllReportsTab extends ConsumerStatefulWidget {
  const AllReportsTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AllReportsTabState();
}

class _AllReportsTabState extends ConsumerState<AllReportsTab> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SalesReportDetail(),
                ),
              );
            },
            child: Column(
              children: [
                const ReportsWidget(
                  report: 'Sales Report',
                  color: AppColors.primary5E5E5E,
                ),
                const VerticalSpacing(10),
                index < 4
                    ? Divider(
                        color: AppColors.primary5E5E5E.withOpacity(0.5),
                      )
                    : const SizedBox.shrink(),
                const VerticalSpacing(10),
              ],
            ),
          );
        });
  }
}
