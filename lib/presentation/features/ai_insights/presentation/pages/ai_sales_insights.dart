import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/ai_insights/data/model/ai_insights_request.dart';
import 'package:laxmii_app/presentation/features/ai_insights/presentation/notifier/get_ai_insights_notifier.dart';
import 'package:laxmii_app/presentation/features/ai_insights/presentation/pages/all_expense_view.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/general_widgets/empty_page.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class AiSalesInsights extends ConsumerStatefulWidget {
  const AiSalesInsights({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AiInsightsHistoryState();
}

class _AiInsightsHistoryState extends ConsumerState<AiSalesInsights> {
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
    Map<String, dynamic> optimizedAiInsights = (aiInsights)?.toJson() ?? {};
    return SingleChildScrollView(
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : (aiInsights?.insights?.isEmpty ?? false)
              ? const EmptyPage(emptyMessage: 'No Insights yet')
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Column(
                    children: [
                      ...optimizedAiInsights.entries.map((entry) {
                        return Column(
                          children: [
                            AiInsightsWidget(
                              title: entry.key.toUpperCase(),
                              subTitle: entry.value,
                            ),
                            const VerticalSpacing(15),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
    );
  }
}
