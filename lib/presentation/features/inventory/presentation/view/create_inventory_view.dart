import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/inventory/data/model/create_inventory_request.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/notifier/create_inventory_notifier.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/view/inventory_view.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/general_widgets/app_outline_button.dart';
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

  @override
  void initState() {
    _productNameController = TextEditingController()
      ..addListener(_validateInput);
    _descriptionController = TextEditingController()
      ..addListener(_validateInput);
    _sellingPriceController = TextEditingController()
      ..addListener(_validateInput);
    _costPriceController = TextEditingController()..addListener(_validateInput);
    _quantityController = TextEditingController()..addListener(_validateInput);
    super.initState();
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _descriptionController.dispose();
    _sellingPriceController.dispose();
    _costPriceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void _validateInput() {
    _isCreateInventoryEnabled.value = _productNameController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _sellingPriceController.text.isNotEmpty &&
        _costPriceController.text.isNotEmpty &&
        _quantityController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(createInventoryNotifier
        .select((v) => v.createInventoryState.isLoading));
    return PageLoader(
      isLoading: isLoading,
      child: Scaffold(
        appBar: const LaxmiiAppBar(
          title: 'Create Product/Services',
        ),
        body: SafeArea(
            child: SingleChildScrollView(
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
                  product: _descriptionController,
                  title: 'Description',
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
                const VerticalSpacing(15),
                UpdateProductsTextField(
                  isMoney: true,
                  product: _costPriceController,
                  title: 'Cost Price',
                ),
                const VerticalSpacing(98),
                ValueListenableBuilder(
                    valueListenable: _isCreateInventoryEnabled,
                    builder: (context, r, c) {
                      return LaxmiiOutlineSendButton(
                        isEnabled: r,
                        onTap: () => _createInventory(),
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
            sellingPrice: int.parse(_sellingPriceController.text.trim()),
            costPrice: int.parse(
              _costPriceController.text.trim(),
            ),
          ),
          onError: (error) {
            context.showError(message: error);
          },
          onSuccess: (message) {
            context.hideOverLay();
            context.showSuccess(message: message);
            context.popAndPushNamed(InventoryView.routeName);
          },
        );
  }
}

class UpdateProductsTextField extends StatelessWidget {
  const UpdateProductsTextField(
      {super.key,
      required this.title,
      required this.product,
      this.keyboardType,
      this.isMoney});
  final String title;
  final bool? isMoney;
  final TextEditingController product;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.s12w400.copyWith(
            color: AppColors.primary5E5E5E,
          ),
        ),
        const VerticalSpacing(5),
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    width: 1.5,
                    color: AppColors.primary5E5E5E.withOpacity(0.5))),
            child: TextField(
              style: context.textTheme.s12w500.copyWith(
                color: AppColors.primaryC4C4C4,
              ),
              keyboardType: keyboardType,
              controller: product,
              decoration: InputDecoration(
                  prefix: isMoney == true
                      ? Text(
                          '\$',
                          style: context.textTheme.s12w500.copyWith(
                            color: AppColors.primaryC4C4C4,
                          ),
                        )
                      : const SizedBox.shrink(),
                  fillColor: Colors.transparent,
                  border: InputBorder.none,
                  filled: false,
                  focusColor: Colors.transparent,
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  )),
            ))
      ],
    );
  }
}
