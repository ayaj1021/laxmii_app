import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';

class ReportDropDownWidget extends StatefulWidget {
  const ReportDropDownWidget({
    super.key,
  });

  @override
  State<ReportDropDownWidget> createState() => _ReportDropDownWidgetState();
}

class _ReportDropDownWidgetState extends State<ReportDropDownWidget> {
  DateTimeRange? _selectedStartDate;

  Future<void> _selectStartDate(BuildContext context) async {
    final now = DateTime.now();
    final DateTimeRange? picked = await showDateRangePicker(
      helpText: 'Select date range',
      context: context,
      initialDateRange: _selectedStartDate,
      //??DateTimeRange(),
      firstDate: DateTime(2000),
      barrierColor: Colors.white,
      lastDate: DateTime(now.year, now.month, now.day),
      saveText: 'Done',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryColor,

              surface: AppColors.primary010101, // Background color
              onSurface: Colors.white, // Text color
              secondary: AppColors.primaryColor.withOpacity(0.5),
            ),
            dialogBackgroundColor: AppColors.primary010101,
            scaffoldBackgroundColor: AppColors.primary010101,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedStartDate) {
      setState(() {
        _selectedStartDate = picked;
      });
    }
  }

  String _formatStartDate(DateTimeRange date) {
    return DateFormat('d MMM, yy').format(date.start);
  }

  String _formaEndDate(DateTimeRange date) {
    return DateFormat('d MMM, yy').format(date.end);
  }

  String _selectedItem = reportOptions[0];
  @override
  Widget build(BuildContext context) {
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
              dropdownColor: AppColors.primary010101,
              underline: const SizedBox.shrink(),
              isExpanded: true,
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.primary7E7E7E,
              ),
              value: _selectedItem,
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
              onChanged: (String? value) {
                _selectedItem = value.toString();
                setState(() {});
              }),
        ),
        if (_selectedItem == 'Custom')
          Row(
            children: [
              GestureDetector(
                onTap: () => _selectStartDate(context),
                child: Container(
                  height: 35,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.primary3B3522.withOpacity(0.4),
                    border: Border.all(
                      width: 0.5,
                      color: AppColors.primaryA67C00,
                    ),
                  ),
                  child: Text(
                    _selectedStartDate == null
                        ? 'Select Date'
                        : "${_formatStartDate(_selectedStartDate!)} - ${_formaEndDate(_selectedStartDate!)}",
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

List<String> reportOptions = [
  'Weekly',
  'Monthly',
  'Yearly',
  'Custom',
];
