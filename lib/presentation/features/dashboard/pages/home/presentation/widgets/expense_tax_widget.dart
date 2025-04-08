import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/ai_insights/presentation/view/ai_insights_view.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ExpensesTaxWidget extends StatefulWidget {
  const ExpensesTaxWidget(
      {super.key,
      required this.subTitle,
      required this.controller,
      this.length,
      required this.aiInsights});

  final String subTitle;
  final int? length;

  final PageController controller;
  final List<String> aiInsights;

  @override
  State<ExpensesTaxWidget> createState() => _ExpensesTaxWidgetState();
}

class _ExpensesTaxWidgetState extends State<ExpensesTaxWidget> {
  final _pageController = PageController();
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context);
    return Stack(
      children: [
        PageView(
            controller: _pageController,
            children: List.generate(widget.aiInsights.length, (index) {
              final data = widget.aiInsights[index];
              return Animate(
                effects: const [
                  FadeEffect(
                    // curve: Curves.easeInOut,
                    delay: Duration(milliseconds: 400),
                    duration: Duration(milliseconds: 300),
                  ),
                ],
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                  decoration: BoxDecoration(
                      color: colorScheme.cardColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data,
                        style: context.textTheme.s16w500.copyWith(
                          color: colorScheme.colorScheme.onSurface,
                        ),
                      ),
                      const VerticalSpacing(5),
                      Text(
                        widget.subTitle,
                        style: context.textTheme.s10w300.copyWith(
                          color: AppColors.primary5E5E5E,
                        ),
                      ),
                      const VerticalSpacing(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5.33),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.primary075427,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '%12',
                                          style: context.textTheme.s10w600
                                              .copyWith(
                                            color: AppColors.primary1FCB4F,
                                          ),
                                        ),
                                        const HorizontalSpacing(5),
                                        SvgPicture.asset(
                                            'assets/icons/arrow_up.svg'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const HorizontalSpacing(16),
                              SvgPicture.asset('assets/icons/expense_icon.svg')
                            ],
                          ),
                          GestureDetector(
                            onTap: () =>
                                context.pushNamed(AiInsightsView.routeName),
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: AppColors.primary3B3522,
                                    )),
                                child: Text(
                                  'View',
                                  style: context.textTheme.s12w500.copyWith(
                                    color: AppColors.primary3B3522,
                                  ),
                                )),
                          )
                        ],
                      ),
                      // const VerticalSpacing(27),
                    ],
                  ),
                ),
              );
            })),
        Align(
          heightFactor: 20,
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 30,
              right: 15,
              left: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (_currentIndex > 0) {
                      setState(() {
                        _currentIndex--;
                      });
                      _pageController.animateToPage(
                        _currentIndex,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: colorScheme.iconTheme.color,
                    size: 14,
                  ),
                ),
                SmoothPageIndicator(
                  controller: _pageController,
                  count: widget.length ?? 0,
                  effect: const WormEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      activeDotColor: AppColors.primaryC4C4C4,
                      dotColor: AppColors.primary5E5E5E),
                ),
                GestureDetector(
                  onTap: () {
                    if (_currentIndex < widget.aiInsights.length - 1) {
                      setState(() {
                        _currentIndex++;
                      });
                      _pageController.animateToPage(
                        _currentIndex,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: colorScheme.iconTheme.color,
                    size: 14,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
