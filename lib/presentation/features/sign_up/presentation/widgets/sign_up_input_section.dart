import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_email_field.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_form_field.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_password_field.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class SignUpInputSection extends StatelessWidget {
  const SignUpInputSection(
      {super.key,
      required this.emailController,
      required this.nameController,
      required this.passwordController});
  final TextEditingController emailController;
  final TextEditingController nameController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LaxmiiFormfield(
          controller: nameController,
          backgroundColor: Colors.transparent,
          bordercolor: AppColors.primary212121,
          hintText: 'Name',
          hintStyle: context.textTheme.s14w400.copyWith(
              color: AppColors.primary212121, fontWeight: FontWeight.w300),
        ),
        const VerticalSpacing(16),
        LaxmiiEmailField(
          // validateFunction: Validators.email(),
          controller: emailController,
          backgroundColor: Colors.transparent,
          bordercolor: AppColors.primary212121,
          hintText: 'Email',
          hintStyle: context.textTheme.s14w400.copyWith(
              color: AppColors.primary212121, fontWeight: FontWeight.w300),
        ),
        const VerticalSpacing(26),
        LaxmiiPasswordField(
          controller: passwordController,
          hintText: 'Password',
          hintStyle: context.textTheme.s14w400.copyWith(
              color: AppColors.primary212121, fontWeight: FontWeight.w300),
          backgroundColor: Colors.transparent,
          bordercolor: AppColors.primary212121,
        )
      ],
    );
  }
}
