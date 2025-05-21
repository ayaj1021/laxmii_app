import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/features/transactions/presentation/notifier/get_all_sales_notifier.dart';
import 'package:laxmii_app/presentation/features/transactions/presentation/widgets/transactions_widget.dart';
import 'package:laxmii_app/presentation/general_widgets/empty_page.dart';
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
    getUserCurrency();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(getAllSalesNotifierProvider.notifier).getAllSales();

      ref.read(getAccessTokenNotifier.notifier).accessToken();
    });
    super.initState();
  }

  String userCurrency = '\$';

  void getUserCurrency() async {
    final currency = await AppDataStorage().getUserCurrency();

    setState(() {
      userCurrency = currency ?? '\$';
    });
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
                  ? const Center(
                      child: EmptyPage(emptyMessage: 'No Sales Available'))
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
                                expenseAmount: '$userCurrency${data.amount}',
                                expenseDate: formattedDate,
                                amountColor: AppColors.primary198624,
                              ),
                              const VerticalSpacing(10)
                            ],
                          );
                        },
                      ),
                    ),
        ],
      ),
    );
  }
}
