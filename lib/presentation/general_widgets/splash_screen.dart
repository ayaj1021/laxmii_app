// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/face_id_login/presentation/view/face_id_login.dart';
import 'package:laxmii_app/presentation/features/login/presentation/login_view.dart';
import 'package:laxmii_app/presentation/features/onboarding/presentation/view/welcome_screen.dart';
import 'package:laxmii_app/presentation/features/profile_setup/presentation/view/profile_setup_view.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  static const routeName = '/';

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  AppDataStorage secureStorage = AppDataStorage();
  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() {
    Future.delayed(const Duration(seconds: 4), () async {
      final data = await secureStorage.loadCurrentState();
      final isProfileSetup = await secureStorage.getProfileSetup();
      final isPinEnabled = await secureStorage.getEnablePin();
      return switch (data) {
        CurrentState.onboarded => context.replaceNamed(LoginView.routeName),
        CurrentState.loggedIn => isProfileSetup
            //  ? context.replaceNamed(Dashboard.routeName)
            ? context.replaceNamed(
                isPinEnabled ? FaceIdLogin.routeName : LoginView.routeName)
            : context.replaceNamed(ProfileSetupView.routeName),
        _ => context.replaceNamed(WelcomeScreen.routeName)
        // _ => context.replaceNamed(SignUpView.routeName),
      };
    });
  }

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
