import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget(
      {super.key, required this.searchController, this.onChanged});
  final TextEditingController searchController;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      padding: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.primary5E5E5E.withValues(alpha: 0.5),
        ),
      ),
      child: TextField(
        onChanged: onChanged,
        controller: searchController,
        style: context.textTheme.s12w300.copyWith(
          color: AppColors.white,
        ),
        decoration: InputDecoration(
          hintText: 'Search Invoice',
          // helperStyle: context.textTheme.s12w300.copyWith(
          //   color: AppColors.primary5E5E5E.withOpacity(0.2),
          // ),
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.primary5E5E5E.withValues(alpha: 0.5),
          ),
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
      ),
    );
  }
}
