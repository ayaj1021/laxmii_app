import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

// ignore: must_be_immutable
class TodoPriorityDropDown extends StatefulWidget {
  TodoPriorityDropDown(
      {super.key, required this.selectedValue, required this.onChanged});
  String? selectedValue;
  final ValueChanged<String?> onChanged;

  @override
  State<TodoPriorityDropDown> createState() => _TodoPriorityDropDownState();
}

class _TodoPriorityDropDownState extends State<TodoPriorityDropDown> {
  List<String> priorityList = ['Weekly', 'Monthly', 'Yearly', 'Once'];
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const VerticalSpacing(15),
        Text(
          'Priority',
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
          child: DropdownButton(
              dropdownColor: colorScheme.cardColor,
              value: widget.selectedValue,
              elevation: 0,
              padding: EdgeInsets.zero,
              hint: Text(
                'None',
                style: context.textTheme.s12w300.copyWith(
                  fontSize: 13,
                  color: colorScheme.colorScheme.onSurface,
                ),
              ),
              underline: const SizedBox.shrink(),
              icon: const Icon(Icons.keyboard_arrow_down),
              isExpanded: true,
              items: priorityList.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: context.textTheme.s14w400.copyWith(
                      color: AppColors.primary5E5E5E,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (v) {
                widget.onChanged(v);
              }),
        )
      ],
    );
  }
}
