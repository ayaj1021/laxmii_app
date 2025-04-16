import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/inventory/data/model/create_inventory_request.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/notifier/create_inventory_notifier.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/notifier/get_all_inventory_notifier.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/widgets/update_products_textfield.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/general_widgets/app_outline_button.dart';
import 'package:laxmii_app/presentation/general_widgets/custom_app_dropdown.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_app_bar.dart';
import 'package:laxmii_app/presentation/general_widgets/page_loader.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class CreateInventory extends ConsumerStatefulWidget {
  const CreateInventory({super.key});
  static const routeName = '/createInventory';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateInventoryState();
}

class _CreateInventoryState extends ConsumerState<CreateInventory> {
  final ValueNotifier<bool> _isCreateInventoryEnabled = ValueNotifier(false);
  late TextEditingController _productNameController;
  late TextEditingController _descriptionController;
  late TextEditingController _sellingPriceController;
  late TextEditingController _costPriceController;
  late TextEditingController _quantityController;
  late TextEditingController _supplierNameController;

  @override
  void initState() {
    getUserCurrency();
    _productNameController = TextEditingController()
      ..addListener(_validateInput);
    _descriptionController = TextEditingController()
      ..addListener(_validateInput);
    _sellingPriceController = TextEditingController()
      ..addListener(_validateInput);
    _costPriceController = TextEditingController()..addListener(_validateInput);
    _quantityController = TextEditingController()..addListener(_validateInput);
    _supplierNameController = TextEditingController()
      ..addListener(_validateInput);
    super.initState();
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

  void _validateInput() {
    _isCreateInventoryEnabled.value = _productNameController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _sellingPriceController.text.isNotEmpty &&
        _costPriceController.text.isNotEmpty &&
        _supplierNameController.text.isNotEmpty &&
        _quantityController.text.isNotEmpty;
  }

  String userCurrency = '\$';

  void getUserCurrency() async {
    final currency = await AppDataStorage().getUserCurrency();

    setState(() {
      userCurrency = currency.toString();
    });
  }

  String? _selectedServiceType;

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(createInventoryNotifier
        .select((v) => v.createInventoryState.isLoading));

    return PageLoader(
      isLoading: isLoading,
      child: Scaffold(
        appBar: const LaxmiiAppBar(
          title: 'Create Product/Services',
          centerTitle: true,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
            child: Column(
              children: [
                CustomDropdown(
                  label: 'Select service type',
                  value: _selectedServiceType,
                  items: _serviceType
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedServiceType = value;
                    });
                  },
                ),
                _selectedServiceType == 'Product'
                    ? Column(
                        children: [
                          const VerticalSpacing(15),
                          UpdateProductsTextField(
                            product: _productNameController,
                            title: 'Product',
                          ),
                          const VerticalSpacing(15),
                          UpdateProductsTextField(
                            product: _descriptionController,
                            title: 'Description',
                          ),
                          const VerticalSpacing(15),
                          UpdateProductsTextField(
                            product: _quantityController,
                            keyboardType: TextInputType.number,
                            title: 'Quantity',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a value';
                              }
                              double? number = double.tryParse(value);
                              if (number == null) {
                                return 'Invalid number';
                              }
                              if (number < 0) {
                                return 'Value cannot be less than 0';
                              }
                              return null;
                            },
                          ),
                          const VerticalSpacing(15),
                          UpdateProductsTextField(
                            product: _supplierNameController,
                            title: 'Supplier name',
                          ),
                          const VerticalSpacing(15),
                          UpdateProductsTextField(
                            isMoney: true,
                            currency: userCurrency,
                            product: _sellingPriceController,
                            keyboardType: TextInputType.number,
                            title: 'Selling Price',
                          ),
                          const VerticalSpacing(15),
                          UpdateProductsTextField(
                            isMoney: true,
                            currency: userCurrency,
                            product: _costPriceController,
                            keyboardType: TextInputType.number,
                            title: 'Cost Price',
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          const VerticalSpacing(15),
                          UpdateProductsTextField(
                            product: _productNameController,
                            title: 'Service',
                          ),
                          const VerticalSpacing(15),
                          UpdateProductsTextField(
                            product: _descriptionController,
                            title: 'Description',
                          ),
                          const VerticalSpacing(15),
                          UpdateProductsTextField(
                            isMoney: true,
                            currency: userCurrency,
                            product: _costPriceController,
                            keyboardType: TextInputType.number,
                            title: 'Service Price',
                          ),
                        ],
                      ),
                const VerticalSpacing(68),
                ValueListenableBuilder(
                    valueListenable: _isCreateInventoryEnabled,
                    builder: (context, r, c) {
                      return LaxmiiOutlineSendButton(
                        isEnabled: r,
                        onTap: () {
                          _validateInventoryInput();
                        },
                        title: 'Create Inventory',
                      );
                    }),
              ],
            ),
          ),
        )),
      ),
    );
  }

  void _createInventory() async {
    await ref.read(getAccessTokenNotifier.notifier).accessToken();
    ref.read(createInventoryNotifier.notifier).createInventory(
          data: CreateInventoryRequest(
            productName: _productNameController.text.trim(),
            description: _descriptionController.text.trim(),
            quantity: int.parse(_quantityController.text.trim()),
            sellingPrice: num.parse(_sellingPriceController.text.trim()),
            costPrice: num.parse(
              _costPriceController.text.trim(),
            ),
            supplierName: _supplierNameController.text.trim(),
          ),
          onError: (error) {
            context.showError(message: error);
          },
          onSuccess: (message) {
            context.hideOverLay();
            context.showSuccess(message: message);
            ref
                .read(getAllInventoryNotifierProvider.notifier)
                .getAllInventory();
            // context.popUntil(ModalRoute.withName(InventoryView.routeName));
            context.pop();
          },
        );
  }

  void _validateInventoryInput() {
    String quantityText = _quantityController.text;
    String sellingPriceText = _sellingPriceController.text;
    String costPriceText = _costPriceController.text;

    try {
      double quantityValue = double.parse(quantityText);
      double sellingPriceValue = double.parse(sellingPriceText);
      double costPriceValue = double.parse(costPriceText);

      if (quantityValue < 1) {
        context.showError(message: 'Quantity cannot be less than 1');

        _quantityController.text = '1';
      } else if (sellingPriceValue < 1) {
        context.showError(message: 'Selling price cannot be less than 1');

        _sellingPriceController.text = '1';
      } else if (costPriceValue < 1) {
        context.showError(message: 'Cost price cannot be less than 1');

        _costPriceController.text = '1';
      } else {
        _createInventory();
      }
    } catch (e) {
      context.showError(message: 'Please enter a valid number');

      _quantityController.clear();
      _sellingPriceController.clear();
      _costPriceController.clear();
    }
  }
}

final List<String> _serviceType = [
  'Product',
  'Service',
];
