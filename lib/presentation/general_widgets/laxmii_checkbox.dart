
import 'package:flutter/material.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';

class LaxmiiCheckbox extends StatelessWidget {
  const LaxmiiCheckbox({
    required this.isChecked,
    required this.onChecked,
    super.key,
  });
  final bool isChecked;
  final void Function(bool?) onChecked;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChecked.call(isChecked);
      },
      child: Container(
        height: 20,
        width: 20,
         padding: const EdgeInsets.all(4), // Optional padding for spacing
          decoration: BoxDecoration(
            border: Border.all(
              color: isChecked ? Colors.transparent : AppColors.primaryColor, // Border color
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(2), // Rounded corners
          ),
        child: Checkbox(
         
          checkColor: AppColors.primary212121,
          
          value:isChecked , onChanged: onChecked),
      )
      
      
      // SvgPicture.asset(
      //   'assets/icons/check.svg',
      //   width: 24,
      //   height: 24,
      //   colorFilter: switch (isChecked) {
      //     true =>
      //       const ColorFilter.mode(AppColors.green, BlendMode.srcIn),
      //     _ => null
      //   },
      // ),
    );
  }
}
