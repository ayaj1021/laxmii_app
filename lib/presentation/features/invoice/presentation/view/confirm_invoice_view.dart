import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/invoice/data/model/update_invoice_request.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/notifier/update_invoice_notifier.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/general_widgets/app_button.dart';
import 'package:laxmii_app/presentation/general_widgets/app_outline_button.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_app_bar.dart';
import 'package:laxmii_app/presentation/general_widgets/page_loader.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';
import 'package:share_plus/share_plus.dart';

class ConfirmInvoiceView extends ConsumerStatefulWidget {
  const ConfirmInvoiceView(
      {required this.customerName,
      required this.issueDate,
      required this.dueDate,
      required this.invoiceNumber,
      required this.invoiceId,
      required this.invoiceStatus,
      super.key});
  final String customerName;
  final String issueDate;
  final String dueDate;
  final String invoiceNumber;
  final String invoiceId;
  final String invoiceStatus;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InvoiceDetailsViewState();
}

class _InvoiceDetailsViewState extends ConsumerState<ConfirmInvoiceView> {
  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
        updateInvoiceNotifier.select((v) => v.updateInvoiceState.isLoading));
    // final invoiceId = ref.watch(createInvoiceNotifier
    //     .select((v) => v.createInvoiceResponse.invoice?.id));
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
                      Container(
                        height: MediaQuery.of(context).size.height * 0.14,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 0),
                        decoration: const BoxDecoration(
                            color: AppColors.primaryC4C4C4,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24))),
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
                                  '# ${widget.invoiceNumber}',
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
                          ],
                        ),
                      ),
                      const VerticalSpacing(400),
                      widget.invoiceStatus == 'unpaid'
                          ? LaxmiiSendButton(
                              onTap: () =>
                                  updateInvoice(invoiceId: widget.invoiceId),
                              title: 'Mark as paid',
                              textColor: AppColors.black,
                            )
                          : const SizedBox.shrink(),
                      const VerticalSpacing(19),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: LaxmiiOutlineSendButton(
                                backgroundColor: Colors.transparent,
                                textColor: AppColors.primary212121,
                                hasBorder: true,
                                icon: 'assets/icons/share.svg',
                                borderColor: AppColors.primary212121,
                                onTap: () async {
                                  _shareInvoiceDetails();
                                },
                                title: 'Share',
                              )),
                          // SizedBox(
                          //     width: 150.w,
                          //     child: LaxmiiOutlineSendButton(
                          //       backgroundColor: Colors.transparent,
                          //       textColor: AppColors.primary212121,
                          //       hasBorder: true,
                          //       icon: 'assets/icons/edit.svg',
                          //       borderColor: AppColors.primary212121,
                          //       onTap: () {},
                          //       title: 'Edit',
                          //     ))
                        ],
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

  void updateInvoice({required String invoiceId}) async {
    await ref.read(getAccessTokenNotifier.notifier).accessToken();
    ref.read(updateInvoiceNotifier.notifier).updateInvoice(
          data: UpdateInvoiceRequest(status: 'paid'),
          onError: (error) {
            context.showError(message: error);
          },
          onSuccess: (message) {
            context.hideOverLay();
            context.showSuccess(message: message);
            // context.pushNamed(InvoiceView.routeName);
          },
          invoiceId: invoiceId,
        );
  }

  void _shareInvoiceDetails() {
    final String shareText = '''
Invoice #${widget.invoiceNumber}
Invoice Date: ${widget.issueDate}
Due Date: ${widget.dueDate}
''';

    Share.share(shareText);
  }
}
