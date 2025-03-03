import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class ReportShareWidget extends StatelessWidget {
  const ReportShareWidget(
      {super.key, required this.icon, required this.title, this.onTap});
  final String icon;
  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          SvgPicture.asset(icon),
          const VerticalSpacing(2),
          Text(
            title,
            style: context.textTheme.s12w400.copyWith(
              color: AppColors.white,
            ),
          )
        ],
      ),
    );
  }
}
