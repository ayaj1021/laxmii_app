import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/extensions/string_extensions.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/inventory/data/model/get_all_inventory_response.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/notifier/get_all_inventory_notifier.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/view/create_inventory_view.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/features/transactions/data/model/create_expense_request.dart';
import 'package:laxmii_app/presentation/features/transactions/presentation/notifier/create_expenses_notifier.dart';
import 'package:laxmii_app/presentation/features/transactions/presentation/view/transactions_view.dart';
import 'package:laxmii_app/presentation/features/transactions/presentation/widgets/add_sales_textfield.dart';
import 'package:laxmii_app/presentation/general_widgets/app_outline_button.dart';
import 'package:laxmii_app/presentation/general_widgets/custom_app_dropdown.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_app_bar.dart';
import 'package:laxmii_app/presentation/general_widgets/page_loader.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class CreateExpenseView extends ConsumerStatefulWidget {
  const CreateExpenseView({super.key});
  static const routeName = '/createExpenseView';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddSalesViewState();
}

class _AddSalesViewState extends ConsumerState<CreateExpenseView> {
  final ValueNotifier<bool> _isAddSalesEnabled = ValueNotifier(false);
  late TextEditingController _amountController;
  late TextEditingController _quantityController;
  late TextEditingController _supplierNameController;

