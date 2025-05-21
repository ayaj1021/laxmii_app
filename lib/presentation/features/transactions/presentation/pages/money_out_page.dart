import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/features/transactions/presentation/notifier/get_all_expenses_notifier.dart';
import 'package:laxmii_app/presentation/features/transactions/presentation/widgets/transactions_widget.dart';
import 'package:laxmii_app/presentation/general_widgets/empty_page.dart';
import 'package:laxmii_app/presentation/general_widgets/page_loader.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class MoneyOutPage extends ConsumerStatefulWidget {
  const MoneyOutPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MoneyOutPageState();
}

class _MoneyOutPageState extends ConsumerState<MoneyOutPage> {
  @override
  void initState() {
    getUserCurrency();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(getAllExpensesNotifierProvider.notifier).getAllExpenses();

      await ref.read(getAccessTokenNotifier.notifier).accessToken();
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
    final expensesList = ref.watch(getAllExpensesNotifierProvider
        .select((v) => v.getAllExpenses.data?.expenses));

    final isLoading = ref.watch(
        getAllExpensesNotifierProvider.select((v) => v.loadState.isLoading));
    return PageLoader(
      isLoading: isLoading,
      child: Column(
        children: [
          expensesList == null
              ? const SizedBox.shrink()
              : expensesList.isEmpty
                  ? const Center(
                      child: EmptyPage(emptyMessage: 'No Sales Available'))
                  : Expanded(
                      child: ListView.builder(
                        itemCount: expensesList.length,
                        itemBuilder: (_, index) {
                          final data = expensesList[index];
                          String inputDate = "${data.createdAt}";
                          DateTime parsedDate = DateTime.parse(inputDate);

                          String formattedDate =
                              DateFormat("MMM d yyyy").format(parsedDate);
                          return Column(
                            children: [
                              TransactionsWidget(
                                expenseName: '${data.expenseType}',
                                expenseType: 'Expenses | ${data.supplierName}',
                                expenseAmount: '$userCurrency${data.amount}',
                                expenseDate: formattedDate,
                                amountColor: AppColors.primaryF94D4D,
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
