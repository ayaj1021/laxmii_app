import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/notifier/add_product_notifier.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/notifier/get_invoice_number_notifier.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/view/all_inventory_list_view.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/view/invoice_details_view.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/widgets/invoice_new_product_widget.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/widgets/invoice_widget.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/general_widgets/app_button.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_app_bar.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class CreateIncomeOneView extends ConsumerStatefulWidget {
  const CreateIncomeOneView({super.key});
  static const routeName = '/createInvoiceView';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddSalesViewState();
}

class _AddSalesViewState extends ConsumerState<CreateIncomeOneView> {
  final ValueNotifier<bool> _isAddSalesEnabled = ValueNotifier(false);
  late TextEditingController _amountController;
  late TextEditingController _customerNameController;
  ValueNotifier<List<ProductItems>> itemsNotifier =
      ValueNotifier<List<ProductItems>>([]);

  @override
  void initState() {
    getUserCurrency();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(getAccessTokenNotifier.notifier).accessToken();
      ref.read(getInvoiceNumberNotifierProvider.notifier).getAllInvoices();
    });
    _amountController = TextEditingController()..addListener(_validateInput);

    _customerNameController = TextEditingController()
      ..addListener(_validateInput);
    super.initState();
  }

  void _validateInput() {
    _isAddSalesEnabled.value = _customerNameController.text.isNotEmpty;
  }

  List<ProductItems> items = [];

  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMM d, yyyy').format(date);
  }

  DateTime? _selectedDueDate;

  Future<void> _selectDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDate: _selectedDueDate,
    );

    if (picked != null && picked != _selectedDueDate) {
      setState(() {
        _selectedDueDate = picked;
      });
    }
  }

  String _formatDueDate(DateTime date) {
    return DateFormat('MMM d, yyyy').format(date);
  }

  // List of items
  double totalAmount = 0; // Total amount
  double taxAmount = 0.0; // Total amount
  double balanceAmount = 0.0; // Total amount

  void addItem(ProductItems newItem) {
    setState(() {
      items.add(newItem); // Add the new item
      totalAmount +=
          newItem.itemQuantity * newItem.itemPrice; // Update the total amount

      taxAmount = totalAmount * 0.0;

      balanceAmount = totalAmount + taxAmount;
    });
  }

  void removeItem(ProductItems item) {
    setState(() {
      items.remove(item); // Add the new item
      totalAmount = 0;
      // item.itemQuantity - item.itemPrice; // Update the total amount
    });
  }

  double calculateTotalAmount() {
    return totalAmount = items.fold(
        0,
        (sum, item) =>
            sum +
            ((item.itemQuantity == 0 ? 1 : item.itemQuantity) *
                item.itemPrice));
  }

  double balanceDue() {
    return balanceAmount =
        items.fold(0, (sum, item) => sum + (totalAmount + taxAmount));
  }

  double taxAmounts() {
    return taxAmount = items.fold(0, (sum, item) => sum + (totalAmount * 0));
  }

  @override
  void dispose() {
    _amountController.dispose();
    _customerNameController.dispose();
    //  itemsNotifier.dispose();
    itemsNotifier.dispose();

    super.dispose();
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
    final invoiceNumber = ref.watch(getInvoiceNumberNotifierProvider
        .select((v) => v.getInvoiceNumber.data?.invoiceNumber ?? ''));
    final colorScheme = Theme.of(context);

    return Scaffold(
      appBar: const LaxmiiAppBar(
        title: 'New income',
        centerTitle: true,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Text(
                'Step 1 of 2',
                style: context.textTheme.s12w500.copyWith(
                  color: colorScheme.colorScheme.onSurface,
                ),
              ),
              const VerticalSpacing(10),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 17),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: colorScheme.cardColor),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 11.5),
                      child: TextField(
                        style: context.textTheme.s15w400.copyWith(
                          color: colorScheme.colorScheme.onSurface,
                        ),
                        controller: _customerNameController,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          hintText: 'Customer (required)',
                          hintStyle: context.textTheme.s14w400.copyWith(
                            color:
                                AppColors.primary5E5E5E.withValues(alpha: 0.5),
                          ),
                          border: InputBorder.none,
                          fillColor: Colors.transparent,
                          filled: false,
                          focusColor: Colors.transparent,
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      color: AppColors.primary3B3522,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          Text(
                            'Invoice no.',
                            style: context.textTheme.s14w400.copyWith(
                              color: AppColors.primary5E5E5E,
                            ),
                          ),
                          const HorizontalSpacing(12),
                          Text(
                            invoiceNumber,
                            style: context.textTheme.s12w400.copyWith(
                              color: colorScheme.colorScheme.onSurface,
                            ),
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      color: AppColors.primary3B3522,
                    ),
                    const VerticalSpacing(10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          Text(
                            'Date',
                            style: context.textTheme.s14w400.copyWith(
                              color: AppColors.primary5E5E5E,
                            ),
                          ),
                          const HorizontalSpacing(45),
                          GestureDetector(
                            onTap: () => _selectDate(context),
                            child: Text(
                              _selectedDate == null
                                  ? _formatDate(DateTime.now())
                                  : _formatDate(_selectedDate!),
                              style: context.textTheme.s12w400.copyWith(
                                color: colorScheme.colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const VerticalSpacing(10),
                    const Divider(
                      color: AppColors.primary3B3522,
                    ),
                    const VerticalSpacing(10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          Text(
                            'Due on',
                            style: context.textTheme.s14w400.copyWith(
                              color: AppColors.primary5E5E5E,
                            ),
                          ),
                          const HorizontalSpacing(35),
                          GestureDetector(
                            onTap: () => _selectDueDate(context),
                            child: Text(
                              _selectedDueDate == null
                                  ? _formatDate(DateTime.now())
                                  : _formatDueDate(_selectedDueDate!),
                              style: context.textTheme.s12w400.copyWith(
                                color: colorScheme.colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const VerticalSpacing(16),
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 17),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: colorScheme.cardColor),
                child: Column(
                  children: [
                    ValueListenableBuilder(
                        valueListenable: itemsNotifier,
                        builder: (context, items, child) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.23,
                            child: ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: items.length,
                                itemBuilder: (_, index) {
                                  final item = items[index];
                                  final price = (item.itemQuantity == 0
                                          ? 1
                                          : item.itemQuantity) *
                                      item.itemPrice;
                                  return Column(
                                    children: [
                                      InvoiceNewProductWidget(
                                        currency: userCurrency,
                                        itemName: item.itemName,
                                        itemQuantity: item.itemQuantity,
                                        itemPrice: item.itemPrice,
                                        totalItemPrice: double.parse(
                                            price.toStringAsFixed(2)),
                                        onItemDelete: () {
                                          setState(() {
                                            items.remove(item);
                                          });
                                          removeItem(item);
                                        },
                                      ),
                                      const VerticalSpacing(5),
                                      if (index < items.length - 1)
                                        const Divider(
                                          color: AppColors.primary3B3522,
                                        )
                                    ],
                                  );
                                }),
                          );
                        }),
                    InkWell(
                      onTap: () async {
                        // final item = await context
                        //     .pushNamed(AddNewInvoiceView.routeName);
                        // if (item != null) {
                        //   itemsNotifier.value = [...itemsNotifier.value, item];
                        //   addItem(item);
                        // }

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => AllInventoryListView(
                                      addItem: addItem,
                                      itemsNotifier: itemsNotifier,
                                    )));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.add_circle,
                            color: AppColors.primaryColor,
                          ),
                          const HorizontalSpacing(5),
                          Text(
                            'Add product or service',
                            style: context.textTheme.s14w500.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const VerticalSpacing(24),
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
                      subTitle: '$userCurrency${calculateTotalAmount()}',
                      //'\$${totalAmount.toStringAsFixed(2)}',
                    ),
                    const VerticalSpacing(30),
                    ValueListenableBuilder(
                        valueListenable: _isAddSalesEnabled,
                        builder: (context, r, c) {
                          return LaxmiiSendButton(
                            isEnabled: r,
                            textColor: colorScheme.colorScheme.onSurface,
                            onTap: () {
                              if (itemsNotifier.value.isEmpty) {
                                context.showError(message: 'Add a product');
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ValueListenableBuilder(
                                      valueListenable: itemsNotifier,
                                      builder: (context, item, _) {
                                        final items =
                                            convertProductItemsToItems(item);
                                        return InvoiceDetailsView(
                                          customerName: _customerNameController
                                              .text
                                              .trim(),
                                          issueDate: _formatDate(
                                              _selectedDate ?? DateTime.now()),
                                          dueDate: _formatDueDate(
                                              _selectedDueDate ??
                                                  DateTime.now()),
                                          invoiceNumber: invoiceNumber,
                                          items: items,
                                          totalAmount: balanceAmount,
                                        );
                                      },
                                    ),
                                  ),
                                );
                              }
                            },
                            title: 'Continue',
                          );
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
