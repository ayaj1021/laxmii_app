// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/dashboard/dashboard.dart';
import 'package:laxmii_app/presentation/features/face_id_login/presentation/view/face_id_login_view.dart';
import 'package:laxmii_app/presentation/features/face_id_login/presentation/view/passcode_login_view.dart';
import 'package:laxmii_app/presentation/features/login/data/model/login_request.dart';
import 'package:laxmii_app/presentation/features/login/presentation/login_view.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/login_notifier.dart';
import 'package:laxmii_app/presentation/features/onboarding/presentation/view/welcome_screen.dart';
import 'package:laxmii_app/presentation/features/profile_setup/presentation/view/profile_setup_view.dart';
import 'package:laxmii_app/presentation/features/verify_email/presentation/view/verify_email.dart';
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
      final isFaceIdSet = await AppDataStorage().getFaceId();
      final isPinEnabled = await secureStorage.getEnablePin();
      final rememberMe = await secureStorage.getRememberMe();

      rememberMe == true
          ? _login()
          : switch (data) {
              CurrentState.onboarded =>
                context.replaceNamed(LoginView.routeName),
              CurrentState.loggedIn => isProfileSetup
                  ? context.replaceNamed(isPinEnabled
                      ? PasscodeLoginView.routeName
                      : isFaceIdSet
                          ? FaceIdLogin.routeName
                          : LoginView.routeName)
                  // : LoginView.routeName)
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

  void _login() async {
    final userEmail = await AppDataStorage().getUserEmail();
    final userPassword = await AppDataStorage().getUserPassword();
    ref.read(loginNotifier.notifier).login(
          data: LoginRequest(
            email: userEmail ?? '',
            password: userPassword ?? '',
          ),
          onError: (error) {
            context.showError(message: error);
            context.pushReplacementNamed(LoginView.routeName);
          },
          onSuccess: (message, isVerified, isAccountSetup) {
            context.hideOverLay();
            context.showSuccess(message: 'Login Successful');

            isVerified == false
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => VerifyEmail(
                              email: userEmail ?? '',
                              isForgotPassword: false,
                            )))
                : isAccountSetup
                    ? context.pushReplacementNamed(Dashboard.routeName)
                    //   : context.pushReplacementNamed(Dashboard.routeName);
                    : context.pushReplacementNamed(ProfileSetupView.routeName);
          },
        );
  }
}
