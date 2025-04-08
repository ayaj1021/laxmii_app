import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';

class QuoteTextField extends StatelessWidget {
  const QuoteTextField(
      {super.key,
      required this.width,
      required this.controller,
      required this.hintText});
  final double width;
  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context);
    return Container(
      width: width,
      decoration: const BoxDecoration(
          border: Border(
        bottom: BorderSide(color: AppColors.primary3B3522, width: 1),
      )),
      child: TextField(
        controller: controller,
        style: context.textTheme.s14w400.copyWith(
            color: colorScheme.colorScheme.onSurface,
            fontWeight: FontWeight.w300),
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
            hintStyle: context.textTheme.s14w400.copyWith(
                color: colorScheme.colorScheme.onSurface,
                fontWeight: FontWeight.w300),
            contentPadding: EdgeInsets.zero,
            hintText: hintText,
            border: InputBorder.none,
            filled: false,
            focusedBorder: InputBorder.none),
      ),
    );
  }
}
