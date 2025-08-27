import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/presentation/general_widgets/app_button.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_form_field.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class ShopifyStoreNameDialog extends StatelessWidget {
  const ShopifyStoreNameDialog(
      {super.key, required this.storeNameController, required this.onTap});
  final TextEditingController storeNameController;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: colorScheme.cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.cancel,
                color: colorScheme.iconTheme.color,
              ),
            ),
          ),
          const VerticalSpacing(10),
          LaxmiiFormfield(
            backgroundColor: Colors.transparent,
            label: 'Store name',
            hintText: 'Enter Store name',
            controller: storeNameController,
            textStyle: context.textTheme.s12w500.copyWith(
              color: colorScheme.colorScheme.onSurface,
            ),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('e.g johndoe '),
          ),
          const VerticalSpacing(20),
          LaxmiiSendButton(onTap: onTap, title: 'Submit')
        ],
      ),
    );
  }
}