  @override
  void initState() {
    getUserCurrency();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(getAccessTokenNotifier.notifier).accessToken();
      await ref
          .read(getAllInventoryNotifierProvider.notifier)
          .getAllInventory();
    });
    _amountController = TextEditingController()..addListener(_validateInput);
    _quantityController = TextEditingController()..addListener(_validateInput);
    _supplierNameController = TextEditingController()
      ..addListener(_validateInput);
    super.initState();
  }

  String? _selectedValue;
  Inventory? _selectedExpense;
  String? _selectedGeneralExpense;

  void _validateInput() {
    _isAddSalesEnabled.value = _selectedValue != null &&
        _amountController.text.isNotEmpty &&
        _supplierNameController.text.isNotEmpty;
  }

  @override
  void dispose() {
    _amountController.dispose();
    _supplierNameController.dispose();
    super.dispose();
  }

  String userCurrency = '\$';

  void getUserCurrency() async {
    final currency = await AppDataStorage().getUserCurrency();

    setState(() {
      userCurrency = currency ?? '\$';
    });
  }
  // DateTime? _selectedDate;

  // String _formatDate(DateTime date) {
  //   return DateFormat('MMM d, yyyy').format(date);
  // }

  // void _pickDate() async {
  //   final DateTime? picked = await selectDate(
  //     context: context,
  //     selectedDate: _selectedDate,
  //   );

  //   if (picked != null) {
  //     setState(() {
  //       _selectedDate = picked;
  //     });
  //   }
  // }

  final List<String> expensesTypeList = const {
    'Rent',
    'Electricity',
    'Utilities',
    'Advertising',
    'Maintenance',
    'Transportation',
    'Salary',
    'Water',
    'Office Supplies',
    'Fuel',
    'Marketing',
    'Others',
  }.toList();

  final List<String> expenseType = [
    'Inventory',
    'General Expenses',
  ];

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
        getAccessTokenNotifier.select((v) => v.getAccessTokenState.isLoading));
    final inventoryList = ref.watch(getAllInventoryNotifierProvider
        .select((v) => v.getAllInventory.data?.inventory));
    return Scaffold(
      appBar: const LaxmiiAppBar(
        title: 'New Expense',
        centerTitle: true,
      ),
      body: PageLoader(
        isLoading: isLoading,
        child: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Expense',
                  style: context.textTheme.s16w400.copyWith(
                    color: AppColors.primary5E5E5E,
                  ),
                ),
                const VerticalSpacing(10),
                CustomDropdown(
                    value: _selectedValue,
                    hintText: 'Select Expense',
                    items: expenseType.map((item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(
                          item,
                          style: context.textTheme.s12w400.copyWith(
                            color: AppColors.primary5E5E5E,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (v) {
                      setState(() {
                        _amountController.text = '';
                        _selectedValue = v;
                        _quantityController.text = '';
                      });
                    }),
                const VerticalSpacing(20),
                _selectedValue == null
                    ? const SizedBox.shrink()
                    : _selectedValue == expenseType[0]
                        ? Column(
                            children: [
                              CustomDropdown<Inventory>(
                                  value: _selectedExpense,
                                  hintText: 'Select Inventory',
                                  items: inventoryList?.map((item) {
                                    return DropdownMenuItem(
                                      value: item,
                                      child: Text(
                                        (item.productName?.capitalize) ?? '',
                                        style:
                                            context.textTheme.s12w400.copyWith(
                                          color: AppColors.primary5E5E5E,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (Inventory? v) {
                                    setState(() {
                                      _selectedExpense = v;
                                      //  _amountController.text = "${v?.costPrice}";
                                    });
                                  }),
                              if (_selectedValue == expenseType[0])
                                GestureDetector(
                                  onTap: () => context
                                      .pushNamed(CreateInventory.routeName),
                                  child: Column(
                                    children: [
                                      const VerticalSpacing(5),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          'Create new inventory',
                                          style: context.textTheme.s12w400
                                              .copyWith(
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            ],
                          )
                        : CustomDropdown(
                            value: _selectedGeneralExpense,
                            hintText: 'Select Expense',
                            items: expensesTypeList.map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(
                                  item,
                                  style: context.textTheme.s12w400.copyWith(
                                    color: AppColors.primary5E5E5E,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (v) {
                              setState(() {
                                _selectedGeneralExpense = v;
                              });
                            }),
                if (_selectedValue == expenseType[0]) const VerticalSpacing(20),
                if (_selectedValue == expenseType[0])
                  AddSalesTextField(
                    hintText: 'Quantity',
                    controller: _quantityController,
                    keyboardType: TextInputType.number,
                  ),
                const VerticalSpacing(20),
                AddSalesTextField(
                  hintText: 'Total Amount',
                  controller: _amountController,
                  isMoney: true,
                  currency: userCurrency,
                  keyboardType: TextInputType.number,
                ),
                const VerticalSpacing(20),
                AddSalesTextField(
                  hintText: 'Supplier Name',
                  controller: _supplierNameController,
                ),
                // const VerticalSpacing(20),
                // GestureDetector(
                //   onTap: () => _pickDate(),
                //   child: Container(
                //     width: MediaQuery.of(context).size.width,
                //     padding: const EdgeInsets.symmetric(
                //         horizontal: 10, vertical: 15),
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(8),
                //       border: Border.all(
                //         width: 1.5,
                //         color: AppColors.primary5E5E5E.withValues(alpha: 0.5),
                //       ),
                //     ),
                //     child: Text(
                //       _selectedDate == null
                //           ? 'Select Date'
                //           : _formatDate(_selectedDate!),
                //       style: context.textTheme.s12w400.copyWith(
                //         color: AppColors.primary5E5E5E,
                //       ),
                //     ),
                //   ),
                // ),
                const VerticalSpacing(24),
                ValueListenableBuilder(
                    valueListenable: _isAddSalesEnabled,
                    builder: (context, r, c) {
                      return LaxmiiOutlineSendButton(
                          //    isEnabled: r,
                          backgroundColor: Colors.transparent,
                          hasBorder: true,
                          borderColor: AppColors.primaryColor,
                          textColor: AppColors.primaryColor,
                          onTap: () {
                            createSales();
                          },
                          title: 'Add expense');
                    }),
              ],
            ),
          ),
        )),
      ),
    );
  }

  void createSales() async {
    await ref.read(getAccessTokenNotifier.notifier).accessToken();
    ref.read(createExpensesNotifier.notifier).createExpenses(
          data: CreateExpenseRequest(
            expenseType: '${_selectedValue?.toLowerCase()}',
            expense: _selectedValue == expenseType[0]
                ? '${_selectedExpense?.productName}'
                : '$_selectedGeneralExpense',
            supplierName: _supplierNameController.text.trim(),
            quantity: _selectedValue == expenseType[0]
                ? int.parse(_quantityController.text.trim())
                : 0,
            amount: _amountController.text.trim(),
          ),
          onError: (error) {
            context.showError(message: error);
          },
          onSuccess: (message) {
            context.hideOverLay();
            context.showSuccess(message: message);
            context.popAndPushNamed(TransactionsView.routeName);
          },
        );
  }
}
