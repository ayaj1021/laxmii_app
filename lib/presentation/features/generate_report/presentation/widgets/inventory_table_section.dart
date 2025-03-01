import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/inventory/data/model/get_all_inventory_response.dart';

class InventoryTableSection extends StatelessWidget {
  const InventoryTableSection({super.key, required this.report});

  final List<Inventory> report;

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
              buildRow([
                'Inventory',
                'Quantity',
                'Cost price',
                'Selling price'
              ], context, isHeader: true),
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
                  ))
                : ListView.builder(
                    itemCount: report.length,
                    itemBuilder: (_, index) {
                      final reportData = report[index];
                      final rowData = [
                        '${reportData.productName}',
                        '${reportData.quantity}',
                        '${reportData.costPrice}',
                        '${reportData.sellingPrice}',
                      ];

                      return Table(
                        border: TableBorder.all(
                            color:
                                AppColors.primaryC4C4C4.withValues(alpha: 0.6),
                            width: 1),
                        children: [
                          if (rowData.isNotEmpty) buildRow(rowData, context),
                          // buildRow([
                          //   _formatDate(reportData.date),
                          //   '${reportData.expenseType}',
                          //   '${reportData.supplier}',
                          //   '${reportData.amount}'
                          // ], context),
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
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                  child: Text(
                    cell,
                    style: context.textTheme.s12w400.copyWith(
                      fontSize: 13,
                      color: isHeader
                          ? AppColors.primaryC4C4C4
                          : AppColors.primary101010,
                    ),
                  ),
                ))
            .toList(),
      );
}
