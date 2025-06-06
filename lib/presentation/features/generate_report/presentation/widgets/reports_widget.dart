import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';

class ReportsWidget extends ConsumerWidget {
  const ReportsWidget(
      {super.key,
      required this.report,
      this.color,
      this.onTap,
      required this.isFavorite});
  final String report;
  final Color? color;
  final bool isFavorite;
  final Function()? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              report,
              style: context.textTheme.s14w400.copyWith(
                  color: colorScheme.colorScheme.onSurface,
                  fontWeight: FontWeight.w300),
            ),
            // GestureDetector(
            //   onTap: onTap,
            //   child: Icon(
            //     Icons.star,
            //     color: color,
            //   ),
            // ),
          ],
        )
      ],
    );
  }
}
