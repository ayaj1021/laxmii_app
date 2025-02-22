import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/general_widgets/empty_page.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class AllAiInsightsView extends ConsumerStatefulWidget {
  const AllAiInsightsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AllInsightsViewState();
}

class _AllInsightsViewState extends ConsumerState<AllAiInsightsView> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: EmptyPage(
              emptyMessage: 'No Insights Yet',
            ),
          )
        ],
      ),
    );
  }
}

class OptimizeTaxSection extends StatelessWidget {
  const OptimizeTaxSection(
      {super.key, required this.title, required this.items});
  final String title;

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.s12w300.copyWith(
            color: AppColors.primary5E5E5E,
          ),
        ),
        const VerticalSpacing(5),
        Column(
          children:
              items.map((item) => OptimizedTaxWidget(text: item)).toList(),
        ),
      ],
    );
  }
}

class OptimizedTaxWidget extends StatelessWidget {
  const OptimizedTaxWidget({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('🔹 '),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Text(
            text,
            style: context.textTheme.s14w400.copyWith(
              color: AppColors.primary5E5E5E,
            ),
            textAlign: TextAlign.justify,
          ),
        )
      ],
    );
  }
}
