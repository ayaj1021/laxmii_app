import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/presentation/widgets/invoice_chart_widget.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/notifier/get_all_invoice_notifier.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/view/invoice_view.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class InvoiceActivity extends ConsumerStatefulWidget {
  const InvoiceActivity({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InvoiceWidgetState();
}

class _InvoiceWidgetState extends ConsumerState<InvoiceActivity> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(getAllInvoiceNotifierProvider.notifier).getAllInvoices();

      await ref.read(getAccessTokenNotifier.notifier).accessToken();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final allInvoiceList = ref.watch(getAllInvoiceNotifierProvider
        .select((v) => v.getAllInvoice.data?.invoices ?? []));
    final colorScheme = Theme.of(context);
    return Animate(
      effects: const [
        FadeEffect(
          duration: Duration(milliseconds: 500),
          begin: 0.5,
        ),
      ],
      child: GestureDetector(
        onTap: () {
          context.pushNamed(InvoiceView.routeName);
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.35,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          width: double.infinity,
          decoration: BoxDecoration(
              color: colorScheme.cardColor,
              borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Invoices',
                    style: context.textTheme.s14w400.copyWith(
                      color: colorScheme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              // const VerticalSpacing(5),
              allInvoiceList.isEmpty
                  ? Column(
                      children: [
                        Text(
                          'No Activity yet',
                          style: context.textTheme.s16w400.copyWith(
                            color: AppColors.primary5E5E5E,
                          ),
                        ),
                        const VerticalSpacing(9),
                        Text(
                          'Create sales and expenses to see activities',
                          style: context.textTheme.s14w400.copyWith(
                            color: AppColors.primary5E5E5E,
                          ),
                        ),
                      ],
                    )
                  : InvoiceChartWidget(
                      allInvoices: allInvoiceList,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
