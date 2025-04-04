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

class SpotifyPage extends ConsumerStatefulWidget {
  const SpotifyPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SpotifyPageState();
}

class _SpotifyPageState extends ConsumerState<SpotifyPage> {
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
    final shopifyList = ref.watch(getAllTransactionsNotifierProvider.select(
        (v) =>
            v.getAllTransactions.data?.transactions
                ?.where((e) => e.type == 'shopify')
                .toList() ??
            []));

    final isLoading = ref.watch(getAllTransactionsNotifierProvider
        .select((v) => v.loadState.isLoading));
    final colorScheme = Theme.of(context);
    return PageLoader(
      isLoading: isLoading,
      child: Column(
        children: [
          isLoading
              ? const SizedBox.shrink()
              : shopifyList.isEmpty
                  ? Center(
                      child: Column(
                        children: [
                          SvgPicture.asset('assets/icons/empty_data.svg'),
                          const VerticalSpacing(10),
                          Text(
                            'No data Available',
                            style: context.textTheme.s14w500.copyWith(
                              color: colorScheme.colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: shopifyList.length,
                        itemBuilder: (_, index) {
                          final data = shopifyList[index];
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
                    ),
        ],
      ),
    );
  }
}
