import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';

class TransactionsWidget extends StatelessWidget {
  const TransactionsWidget(
      {super.key,
      required this.expenseName,
      required this.expenseType,
      required this.expenseAmount,
      required this.expenseDate,
      this.amountColor});
  final String expenseName;
  final String expenseType;
  final String expenseAmount;
  final String expenseDate;
  final Color? amountColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.primary010101,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                expenseName,
                style: context.textTheme.s14w500.copyWith(
                  color: AppColors.primaryC4C4C4,
                ),
              ),
              Text(
                expenseType,
                style: context.textTheme.s12w300.copyWith(
                  color: AppColors.primary5E5E5E,
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                expenseAmount,
                style: context.textTheme.s14w500.copyWith(
                  color: amountColor ?? AppColors.primaryC4C4C4,
                ),
              ),
              Text(
                expenseDate,
                style: context.textTheme.s12w300.copyWith(
                  color: AppColors.primary5E5E5E,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
