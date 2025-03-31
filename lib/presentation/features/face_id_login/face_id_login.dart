import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/dashboard/dashboard.dart';
import 'package:laxmii_app/presentation/features/login/data/model/login_request.dart';
import 'package:laxmii_app/presentation/features/login/presentation/login_view.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/login_notifier.dart';
import 'package:laxmii_app/presentation/features/profile_setup/presentation/view/profile_setup_view.dart';
import 'package:laxmii_app/presentation/features/verify_email/presentation/view/verify_email.dart';
import 'package:laxmii_app/presentation/general_widgets/app_button.dart';
import 'package:laxmii_app/presentation/general_widgets/page_loader.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';
import 'package:local_auth/local_auth.dart';

class FaceIdLogin extends ConsumerStatefulWidget {
  const FaceIdLogin({super.key});
  static const routeName = '/faceIdLogin';

  @override
  ConsumerState<FaceIdLogin> createState() => _FaceIdLoginState();
}

class _FaceIdLoginState extends ConsumerState<FaceIdLogin> {
  // final LocalAuthApi _localAuthApi = LocalAuthApi();

  LocalAuthentication auth = LocalAuthentication();
  // bool _supportState = false;

  @override
  void initState() {
    super.initState();
    // Automatically trigger authentication when the screen is loaded
    _authenticate();
    //  auth = LocalAuthentication();
    auth.isDeviceSupported().then((bool isSupported) {
      setState(() {
        // _supportState = isSupported;
      });
    });
  }

  Future<void> _authenticate() async {
    try {
      bool authenticated = await auth.authenticate(
          localizedReason: 'Please scan to authenticate',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: false,
            useErrorDialogs: true,
          ));
      log('Authenticated: $authenticated');
      if (mounted) {
        authenticated
            ? _login()
            : context.pushReplacementNamed(LoginView.routeName);
      }

      //context.pushReplacementNamed(LoginView.routeName);
    } on PlatformException catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        ref.watch(loginNotifier.select((v) => v.loginState.isLoading));
    final colorScheme = Theme.of(context);
    return Scaffold(
      body: PageLoader(
        isLoading: isLoading,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // if (_supportState)
                Text(
                  'Welcome Back',
                  style: context.textTheme.s16w400.copyWith(
                      color: colorScheme.colorScheme.onSurface,
                      fontWeight: FontWeight.w300),
                ),

                // Text(
                //   'This device is not supported',
                //   style: context.textTheme.s14w400.copyWith(
                //       color: AppColors.white, fontWeight: FontWeight.w300),
                // ),
                const SizedBox(height: 20),
                // Optional: Add a button to retry authentication if needed

                LaxmiiSendButton(
                    onTap: _authenticate,
                    //_getAvailableBiometrics,
                    title: 'Authenticate to login'),
                const VerticalSpacing(20),
                GestureDetector(
                  onTap: () =>
                      context.pushReplacementNamed(LoginView.routeName),
                  child: Text(
                    'Login manually',
                    style: context.textTheme.s16w400.copyWith(
                        color: colorScheme.colorScheme.onSurface,
                        fontWeight: FontWeight.w300),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Future<void> _getAvailableBiometrics() async {
  //   List<BiometricType> availableBiometrics =
  //       await auth.getAvailableBiometrics();
  //   log("List of available biometric: $availableBiometrics");
  //   if (!mounted) {
  //     return;
  //   } else {
  //     _authenticate();
  //   }
  // }

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
