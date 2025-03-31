import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/shopify/presentation/view/shopify_web_view.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class ConnectSpotifyButtonWidget extends StatelessWidget {
  const ConnectSpotifyButtonWidget(
      {super.key, required this.userId, required this.isConnected});
  final String userId;
  final bool? isConnected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primary101010,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                  width: 20,
                  height: 27,
                  child: Image.asset('assets/images/spotify_logo.png')),
              const HorizontalSpacing(5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Connect Shopify Store',
                    style: context.textTheme.s14w500.copyWith(
                      color: AppColors.primaryC4C4C4,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      'Link Shopify account to Laxmii',
                      style: context.textTheme.s12w500.copyWith(
                        color: AppColors.primary5E5E5E,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              log('user id ${userId.toString()}');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ShopifyWebView(
                            shopifyUrl:
                                'https://laxmii.onrender.com/auth/shopify?shop=abbyxl&id=$userId',
                          )));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.primary14131A,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.primary3B3522),
              ),
              child: Text(isConnected == true ? 'Connected' : 'Connect',
                  style: context.textTheme.s12w500.copyWith(
                    color: AppColors.primary5E8E3E,
                    fontSize: 13,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
