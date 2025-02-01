import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';

class AddSalesTextField extends StatelessWidget {
  const AddSalesTextField(
      {super.key,
      // required this.title,
      required this.controller,
      this.keyboardType,
      this.isMoney,
      required this.hintText,
      this.onChanged});
  // final String title;
  final String hintText;
  final bool? isMoney;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
        // padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                width: 1.5,
                color: AppColors.primary5E5E5E.withValues(alpha: 0.5))),
        child: TextField(
          style: context.textTheme.s12w500.copyWith(
            color: AppColors.primaryC4C4C4,
          ),
          onChanged: onChanged,
          keyboardType: keyboardType,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            helperStyle: context.textTheme.s12w300.copyWith(
              color: AppColors.primary5E5E5E.withValues(alpha: 0.5),
            ),
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
            ),
          ),
        ));
  }
}
