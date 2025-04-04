import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/generate_report/presentation/view/sales_report_detail.dart';

// ignore: must_be_immutable
class ReportDropDownWidget extends StatefulWidget {
  ReportDropDownWidget({
    super.key,
    required this.selectedStartDate,
    required this.selectedPeriod,
    this.onChanged,
    this.onTap,
  });
  String selectedPeriod;

  DateTimeRange? selectedStartDate;
  final void Function(String?)? onChanged;
  final void Function()? onTap;

  @override
  State<ReportDropDownWidget> createState() => _ReportDropDownWidgetState();
}

class _ReportDropDownWidgetState extends State<ReportDropDownWidget> {
  // DateTimeRange? _selectedStartDate;

  String _formatStartDate(DateTimeRange date) {
    return DateFormat('d MMM, yy').format(date.start);
  }

  String _formaEndDate(DateTimeRange date) {
    return DateFormat('d MMM, yy').format(date.end);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 102.w,
          height: 35,
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              width: 0.5,
              color: AppColors.primary5E5E5E,
            ),
          ),
          child: DropdownButton(
            dropdownColor: colorScheme.cardColor,
            elevation: 0,
            underline: const SizedBox.shrink(),
            isExpanded: true,
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.primary7E7E7E,
            ),
            value: widget.selectedPeriod,
            items: reportOptions.map((option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(
                  option,
                  style: context.textTheme.s12w400.copyWith(
                      color: AppColors.primary7E7E7E,
                      fontWeight: FontWeight.w600,
                      fontSize: 11),
                ),
              );
            }).toList(),
            onChanged: widget.onChanged,
          ),
        ),
        if (widget.selectedPeriod == 'Custom')
          Row(
            children: [
              GestureDetector(
                onTap: widget.onTap,
                child: Container(
                  height: 35,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.primary3B3522.withValues(alpha: 0.4),
                    border: Border.all(
                      width: 0.5,
                      color: AppColors.primaryA67C00,
                    ),
                  ),
                  child: Text(
                    widget.selectedStartDate == null
                        ? 'Select Date'
                        : "${_formatStartDate(widget.selectedStartDate!)} - ${_formaEndDate(widget.selectedStartDate!)}",
                    // '$_formatDate',
                    style: context.textTheme.s12w600.copyWith(
                      color: AppColors.primaryA67C00,
                      fontSize: 11,
                    ),
                  ),
                ),
              )
            ],
          )
      ],
    );
  }
}
