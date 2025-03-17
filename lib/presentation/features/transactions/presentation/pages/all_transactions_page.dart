import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/features/transactions/presentation/notifier/get_all_transactions_notifier.dart';
import 'package:laxmii_app/presentation/features/transactions/presentation/widgets/transactions_widget.dart';
import 'package:laxmii_app/presentation/general_widgets/page_loader.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class AllTransactionsPage extends ConsumerStatefulWidget {
  const AllTransactionsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AllTransactionsPageState();
}

class _AllTransactionsPageState extends ConsumerState<AllTransactionsPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref
          .read(getAllTransactionsNotifierProvider.notifier)
          .getAllTransactions();

      await ref.read(getAccessTokenNotifier.notifier).accessToken();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final transactionsList = ref.watch(getAllTransactionsNotifierProvider
        .select((v) => v.getAllTransactions.data?.transactions));

    final isLoading = ref.watch(getAllTransactionsNotifierProvider
        .select((v) => v.loadState.isLoading));
    return PageLoader(
      isLoading: isLoading,
      child: Column(
        children: [
          transactionsList == null
              ? const SizedBox.shrink()
              : transactionsList.isEmpty
                  ? Center(
                      child: Column(
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
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: transactionsList.length,
                        itemBuilder: (_, index) {
                          final data = transactionsList[index];
                          String inputDate = "${data.createdAt}";
                          DateTime parsedDate = DateTime.parse(inputDate);
                          final expense =
                              data.transactionType?.replaceAll('_', ' ');
                          final supplierName = data.type == 'expense'
                              ? data.supplierName
                              : data.customerName;
                          final expenseName = data.type == 'expense'
                              ? data.expenseType
                              : data.inventory;

                          String formattedDate =
                              DateFormat("MMM d yyyy").format(parsedDate);
                          return Column(
                            children: [
                              TransactionsWidget(
                                expenseName: '$expenseName',
                                expenseType:
                                    '${expense?.toUpperCase()} | $supplierName',
                                expenseAmount: '\$${data.amount}',
                                expenseDate: formattedDate,
                                amountColor: data.type == 'expense'
                                    ? AppColors.primaryF94D4D
                                    : AppColors.primary198624,
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
