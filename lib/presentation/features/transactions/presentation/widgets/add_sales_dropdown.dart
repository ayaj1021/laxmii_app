import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/inventory/data/model/get_all_inventory_response.dart';

// ignore: must_be_immutable
class AddSalesDropdown extends StatefulWidget {
  AddSalesDropdown({
    super.key,
    required this.inventoryList,
    required String selectedValue,
    required String selectedPrice,
  });
  final List<Inventory> inventoryList;
  Inventory? selectedValue;
  String? selectedPrice;

  @override
  State<AddSalesDropdown> createState() => _AddSalesDropdownState();
}

class _AddSalesDropdownState extends State<AddSalesDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 1.5,
          color: AppColors.primary5E5E5E.withOpacity(0.5),
        ),
      ),
      child: DropdownButton<Inventory>(
        dropdownColor: AppColors.primary101010,
        value: widget.selectedValue,
        padding: EdgeInsets.zero,
        hint: Text(
          'Select Inventory',
          style: context.textTheme.s12w300.copyWith(
            color: AppColors.primaryC4C4C4.withOpacity(0.4),
          ),
        ),
        underline: const SizedBox.shrink(),
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        items: widget.inventoryList.map((Inventory item) {
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
        onChanged: (Inventory? v) {
          setState(() {
            widget.selectedValue = v;
            widget.selectedPrice = '${v?.sellingPrice}';

            // widget.selectedPrice = widget.inventoryList
            //     .firstWhere((value) => widget.selectedPrice == v?.productName)
            //     .sellingPrice
            //     .toString();
          });
        },
      ),
    );
  }
}
