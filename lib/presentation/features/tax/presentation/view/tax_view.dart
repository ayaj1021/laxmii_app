import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/widgets/update_products_textfield.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/features/tax/data/model/calculate_tax_request.dart';
import 'package:laxmii_app/presentation/features/tax/data/model/get_total_profit_request.dart';
import 'package:laxmii_app/presentation/features/tax/presentation/notifier/calculate_tax_notifier.dart';
import 'package:laxmii_app/presentation/features/tax/presentation/notifier/get_total_tax_profit_notifier.dart';
import 'package:laxmii_app/presentation/features/tax/presentation/view/tax_calculation_result.dart';
import 'package:laxmii_app/presentation/features/tax/presentation/widgets/tax_date_select_section.dart';
import 'package:laxmii_app/presentation/features/tax/presentation/widgets/tax_dropdown_widget.dart';
import 'package:laxmii_app/presentation/general_widgets/app_button.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_app_bar.dart';
import 'package:laxmii_app/presentation/general_widgets/page_loader.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class TaxView extends ConsumerStatefulWidget {
  const TaxView({super.key});

  static const String routeName = '/taxView';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TaxViewState();
}

class _TaxViewState extends ConsumerState<TaxView> {
  final _entityController = TextEditingController();
  String? _selectedValue;

  DateTime? _fromDate;

  Future<void> _fromDateSelect(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _fromDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      // lastDate: DateTime(2100),
    );

    if (picked != null && picked != _fromDate) {
      setState(() {
        _fromDate = picked;
      });
    }
  }

  DateTime? _toDate;

  Future<void> _toDateSelect(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _toDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      //  lastDate: DateTime(2100),
    );

    if (picked != null && picked != _toDate) {
      setState(() {
        _toDate = picked;
      });
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMM d, yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        ref.watch(calculateTaxNotifier.select((v) => v.loadState.isLoading));

    final isGetProfitLoading = ref
        .watch(getTotalTaxProfitNotifier.select((v) => v.loadState.isLoading));
    final taxProfit = ref.watch(
        getTotalTaxProfitNotifier.select((v) => v.getTotalTaxProfitResponse));
    return Scaffold(
      appBar: const LaxmiiAppBar(
        title: 'Tax Optimization Calculator',
        centerTitle: true,
      ),
      body: PageLoader(
        isLoading: isGetProfitLoading,
        child: PageLoader(
          isLoading: isLoading,
          child: SingleChildScrollView(
            child: SafeArea(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                children: [
                  Center(
                    child: SizedBox(
                        width: 257.w,
                        child: Text(
                          'Quickly calculate your tax savings and identify opportunities for deductions and credits.',
                          style: context.textTheme.s14w400.copyWith(
                            color: AppColors.primary5E5E5E,
                          ),
                          textAlign: TextAlign.center,
                        )),
                  ),
                  const VerticalSpacing(16),
                  TaxDropdownWidget(
                    selectedValue: _selectedValue.toString(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedValue = newValue;
                      });
                    },
                  ),
                  const VerticalSpacing(8),
                  TaxDateSelectSection(
                    fromDate: _formatDate(_fromDate ?? DateTime.now()),
                    toDate: _formatDate(_toDate ?? DateTime.now()),
                    fromDateTap: () {
                      _fromDateSelect(context);
                    },
                    toDateTap: () {
                      if (_fromDate == null) {
                        context.showError(message: 'Choose a start date');
                      } else {
                        _toDateSelect(context).then(
                          (val) {
                            final data = GetTotalProfitRequest(
                                startDate: _fromDate ?? DateTime.now(),
                                endDate: _toDate ?? DateTime.now());

                            if (_fromDate == null) {
                            } else {
                              ref
                                  .read(getTotalTaxProfitNotifier.notifier)
                                  .getTotalTaxProfit(
                                      data: data,
                                      onError: (error) {
                                        context.showError(message: error);
                                      },
                                      onSuccess: (message) {});
                            }
                          },
                        );
                      }
                    },
                  ),
                  const VerticalSpacing(8),
                  TaxProfitWidget(
                    title: 'Total Income',
                    data: '\$${taxProfit.salesTotal ?? ''}',
                  ),
                  const VerticalSpacing(8),
                  TaxProfitWidget(
                    title: 'Total Expenditure',
                    data: '\$${taxProfit.expenseTotal ?? ''}',
                  ),
                  const VerticalSpacing(8),
                  TaxProfitWidget(
                    title: 'Profit',
                    data: '\$${taxProfit.profit ?? ''}',
                  ),
                  const VerticalSpacing(8),
                  UpdateProductsTextField(
                    product: _entityController,
                    title: 'Entity',
                  ),
                  const VerticalSpacing(70),
                  LaxmiiSendButton(
                      onTap: () {
                        if (_fromDate == null || _toDate == null) {
                          context.showError(message: 'Please select date');
                        } else if (_selectedValue == null) {
                          context.showError(message: 'Please select period');
                        } else {
                          _calculateTax(taxProfit.profit ?? 0);
                        }
                      },
                      title: 'Calculate Tax')
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }

  void _calculateTax(int profit) async {
    final data = CalculateTaxRequest(period: '$_selectedValue', profit: profit);
    await ref.read(getAccessTokenNotifier.notifier).accessToken();
    await ref.read(calculateTaxNotifier.notifier).calculateTax(
        data: data,
        onError: (error) {
          context.showError(message: error);
        },
        onSuccess: (message) {
          context.showSuccess(message: 'Tax calculated successfully');
          context.pushNamed(TaxCalculationResult.routeName);
        });
  }
}

class TaxProfitWidget extends StatelessWidget {
  const TaxProfitWidget({super.key, required this.title, required this.data});
  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.s14w400.copyWith(
            color: AppColors.primary5E5E5E,
          ),
        ),
        const VerticalSpacing(5),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  width: 1.5,
                  color: AppColors.primary5E5E5E.withValues(alpha: 0.5))),
          child: Text(
            data,
            style: context.textTheme.s14w500.copyWith(
              color: AppColors.primaryC4C4C4,
            ),
          ),
        ),
      ],
    );
  }
}
