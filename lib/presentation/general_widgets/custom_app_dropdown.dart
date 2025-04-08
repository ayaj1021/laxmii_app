// import 'package:flutter/material.dart';
// import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
// import 'package:laxmii_app/core/theme/app_colors.dart';
// import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

// class CustomDropdown<T> extends StatelessWidget {
//   final T? value;
//   final List<DropdownMenuItem<T>>? items;
//   final String hintText;
//   final String? label;
//   final ValueChanged<T?>? onChanged;
//   final double borderRadius;
//   final double borderWidth;

//   const CustomDropdown({
//     super.key,
//     this.value,
//     this.items,
//     this.hintText = 'Select an option',
//     this.onChanged,
//     this.borderRadius = 8.0,
//     this.borderWidth = 1.5,
//     this.label,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (label != null)
//           Text(
//             label!,
//             style: context.textTheme.s14w400
//                 .copyWith(color: AppColors.primaryC4C4C4),
//           ),
//         if (label != null) const VerticalSpacing(8),
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(borderRadius),
//             border: Border.all(
//               width: borderWidth,
//               color: AppColors.primary5E5E5E.withValues(alpha: 0.5),
//             ),
//           ),
//           child: DropdownButton<T>(
//             dropdownColor: AppColors.primary101010,
//             value: value,
//             padding: EdgeInsets.zero,
//             hint: Text(
//               hintText,
//               style: context.textTheme.s12w300.copyWith(
//                 color: AppColors.primaryC4C4C4.withValues(alpha: 0.4),
//               ),
//             ),
//             underline: const SizedBox.shrink(),
//             icon: const Icon(Icons.keyboard_arrow_down),
//             isExpanded: true,
//             items: items,
//             onChanged: onChanged,
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class CustomDropdown<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>>? items;
  final String hintText;
  final String? label;
  final ValueChanged<T?>? onChanged;
  final double borderRadius;
  final double borderWidth;

  const CustomDropdown({
    super.key,
    this.value,
    this.items,
    this.hintText = 'Select an option',
    this.onChanged,
    this.borderRadius = 8.0,
    this.borderWidth = 1.5,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label!,
            style: context.textTheme.s14w400
                .copyWith(color: AppColors.primaryC4C4C4),
          ),
        if (label != null) const VerticalSpacing(8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              width: borderWidth,
              color: AppColors.primary5E5E5E.withValues(alpha: 0.5),
            ),
          ),
          child: DropdownButton<T>(
            elevation: 0,
            dropdownColor: colorScheme.cardColor,
            value: value,
            padding: EdgeInsets.zero,
            hint: Text(
              hintText,
              style: context.textTheme.s12w300.copyWith(
                color: colorScheme.colorScheme.onSurface,
              ),
            ),
            underline: const SizedBox.shrink(),
            icon: const Icon(Icons.keyboard_arrow_down),
            isExpanded: true, // Fixed typo here
            items: items,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
