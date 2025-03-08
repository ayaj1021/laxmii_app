import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/transactions/presentation/pages/all_transactions_page.dart';
import 'package:laxmii_app/presentation/features/transactions/presentation/pages/money_in_view.dart';
import 'package:laxmii_app/presentation/features/transactions/presentation/pages/money_out_page.dart';
import 'package:laxmii_app/presentation/features/transactions/presentation/pages/spotify_page.dart';
import 'package:laxmii_app/presentation/features/transactions/presentation/view/create_expense_view.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_app_bar.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class TransactionsView extends ConsumerStatefulWidget {
  const TransactionsView({super.key});
  static const routeName = '/transactionView';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransactionsViewState();
}

class _TransactionsViewState extends ConsumerState<TransactionsView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LaxmiiAppBar(
        title: 'Cashflow',
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TabBar(
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorWeight: 0,
                      labelPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.primaryColor,
                      ),
                      labelStyle: context.textTheme.s12w400
                          .copyWith(color: AppColors.white),
                      unselectedLabelStyle: context.textTheme.s12w400
                          .copyWith(color: AppColors.primary3B3522),
                      controller: _tabController,
                      tabs: const [
                        Text('All'),
                        Text('Money In'),
                        Text('Money Out'),
                        Text('Shopify'),
                      ]),
                ),
                // const HorizontalSpacing(50),
                GestureDetector(
                  onTap: () => context.pushNamed(CreateExpenseView.routeName),
                  child: const Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.add_circle,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const VerticalSpacing(15),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  AllTransactionsPage(),
                  MoneyInPage(),
                  MoneyOutPage(),
                  SpotifyPage()
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
