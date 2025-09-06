import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/extensions/string_extensions.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/inventory/data/model/update_inventory_request.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/notifier/delete_inventory_notifier.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/notifier/get_all_inventory_notifier.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/notifier/get_single_inventory_notifier.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/notifier/increase_count_notifier.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/notifier/update_inventory_notifier.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/view/inventory_view.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/widgets/update_products_textfield.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/general_widgets/app_outline_button.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_app_bar.dart';
import 'package:laxmii_app/presentation/general_widgets/page_loader.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class UpdateInventory extends ConsumerStatefulWidget {
  const UpdateInventory(
      {required this.productName,
      required this.productDescription,
      required this.sellingPrice,
      required this.costPrice,
      required this.itemQuantity,
      required this.itemId,
      required this.currency,
      required this.serviceType,
      required this.supplierName,
      super.key});
  final String productName;
  final String productDescription;
  final String sellingPrice;
  final String costPrice;
  final String itemQuantity;
  final String itemId;
  final String currency;
  final String serviceType;
  final String supplierName;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UpdateInventoryState();
}

class _UpdateInventoryState extends ConsumerState<UpdateInventory> {
  late final TextEditingController _productNameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _sellingPriceController;
  late final TextEditingController _costPriceController;
  late final TextEditingController _quantityController;
  late final TextEditingController _supplierNameController;
  late num _initialQuantity; // Store the original quantity
  // int get _currentQuantity =>
  //     _initialQuantity + ref.read(increaseCountProvider(_initialQuantity));

