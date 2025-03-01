import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/presentation/components/cashflow_activity.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/presentation/components/invoice_activity.dart';

import 'package:laxmii_app/presentation/features/dashboard/pages/activity/presentation/notifier/get_cashflow_notifier.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(getCashFlowNotifierProvider.notifier).getCashFlow();

      await ref.read(getAccessTokenNotifier.notifier).accessToken();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cashFlowList = ref.watch(getCashFlowNotifierProvider
        .select((v) => v.getCashFlow.data?.cashflow ?? []));
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        title: Text(
          'Activity',
          style: context.textTheme.s24w400.copyWith(
            color: AppColors.primaryC4C4C4,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              children: [
                CashFlowActivity(
                  cashFlow: cashFlowList,
                ),
                const VerticalSpacing(24),
                const InvoiceActivity()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
