import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class LoginHeaderSection extends StatelessWidget {
  const LoginHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hi! Welcome Back',
          style: context.textTheme.s24w400.copyWith(
            color: colorScheme.colorScheme.onSurface,
          ),
        ),
        const VerticalSpacing(2),
        Text(
          'Sign in to your account',
          style: context.textTheme.s14w400.copyWith(
            color: colorScheme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
