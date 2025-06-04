import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/presentation/components/cashflow_activity.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/presentation/notifier/get_cashflow_details_notifier.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/presentation/notifier/get_cashflow_notifier.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/presentation/widgets/expense_details_widget.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/presentation/widgets/income_details_widget.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class ActivityView extends ConsumerStatefulWidget {
  const ActivityView({super.key});

  @override
  ConsumerState<ActivityView> createState() => _ActivityViewState();
}

class _ActivityViewState extends ConsumerState<ActivityView> {
  @override
  void initState() {
    getUserCurrency();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(getAccessTokenNotifier.notifier).accessToken();
      await ref
          .read(getCashFlowNotifierProvider.notifier)
          .getCashFlow(query: 'week');
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
    // final cashFlowList = ref.watch(getCashFlowNotifierProvider
    //     .select((v) => v.getCashFlow.data?.cashflow ?? []));
    final incomeDetails = ref.watch(
        getCashFlowDetailsNotifierProvider.select((v) => v.data?.income ?? []));

    final expenseDetails = ref.watch(getCashFlowDetailsNotifierProvider
        .select((v) => v.data?.expenses ?? []));
    final colorScheme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        title: Text(
          'Activity',
          style: context.textTheme.s24w400.copyWith(
            color: colorScheme.colorScheme.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            children: [
              const CashFlowActivity(),
              const VerticalSpacing(20),

              //  InvoiceActivity()
              if (incomeDetails.isNotEmpty)
                IncomeDetailsWidget(
                  currency: userCurrency,
                  incomeDetails: incomeDetails,
                ),

              if (expenseDetails.isNotEmpty)
                ExpenseDetailsWidget(
                  currency: userCurrency,
                  expenseDetails: expenseDetails,
                )
            ],
          ),
        ),
      ),
    );
  }
}
