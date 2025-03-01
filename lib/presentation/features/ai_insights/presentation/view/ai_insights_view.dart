import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/ai_insights/data/model/ai_insights_request.dart';
import 'package:laxmii_app/presentation/features/ai_insights/presentation/notifier/get_ai_insights_notifier.dart';
import 'package:laxmii_app/presentation/features/ai_insights/presentation/pages/all_insights_view.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_app_bar.dart';

class AiInsightsView extends ConsumerStatefulWidget {
  const AiInsightsView({super.key});
  static const String routeName = '/aiInsightView';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AiInsightsViewState();
}

class _AiInsightsViewState extends ConsumerState<AiInsightsView> {
  final data = AiInsightsRequest(insightType: 'sales');

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref
          .read(getAiIsightsNotifierProvider.notifier)
          .getAiInsights(request: data);

      await ref.read(getAccessTokenNotifier.notifier).accessToken();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final aiInsights = ref.watch(getAiIsightsNotifierProvider
        .select((v) => v.getAiInsights.data?.aiInsights));
    final isLoading = ref.watch(
        getAiIsightsNotifierProvider.select((v) => v.loadState.isLoading));

    return Scaffold(
      appBar: const LaxmiiAppBar(
        title: 'AI Insights',
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: AllAiInsightsView(
                    aiInsights: aiInsights,
                    isLoading: isLoading,
                  ),
                  //
                  //
                  // SizedBox(
                  //     width: MediaQuery.of(context).size.width * 0.5,
                  //     child: TabBar(
                  //       isScrollable: true,
                  //       tabAlignment: TabAlignment.start,
                  //       indicatorSize: TabBarIndicatorSize.tab,
                  //       indicatorWeight: 0,
                  //       labelPadding:
                  //           const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  //       indicator: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(10),
                  //         color: AppColors.primaryColor,
                  //       ),
                  //       labelStyle: context.textTheme.s12w400
                  //           .copyWith(color: AppColors.white),
                  //       unselectedLabelStyle: context.textTheme.s12w400
                  //           .copyWith(color: AppColors.white),
                  //       controller: _tabController,
                  //       tabs: const [
                  //         Text('All'),
                  //         Text('History'),
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  // Expanded(
                  //   // height: MediaQuery.of(context).size.height * 05,
                  //   child: TabBarView(
                  //     controller: _tabController,
                  //     children: [
                  //       AllAiInsightsView(
                  //         aiInsights: aiInsights,
                  //         isLoading: isLoading,
                  //       ),
                  //       const AiInsightsHistory(),
                  //     ],
                  //   ),
                  // )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
