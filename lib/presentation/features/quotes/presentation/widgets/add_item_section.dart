import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/inventory/data/model/get_all_inventory_response.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/features/quotes/data/model/create_quotes_request.dart';
import 'package:laxmii_app/presentation/features/quotes/presentation/widgets/add_quote_item_text_field.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_app_bar.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class AddItemSection extends ConsumerStatefulWidget {
  const AddItemSection({
    super.key,
    required this.item,
    required this.quantity,
    required this.sellingPrice,
  });
  final String item;
  final int quantity;
  final num sellingPrice;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddItemSectionState();
}

class _AddItemSectionState extends ConsumerState<AddItemSection> {
  final ValueNotifier<bool> isAddProductEnabled = ValueNotifier(false);
  final ValueNotifier<double> _calculateProduct = ValueNotifier<double>(0);

  late TextEditingController _quantityController;
  late TextEditingController _sellingPriceController;
  Inventory? _selectedProduct;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(getAccessTokenNotifier.notifier).accessToken();
    });

    _quantityController = TextEditingController()..addListener(_validateInput);
    _sellingPriceController = widget.sellingPrice == 0
        ? TextEditingController()
        : TextEditingController(text: widget.sellingPrice.toString())
      ..addListener(_validateInput);

    // TextEditingController()
    //   ..addListener(_validateInput);
    super.initState();
  }

  void _validateInput() {
    isAddProductEnabled.value = _selectedProduct != null &&
        _quantityController.text.isNotEmpty &&
        _sellingPriceController.text.isNotEmpty;
    _calculateProduct.value = calculateTotal().toDouble();
  }

  num calculateTotal() {
    try {
      double quantity = double.parse(_quantityController.text);
      double sellingPrice = double.parse(_sellingPriceController.text);
      return quantity * sellingPrice;
    } catch (e) {
      return 0; // Return 0 if input is invalid
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  const VerticalSpacing(5),
                  Text(
                    widget.item,
                    style: context.textTheme.s16w500.copyWith(
                      color: AppColors.white,
                    ),
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
                      color: AppColors.primaryC4C4C4,
                      fontSize: 14,
                    ),
                  ),
                  ValueListenableBuilder<double>(
                    valueListenable: _calculateProduct,
                    builder: (context, totalAmount, child) {
                      return Text(
                        '\$$totalAmount',
                        style: context.textTheme.s12w300.copyWith(
                          color: AppColors.primaryC4C4C4,
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
                if (_sellingPriceController.text.isEmpty ||
                    _quantityController.text.isEmpty) {
                  context.showError(message: 'All fields are required');
                } else {
                  final item = ProductItem(
                    itemName: widget.item,
                    itemPrice:
                        double.parse(_sellingPriceController.text.trim()),
                    itemQuantity: num.parse(_quantityController.text.trim()),
                  );

                  Navigator.pop(context, item);
                  context.showSuccess(message: 'Item added');
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
