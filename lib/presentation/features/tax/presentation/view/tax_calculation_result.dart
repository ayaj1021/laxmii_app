import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/features/tax/data/model/optimize_tax_request.dart';
import 'package:laxmii_app/presentation/features/tax/presentation/notifier/calculate_tax_notifier.dart';
import 'package:laxmii_app/presentation/features/tax/presentation/notifier/optimize_tax_notifier.dart';
import 'package:laxmii_app/presentation/features/tax/presentation/view/tax_optimization_view.dart';
import 'package:laxmii_app/presentation/features/tax/presentation/widgets/tax_calculation_widget.dart';
import 'package:laxmii_app/presentation/general_widgets/app_button.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_app_bar.dart';
import 'package:laxmii_app/presentation/general_widgets/page_loader.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class TaxCalculationResult extends ConsumerStatefulWidget {
  const TaxCalculationResult({super.key});
  static const String routeName = '/taxCalculationView';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TaxCalculationResultState();
}

class _TaxCalculationResultState extends ConsumerState<TaxCalculationResult> {
  @override
  void initState() {
    super.initState();
    getUserCurrency();
  }

  String userCurrency = '\$';

  void getUserCurrency() async {
    final currency = await AppDataStorage().getUserCurrency();

    setState(() {
      userCurrency = currency.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final calculatedTax = ref.watch(calculateTaxNotifier
        .select((v) => v.calculateTaxResponse.taxCalculation));
    final isLoading = ref
        .watch(optimizeTaxProfitNotifier.select((v) => v.loadState.isLoading));
    final colorScheme = Theme.of(context);

    return Scaffold(
      appBar: const LaxmiiAppBar(
        title: 'Tax Calculation Result',
        centerTitle: true,
      ),
      body: PageLoader(
        isLoading: isLoading,
        child: SingleChildScrollView(
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 27,
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: colorScheme.cardColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Calculation Summary',
                        style: context.textTheme.s16w500.copyWith(
                          color: colorScheme.colorScheme.onSurface,
                        ),
                      ),
                      const VerticalSpacing(8),
                      TaxCalculationWidget(
                        title: 'Pay from all employments',
                        subTitle:
                            '$userCurrency${calculatedTax?.totalIncome ?? ''}',
                      ),
                      const VerticalSpacing(8),
                      TaxCalculationWidget(
                        title: 'Profit from Land and properties',
                        subTitle: '$userCurrency 0.00',
                      ),
                      const VerticalSpacing(8),
                      TaxCalculationWidget(
                        title: 'Total dividend income',
                        subTitle: '$userCurrency 0.00',
                      ),
                      const VerticalSpacing(8),
                      TaxCalculationWidget(
                        title: 'Interest from savings',
                        subTitle: '$userCurrency 0.00',
                      ),
                      const VerticalSpacing(8),
                      TaxCalculationWidget(
                        title: 'Total income',
                        subTitle: '$userCurrency 0.00',
                      ),
                      const VerticalSpacing(8),
                      TaxCalculationWidget(
                        title: 'Personal allowance',
                        subTitle:
                            '$userCurrency ${calculatedTax?.personalAllowance ?? ''}',
                      ),
                    ],
                  ),
                ),
                const VerticalSpacing(24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: colorScheme.cardColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tax Due',
                        style: context.textTheme.s16w500.copyWith(
                          color: colorScheme.colorScheme.onSurface,
                        ),
                      ),
                      const VerticalSpacing(8),
                      TaxCalculationWidget(
                        title: 'Total income on which tax is due',
                        subTitle:
                            '$userCurrency ${calculatedTax?.taxableIncome ?? ''}',
                      ),
                      const VerticalSpacing(8),
                      TaxCalculationWidget(
                        title: 'UK income tax due',
                        subTitle:
                            '$userCurrency ${calculatedTax?.incomeTaxDue ?? ''}',
                      ),
                      const VerticalSpacing(8),
                      TaxCalculationWidget(
                        title: 'Capital Gains tax due',
                        subTitle: '$userCurrency 0.00',
                      ),
                      const VerticalSpacing(8),
                      TaxCalculationWidget(
                        title: 'Foreign taxes held',
                        subTitle: '$userCurrency 0.00',
                      ),
                      const VerticalSpacing(8),
                      TaxCalculationWidget(
                        title: 'Total income tax due',
                        subTitle:
                            '$userCurrency ${calculatedTax?.incomeTaxDue ?? ''}',
                        titleStyle: context.textTheme.s14w500.copyWith(
                            //   color: AppColors.primaryC4C4C4,
                            ),
                        subTitleStyle: context.textTheme.s14w500.copyWith(
                            //  color: AppColors.primaryC4C4C4,
                            ),
                      ),
                    ],
                  ),
                ),
                const VerticalSpacing(24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: colorScheme.cardColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const VerticalSpacing(8),
                      TaxCalculationWidget(
                        title: 'NI contributions',
                        subTitle: '$userCurrency ${calculatedTax?.niDue ?? ''}',
                      ),
                      const VerticalSpacing(8),
                      TaxCalculationWidget(
                        title: 'Tax Due',
                        subTitle:
                            '$userCurrency ${calculatedTax?.totalTax ?? ''}',
                        titleStyle: context.textTheme.s14w500.copyWith(
                            // color: AppColors.primaryC4C4C4,
                            ),
                        subTitleStyle: context.textTheme.s14w500.copyWith(
                            //  color: AppColors.primaryC4C4C4,
                            ),
                      ),
                      const VerticalSpacing(8),
                      TaxCalculationWidget(
                        title: 'After-tax receipt',
                        subTitle:
                            '$userCurrency ${calculatedTax?.afterTaxIncome ?? ''}',
                        titleStyle: context.textTheme.s14w500.copyWith(
                            // color: AppColors.primaryC4C4C4,
                            ),
                        subTitleStyle: context.textTheme.s14w500.copyWith(
                            //  color: AppColors.primaryC4C4C4,
                            ),
                      ),
                      const VerticalSpacing(8),
                      TaxCalculationWidget(
                          title: 'Effective tax rate',
                          subTitle:
                              '$userCurrency ${calculatedTax?.effectiveTaxRate ?? ''}',
                          titleStyle: context.textTheme.s14w500.copyWith(
                              //  color: AppColors.primaryC4C4C4,
                              ),
                          subTitleStyle: context.textTheme.s14w500.copyWith(
                              //  color: AppColors.primaryC4C4C4,
                              )),
                    ],
                  ),
                ),
                const VerticalSpacing(28),
                LaxmiiSendButton(
                    onTap: () {
                      final totalIncome = calculatedTax?.totalIncome != null &&
                              calculatedTax?.totalIncome != 0
                          ? num.tryParse(
                                  (calculatedTax?.totalIncome).toString()) ??
                              0
                          : 0;

                      final personalAllowance =
                          calculatedTax?.personalAllowance != null &&
                                  calculatedTax?.personalAllowance != 0
                              ? num.tryParse((calculatedTax?.personalAllowance)
                                      .toString()) ??
                                  0
                              : 0;

                      final taxableIncome = calculatedTax?.taxableIncome !=
                                  null &&
                              calculatedTax?.taxableIncome != 0
                          ? num.tryParse(
                                  (calculatedTax?.taxableIncome).toString()) ??
                              0
                          : 0;

                      _optimizeTax(
                        OptimizeTaxRequest(
                          totalIncome: totalIncome,
                          personalAllowance: personalAllowance,
                          taxableIncome: taxableIncome,
                          // totalIncome: num.parse(
                          //   '${calculatedTax?.totalIncome ?? ''}',
                          // ),
                          // personalAllowance: num.parse(
                          //   '${calculatedTax?.personalAllowance ?? ''}',
                          // ),
                          // taxableIncome: num.parse(
                          //   '${calculatedTax?.taxableIncome ?? ''}',
                          // ),
                          incomeTaxDue:
                              calculatedTax?.incomeTaxDue.toString() ?? '',
                          niDue: calculatedTax?.niDue.toString() ?? '',
                          totalTax: calculatedTax?.totalTax.toString() ?? '',
                          afterTaxIncome:
                              calculatedTax?.afterTaxIncome.toString() ?? '',
                          effectiveTaxRate:
                              calculatedTax?.effectiveTaxRate ?? '',
                        ),
                      );
                    },
                    title: 'Check Tax Optimization')
              ],
            ),
          )),
        ),
      ),
    );
  }

  void _optimizeTax(OptimizeTaxRequest data) async {
    await ref.read(getAccessTokenNotifier.notifier).accessToken();
    await ref.read(optimizeTaxProfitNotifier.notifier).optimizeTax(
        data: data,
        onError: (error) {
          context.showError(message: error);
        },
        onSuccess: (message) {
          context.showSuccess(message: 'Tax optimized successfully');
          context.pushNamed(TaxOptimizationView.routeName);
        });
  }
}
