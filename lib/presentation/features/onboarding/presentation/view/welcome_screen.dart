// import 'package:flutter/material.dart';
// import 'package:laxmii_app/core/extensions/build_context_extension.dart';
// import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
// import 'package:laxmii_app/core/theme/app_colors.dart';
// import 'package:laxmii_app/presentation/features/login/presentation/login_view.dart';
// import 'package:laxmii_app/presentation/features/onboarding/presentation/view/onboarding_view.dart';
// import 'package:laxmii_app/presentation/features/onboarding/presentation/widgets/onboarding_page_background.dart';
// import 'package:laxmii_app/presentation/general_widgets/app_button.dart';
// import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

// class WelcomeScreen extends StatelessWidget {
//   const WelcomeScreen({super.key});
//   static const String routeName = '/welcomeScreen';

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context);
//     return Scaffold(
//       body: SafeArea(
//         child: ListView(
//           children: [
//             Stack(
//               children: [
//                 const OnboardingPageBackground(),
//                 SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                         left: 29, right: 29, top: 200, bottom: 30),
//                     child: Column(
//                       children: [
//                         Text(
//                           'Master Your Money. Move Different',
//                           style: context.textTheme.s14w400.copyWith(
//                             color: colorScheme.colorScheme.onSurface,
//                             fontSize: 40,
//                           ),
//                         ),
//                         const VerticalSpacing(165),
//                         LaxmiiSendButton(
//                             onTap: () {
//                               context.pushReplacementNamed(
//                                   OnboardingView.routeName);
//                             },
//                             title: 'Get Started'),
//                         const VerticalSpacing(24),
//                         InkWell(
//                           onTap: () => context.pushNamed(LoginView.routeName),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'Already have an account? ',
//                                 style: context.textTheme.s14w400.copyWith(
//                                     color: colorScheme.colorScheme.onSurface,
//                                     fontWeight: FontWeight.w300),
//                               ),
//                               GestureDetector(
//                                 onTap: () =>
//                                     context.pushNamed(LoginView.routeName),
//                                 child: Text(
//                                   'Sign in',
//                                   style: context.textTheme.s14w500.copyWith(
//                                     color: AppColors.primaryColor,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const VerticalSpacing(34),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/login/presentation/login_view.dart';
import 'package:laxmii_app/presentation/features/onboarding/presentation/view/onboarding_view.dart';
import 'package:laxmii_app/presentation/general_widgets/app_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  static const String routeName = '/welcomeScreen';

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Image.asset(
                        'assets/images/blur_image_one.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 29),
                  // padding: const EdgeInsets.only(
                  //     left: 29, right: 29, top: 0, bottom: 30),
                  child: Text(
                    'Master Your Money. Move Different',
                    style: context.textTheme.s14w400.copyWith(
                      color: colorScheme.colorScheme.onSurface,
                      fontSize: 40,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  // const VerticalSpacing(195),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 29),
                  child: Column(
                    children: [
                      LaxmiiSendButton(
                          onTap: () {
                            context
                                .pushReplacementNamed(OnboardingView.routeName);
                          },
                          title: 'Get Started'),
                      SizedBox(height: screenHeight * 0.03),
                      InkWell(
                        onTap: () => context.pushNamed(LoginView.routeName),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account? ',
                              style: context.textTheme.s14w400.copyWith(
                                  color: colorScheme.colorScheme.onSurface,
                                  fontWeight: FontWeight.w300),
                            ),
                            GestureDetector(
                              onTap: () =>
                                  context.pushNamed(LoginView.routeName),
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
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}
