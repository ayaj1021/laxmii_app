import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';

class PopUpMenuButtonWidget extends StatelessWidget {
  const PopUpMenuButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColors.primary5E5E5E)),
      child: PopupMenuButton(
          color: AppColors.primary101010,
          child: Text(
            'Customize widget',
            style: context.textTheme.s11w600.copyWith(
              color: AppColors.primary737373,
            ),
          ),
          itemBuilder: (_) {
            return [
              PopupMenuItem(
                child: Text(
                  'Cashflow',
                  style: context.textTheme.s11w600.copyWith(
                    color: AppColors.primary7E7E7E,
                  ),
                ),
              ),
              PopupMenuItem(
                child: Text(
                  'Mileage',
                  style: context.textTheme.s11w600.copyWith(
                    color: AppColors.primary7E7E7E,
                  ),
                ),
              ),
              PopupMenuItem(
                child: Text(
                  'Invoices',
                  style: context.textTheme.s11w600.copyWith(
                    color: AppColors.primary7E7E7E,
                  ),
                ),
              ),
              PopupMenuItem(
                child: Text(
                  'Inventory',
                  style: context.textTheme.s11w600.copyWith(
                    color: AppColors.primary7E7E7E,
                  ),
                ),
              ),
            ];
          }),
    );
  }
}
