import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/tools/widgets/tabs_selection_widget.dart';
import 'package:laxmii_app/presentation/features/generate_report/presentation/view/generate_report.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/view/inventory_view.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/view/invoice_view.dart';
import 'package:laxmii_app/presentation/features/quotes/presentation/view/quote_view.dart';
import 'package:laxmii_app/presentation/features/tax/presentation/view/tax_view.dart';
import 'package:laxmii_app/presentation/features/todo/presentation/view/todo_view.dart';
import 'package:laxmii_app/presentation/features/transactions/presentation/view/transactions_view.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class ToolsView extends ConsumerWidget {
  const ToolsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Text(
          'Tools',
          style: context.textTheme.s20w500.copyWith(
            color: AppColors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 30),
            child: Column(
              children: [
                TabsSelectionWidget(
                  onTap: () => context.pushNamed(InventoryView.routeName),
                  icon: 'assets/icons/inventory.svg',
                  title: 'Inventory management',
                ),
                const VerticalSpacing(20),
                TabsSelectionWidget(
                  onTap: () => context.pushNamed(TransactionsView.routeName),
                  icon: 'assets/icons/transactions.svg',
                  title: 'Transactions',
                ),
                const VerticalSpacing(20),
                TabsSelectionWidget(
                  onTap: () => context.pushNamed(InvoiceView.routeName),
                  icon: 'assets/icons/invoice.svg',
                  title: 'Invoice',
                ),
                const VerticalSpacing(20),
                const TabsSelectionWidget(
                  icon: 'assets/icons/mileage_tracker.svg',
                  title: 'Mileage Tracker',
                ),
                const VerticalSpacing(20),
                TabsSelectionWidget(
                  onTap: () => context.pushNamed(TodoView.routeName),
                  icon: 'assets/icons/todo.svg',
                  title: 'Goals',
                ),
                const VerticalSpacing(20),
                TabsSelectionWidget(
                  onTap: () => context.pushNamed(TaxView.routeName),
                  icon: 'assets/icons/tax.svg',
                  title: 'Tax Optimization',
                ),
                const VerticalSpacing(20),
                TabsSelectionWidget(
                  icon: 'assets/icons/quote.svg',
                  onTap: () => context.pushNamed(QuoteView.routeName),
                  title: 'Generate Quote',
                ),
                const VerticalSpacing(20),
                TabsSelectionWidget(
                  onTap: () => context.pushNamed(GenerateReport.routeName),
                  icon: 'assets/icons/quote.svg',
                  title: 'Generate Report',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
