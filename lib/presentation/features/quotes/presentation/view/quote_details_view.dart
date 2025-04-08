import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/extensions/string_extensions.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/date_format.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/widgets/invoice_new_product_widget.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/widgets/invoice_widget.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/features/quotes/data/model/create_quotes_request.dart';
import 'package:laxmii_app/presentation/features/quotes/presentation/notifier/delete_quotes_notifier.dart';
import 'package:laxmii_app/presentation/features/quotes/presentation/notifier/get_all_quotes_notifier.dart';
import 'package:laxmii_app/presentation/features/quotes/presentation/notifier/get_single_quote_notifier.dart';
import 'package:laxmii_app/presentation/features/quotes/presentation/view/quote_view.dart';
import 'package:laxmii_app/presentation/features/quotes/presentation/widgets/generate_quote_pdf.dart';
import 'package:laxmii_app/presentation/general_widgets/app_button.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_app_bar.dart';
import 'package:laxmii_app/presentation/general_widgets/page_loader.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class QuoteDetailsView extends ConsumerStatefulWidget {
  const QuoteDetailsView({
    super.key,
    required this.quoteId,
  });
  final String quoteId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _QuoteDetailsViewState();
}

class _QuoteDetailsViewState extends ConsumerState<QuoteDetailsView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref
          .read(getSingleQuoteNotifierProvider.notifier)
          .getSingleQuote(quoteId: widget.quoteId);

      await ref.read(getAccessTokenNotifier.notifier).accessToken();

      calculateAmounts();
    });
    super.initState();
  }

  num totalAmount = 0.0; // Total amount
  // num taxAmount = 0.0; // Total amount
  // num balanceAmount = 0.0; // Total amount

  void calculateAmounts() {
    final quoteDetails = ref.read(getSingleQuoteNotifierProvider
        .select((v) => v.getSingleQuote.data?.quote));

    if (quoteDetails?.items != null) {
      // Calculate total amount
      totalAmount = quoteDetails!.items!
          .map((item) => item.quantity! * (item.price ?? 0))
          .reduce((a, b) => a + b);

      // Calculate 8% tax
      //  taxAmount = totalAmount * 0.08;

      // Calculate balance due
      //  balanceAmount = totalAmount + taxAmount;

      // Update the UI
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final quoteDetails = ref.watch(getSingleQuoteNotifierProvider
        .select((v) => v.getSingleQuote.data?.quote));

    final isLoading = ref.watch(
        getSingleQuoteNotifierProvider.select((v) => v.loadState.isLoading));

    final isDeleteQuoteLoading =
        ref.watch(deleteQuoteNotifier.select((v) => v.loadState.isLoading));
    final colorScheme = Theme.of(context);

    return Scaffold(
      appBar: LaxmiiAppBar(
        title: 'Quote Details',
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: GestureDetector(
              onTap: () {
                _deleteQuote();
              },
              child: const Icon(
                Icons.delete_outline,
                color: AppColors.red,
              ),
            ),
          )
        ],
      ),
      body: PageLoader(
        isLoading: isDeleteQuoteLoading,
        child: PageLoader(
          isLoading: isLoading,
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: colorScheme.cardColor,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset('assets/icons/user.svg'),
                          const HorizontalSpacing(22),
                          Text(
                            (quoteDetails?.customerName?.capitalize) ?? '',
                            style: context.textTheme.s14w400.copyWith(
                                color: colorScheme.colorScheme.onSurface,
                                fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                      const VerticalSpacing(10),
                      Row(
                        children: [
                          SvgPicture.asset('assets/icons/calendar.svg'),
                          const HorizontalSpacing(22),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                formatDateTimeYear(
                                    '${quoteDetails?.issueDate}'),
                                style: context.textTheme.s14w400.copyWith(
                                    color: colorScheme.colorScheme.onSurface,
                                    fontWeight: FontWeight.w300),
                              ),
                              const VerticalSpacing(10),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.70,
                                decoration: const BoxDecoration(
                                    border: Border(
                                  bottom: BorderSide(
                                      color: AppColors.primary3B3522, width: 1),
                                )),
                              )
                            ],
                          )
                        ],
                      ),
                      const VerticalSpacing(10),
                      Row(
                        children: [
                          SvgPicture.asset('assets/icons/timer.svg'),
                          const HorizontalSpacing(22),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                formatDateTimeYear(
                                    '${quoteDetails?.expiryDate}'),
                                style: context.textTheme.s14w400.copyWith(
                                    color: colorScheme.colorScheme.onSurface,
                                    fontWeight: FontWeight.w300),
                              ),
                              const VerticalSpacing(10),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.70,
                                decoration: const BoxDecoration(
                                    border: Border(
                                  bottom: BorderSide(
                                      color: AppColors.primary3B3522, width: 1),
                                )),
                              ),
                              const VerticalSpacing(15),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const VerticalSpacing(44),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: colorScheme.cardColor,
                  ),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: ListView.builder(
                        itemCount: quoteDetails?.items?.length,
                        itemBuilder: (_, index) {
                          final data = quoteDetails?.items?[index];
                          return InvoiceNewProductWidget(
                            itemName: data?.description?.capitalize ?? '',
                            itemQuantity: data?.quantity ?? 0,
                            itemPrice: data?.price?.toDouble() ?? 0,
                            totalItemPrice: data?.price?.toDouble() ?? 0,
                          );
                        }),
                  ),
                ),
                const VerticalSpacing(30),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16)),
                      color: colorScheme.cardColor),
                  child: Column(
                    children: [
                      InvoiceWidget(
                        title: 'Total',
                        subTitle: '\$${totalAmount.toStringAsFixed(2)}',
                      ),
                      const VerticalSpacing(14),
                      // InvoiceWidget(
                      //   title: 'Tax 8%',
                      //   subTitle: '\$${taxAmount.toStringAsFixed(2)}',
                      // ),
                      // const VerticalSpacing(14),
                      // InvoiceWidget(
                      //   title: 'Balance due',
                      //   subTitle: '\$${balanceAmount.toStringAsFixed(2)}',
                      // ),
                      const VerticalSpacing(19),
                      LaxmiiSendButton(
                          onTap: () {
                            generateQuotePdf(
                              clientName:
                                  quoteDetails?.customerName?.capitalize ?? '',
                              quotesNo: quoteDetails?.quoteNumber ?? '',
                              quoteIssueDate: formatDateTimeYear(
                                  '${quoteDetails?.issueDate}'),
                              quoteDueDate: formatDateTimeYear(
                                  '${quoteDetails?.expiryDate}'),
                              items: quoteDetails!.items!
                                  .map((e) => ProductItem.fromSingleQuote(e))
                                  .toList(),

                              //quoteDetails?.items as List<ProductItem>,
                            );
                          },
                          title: 'Generate Quote')
                    ],
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }

  void generateQuotePdf(
      {required String quotesNo,
      required String clientName,
      required String quoteIssueDate,
      required String quoteDueDate,
      required List<ProductItem> items}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => QuotePage(
                  clientName: clientName,
                  quoteNo: quotesNo,
                  issueDate: quoteIssueDate,
                  dueDate: quoteDueDate,
                  items: items,
                )));
  }

  void _deleteQuote() async {
    await ref.read(getAccessTokenNotifier.notifier).accessToken();
    ref.read(deleteQuoteNotifier.notifier).deleteQuote(
        onError: (error) {
          context.showError(message: error);
        },
        onSuccess: (message) {
          context.showSuccess(message: message);
          ref.read(getAllQuotesNotifierProvider.notifier).getAllQuotes();

          context.popUntil(ModalRoute.withName(QuoteView.routeName));
        },
        quoteId: widget.quoteId);
  }
}
