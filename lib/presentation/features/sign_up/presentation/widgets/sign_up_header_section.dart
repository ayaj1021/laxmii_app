import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class SignUpHeaderSection extends StatelessWidget {
  const SignUpHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sign Up',
          style: context.textTheme.s24w400.copyWith(
            color: colorScheme.colorScheme.onSurface,
          ),
        ),
        const VerticalSpacing(2),
        Text(
          'Create account and enjoy all services',
          style: context.textTheme.s14w400.copyWith(
            color: colorScheme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
