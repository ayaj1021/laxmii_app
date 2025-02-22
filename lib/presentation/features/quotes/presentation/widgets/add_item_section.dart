import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/inventory/data/model/get_all_inventory_response.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/notifier/get_all_inventory_notifier.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/features/quotes/data/model/create_quotes_request.dart';
import 'package:laxmii_app/presentation/features/quotes/presentation/widgets/add_quote_item_text_field.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_app_bar.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class AddItemSection extends ConsumerStatefulWidget {
  const AddItemSection({super.key});
  static const String routeName = '/addItemSection';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddItemSectionState();
}

class _AddItemSectionState extends ConsumerState<AddItemSection> {
  final ValueNotifier<bool> isAddProductEnabled = ValueNotifier(false);
  final ValueNotifier<int> _calculateProduct = ValueNotifier<int>(0);

  late TextEditingController _quantityController;
  late TextEditingController _sellingPriceController;
  Inventory? _selectedProduct;
  Inventory? _selectedProductPrice;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(getAccessTokenNotifier.notifier).accessToken();
      await ref
          .read(getAllInventoryNotifierProvider.notifier)
          .getAllInventory();
    });

    _quantityController = TextEditingController()..addListener(_validateInput);
    _sellingPriceController = TextEditingController()
      ..addListener(_validateInput);
    super.initState();
  }

  void _validateInput() {
    isAddProductEnabled.value = _selectedProduct != null &&
        _quantityController.text.isNotEmpty &&
        _sellingPriceController.text.isNotEmpty;
    _calculateProduct.value = calculateTotal();
  }

  int calculateTotal() {
    try {
      int quantity = int.parse(_quantityController.text);
      int sellingPrice = int.parse(_sellingPriceController.text);
      return quantity * sellingPrice;
    } catch (e) {
      return 0; // Return 0 if input is invalid
    }
  }

  @override
  Widget build(BuildContext context) {
    final inventoryList = ref
        .watch(getAllInventoryNotifierProvider
            .select((v) => v.getAllInventory.data?.inventory ?? []))
        .toList();
    return Scaffold(
      appBar: const LaxmiiAppBar(
        title: 'Add Quote',
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primary101010),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Item',
                    style: context.textTheme.s10w300.copyWith(
                      color: AppColors.primary5E5E5E,
                    ),
                  ),
                  DropdownButton<Inventory>(
                    dropdownColor: AppColors.primary101010,
                    value: _selectedProduct,
                    padding: EdgeInsets.zero,
                    hint: Text(
                      'Select Product',
                      style: context.textTheme.s12w300.copyWith(
                        color: AppColors.primaryC4C4C4.withValues(alpha: 0.4),
                      ),
                    ),
                    underline: const SizedBox.shrink(),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    isExpanded: true,
                    items: inventoryList.map((Inventory item) {
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
                        _selectedProduct = newValue;
                        // _selectedProductPrice =
                        //     (newValue?.sellingPrice ?? 0) as Inventory?;
                      });
                    },
                  ),
                ],
              ),
            ),
            const VerticalSpacing(20),
            AddQuoteItemTextField(
              controller: _quantityController,
              title: 'Quantity',
              onChanged: (v) {
                _validateInput();
              },
              hintText: 'Enter item quantity',
            ),
            const VerticalSpacing(20),
            AddQuoteItemTextField(
              controller: _sellingPriceController,
              title: 'Price',
              isMoney: true,
              onChanged: (v) {
                _validateInput();
              },
              hintText: 'Enter item price',
            ),
            const VerticalSpacing(20),
            Divider(
              color: AppColors.primary5E5E5E.withValues(alpha: 0.5),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Amount',
                    style: context.textTheme.s12w300.copyWith(
                      color: AppColors.primaryC4C4C4.withValues(alpha: 0.4),
                      fontSize: 14,
                    ),
                  ),
                  ValueListenableBuilder<int>(
                    valueListenable: _calculateProduct,
                    builder: (context, totalAmount, child) {
                      return Text(
                        '\$$totalAmount',
                        style: context.textTheme.s12w300.copyWith(
                          color: AppColors.primaryC4C4C4.withValues(alpha: 0.4),
                          fontSize: 14,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const VerticalSpacing(5),
            Divider(
              color: AppColors.primary5E5E5E.withValues(alpha: 0.5),
            ),
            const VerticalSpacing(29),
            GestureDetector(
              onTap: () {
                if (_selectedProduct == null ||
                    _sellingPriceController.text.isEmpty ||
                    _quantityController.text.isEmpty) {
                  context.showError(message: 'All fields are required');
                } else {
                  final item = ProductItem(
                    itemName: '${_selectedProduct?.productName}',
                    itemPrice: int.parse(_sellingPriceController.text.trim()),
                    itemQuantity: int.parse(_quantityController.text.trim()),
                  );

                  Navigator.pop(context, item);
                }
              },
              child: Text(
                'Add Item',
                style: context.textTheme.s14w500.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
