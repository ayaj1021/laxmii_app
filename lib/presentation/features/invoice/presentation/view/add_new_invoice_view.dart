import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/inventory/data/model/get_all_inventory_response.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/notifier/get_all_inventory_notifier.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/widgets/update_products_textfield.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/notifier/add_product_notifier.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/general_widgets/app_outline_button.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_app_bar.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class AddNewInvoiceView extends ConsumerStatefulWidget {
  const AddNewInvoiceView({super.key});
  static const routeName = '/addNewInvoiceView';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddNewInvoiceViewState();
}

class _AddNewInvoiceViewState extends ConsumerState<AddNewInvoiceView> {
  final ValueNotifier<bool> isAddProductEnabled = ValueNotifier(false);

  late TextEditingController _quantityController;
  late TextEditingController _sellingPriceController;
  Inventory? _selectedProduct;
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
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _sellingPriceController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inventoryList = ref
        .watch(getAllInventoryNotifierProvider
            .select((v) => v.getAllInventory.data?.inventory ?? []))
        .toList();
    return Scaffold(
      appBar: const LaxmiiAppBar(
        title: 'Add invoice',
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                    });
                  },
                ),
              ),
              const VerticalSpacing(15),
              UpdateProductsTextField(
                product: _quantityController,
                title: 'Quantity',
              ),
              const VerticalSpacing(15),
              UpdateProductsTextField(
                isMoney: true,
                product: _sellingPriceController,
                title: 'Selling Price',
              ),
              const VerticalSpacing(150),
              ValueListenableBuilder(
                  valueListenable: isAddProductEnabled,
                  builder: (context, r, c) {
                    return LaxmiiOutlineSendButton(
                      isEnabled: r,
                      onTap: () {
                        final item = ProductItems(
                          itemName: '${_selectedProduct?.productName}',
                          itemPrice:
                              double.parse(_sellingPriceController.text.trim()),
                          itemQuantity:
                              int.parse(_quantityController.text.trim()),
                        );

                        Navigator.pop(context, item);
                      },
                      title: 'Add Product',
                    );
                  }),
            ],
          ),
        ),
      )),
    );
  }
}
