import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/dashboard/dashboard.dart';
import 'package:laxmii_app/presentation/features/login/presentation/login_view.dart';
import 'package:laxmii_app/presentation/features/sign_up/presentation/view/sign_up_view.dart';
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
    // WidgetsBinding.instance.addPostFrameCallback((_) async {

    // });
  }

  void _init() {
    Future.delayed(const Duration(milliseconds: 2000), () async {
      final data = await secureStorage.loadCurrentState();
      return switch (data) {
        CurrentState.onboarded => context.replaceNamed(LoginView.routeName),
        CurrentState.loggedIn => context.replaceNamed(Dashboard.routeName),
        _ => context.replaceNamed(SignUpView.routeName)
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
