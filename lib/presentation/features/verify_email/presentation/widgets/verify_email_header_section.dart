import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class VerifyEmailHeaderSection extends StatelessWidget {
  const VerifyEmailHeaderSection({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Verify your email',
          style: context.textTheme.s24w400.copyWith(
            color: colorScheme.colorScheme.onSurface,
          ),
        ),
        const VerticalSpacing(2),
        Text(
          'We sent a 6-digits a 6-digit verification code to $email. Please input the code.',
          style: context.textTheme.s14w400.copyWith(
            color: colorScheme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
