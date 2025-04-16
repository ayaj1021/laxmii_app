import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage(
      {super.key, required this.emptyMessage, this.hasButton, this.button});
  final String emptyMessage;
  final bool? hasButton;
  final Widget? button;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/icons/empty_data.svg'),
        const VerticalSpacing(10),
        Text(
          emptyMessage,
          style: context.textTheme.s14w500.copyWith(
            color: colorScheme.colorScheme.onSurface,
          ),
        ),
        if (hasButton == true) button ?? const SizedBox.shrink()
      ],
    );
  }
}
