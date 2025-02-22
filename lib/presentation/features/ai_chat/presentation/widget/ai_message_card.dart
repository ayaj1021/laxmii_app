import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class AiMessageCard extends StatelessWidget {
  const AiMessageCard({
    super.key,
    required this.message,
    required this.type,
    this.isLoading = false,
  });
  final String message;
  final String type;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 18.h,
                width: 21.w,
                child: Image.asset('assets/logo/laxmii_logo.png'),
              ),
              const HorizontalSpacing(20),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width - 10,
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  padding: const EdgeInsets.all(13),
                  decoration: const BoxDecoration(
                      color: AppColors.primary505050,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                          bottomRight: Radius.circular(25))),
                  child: Text(
                    message,
                    style: context.textTheme.s12w300.copyWith(
                      color: AppColors.primaryC4C4C4,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
