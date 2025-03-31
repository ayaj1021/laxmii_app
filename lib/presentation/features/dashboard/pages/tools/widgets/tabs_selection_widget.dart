import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class TabsSelectionWidget extends StatelessWidget {
  const TabsSelectionWidget(
      {super.key, required this.icon, required this.title, this.onTap});
  final String icon;
  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: colorScheme.colorScheme.onPrimaryContainer,
                ),
                child: SvgPicture.asset(icon),
              ),
              const HorizontalSpacing(10),
              Text(
                title,
                style: context.textTheme.s14w400.copyWith(
                  color: colorScheme.colorScheme.onSurface,
                ),
              )
            ],
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: colorScheme.iconTheme.color,
            size: 14,
          )
        ],
      ),
    );
  }
}
