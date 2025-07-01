import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/quotes/presentation/widgets/quote_text_field.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class QoutesInfoInputSection extends StatelessWidget {
  const QoutesInfoInputSection({
    super.key,
    required this.nameController,
    required this.quoteStartDate,
    required this.quoteExpiryDate,
    this.onQuoteStartDateSelected,
    this.onQuoteExpiryDateSelected,
  });

  final TextEditingController nameController;
  final String quoteStartDate;
  final String quoteExpiryDate;
  final Function()? onQuoteStartDateSelected;
  final Function()? onQuoteExpiryDateSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: colorScheme.cardColor,
      ),
      child: Column(
        children: [
          Row(
            //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset('assets/icons/user.svg'),
              const HorizontalSpacing(14),
              QuoteTextField(
                width: MediaQuery.of(context).size.width * 0.73,
                controller: nameController,
                hintText: 'Who is it for?',
              )
            ],
          ),
          const VerticalSpacing(10),
          InkWell(
            onTap: onQuoteStartDateSelected,
            child: Row(
              children: [
                SvgPicture.asset('assets/icons/calendar.svg'),
                //  const HorizontalSpacing(10),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        quoteStartDate,
                        style: context.textTheme.s14w400.copyWith(
                            color: colorScheme.colorScheme.onSurface,
                            fontWeight: FontWeight.w300),
                      ),
                      const VerticalSpacing(10),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.72,
                        decoration: const BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                              color: AppColors.primary3B3522, width: 1),
                        )),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const VerticalSpacing(10),
          InkWell(
            onTap: onQuoteExpiryDateSelected,
            child: Row(
              children: [
                SvgPicture.asset('assets/icons/timer.svg'),
                // const HorizontalSpacing(10),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        quoteExpiryDate,
                        style: context.textTheme.s14w400.copyWith(
                            color: colorScheme.colorScheme.onSurface,
                            fontWeight: FontWeight.w300),
                      ),
                      const VerticalSpacing(10),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.73,
                        decoration: const BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                              color: AppColors.primary3B3522, width: 1),
                        )),
                      ),
                      const VerticalSpacing(15),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
