import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/features/transactions/presentation/notifier/delete_recurring_notifier.dart';
import 'package:laxmii_app/presentation/features/transactions/presentation/notifier/get_all_recurring_expense_notifier.dart';
import 'package:laxmii_app/presentation/features/transactions/presentation/widgets/transactions_widget.dart';
import 'package:laxmii_app/presentation/general_widgets/empty_page.dart';
import 'package:laxmii_app/presentation/general_widgets/page_loader.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class RecurringPage extends ConsumerStatefulWidget {
  const RecurringPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MoneyOutPageState();
}

class _MoneyOutPageState extends ConsumerState<RecurringPage> {
  @override
  void initState() {
    getUserCurrency();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(getRecurringNotifierProvider.notifier).getAllRecurring();

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
    final recurringExpense = ref.watch(
        getRecurringNotifierProvider.select((v) => v.data?.recurringExpenses));

    final isLoading = ref
        .watch(getRecurringNotifierProvider.select((v) => v.state.isLoading));
    return PageLoader(
      isLoading: isLoading,
      child: Column(
        children: [
          recurringExpense == null
              ? const SizedBox.shrink()
              : recurringExpense.isEmpty
                  ? const Center(
                      child: EmptyPage(
                        emptyMessage: 'No Recurring expense Available',
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: recurringExpense.length,
                        itemBuilder: (_, index) {
                          final data = recurringExpense[index];
                          String inputDate = "${data.createdAt}";
                          DateTime parsedDate = DateTime.parse(inputDate);

                          String formattedDate =
                              DateFormat("MMM d yyyy").format(parsedDate);
                          return Dismissible(
                            key: Key(data.id.toString()), // Use a unique key
                            direction: DismissDirection.endToStart,
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              color: Colors.red,
                              child:
                                  const Icon(Icons.delete, color: Colors.white),
                            ),
                            onDismissed: (direction) {
                              // Remove the item from the list
                              ref
                                  .read(
                                      deleteRecurringNotifierProvider.notifier)
                                  .deleteRecurring(
                                data.id ?? '',
                                onSuccess: (message) {
                                  setState(() {
                                    recurringExpense
                                        .removeAt(index); // local removal
                                  });
                                  ref
                                      .read(
                                          getRecurringNotifierProvider.notifier)
                                      .getAllRecurring();
                                },
                              );
                            },
                            child: Column(
                              children: [
                                TransactionsWidget(
                                  expenseName: '${data.expense}',
                                  expenseType:
                                      'Expenses | ${data.supplierName}',
                                  expenseAmount: '$userCurrency${data.amount}',
                                  expenseDate: formattedDate,
                                  frequency: data.frequency,
                                  amountColor: AppColors.primaryF94D4D,
                                ),
                                const VerticalSpacing(10)
                              ],
                            ),
                          );
                        },
                      ),
                    )
        ],
      ),
    );
  }
}
