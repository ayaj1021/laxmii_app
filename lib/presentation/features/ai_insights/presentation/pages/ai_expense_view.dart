import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/ai_insights/data/model/ai_insights_request.dart';
import 'package:laxmii_app/presentation/features/ai_insights/presentation/notifier/get_ai_insights_notifier.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/general_widgets/empty_page.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class AiExpenseInsight extends ConsumerStatefulWidget {
  const AiExpenseInsight({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AllInsightsViewState();
}

class _AllInsightsViewState extends ConsumerState<AiExpenseInsight> {
  final data = AiInsightsRequest(insightType: 'expense');
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

                              //'${entry.value}'
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

class AiInsightsWidget extends StatelessWidget {
  const AiInsightsWidget(
      {super.key, required this.title, required this.subTitle});
  final String title;
  final List<dynamic> subTitle;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.s16w500.copyWith(
            color: colorScheme.colorScheme.onSurface,
          ),
        ),
        const VerticalSpacing(10),
        Column(
          children: List.generate(subTitle.length, (index) {
            final data = subTitle[index];
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: CircleAvatar(
                    radius: 3,
                    backgroundColor: colorScheme.iconTheme.color,
                  ),
                ),
                const HorizontalSpacing(10),
                Expanded(child: Text(data))
              ],
            );
          }),
        ),
        // Text(
        //   subTitle,
        //   style: context.textTheme.s14w400.copyWith(
        //     color: AppColors.primary5E5E5E,
        //     fontSize: 14,
        //   ),
        // ),
        const VerticalSpacing(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // Container(
                //   padding: const EdgeInsets.all(5.33),
                //   decoration: BoxDecoration(
                //     border: Border.all(
                //       color: AppColors.primary075427,
                //     ),
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                //   child: Row(
                //     children: [
                //       Row(
                //         children: [
                //           Text(
                //             '%12',
                //             style: context.textTheme.s10w600.copyWith(
                //               color: AppColors.primary1FCB4F,
                //             ),
                //           ),
                //           const HorizontalSpacing(5),
                //           SvgPicture.asset('assets/icons/arrow_up.svg'),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                // const HorizontalSpacing(16),
                SvgPicture.asset('assets/icons/expense_icon.svg')
              ],
            ),
            // Container(
            //     padding:
            //         const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(10),
            //         border: Border.all(
            //           color: AppColors.primary3B3522,
            //         )),
            //     child: Text(
            //       'View',
            //       style: context.textTheme.s12w500.copyWith(
            //         color: AppColors.primary3B3522,
            //       ),
            //     ))
          ],
        ),
      ],
    );
  }
}
