import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/features/transactions/presentation/notifier/get_all_sales_notifier.dart';
import 'package:laxmii_app/presentation/features/transactions/presentation/widgets/transactions_widget.dart';
import 'package:laxmii_app/presentation/general_widgets/page_loader.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class MoneyInPage extends ConsumerStatefulWidget {
  const MoneyInPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MoneyInPageState();
}

class _MoneyInPageState extends ConsumerState<MoneyInPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(getAllSalesNotifierProvider.notifier).getAllSales();

      await ref.read(getAccessTokenNotifier.notifier).accessToken();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final salesList = ref.watch(
        getAllSalesNotifierProvider.select((v) => v.getAllSales.data?.sales));
    final isLoading = ref.watch(
        getAllSalesNotifierProvider.select((v) => v.loadState.isLoading));
    return PageLoader(
      isLoading: isLoading,
      child: Column(
        children: [
          salesList == null
              ? const SizedBox.shrink()
              : salesList.isEmpty
                  ? Column(
                      children: [
                        SvgPicture.asset('assets/icons/empty_data.svg'),
                        const VerticalSpacing(10),
                        Text(
                          'No Sales Available',
                          style: context.textTheme.s14w500.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: salesList.length,
                        itemBuilder: (_, index) {
                          final data = salesList[index];
                          String inputDate = "${data.createdAt}";
                          DateTime parsedDate = DateTime.parse(inputDate);

                          String formattedDate =
                              DateFormat("MMM d yyyy").format(parsedDate);
                          return Column(
                            children: [
                              TransactionsWidget(
                                expenseName: '${data.inventory}',
                                expenseType: 'Expenses | ${data.customerName}',
                                expenseAmount: '\$${data.amount}',
                                expenseDate: formattedDate,
                                amountColor: AppColors.primary198624,
                              ),
                              const VerticalSpacing(10)
                            ],
                          );
                        },
                      ),
                    )
        ],
      ),
    );
  }
}
