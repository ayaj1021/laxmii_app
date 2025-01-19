import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/generate_report/presentation/widgets/all_reports_tab.dart';
import 'package:laxmii_app/presentation/features/generate_report/presentation/widgets/favorites_tab.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_app_bar.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class GenerateReport extends ConsumerStatefulWidget {
  const GenerateReport({super.key});
  static const String routeName = '/generateReport';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GenerateReportState();
}

class _GenerateReportState extends ConsumerState<GenerateReport>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LaxmiiAppBar(
        centerTitle: true,
        title: 'Reports',
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
          child: Column(
            children: [
              TabBar(
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: AppColors.primary5E5E5E,
                automaticIndicatorColorAdjustment: true,
                labelPadding: const EdgeInsets.symmetric(vertical: 7),
                unselectedLabelStyle: context.textTheme.s16w400.copyWith(
                  color: AppColors.primary5E5E5E,
                ),
                labelStyle: context.textTheme.s16w400.copyWith(
                  color: AppColors.primaryC4C4C4,
                ),
                tabs: [
                  Text(
                    'All Reports',
                    style: context.textTheme.s16w500.copyWith(),
                  ),
                  Text(
                    'Favorites',
                    style: context.textTheme.s16w500.copyWith(),
                  ),
                ],
              ),
              const VerticalSpacing(20),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    AllReportsTab(),
                    FavoritesTab(),
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
