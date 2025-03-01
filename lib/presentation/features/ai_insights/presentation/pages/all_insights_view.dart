import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/ai_insights/data/model/ai_insights_response.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class AllAiInsightsView extends ConsumerStatefulWidget {
  const AllAiInsightsView({
    super.key,
    required this.aiInsights,
    required this.isLoading,
  });
  final AiInsights? aiInsights;
  final bool isLoading;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AllInsightsViewState();
}

class _AllInsightsViewState extends ConsumerState<AllAiInsightsView> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> optimizedAiInsights =
        (widget.aiInsights)?.toJson() ?? {};
    return SingleChildScrollView(
      child: widget.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Column(
                children: [
                  ...optimizedAiInsights.entries.map((entry) {
                    return Column(
                      children: [
                        AiInsightsWidget(
                            title: entry.key.toUpperCase(),
                            subTitle: '${entry.value}'

                            //'Your utility bills were 30% higher this month due to increased energy use',

                            ),

                        // OptimizeTaxSection(
                        //   title: entry.key.toUpperCase(),
                        //   items: List<String>.from(entry.value),
                        // ),
                        const VerticalSpacing(15),
                      ],
                    );
                  }),
                  // Center(
                  //   child: EmptyPage(
                  //     emptyMessage: 'No Insights Yet',
                  //   ),
                  // )
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
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.s16w500.copyWith(
            color: AppColors.white,
          ),
        ),
        const VerticalSpacing(10),
        Text(
          subTitle,
          style: context.textTheme.s14w400.copyWith(
            color: AppColors.primary5E5E5E,
            fontSize: 14,
          ),
        ),
        const VerticalSpacing(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(5.33),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.primary075427,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Text(
                            '%12',
                            style: context.textTheme.s10w600.copyWith(
                              color: AppColors.primary1FCB4F,
                            ),
                          ),
                          const HorizontalSpacing(5),
                          SvgPicture.asset('assets/icons/arrow_up.svg'),
                        ],
                      ),
                    ],
                  ),
                ),
                const HorizontalSpacing(16),
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
