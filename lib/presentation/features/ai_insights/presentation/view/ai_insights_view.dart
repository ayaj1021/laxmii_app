import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/ai_insights/presentation/pages/ai_sales_insights.dart';
import 'package:laxmii_app/presentation/features/ai_insights/presentation/pages/all_expense_view.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_app_bar.dart';

class AiInsightsView extends ConsumerStatefulWidget {
  const AiInsightsView({super.key});
  static const String routeName = '/aiInsightView';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AiInsightsViewState();
}

class _AiInsightsViewState extends ConsumerState<AiInsightsView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(getAccessTokenNotifier.notifier).accessToken();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LaxmiiAppBar(
        title: 'AI Insights',
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 0,
                  dividerHeight: 0,
                  labelPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                    Text('Sales'),
                    Text('Expense'),
                  ]),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    AiSalesInsights(),
                    AiExpenseInsight(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
