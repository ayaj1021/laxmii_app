import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/expenses/presentation/notifier/delete_expense_notifier.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/features/transactions/presentation/notifier/get_all_expenses_notifier.dart';
import 'package:laxmii_app/presentation/features/transactions/presentation/view/create_expense_view.dart';
import 'package:laxmii_app/presentation/features/transactions/presentation/widgets/transactions_widget.dart';
import 'package:laxmii_app/presentation/general_widgets/empty_page.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_app_bar.dart';
import 'package:laxmii_app/presentation/general_widgets/page_loader.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class ExpenseView extends ConsumerStatefulWidget {
  const ExpenseView({super.key});
  static const routeName = '/expenseView';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MoneyOutPageState();
}

class _MoneyOutPageState extends ConsumerState<ExpenseView> {
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
    return Scaffold(
      appBar: const LaxmiiAppBar(
        title: 'Expenses',
        centerTitle: true,
      ),
      body: SafeArea(
        child: PageLoader(
          isLoading: isLoading,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => context.pushNamed(CreateExpenseView.routeName),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Create Expense',
                      style: context.textTheme.s15w600.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
                const VerticalSpacing(8),
                expensesList == null
                    ? const SizedBox.shrink()
                    : expensesList.isEmpty
                        ? const Center(
                            child:
                                EmptyPage(emptyMessage: 'No Sales Available'))
                        : Expanded(
                            child: ListView.builder(
                              itemCount: expensesList.length,
                              itemBuilder: (_, index) {
                                final data = expensesList[index];
                                String inputDate = "${data.createdAt}";
                                DateTime parsedDate = DateTime.parse(inputDate);

                                String formattedDate =
                                    DateFormat("MMM d yyyy").format(parsedDate);
                                return Dismissible(
                                  key: Key(
                                      data.id.toString()), // Use a unique key
                                  direction: DismissDirection.endToStart,
                                  background: Container(
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    color: Colors.red,
                                    child: const Icon(Icons.delete,
                                        color: Colors.white),
                                  ),
                                  onDismissed: (direction) {
                                    // Remove the item from the list
                                    ref
                                        .read(deleteExpenseNotifierProvider
                                            .notifier)
                                        .deleteExpense(
                                      data.id ?? '',
                                      onSuccess: (message) {
                                        setState(() {
                                          expensesList.removeAt(index);
                                        });
                                        ref
                                            .read(getAllExpensesNotifierProvider
                                                .notifier)
                                            .getAllExpenses();
                                        context.showSuccess(message: message);
                                      },
                                      onError: (error) {
                                        context.showError(message: error);
                                      },
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      TransactionsWidget(
                                        expenseName: '${data.expenseType}',
                                        expenseType:
                                            'Expenses | ${data.supplierName}',
                                        expenseAmount:
                                            '$userCurrency${data.amount}',
                                        expenseDate: formattedDate,
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
          ),
        ),
      ),
    );
  }
}
