import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/date_picker.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/widgets/invoice_widget.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/features/quotes/data/model/create_quotes_request.dart';
import 'package:laxmii_app/presentation/features/quotes/presentation/notifier/create_quotes_notifier.dart';
import 'package:laxmii_app/presentation/features/quotes/presentation/notifier/get_quote_no_notifier.dart';
import 'package:laxmii_app/presentation/features/quotes/presentation/widgets/add_quotes_section.dart';
import 'package:laxmii_app/presentation/features/quotes/presentation/widgets/quotes_info_input_section.dart';
import 'package:laxmii_app/presentation/general_widgets/app_button.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_app_bar.dart';
import 'package:laxmii_app/presentation/general_widgets/page_loader.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class CreateQuoteView extends ConsumerStatefulWidget {
  const CreateQuoteView({super.key});
  static const String routeName = '/createQuote';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateQuoteViewState();
}

class _CreateQuoteViewState extends ConsumerState<CreateQuoteView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(getQuoteNoNotifierProvider.notifier).getQuoteNo();

      await ref.read(getAccessTokenNotifier.notifier).accessToken();
    });
    super.initState();
  }

  final nameController = TextEditingController();

  DateTime? _quoteStartDate;

  Future<void> _quoteStartSelectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _quoteStartDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _quoteStartDate) {
      setState(() {
        _quoteStartDate = picked;
      });
    }
  }

  String _formatQuoteSelectDate(DateTime date) {
    return DateFormat('MMM d, yyyy').format(date);
  }

  DateTime? _quoteExpiryDate;

  Future<void> _quoteExpirySelectDate(BuildContext context) async {
    final DateTime? picked = await selectDate(
      context: context,
      selectedDate: _quoteExpiryDate,
    );

    if (picked != null && picked != _quoteExpiryDate) {
      setState(() {
        _quoteExpiryDate = picked;
      });
    }
  }

  String _formatQuoteExpiryDate(DateTime date) {
    return DateFormat('MMM d, yyyy').format(date);
  }

  List<ProductItem> items = []; // List of items
  double totalAmount = 0.0; // Total amount
  double taxAmount = 0.0; // Total amount
  double balanceAmount = 0.0; // Total amount

  void addItem(ProductItem newItem) {
    setState(() {
      items.add(newItem); // Add the new item
      totalAmount +=
          newItem.itemQuantity * newItem.itemPrice; // Update the total amount

      taxAmount = totalAmount * 0.08;

      balanceAmount = totalAmount + taxAmount;
    });
  }

  void calculateTotalAmount() {
    totalAmount = items.fold(
        0, (sum, item) => sum + (item.itemQuantity * item.itemPrice));
  }

  @override
  Widget build(BuildContext context) {
    final quotesNo = ref.watch(getQuoteNoNotifierProvider
        .select((v) => v.getSingleNo.data?.quoteNumber));

    final isLoading = ref.watch(
        createQuotesNotifier.select((v) => v.createQuotesState.isLoading));
    return Scaffold(
      appBar: const LaxmiiAppBar(
        centerTitle: true,
        title: 'Quote',
      ),
      body: PageLoader(
        isLoading: isLoading,
        child: SingleChildScrollView(
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 34),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                QoutesInfoInputSection(
                  nameController: nameController,
                  quoteStartDate: _quoteStartDate == null
                      ? 'Dated today'
                      : _formatQuoteSelectDate(_quoteStartDate!),
                  quoteExpiryDate: _quoteStartDate == null
                      ? 'When does it expire?'
                      : _formatQuoteExpiryDate(
                          _quoteExpiryDate ?? DateTime.now()),
                  onQuoteStartDateSelected: () =>
                      _quoteStartSelectDate(context),
                  onQuoteExpiryDateSelected: () =>
                      _quoteExpirySelectDate(context),
                ),
                const VerticalSpacing(17),
                Text(
                  'Items',
                  style: context.textTheme.s14w400.copyWith(
                      color: AppColors.primaryC4C4C4,
                      fontWeight: FontWeight.w300),
                ),
                const VerticalSpacing(36),
                AddQuotesSection(
                  addItem: addItem,
                ),
                const VerticalSpacing(58),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.primary101010),
                  child: Column(
                    children: [
                      InvoiceWidget(
                        title: 'Subtotal',
                        subTitle: '\$${totalAmount.toStringAsFixed(2)}',
                      ),
                      const VerticalSpacing(14),
                      InvoiceWidget(
                        title: 'Tax 8%',
                        subTitle: '\$${taxAmount.toStringAsFixed(2)}',
                      ),
                      const VerticalSpacing(14),
                      InvoiceWidget(
                        title: 'Balance due',
                        subTitle: '\$${balanceAmount.toStringAsFixed(2)}',
                      ),
                    ],
                  ),
                ),
                const VerticalSpacing(50),
                LaxmiiSendButton(
                  onTap: () {
                    items.isEmpty
                        ? context.showError(message: 'Items cannot be empty')
                        : createQuote(
                            quotesNo: quotesNo ?? '', productItems: items);
                  },
                  title: 'Save',
                )
              ],
            ),
          )),
        ),
      ),
    );
  }

  void createQuote(
      {required String quotesNo,
      required List<ProductItem> productItems}) async {
    await ref.read(getAccessTokenNotifier.notifier).accessToken();
    final items = convertProductItemsToQuoteItems(productItems);
    ref.read(createQuotesNotifier.notifier).createQuotes(
          data: CreateQuotesRequest(
            customerName: nameController.text.trim(),
            issueDate: _formatQuoteSelectDate(_quoteStartDate!),
            expiryDate: _formatQuoteExpiryDate(_quoteExpiryDate!),
            quoteNumber: quotesNo,
            items: items,
            totalAmount: balanceAmount.toInt(),
          ),
          onError: (error) {
            context.showError(message: error);
          },
          onSuccess: (message) {
            context.hideOverLay();
            context.showSuccess(message: message);
            //  context.popAndPushNamed(InvoiceView.routeName);
          },
        );
  }
}
