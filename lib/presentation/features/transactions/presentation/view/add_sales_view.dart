import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/inventory/data/model/get_all_inventory_response.dart';

import 'package:laxmii_app/presentation/features/inventory/presentation/notifier/get_all_inventory_notifier.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/features/transactions/data/model/create_sales_request.dart';
import 'package:laxmii_app/presentation/features/transactions/presentation/notifier/create_sales_notifier.dart';
import 'package:laxmii_app/presentation/features/transactions/presentation/view/transactions_view.dart';
import 'package:laxmii_app/presentation/features/transactions/presentation/widgets/add_sales_textfield.dart';
import 'package:laxmii_app/presentation/general_widgets/app_outline_button.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_app_bar.dart';
import 'package:laxmii_app/presentation/general_widgets/page_loader.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class AddSalesView extends ConsumerStatefulWidget {
  const AddSalesView({super.key});
  static const routeName = '/addSalesView';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddSalesViewState();
}

class _AddSalesViewState extends ConsumerState<AddSalesView> {
  final ValueNotifier<bool> _isAddSalesEnabled = ValueNotifier(false);
  late TextEditingController _amountController;
  late TextEditingController _customerNameController;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref
          .read(getAllInventoryNotifierProvider.notifier)
          .getAllInventory();

      await ref.read(getAccessTokenNotifier.notifier).accessToken();
    });
    _amountController = TextEditingController()..addListener(_validateInput);
    _customerNameController = TextEditingController()
      ..addListener(_validateInput);
    super.initState();
  }

  Inventory? _selectedValue;
  String? _selectedPrice;

  void _validateInput() {
    _isAddSalesEnabled.value = _selectedValue != null &&
        _amountController.text.isNotEmpty &&
        _customerNameController.text.isNotEmpty;
  }

  @override
  void dispose() {
    _amountController.dispose();
    _customerNameController.dispose();
    super.dispose();
  }

  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(), // This will change to light theme.
          child: child!,
        );
      },
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

  @override
  Widget build(BuildContext context) {
    final inventoryList = ref.watch(getAllInventoryNotifierProvider
        .select((v) => v.getAllInventory.data?.inventory));

    // final amount = inventoryList
    //     ?.firstWhere((amount) => amount.productName == _selectedValue?.sellingPrice);

    final isLoading = ref.watch(
        getAccessTokenNotifier.select((v) => v.getAccessTokenState.isLoading));
    return PageLoader(
      isLoading: isLoading,
      child: Scaffold(
        appBar: const LaxmiiAppBar(
          title: 'New Sale',
          centerTitle: true,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Sale',
                  style: context.textTheme.s16w400.copyWith(
                    color: AppColors.primary5E5E5E,
                  ),
                ),
                const VerticalSpacing(10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      width: 1.5,
                      color: AppColors.primary5E5E5E.withValues(alpha: 0.5),
                    ),
                  ),
                  child: DropdownButton<Inventory>(
                    dropdownColor: AppColors.primary101010,
                    value: _selectedValue,
                    padding: EdgeInsets.zero,
                    hint: Text(
                      'Select Inventory',
                      style: context.textTheme.s12w300.copyWith(
                        color: AppColors.primaryC4C4C4.withValues(alpha: 0.4),
                      ),
                    ),
                    underline: const SizedBox.shrink(),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    isExpanded: true,
                    items: inventoryList?.map((Inventory item) {
                      return DropdownMenuItem<Inventory>(
                        value: item,
                        child: Text(
                          '${item.productName}',
                          style: context.textTheme.s12w400.copyWith(
                            color: AppColors.primary5E5E5E,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (Inventory? newValue) {
                      setState(() {
                        _selectedValue = newValue;

                        _amountController.text =
                            newValue?.sellingPrice?.toString() ?? '';
                      });
                    },
                  ),
                ),
                const VerticalSpacing(10),
                AddSalesTextField(
                  hintText: _selectedPrice ?? '',

                  //'Amount',
                  controller: _amountController,
                  isMoney: true,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      // _amountController.text =
                      //     '$amount';
                    });
                  },
                ),
                const VerticalSpacing(10),
                AddSalesTextField(
                  hintText: 'Customer Name',
                  controller: _customerNameController,
                ),
                const VerticalSpacing(10),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        width: 1.5,
                        color: AppColors.primary5E5E5E.withValues(alpha: 0.5),
                      ),
                    ),
                    child: Text(
                      _selectedDate == null
                          ? 'Select Date'
                          : _formatDate(_selectedDate!),
                      style: context.textTheme.s12w400.copyWith(
                        color: AppColors.primary5E5E5E,
                      ),
                    ),
                  ),
                ),
                const VerticalSpacing(24),
                ValueListenableBuilder(
                    valueListenable: _isAddSalesEnabled,
                    builder: (context, r, c) {
                      return LaxmiiOutlineSendButton(
                          //  isEnabled: r,
                          backgroundColor: Colors.transparent,
                          hasBorder: true,
                          borderColor: AppColors.primaryColor,
                          textColor: AppColors.primaryColor,
                          onTap: () {
                            createSales();
                          },
                          title: 'Add Sale');
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
    ref.read(createSalesNotifier.notifier).createSales(
          data: CreateSalesRequest(
            customerName: _customerNameController.text.trim(),
            inventory: _selectedValue!.productName.toString(),
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
