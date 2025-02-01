import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

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
