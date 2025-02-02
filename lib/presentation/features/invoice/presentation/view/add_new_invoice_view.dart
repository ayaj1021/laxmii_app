import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/view/create_inventory_view.dart';
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
  final ValueNotifier<bool> _isAddProductEnabled = ValueNotifier(false);
  late TextEditingController _productNameController;
  late TextEditingController _quantityController;
  late TextEditingController _sellingPriceController;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(getAccessTokenNotifier.notifier).accessToken();
      // await ref
      //     .read(getInvoiceNumberNotifierProvider.notifier)
      //     .getAllInvoices();
    });
    _productNameController = TextEditingController()
      ..addListener(_validateInput);

    _quantityController = TextEditingController()..addListener(_validateInput);
    _sellingPriceController = TextEditingController()
      ..addListener(_validateInput);
    super.initState();
  }

  void _validateInput() {
    _isAddProductEnabled.value = _productNameController.text.isNotEmpty &&
        _quantityController.text.isNotEmpty &&
        _sellingPriceController.text.isNotEmpty;
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _quantityController.dispose();
    _sellingPriceController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LaxmiiAppBar(
        title: 'Add invoice',
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
        child: Column(
          children: [
            UpdateProductsTextField(
              product: _productNameController,
              title: 'Product',
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
                valueListenable: _isAddProductEnabled,
                builder: (context, r, c) {
                  return LaxmiiOutlineSendButton(
                    isEnabled: r,
                    onTap: () {},

                    //_createInventory(),
                    title: 'Add Product',
                  );
                }),
          ],
        ),
      )),
    );
  }
}
