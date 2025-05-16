import 'package:flutter/material.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';

class LaxmiiCheckbox extends StatelessWidget {
  const LaxmiiCheckbox({
    required this.isChecked,
    required this.onChecked,
    super.key,
  });
  final bool isChecked;
  final void Function() onChecked;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChecked,
      child: Container(
        alignment: Alignment.center,
        height: isChecked ? 20 : 20,
        width: isChecked ? 20 : 20,

        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primaryColor, // Border color
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(2), // Rounded corners
        ),
        child: isChecked == true
            ? const Center(
                child: Icon(
                  Icons.check,
                  size: 18,
                  color: AppColors.primaryColor,
                ),
              )
            : const SizedBox.shrink(),

        // Checkbox(
        //     checkColor: AppColors.primary212121,
        //     value: isChecked,
        //     onChanged: onChecked),
      ),
    );
  }
}

class OnboardLaxmiiCheckbox extends StatelessWidget {
  const OnboardLaxmiiCheckbox({
    required this.isChecked,
    required this.onChecked,
    super.key,
  });
  final bool isChecked;
  final void Function(bool?) onChecked;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      padding: const EdgeInsets.all(4), // Optional padding for spacing
      decoration: BoxDecoration(
        border: Border.all(
          color: isChecked
              ? Colors.transparent
              : AppColors.primaryColor, // Border color
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(2), // Rounded corners
      ),
      child:

          //isChecked ? const Icon(Icons.check) : const SizedBox.shrink(),

          Checkbox(
              checkColor: AppColors.primary212121,
              value: isChecked,
              onChanged: onChecked),
    );
  }
}
