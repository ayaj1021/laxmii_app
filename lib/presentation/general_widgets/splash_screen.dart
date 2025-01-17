// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/sign_up/presentation/view/sign_up_view.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  static const routeName = '/';

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  SecureStorage secureStorage = SecureStorage();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // sendToken();
    });
    Future.delayed(const Duration(seconds: 3), () async {
      final accessToken = await secureStorage.getUserAccessToken();
      log('This is accesstoken $accessToken');
      context.pushReplacementNamed(SignUpView.routeName);

      // if (accessToken != null) {
      //   context.pushReplacementNamed(Dashboard.routeName);
      // } else {
      //   context.pushReplacementNamed(SignUpView.routeName);
      // }
    });
  }

  // sendToken() async {
  //   await ref.read(sendTokenNotifier.notifier).sendToken();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 100.h,
              width: 100.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Image.asset(
                  'assets/logo/laxmii_logo.png',
                ),
              ),
            ),
          ),
          const VerticalSpacing(20),
          SizedBox(
            width: 150.w,
            child: const LinearProgressIndicator(
              color: AppColors.primaryColor,
            ),
          )
        ],
      ),
    );
  }
}
