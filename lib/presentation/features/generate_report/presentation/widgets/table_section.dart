import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';

class TableSection extends StatelessWidget {
  const TableSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Table(
        border: TableBorder.all(
            color: AppColors.primaryC4C4C4.withOpacity(0.6), width: 1),
        children: [
          buildRow(['Daily', 'Item', 'Customer', 'Amount(\$)'], context,
              isHeader: true),
          buildRow(['18-11-2024', 'MacBook 2020', 'Lorem ipsum', '300.00)'],
              context),
          buildRow(['18-11-2024', 'MacBook 2020', 'Lorem ipsum', '300.00)'],
              context),
          buildRow(['18-11-2024', 'MacBook 2020', 'Lorem ipsum', '300.00)'],
              context),
          buildRow(['18-11-2024', 'MacBook 2020', 'Lorem ipsum', '300.00)'],
              context),
          buildRow(['18-11-2024', 'MacBook 2020', 'Lorem ipsum', '300.00)'],
              context),
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
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  child: Center(
                    child: Text(
                      cell,
                      style: context.textTheme.s11w600.copyWith(
                        color: isHeader
                            ? AppColors.primaryC4C4C4
                            : AppColors.primary101010,
                      ),
                    ),
                  ),
                ))
            .toList(),
      );
}