  @override
  void initState() {
    super.initState();
    _initialQuantity = num.parse(widget.itemQuantity);
    // Initialize controllers
    _productNameController =
        TextEditingController(text: widget.productName.capitalize);
    _descriptionController =
        TextEditingController(text: widget.productDescription.capitalize);
    _sellingPriceController = TextEditingController(text: widget.sellingPrice);
    _costPriceController = TextEditingController(text: widget.costPrice);
    _supplierNameController = TextEditingController(text: widget.supplierName);

    // Initialize with 0; the Riverpod state handles true value
    _quantityController =
        TextEditingController(text: _initialQuantity.toString());

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref
          .read(getSingleInventoryNotifierProvider.notifier)
          .getSingleInventory(singleInventoryId: widget.itemId);
      await ref.read(getAccessTokenNotifier.notifier).accessToken();

      // Sync Riverpod state with initial quantity once

      ref.read(increaseCountProvider(_initialQuantity).notifier).set(0);
    });
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _descriptionController.dispose();
    _sellingPriceController.dispose();
    _costPriceController.dispose();
    _quantityController.dispose();
    _supplierNameController.dispose();
    super.dispose();
  }

  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    final isDeleting = ref.watch(deleteInventoryNotifier
        .select((v) => v.deleteInventoryState.isLoading));
    final isUpdating = ref.watch(updateInventoryNotifier
        .select((v) => v.updateInventoryState.isLoading));

    // Watch the change in quantity (positive or negative from initial)
    final quantityChange = ref.watch(increaseCountProvider(_initialQuantity));
    final quantityNotifier =
        ref.read(increaseCountProvider(_initialQuantity).notifier);

    // Calculate current quantity
    final currentQuantity = _initialQuantity + quantityChange;

    // Update the text controller when quantity changes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_quantityController.text != currentQuantity.toString()) {
        _quantityController.text = currentQuantity.toString();
      }
    });

    return PageLoader(
      isLoading: isUpdating,
      child: PageLoader(
        isLoading: isDeleting,
        child: Scaffold(
          appBar: const LaxmiiAppBar(
              title: 'Update Product/Services', centerTitle: true),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
              child: Column(
                children: [
                  UpdateProductsTextField(
                      title: 'Product name', product: _productNameController),
                  const VerticalSpacing(15),
                  UpdateProductsTextField(
                      title: 'Description', product: _descriptionController),
                  const VerticalSpacing(15),
                  if (widget.serviceType.toLowerCase() == 'product') ...[
                    UpdateProductsTextField(
                      //  title: 'Quantitys (initial: ${widget.itemQuantity})',
                      isEnabled: false,
                      title:
                          'Quantity (initial: $_initialQuantity, current: $currentQuantity)',
                      product: _quantityController,
                      // keyboardType: TextInputType.number,
                      increaseDecreaseButton: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Column(
                          children: [
                            GestureDetector(
                                onTap: quantityNotifier.decrement,
                                child: const Icon(Icons.remove)),
                            GestureDetector(
                                onTap: quantityNotifier.increment,
                                child: const Icon(Icons.add)),
                          ],
                        ),
                      ),
                    ),
                    const VerticalSpacing(15),
                    UpdateProductsTextField(
                        title: 'Supplier name',
                        product: _supplierNameController),
                    const VerticalSpacing(15),
                    UpdateProductsTextField(
                      isMoney: true,
                      currency: widget.currency,
                      title: 'Selling Price',
                      product: _sellingPriceController,
                    ),
                    const VerticalSpacing(15),
                    UpdateProductsTextField(
                      isMoney: true,
                      currency: widget.currency,
                      title: 'Cost Price',
                      product: _costPriceController,
                    ),
                  ] else
                    UpdateProductsTextField(
                      isMoney: true,
                      currency: widget.currency,
                      title: 'Service Price',
                      product: _costPriceController,
                      // keyboardType: TextInputType.number,
                    ),
                  const VerticalSpacing(60),
                  LaxmiiOutlineSendButton(
                      backgroundColor: Colors.transparent,
                      hasBorder: true,
                      borderColor: AppColors.primaryColor,
                      textColor: AppColors.primaryColor,
                      title: 'Update',
                      onTap: () {
                        _validateInventoryInput(quantityChange);
                      }),
                  const VerticalSpacing(20),
                  LaxmiiOutlineSendButton(
                    backgroundColor: Colors.transparent,
                    textColor: AppColors.red,
                    title: 'Delete',
                    onTap: () => _deleteInventory(inventoryId: widget.itemId),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _validateInventoryInput(num quantityChange) {
    if (_isSubmitting) return;
    String costPriceText = _costPriceController.text;

    try {
      double costPriceValue = double.parse(costPriceText);

      if (costPriceValue < 1) {
        context.showError(message: 'Cost price cannot be less than 1');

        _costPriceController.text = '1';
      } else {
        _isSubmitting = true;
        setState(() {});
        _handleUpdateTap(quantityChange);
      }
    } catch (e) {
      context.showError(message: 'Please enter a valid number');

      _quantityController.clear();
      _sellingPriceController.clear();
      _costPriceController.clear();
    }
  }

  void _handleUpdateTap(num quantityChange) {
    if (widget.serviceType.toLowerCase() == 'product') {
      if (_productNameController.text.isEmpty ||
          _descriptionController.text.isEmpty ||
          _quantityController.text.isEmpty ||
          _supplierNameController.text.isEmpty ||
          _sellingPriceController.text.isEmpty ||
          _costPriceController.text.isEmpty) {
        context.showError(message: 'Please fill all fields');
        return;
      }
    } else {
      if (_productNameController.text.isEmpty ||
          _descriptionController.text.isEmpty ||
          _costPriceController.text.isEmpty) {
        context.showError(message: 'Please fill all fields');
        return;
      }
    }

    _updateInventory(
        inventoryId: widget.itemId, quantityChange: quantityChange);
  }

  void _updateInventory(
      {required String inventoryId, required num quantityChange}) async {
    await ref.read(getAccessTokenNotifier.notifier).accessToken();

    //  final quantity = int.tryParse(_quantityController.text) ?? 0;

    final data = widget.serviceType.toLowerCase() == 'product'
        ? UpdateInventoryRequest(
            type: widget.serviceType.toLowerCase(),
            productName: _productNameController.text.trim(),
            description: _descriptionController.text.trim(),
            supplierName: _supplierNameController.text.trim(),
            quantity: quantityChange,
            sellingPrice: num.parse(_sellingPriceController.text),
            costPrice: num.parse(_costPriceController.text),
          )
        : UpdateInventoryRequest(
            type: widget.serviceType.toLowerCase(),
            productName: _productNameController.text.trim(),
            description: _descriptionController.text.trim(),
            //  supplierName: _supplierNameController.text.trim(),
            costPrice: num.parse(_costPriceController.text),
          );

    ref.read(updateInventoryNotifier.notifier).updateInventory(
          data: data,
          inventoryId: inventoryId,
          onError: (error) => context.showError(message: error),
          onSuccess: (message) {
            context.hideOverLay();
            context.showSuccess(message: message);
            ref
                .read(getAllInventoryNotifierProvider.notifier)
                .getAllInventory();
            context.popUntil(ModalRoute.withName(InventoryView.routeName));
          },
        );
  }

  void _deleteInventory({required String inventoryId}) async {
    await ref.read(getAccessTokenNotifier.notifier).accessToken();

    ref.read(deleteInventoryNotifier.notifier).deleteInventory(
          inventoryId: inventoryId,
          onError: (error) => context.showError(message: error),
          onSuccess: (message) {
            context.hideOverLay();
            context.showSuccess(message: message);
            ref
                .read(getAllInventoryNotifierProvider.notifier)
                .getAllInventory();
            context.popUntil(ModalRoute.withName(InventoryView.routeName));
          },
        );
  }
}
