import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/invoice/data/model/create_invoice_request.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/notifier/create_invoice_notifier.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/view/invoice_view.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/general_widgets/app_button.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_app_bar.dart';
import 'package:laxmii_app/presentation/general_widgets/page_loader.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';
import 'package:screenshot/screenshot.dart';

class InvoiceDetailsView extends ConsumerStatefulWidget {
  const InvoiceDetailsView(
      {required this.customerName,
      required this.issueDate,
      required this.dueDate,
      required this.invoiceNumber,
      required this.totalAmount,
      required this.items,
      super.key});
  final String customerName;
  final String issueDate;
  final String dueDate;
  final String invoiceNumber;
  final double totalAmount;
  final List<Item> items;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InvoiceDetailsViewState();
}

class _InvoiceDetailsViewState extends ConsumerState<InvoiceDetailsView> {
  final screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
        createInvoiceNotifier.select((v) => v.createInvoiceState.isLoading));

    return PageLoader(
      isLoading: isLoading,
      child: Scaffold(
        appBar: const LaxmiiAppBar(
          title: 'Details',
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Step 1 of 2',
                style: context.textTheme.s12w500.copyWith(
                  color: AppColors.white,
                ),
              ),
              const VerticalSpacing(5),
              Container(
                height: 650.h,
                padding:
                    const EdgeInsets.symmetric(horizontal: 21, vertical: 24),
                decoration: const BoxDecoration(
                    color: AppColors.primaryC4C4C4,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24))),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Invoices',
                            style: context.textTheme.s24w600.copyWith(
                              color: AppColors.black,
                            ),
                          ),
                          const HorizontalSpacing(5),
                          Text(
                            widget.invoiceNumber,
                            style: context.textTheme.s24w600.copyWith(
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                      const VerticalSpacing(9),
                      Row(
                        children: [
                          Text(
                            'Invoice date:',
                            style: context.textTheme.s12w500.copyWith(
                              color: AppColors.black,
                            ),
                          ),
                          const HorizontalSpacing(3),
                          Text(
                            widget.issueDate,
                            style: context.textTheme.s12w500.copyWith(
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                      const VerticalSpacing(10),
                      Row(
                        children: [
                          Text(
                            'Due date:',
                            style: context.textTheme.s12w500.copyWith(
                              color: AppColors.black,
                            ),
                          ),
                          const HorizontalSpacing(3),
                          Text(
                            widget.dueDate,
                            style: context.textTheme.s12w500.copyWith(
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                      const VerticalSpacing(450),
                      LaxmiiSendButton(
                        onTap: () => createInvoice(),

                        // shareInvoice(
                        //     context: context,
                        //     screenshotController: screenshotController,
                        //     invoiceNumber: widget.invoiceNumber,
                        //     dueDate: widget.dueDate,
                        //     issueDate: widget.issueDate),
                        title: 'Save',
                        textColor: AppColors.black,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }

  void createInvoice() async {
    await ref.read(getAccessTokenNotifier.notifier).accessToken();
    ref.read(createInvoiceNotifier.notifier).createInvoice(
          data: CreateInvoiceRequest(
            customerName: widget.customerName,
            issueDate: widget.issueDate.toString(),
            dueDate: widget.dueDate.toString(),
            invoiceNumber: widget.invoiceNumber,
            items: widget.items,
            totalAmount: widget.totalAmount,
          ),
          onError: (error) {
            context.showError(message: error);
          },
          onSuccess: (message) {
            context.hideOverLay();
            context.showSuccess(message: message);
            context.popAndPushNamed(InvoiceView.routeName);
          },
        );
  }
}
