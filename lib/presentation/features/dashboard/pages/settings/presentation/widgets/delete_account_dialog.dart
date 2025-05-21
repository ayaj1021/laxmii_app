import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class DeleteAccountBottomSheet extends StatelessWidget {
  const DeleteAccountBottomSheet({super.key, this.onDelete});
  final Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context);
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 27),
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
          color: colorScheme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(20),
          )),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: AppColors.primaryFB5158),
            child: Text(
              'Warning',
              style: context.textTheme.s12w300.copyWith(color: Colors.white),
            ),
          ),
          const VerticalSpacing(6),
          Text(
            'Are you sure you want to delete your account?',
            style: context.textTheme.s20w500.copyWith(
              color: colorScheme.colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const VerticalSpacing(16),
          Text(
            'By deleting your account you will lose your data. Alternatively, you can back to deactivate.',
            style: context.textTheme.s14w400.copyWith(
              color: AppColors.primary5E5E5E,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
          ),
          const VerticalSpacing(35),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: colorScheme.cardColor,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Back',
                        style: context.textTheme.s14w400.copyWith(
                          color: colorScheme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const HorizontalSpacing(20),
              Expanded(
                child: GestureDetector(
                  onTap: onDelete,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColors.primaryColor,
                    ),
                    child: Center(
                      child: Text(
                        'Delete Account',
                        style: context.textTheme.s14w400.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
