import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';

class LaxmiiAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LaxmiiAppBar({
    super.key,
    this.titleWidget,
    this.leading,
    this.title,
    this.actions,
    this.elevation = 0,
    this.centerTitle,
  });
  final Widget? titleWidget;
  final Widget? leading;
  final String? title;
  final List<Widget>? actions;
  final double elevation;
  final bool? centerTitle;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context);
    return AppBar(
      title: titleWidget ??
          (title != null
              ? Text(
                  title ?? '',
                  style: context.textTheme.s15w500.copyWith(
                    color: colorScheme.colorScheme.onSurface,
                  ),
                )
              : null),
      leading: leading ??
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              'assets/icons/arrowleft.svg',
              fit: BoxFit.scaleDown,
              colorFilter: ColorFilter.mode(
                  colorScheme.colorScheme.onSurface, BlendMode.srcIn),
            ),
          ),
      centerTitle: centerTitle,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: elevation,
      iconTheme: const IconThemeData(color: AppColors.primarysWatch),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
