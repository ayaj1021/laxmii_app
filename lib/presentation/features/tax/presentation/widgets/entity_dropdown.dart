import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class EntityDropdownWidget extends StatelessWidget {
  const EntityDropdownWidget(
      {super.key, this.onChanged, required this.selectedValue});
  final Function(String?)? onChanged;
  final String selectedValue;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context);
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Entity',
              style: context.textTheme.s14w400.copyWith(
                color: AppColors.primary5E5E5E,
              ),
            ),
            const VerticalSpacing(5),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  width: 1.5,
                  color: AppColors.primary5E5E5E.withValues(alpha: 0.5),
                ),
              ),
              child: DropdownButton<String>(
                  elevation: 0,
                  dropdownColor: colorScheme.cardColor,
                  value: entityTypes.contains(selectedValue)
                      ? selectedValue
                      : null,
                  padding: EdgeInsets.zero,
                  hint: Text(
                    'Select entity type',
                    style: context.textTheme.s12w300.copyWith(
                      color: colorScheme.colorScheme.onSurface,
                    ),
                  ),
                  underline: const SizedBox.shrink(),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  isExpanded: true,
                  items: entityTypes.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: context.textTheme.s14w400.copyWith(
                          color: AppColors.primary5E5E5E,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: onChanged),
            ),
          ],
        ),
      ],
    );
  }
}

final List<String> entityTypes = ['Individual', 'Limited Company'];
