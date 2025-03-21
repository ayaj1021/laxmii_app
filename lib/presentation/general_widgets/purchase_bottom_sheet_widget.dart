
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/strings.dart';
import 'package:laxmii_app/presentation/general_widgets/app_button.dart';
import 'package:laxmii_app/presentation/general_widgets/ds_bottom_sheet.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class PurchaseBottomSheetWidget extends StatelessWidget {
  const PurchaseBottomSheetWidget({super.key, required this.purchaseInfo,required this.onTap});
  final String purchaseInfo;
   final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return AbakonBottomSheet(
      content: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30.h,
              width: 30.w,
              child: SvgPicture.asset('assets/icons/information_icon.svg'),
            ),
            const VerticalSpacing(16),
            Text(
              Strings.areYouSure,
              style: context.textTheme.s20w600.copyWith(
                color: AppColors.black,
              ),
            ),
            const VerticalSpacing(16),
            Text(
              purchaseInfo,
              style: context.textTheme.s12w400.copyWith(
                color: AppColors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const VerticalSpacing(50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                //  height: 43.h,
                  width: 144.w,
                  child: LaxmiiSendButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    title: 'No',
                    backgroundColor: AppColors.white,
                    textColor: AppColors.primaryColor,
                    hasBorder: true,
                    borderColor: AppColors.primaryColor,
                  ),
                ),
                SizedBox(
                 // height: 43.h,
                  width: 144.w,
                  child: LaxmiiSendButton(onTap: onTap, title: 'Yes'),
                ),
              ],
            ),
            const VerticalSpacing(70),
          ],
        ),
      ),
    );
  }
}
