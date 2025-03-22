import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/login/presentation/login_view.dart';
import 'package:laxmii_app/presentation/features/onboarding/presentation/view/onboarding_view.dart';
import 'package:laxmii_app/presentation/features/onboarding/presentation/widgets/onboarding_page_background.dart';
import 'package:laxmii_app/presentation/general_widgets/app_button.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  static const String routeName = '/welcomeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const OnboardingPageBackground(),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 29, right: 29, top: 400, bottom: 30),
                child: Column(
                  children: [
                    Text(
                      'All Your finances in one place with',
                      style: context.textTheme.s14w400.copyWith(
                        color: AppColors.white,
                        fontSize: 40,
                      ),
                    ),
                    const VerticalSpacing(116),
                    LaxmiiSendButton(
                        onTap: () {
                          context
                              .pushReplacementNamed(OnboardingView.routeName);
                        },
                        title: 'Get Started'),
                    const VerticalSpacing(24),
                    InkWell(
                      onTap: () => context.pushNamed(LoginView.routeName),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account? ',
                            style: context.textTheme.s14w400.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w300),
                          ),
                          GestureDetector(
                            onTap: () => context.pushNamed(LoginView.routeName),
                            child: Text(
                              'Sign in',
                              style: context.textTheme.s14w500.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const VerticalSpacing(34),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
