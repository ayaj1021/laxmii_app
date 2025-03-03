import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/generate_report/data/model/get_single_report_response.dart';

class TableSection extends StatelessWidget {
  const TableSection({super.key, required this.headers, required this.report});

  final List<String> headers;
  final List<ReportData> report;

  String _formatDate(date) {
    return DateFormat('d MMM, yy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Table(
            border: TableBorder.all(
              color: AppColors.primaryC4C4C4.withValues(alpha: 0.6),
              width: 1,
            ),
            children: [
              if (headers.isNotEmpty)
                buildRow(headers, context, isHeader: true),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: report.isEmpty
                ? Center(
                    child: Text(
                      'No reports available',
                      style: context.textTheme.s11w600
                          .copyWith(color: AppColors.primaryC4C4C4),
                    ),
                  )
                : ListView.builder(
                    itemCount: report.length,
                    itemBuilder: (_, index) {
                      final reportData = report[index];
                      final rowData = [
                        _formatDate(reportData.date),
                        '${reportData.expenseType ?? reportData.inventory ?? reportData.invoiceNumber}',
                        '${reportData.supplier ?? reportData.customer ?? reportData.customerName}',
                        '${reportData.amount}'
                      ];

                      return Table(
                        border: TableBorder.all(
                            color:
                                AppColors.primaryC4C4C4.withValues(alpha: 0.6),
                            width: 1),
                        children: [
                          if (rowData.isNotEmpty) buildRow(rowData, context),
                        ],
                      );
                    }),
          )
        ],
      ),
    );
  }

  TableRow buildRow(List<String> cells, BuildContext context,
          {bool isHeader = false}) =>
      TableRow(
        decoration: BoxDecoration(
          color: isHeader ? AppColors.primary101010 : AppColors.primary5E5E5E,
        ),
        children: cells
            .map((cell) => Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  child: Text(
                    cell,
                    style: context.textTheme.s11w600.copyWith(
                      color: isHeader
                          ? AppColors.primaryC4C4C4
                          : AppColors.primary101010,
                    ),
                  ),
                ))
            .toList(),
      );
}
