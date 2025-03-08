import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/invoice/data/model/create_invoice_request.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/notifier/create_invoice_notifier.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/view/confirm_invoice_view.dart';
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
  final List<CreateInvoiceItem> items;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InvoiceDetailsViewState();
}

class _InvoiceDetailsViewState extends ConsumerState<InvoiceDetailsView> {
  final screenshotController = ScreenshotController();

  double totalAmount = 0.0;
  double calculateTotalAmount() {
    return totalAmount =
        widget.items.fold(0, (sum, item) => sum + (item.quantity * item.price));
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
        createInvoiceNotifier.select((v) => v.createInvoiceState.isLoading));

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
                child: SingleChildScrollView(
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
                      widget.items.isEmpty
                          ? Center(
                              child: Text(
                              'No reports available',
                              style: context.textTheme.s11w600
                                  .copyWith(color: AppColors.primaryC4C4C4),
                            ))
                          : Column(
                              children:
                                  List.generate(widget.items.length, (index) {
                                final reportData = widget.items[index];
                                final rowData = [
                                  (reportData.description),
                                  '${reportData.quantity}',
                                  '${reportData.price}',
                                  '${reportData.quantity * reportData.price}',
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
                              }),
                            ),
                      const VerticalSpacing(8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total(\$)',
                              style: context.textTheme.s16w500.copyWith(
                                color: AppColors.black,
                              ),
                            ),
                            Text(
                              '\$${calculateTotalAmount()}',
                              style: context.textTheme.s16w500.copyWith(
                                color: AppColors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                      const VerticalSpacing(200),
                      LaxmiiSendButton(
                        onTap: () {
                          createInvoice();
                        },

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
          onSuccess: (message, id, status) {
            context.hideOverLay();
            context.showSuccess(message: message);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ConfirmInvoiceView(
                  customerName: widget.customerName,
                  issueDate: widget.issueDate,
                  dueDate: widget.dueDate,
                  invoiceNumber: widget.invoiceNumber,
                  invoiceId: id,
                  invoiceStatus: status,
                  items: widget.items,
                ),
              ),
            );
            // context.popAndPushNamed(InvoiceView.routeName);
          },
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
