import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/dashboard/dashboard.dart';
import 'package:laxmii_app/presentation/features/invoice/data/model/create_invoice_request.dart';
import 'package:laxmii_app/presentation/features/invoice/data/model/get_all_invoice_response.dart';
import 'package:laxmii_app/presentation/features/invoice/data/model/update_invoice_request.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/notifier/update_invoice_notifier.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/widgets/share_invoice_pdf.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/general_widgets/app_button.dart';
import 'package:laxmii_app/presentation/general_widgets/app_outline_button.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_app_bar.dart';
import 'package:laxmii_app/presentation/general_widgets/page_loader.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class ConfirmInvoiceView extends ConsumerStatefulWidget {
  const ConfirmInvoiceView(
      {required this.customerName,
      required this.issueDate,
      required this.dueDate,
      required this.invoiceNumber,
      required this.invoiceId,
      required this.invoiceStatus,
      this.filteredInvoices,
      this.items,
      super.key});
  final String customerName;
  final String issueDate;
  final String dueDate;
  final String invoiceNumber;
  final String invoiceId;
  final String invoiceStatus;
  final List<CreateInvoiceItem>? items;
  final List<Item>? filteredInvoices;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InvoiceDetailsViewState();
}

class _InvoiceDetailsViewState extends ConsumerState<ConfirmInvoiceView> {
  double totalAmount = 0.0;

  double calculateTotalAmount() {
    return totalAmount = (widget.items ?? [])
        .fold(0, (sum, item) => sum + (item.quantity * item.price));
  }

