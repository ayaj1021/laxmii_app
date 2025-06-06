import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/view/create_inventory_view.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/view/create_income_one_view.dart';
import 'package:laxmii_app/presentation/features/todo/presentation/view/create_task_view.dart';
import 'package:laxmii_app/presentation/features/transactions/presentation/view/create_expense_view.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class HomeBottomNav extends StatelessWidget {
  const HomeBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 27),
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
          color: colorScheme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(20),
          )),
      child: Column(
        children: [
          HomeBottomNavSelectionsWidget(
            onTap: () => context.pushNamed(CreateInventory.routeName),
            icon: 'assets/icons/inventory.svg',
            title: 'Inventory',
          ),
          const VerticalSpacing(16),
          HomeBottomNavSelectionsWidget(
            onTap: () => context.pushNamed(CreateIncomeOneView.routeName),
            icon: 'assets/icons/transactions.svg',
            title: 'Income',
          ),
          const VerticalSpacing(16),
          HomeBottomNavSelectionsWidget(
            onTap: () => context.pushNamed(CreateExpenseView.routeName),
            icon: 'assets/icons/transactions.svg',
            title: 'Expense',
          ),
          const VerticalSpacing(16),
          HomeBottomNavSelectionsWidget(
            onTap: () => context.pushNamed(CreateTaskView.routeName),
            icon: 'assets/icons/todo.svg',
            title: 'Goals',
          ),
        ],
      ),
    );
  }
}

class HomeBottomNavSelectionsWidget extends StatelessWidget {
  const HomeBottomNavSelectionsWidget(
      {super.key, required this.icon, required this.title, this.onTap});
  final String icon;
  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: colorScheme.cardColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: colorScheme.colorScheme.onPrimaryContainer,
                  ),
                  child: SvgPicture.asset(icon),
                ),
                const HorizontalSpacing(10),
                Text(
                  title,
                  style: context.textTheme.s14w400.copyWith(
                    color: AppColors.primary5E5E5E,
                  ),
                )
              ],
            ),
            const Icon(
              Icons.add,
              color: AppColors.primary5E5E5E,
              size: 14,
            )
          ],
        ),
      ),
    );
  }
}
