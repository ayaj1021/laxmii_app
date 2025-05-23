import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/utils.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/settings/presentation/widgets/shopify_store_name_dialog.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_user_details_notifier.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class ConnectSpotifyButtonWidget extends ConsumerStatefulWidget {
  const ConnectSpotifyButtonWidget(
      {super.key, required this.userId, required this.isConnected});
  final String userId;
  final bool? isConnected;

  @override
  ConsumerState<ConnectSpotifyButtonWidget> createState() =>
      _ConnectSpotifyButtonWidgetState();
}

class _ConnectSpotifyButtonWidgetState
    extends ConsumerState<ConnectSpotifyButtonWidget> {
  final _storeNameController = TextEditingController();

  @override
  void dispose() {
    _storeNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.cardColor,
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
                      color: colorScheme.colorScheme.onSurface,
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
              ref.read(getUserDetailsNotifier.notifier).getUserDetails();
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        contentPadding: EdgeInsets.zero,
                        content: SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.9,
                          height: MediaQuery.sizeOf(context).height * 0.4,
                          child: ShopifyStoreNameDialog(
                            storeNameController: _storeNameController,
                            onTap: () {
                              if (_storeNameController.text.isEmpty) {
                                context.showError(
                                    message: 'Pls enter store name');
                              } else {
                                final userStore = _storeNameController.text
                                    .trim()
                                    .replaceAll(' ', '-');
                                final url =
                                    'https://laxmii-latest.onrender.com/auth/shopify?shop=${userStore.toLowerCase().trim()}&id=${widget.userId}';
                                //     'https://laxmii.onrender.com/auth/shopify?shop=${userStore.toLowerCase().trim()}&id=${widget.userId}';
                                log('https://laxmii-latest.onrender.com/auth/shopify?shop=${userStore.toLowerCase().trim()}&id=${widget.userId}');
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (_) => ShopifyWebView(
                                //       shopifyUrl: url,
                                //       // 'https://laxmii.onrender.com/auth/shopify?shop=abbyxl&id=${widget.userId}',
                                //     ),
                                //   ),
                                // );

                                AppUtils.launchURL(url);
                              }
                            },
                          ),
                        ),
                      ));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.primary14131A,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.primary3B3522),
              ),
              child: Text(widget.isConnected == true ? 'Connected' : 'Connect',
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
