import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/utils/date_picker.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/login/data/model/get_user_details_response.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/features/quotes/data/model/create_quotes_request.dart';
import 'package:laxmii_app/presentation/features/quotes/presentation/notifier/create_quotes_notifier.dart';
import 'package:laxmii_app/presentation/features/quotes/presentation/notifier/get_quote_no_notifier.dart';
import 'package:laxmii_app/presentation/features/quotes/presentation/widgets/add_quotes_section.dart';
import 'package:laxmii_app/presentation/features/quotes/presentation/widgets/generate_quote_pdf.dart';
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
  GetUserDetailsResponse? profileResponse;
  ValueNotifier<List<ProductItem>> quoteItemsNotifier =
      ValueNotifier<List<ProductItem>>([]);
  @override
  void initState() {
    getProfile();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(getQuoteNoNotifierProvider.notifier).getQuoteNo();

      await ref.read(getAccessTokenNotifier.notifier).accessToken();
    });
    super.initState();
  }

  final nameController = TextEditingController();

  DateTime? _quoteStartDate;

  void getProfile() async {
    final profile = await AppDataStorage().getUserDetails();
    setState(() {
      profileResponse = profile;
    });
  }

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
        lastDate: DateTime(2100));

    if (picked != null && picked != _quoteExpiryDate) {
      setState(() {
        _quoteExpiryDate = picked;
      });
    }
  }

  String _formatQuoteExpiryDate(DateTime date) {
    return DateFormat('MMM d, yyyy').format(date);
  }

  // List<ProductItem> items = []; // List of items
  double totalAmount = 0.0; // Total amount
  double taxAmount = 0.0; // Total amount
  double balanceAmount = 0.0; // Total amount

  // void addItem(ProductItem newItem) {
  //   setState(() {
  //     items.add(newItem); // Add the new item
  //     totalAmount +=
  //         newItem.itemQuantity * newItem.itemPrice; // Update the total amount

  //     taxAmount = totalAmount * 0.08;

  //     balanceAmount = totalAmount + taxAmount;
  //   });
  // }

  // void calculateTotalAmount() {
  //   totalAmount = items.fold(
  //       0, (sum, item) => sum + (item.itemQuantity * item.itemPrice));
  // }

  void addItem(ProductItem newItem) {
    // Create a new list with the added item
    List<ProductItem> updatedItems = List.from(quoteItemsNotifier.value)
      ..add(newItem);

    // Update the notifier with the new list
    quoteItemsNotifier.value = updatedItems;

    setState(() {
      // Calculate totals using the updated list
      calculateTotalAmount();
      taxAmount = totalAmount * 0.08;
      balanceAmount = totalAmount + taxAmount;
    });
  }

  void calculateTotalAmount() {
    totalAmount = quoteItemsNotifier.value
        .fold(0, (sum, item) => sum + (item.itemQuantity * item.itemPrice));
  }

  @override
  Widget build(BuildContext context) {
    final quotesNo = ref.watch(getQuoteNoNotifierProvider
        .select((v) => v.getSingleNo.data?.quoteNumber));

    final isLoading = ref.watch(
        createQuotesNotifier.select((v) => v.createQuotesState.isLoading));
    final colorScheme = Theme.of(context);
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
                      : _formatQuoteSelectDate(
                          _quoteStartDate ?? DateTime.now()),
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
                      color: colorScheme.colorScheme.onSurface,
                      fontWeight: FontWeight.w300),
                ),
                const VerticalSpacing(36),
                AddQuotesSection(
                  addItem: addItem,
                  quoteItemsNotifier: quoteItemsNotifier,
                ),
                const VerticalSpacing(50),
                ValueListenableBuilder(
                    valueListenable: quoteItemsNotifier,
                    builder: (context, items, child) {
                      return LaxmiiSendButton(
                        onTap: () {
                          if (items.isEmpty) {
                            context.showError(message: 'Items cannot be empty');
                          } else {
                            generateQuotePdf(
                                quotesNo: '$quotesNo', items: items);
                            createQuote(
                                quotesNo: quotesNo ?? '', productItems: items);
                          }
                        },
                        title: 'Save',
                      );
                    })
              ],
            ),
          )),
        ),
      ),
    );
  }

  List<Item> getItemsForRequest() {
    return convertProductItemsToQuoteItems(quoteItemsNotifier.value);
  }

  void generateQuotePdf(
      {required String quotesNo, required List<ProductItem> items}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => QuotePage(
                  businessName: profileResponse?.profile?.businessName ?? '',
                  businessAddress: profileResponse?.profile?.address ?? '',
                  clientName: nameController.text.trim(),
                  quoteNo: quotesNo,
                  issueDate:
                      _formatQuoteSelectDate(_quoteStartDate ?? DateTime.now()),
                  dueDate: _formatQuoteExpiryDate(
                      _quoteExpiryDate ?? DateTime.now()),
                  items: items,
                )));
  }

  void createQuote(
      {required String quotesNo,
      required List<ProductItem> productItems}) async {
    await ref.read(getAccessTokenNotifier.notifier).accessToken();
    final items = getItemsForRequest();
    ref.read(createQuotesNotifier.notifier).createQuotes(
          data: CreateQuotesRequest(
            customerName: nameController.text.trim(),
            issueDate:
                _formatQuoteSelectDate(_quoteStartDate ?? DateTime.now()),
            expiryDate:
                _formatQuoteExpiryDate(_quoteExpiryDate ?? DateTime.now()),
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
            // context.popUntil(ModalRoute.withName(QuoteView.routeName));
          },
        );
  }
}
