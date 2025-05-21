import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';

class AddQuoteItemTextField extends StatelessWidget {
  const AddQuoteItemTextField(
      {super.key,
      required this.title,
      this.isMoney,
      required this.controller,
      this.onChanged,
      required this.hintText,
      required this.currency});
  final String title;
  final String hintText;
  final String currency;
  final bool? isMoney;
  final TextEditingController controller;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colorScheme.cardColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textTheme.s10w300.copyWith(
              color: AppColors.primary5E5E5E,
            ),
          ),
          TextField(
            controller: controller,
            style: context.textTheme.s12w500.copyWith(
              color: colorScheme.colorScheme.onSurface,
            ),
            onChanged: onChanged,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                prefix: isMoney == true
                    ? Text(
                        currency,
                        style: context.textTheme.s12w500.copyWith(
                          color: colorScheme.colorScheme.onSurface,
                        ),
                      )
                    : const SizedBox.shrink(),
                filled: false,
                border: InputBorder.none,
                hintText: hintText,
                focusedBorder: InputBorder.none),
          ),
        ],
      ),
    );
  }
}
