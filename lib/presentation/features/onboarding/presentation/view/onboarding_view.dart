import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/onboarding/presentation/widgets/onboard_model.dart';
import 'package:laxmii_app/presentation/features/onboarding/presentation/widgets/onboarding_page_background.dart';
import 'package:laxmii_app/presentation/features/sign_up/presentation/view/sign_up_view.dart';
import 'package:laxmii_app/presentation/general_widgets/app_button.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});
  static String routeName = '/onboardingView';

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    //   final colorScheme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          const OnboardingPageBackground(),
          SafeArea(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(39, 70, 39, 40),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: onboardPages.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        final data = onboardPages[index];
                        return Column(
                          children: [
                            Text(
                              data.text,
                              style: context.textTheme.s16w400.copyWith(
                                color: AppColors.primaryColor,

                                //colorScheme.colorScheme.onSurface,
                                fontSize: 36,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const VerticalSpacing(22),
                            Image.asset(data.image),
                            const VerticalSpacing(100),
                          ],
                        );
                      },
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: onboardPages.length,
                    effect: WormEffect(
                      dotHeight: 16,
                      dotWidth: 16,
                      activeDotColor: AppColors.primaryColor,
                      dotColor: AppColors.primaryColor.withValues(alpha: 0.2),
                      type: WormType.thinUnderground,
                    ),
                  ),
                  const VerticalSpacing(37),
                  LaxmiiSendButton(
                    onTap: () {
                      if (_currentIndex < onboardPages.length - 1) {
                        setState(() {
                          _currentIndex++;
                        });
                        _pageController.animateToPage(
                          _currentIndex,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        context.pushReplacementNamed(SignUpView.routeName);
                      }
                    },
                    title: 'Next',
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: AppColors.white,
                      size: 18,
                    ),
                  ),
                  const VerticalSpacing(24),
                  GestureDetector(
                    onTap: () {
                      context.pushReplacementNamed(SignUpView.routeName);
                    },
                    child: Text(
                      'Skip',
                      style: context.textTheme.s16w400.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