  double calculateFilteredTotalAmount() {
    return totalAmount = (widget.filteredInvoices ?? [])
        .fold(0, (sum, items) => sum + (items.quantity * items.price));
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
        updateInvoiceNotifier.select((v) => v.updateInvoiceState.isLoading));
    // final invoiceId = ref.watch(createInvoiceNotifier
    //     .select((v) => v.createInvoiceResponse.invoice?.id));
    return Scaffold(
      appBar: const LaxmiiAppBar(
        title: 'Invoice Details',
        centerTitle: true,
      ),
      body: PageLoader(
        isLoading: isLoading,
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                padding:
                    const EdgeInsets.symmetric(horizontal: 21, vertical: 24),
                decoration: const BoxDecoration(
                    color: AppColors.primaryC4C4C4,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24))),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.customerName,
                          style: context.textTheme.s24w600.copyWith(
                            color: AppColors.black,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Invoices:',
                                  style: context.textTheme.s14w500.copyWith(
                                    color: AppColors.primary5E5E5E,
                                  ),
                                ),
                                const HorizontalSpacing(5),
                                Text(
                                  widget.invoiceNumber,
                                  style: context.textTheme.s14w600.copyWith(
                                      color: AppColors.black, fontSize: 13),
                                ),
                              ],
                            ),
                            const VerticalSpacing(6),
                            Row(
                              children: [
                                Text(
                                  'Due:',
                                  style: context.textTheme.s14w500.copyWith(
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
                      ],
                    ),
                    const VerticalSpacing(47),
                    Table(
                      border: TableBorder.all(
                        color: AppColors.primaryC4C4C4.withValues(alpha: 0.6),
                        width: 1,
                      ),
                      children: [
                        buildRow(
                            ['Product', 'Quantity', 'Price', 'Amount'],
                            context,
                            isHeader: true,
                            Colors.transparent),
                      ],
                    ),
                    widget.items?.isEmpty ?? widget.items == null
                        ? Column(
                            children: List.generate(
                                widget.filteredInvoices?.length ?? 0, (index) {
                              final reportData =
                                  widget.filteredInvoices?[index];
                              final rowDatas = [
                                (reportData?.description ?? ''),
                                '${reportData?.quantity ?? ''}',
                                '${reportData?.price}',
                                '${(reportData?.quantity ?? 0) * (reportData?.price ?? 0)}',
                              ];

                              return Table(
                                border: TableBorder.all(
                                    color: AppColors.primaryC4C4C4
                                        .withValues(alpha: 0.3),
                                    width: 0),
                                children: [
                                  if (rowDatas.isNotEmpty)
                                    buildRow(
                                        rowDatas,
                                        context,
                                        index % 2 == 0
                                            ? AppColors.primaryD9D9D9
                                                .withValues(alpha: 0.7)
                                            : Colors.transparent),
                                ],
                              );
                            }),
                          )
                        : Column(
                            children: List.generate(
                              widget.items?.length ?? 0,
                              (index) {
                                final reportData = widget.items?[index];
                                final rowData = [
                                  (reportData?.description ?? ''),
                                  '${reportData?.quantity ?? ''}',
                                  '${reportData?.price}',
                                  '${(reportData?.quantity ?? 0) * (reportData?.price ?? 0)}',
                                ];

                                return Table(
                                  border: TableBorder.all(
                                      color: AppColors.primaryC4C4C4
                                          .withValues(alpha: 0.3),
                                      width: 0),
                                  children: [
                                    if (rowData.isNotEmpty)
                                      buildRow(
                                          rowData,
                                          context,
                                          index % 2 == 0
                                              ? AppColors.primaryD9D9D9
                                                  .withValues(alpha: 0.7)
                                              : Colors.transparent),
                                  ],
                                );
                              },
                            ),
                          ),
                    const VerticalSpacing(8),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 16),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text(
                    //         'Total(\$)',
                    //         style: context.textTheme.s16w500.copyWith(
                    //           color: AppColors.black,
                    //         ),
                    //       ),
                    //       Text(
                    //         // ignore: unrelated_type_equality_checks
                    //         '\$${(widget.items?.isEmpty ?? widget.items == 0) ? calculateTotalAmount() : calculateFilteredTotalAmount()}',
                    //         style: context.textTheme.s16w500.copyWith(
                    //           color: AppColors.black,
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    const VerticalSpacing(150),
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
                            width: MediaQuery.of(context).size.width * 0.87,
                            child: LaxmiiOutlineSendButton(
                              backgroundColor: Colors.transparent,
                              textColor: AppColors.primary212121,
                              hasBorder: true,
                              icon: 'assets/icons/share.svg',
                              borderColor: AppColors.primary212121,
                              onTap: () {
                                InvoicePdfGenerator().generateAndSharePDF(
                                    customerName: widget.customerName,
                                    dueDate: widget.dueDate,
                                    invoiceNumber: widget.invoiceNumber,
                                    total: calculateTotalAmount(),
                                    filteredInvoiceTotal:
                                        calculateFilteredTotalAmount(),
                                    invoiceItems: widget.items ?? [],
                                    filteredInvoices:
                                        widget.filteredInvoices ?? [],
                                    cells: [
                                      'Product',
                                      'Quantity',
                                      'Price',
                                      'Amount'
                                    ]);
                              },
                              title: 'Share',
                            )),
                      ],
                    ),
                    const VerticalSpacing(20),
                    GestureDetector(
                      onTap: () {
                        context.pushReplacementNamed(Dashboard.routeName);
                      },
                      child: Text(
                        'Go back home',
                        style: context.textTheme.s16w500.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
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
            //  context.popUntil(ModalRoute.withName(InvoiceView.routeName));
            context.pushReplacementNamed(Dashboard.routeName);
          },
          invoiceId: invoiceId,
        );
  }

  TableRow buildRow(List<String> cells, BuildContext context, Color bodyColor,
          {bool isHeader = false}) =>
      TableRow(
        decoration: BoxDecoration(
          color: isHeader ? Colors.transparent : bodyColor,
        ),
        children: cells
            .map((cell) => Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                  child: Text(
                    cell,
                    style: context.textTheme.s14w500.copyWith(
                      color:
                          isHeader ? AppColors.black : AppColors.primary101010,
                    ),
                  ),
                ))
            .toList(),
      );
}
