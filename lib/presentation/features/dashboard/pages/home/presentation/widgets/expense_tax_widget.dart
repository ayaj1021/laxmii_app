import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/ai_insights/presentation/view/ai_insights_view.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ExpensesTaxWidget extends StatelessWidget {
  const ExpensesTaxWidget(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.controller,
      this.length,
      this.onBackPressed,
      this.onForwardPressed});
  final String title;
  final String subTitle;
  final int? length;
  final Function()? onBackPressed;
  final Function()? onForwardPressed;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      decoration: BoxDecoration(
          color: AppColors.primary101010,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textTheme.s16w500.copyWith(
              color: AppColors.white,
            ),
          ),
          const VerticalSpacing(5),
          Text(
            subTitle,
            style: context.textTheme.s10w300.copyWith(
              color: AppColors.primary5E5E5E,
            ),
          ),
          const VerticalSpacing(20),
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
                              style: context.textTheme.s10w600.copyWith(
                                color: AppColors.primary1FCB4F,
                              ),
                            ),
                            const HorizontalSpacing(5),
                            SvgPicture.asset('assets/icons/arrow_up.svg'),
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
                onTap: () => context.pushNamed(AiInsightsView.routeName),
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
          const VerticalSpacing(27),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: onBackPressed,
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.primaryC4C4C4,
                  size: 14,
                ),
              ),
              SmoothPageIndicator(
                controller: controller,
                count: length ?? 0,
                effect: const WormEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    activeDotColor: AppColors.primaryC4C4C4,
                    dotColor: AppColors.primary5E5E5E),
              ),
              GestureDetector(
                onTap: onForwardPressed,
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.primaryC4C4C4,
                  size: 14,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
