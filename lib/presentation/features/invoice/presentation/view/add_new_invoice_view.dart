import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/extensions/string_extensions.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/notifier/get_all_inventory_notifier.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/widgets/update_products_textfield.dart';
import 'package:laxmii_app/presentation/features/invoice/data/model/get_invoice_by_name_request.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/notifier/add_product_notifier.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/notifier/get_invoice_by_name_notifier.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/general_widgets/app_outline_button.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_app_bar.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class AddNewInvoiceView extends ConsumerStatefulWidget {
  const AddNewInvoiceView({
    super.key,
    required this.item,
    required this.quantity,
    required this.sellingPrice,
    required this.serviceType,
  });
  final String item;

  final String serviceType;

  final int quantity;
  final num sellingPrice;
  static const routeName = '/addNewInvoiceView';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddNewInvoiceViewState();
}

class _AddNewInvoiceViewState extends ConsumerState<AddNewInvoiceView> {
  final ValueNotifier<bool> isAddProductEnabled = ValueNotifier(false);

  final _quantityController = TextEditingController();
  late TextEditingController _sellingPriceController;

  @override
  void initState() {
    getUserCurrency();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(getAccessTokenNotifier.notifier).accessToken();

      if (!mounted) return;
      await ref
          .read(getAllInventoryNotifierProvider.notifier)
          .getAllInventory();
    });

    //_quantityController = TextEditingController()..addListener(_validateInput);
    _sellingPriceController = widget.sellingPrice == 0
        ? TextEditingController()
        : TextEditingController(text: widget.sellingPrice.toString())
      ..addListener(_validateInput);

    super.initState();
  }

  void _validateInput() {
    isAddProductEnabled.value = // _quantityController.text.isNotEmpty &&
        _sellingPriceController.text.isNotEmpty;
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _sellingPriceController.dispose();

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
    final colorScheme = Theme.of(context);
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
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    width: 1.5,
                    color: AppColors.primary5E5E5E.withValues(alpha: 0.5),
                  ),
                ),
                child: Text(
                  widget.item.capitalize,
                  style: context.textTheme.s14w500.copyWith(
                    color: colorScheme.colorScheme.onSurface,
                  ),
                ),
              ),
              if (widget.serviceType == 'product')
                Column(
                  children: [
                    const VerticalSpacing(15),
                    UpdateProductsTextField(
                      product: _quantityController,
                      title: 'Quantity  ${widget.quantity}',
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              const VerticalSpacing(15),
              UpdateProductsTextField(
                isMoney: true,
                currency: userCurrency,
                product: _sellingPriceController,
                title:
                    widget.serviceType == 'product' ? 'Selling Price' : 'Price',
                keyboardType: TextInputType.number,
              ),
              const VerticalSpacing(150),
              ValueListenableBuilder(
                  valueListenable: isAddProductEnabled,
                  builder: (context, r, c) {
                    return LaxmiiOutlineSendButton(
                      isEnabled: r,
                      onTap: () {
                        if (_quantityController.text.isEmpty) {
                          final item = ProductItems(
                            itemName: widget.item,
                            itemPrice: double.parse(
                                _sellingPriceController.text.trim()),
                            itemQuantity: int.parse('0'),
                          );

                          Navigator.pop(context, item);
                          context.showSuccess(message: 'Product added');
                          // return;
                        } else if (int.parse(_quantityController.text) >
                            (widget.quantity)) {
                          context.showError(
                              message:
                                  'Quantity cannot be higher than existing quantity');
                        } else {
                          final item = ProductItems(
                            itemName: widget.item,
                            itemPrice: double.parse(
                                _sellingPriceController.text.trim()),
                            itemQuantity:
                                int.parse(_quantityController.text.trim()),
                          );

                          Navigator.pop(context, item);
                          context.showSuccess(message: 'Product added');
                        }
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

  void getInvoiceDetails({required String productName}) async {
    await ref.read(getAccessTokenNotifier.notifier).accessToken();
    ref.read(getInvoiceByNameNotifierProvider.notifier).getInvoiceByName(
          request: GetInvoiceByNameRequest(productName: productName),
        );
  }
}
