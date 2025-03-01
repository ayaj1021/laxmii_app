import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/dashboard/dashboard.dart';
import 'package:laxmii_app/presentation/features/tax/data/model/optimize_tax_response.dart';
import 'package:laxmii_app/presentation/features/tax/presentation/notifier/optimize_tax_notifier.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_app_bar.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class TaxOptimizationView extends ConsumerStatefulWidget {
  const TaxOptimizationView({super.key});
  static const String routeName = '/taxOptimizationView';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TaxOptimizationViewState();
}

class _TaxOptimizationViewState extends ConsumerState<TaxOptimizationView> {
  List<String> combineOptimizedTaxStrategies(OptimizedTax? optimizedTax) {
    List<String> combinedList = [];

    if (optimizedTax == null) return combinedList;

    if (optimizedTax.incomeManagementStrategy != null) {
      combinedList.addAll(optimizedTax.incomeManagementStrategy!);
    }

    if (optimizedTax.maximizeDeductions != null) {
      combinedList.addAll(optimizedTax.maximizeDeductions!);
    }

    if (optimizedTax.optimizeBusinessTaxes != null) {
      combinedList.addAll(optimizedTax.optimizeBusinessTaxes!);
    }

    return combinedList;
  }

  @override
  Widget build(BuildContext context) {
    final optimizedTax = ref.watch(optimizeTaxProfitNotifier
        .select((v) => v.optimizeTaxResponse.optimizedTax));

    Map<String, dynamic> optimizedData = optimizedTax!.toJson();
    return Scaffold(
      appBar: LaxmiiAppBar(
        title: 'Tax Optimization',
        centerTitle: true,
        actions: [
          TextButton(
            child: Text(
              'Close',
              style: context.textTheme.s14w500.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
            onPressed: () {
              context.pushReplacementNamed(Dashboard.routeName);
            },
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...optimizedData.entries.map((entry) {
                    return Column(
                      children: [
                        OptimizeTaxSection(
                          title: entry.key.toUpperCase(),
                          items: List<String>.from(entry.value),
                        ),
                        const VerticalSpacing(15),
                      ],
                    );
                  }),
                ],
              ),
            )),
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
