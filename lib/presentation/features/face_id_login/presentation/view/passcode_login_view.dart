import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/dashboard/dashboard.dart';
import 'package:laxmii_app/presentation/features/face_id_login/presentation/view/setup_pin_page.dart';
import 'package:laxmii_app/presentation/features/login/data/model/login_request.dart';
import 'package:laxmii_app/presentation/features/login/presentation/login_view.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/login_notifier.dart';
import 'package:laxmii_app/presentation/features/profile_setup/presentation/view/profile_setup_view.dart';
import 'package:laxmii_app/presentation/features/verify_email/presentation/view/verify_email.dart';
import 'package:laxmii_app/presentation/general_widgets/app_pin_input_field.dart';
import 'package:laxmii_app/presentation/general_widgets/custom_keyboard.dart';
import 'package:laxmii_app/presentation/general_widgets/page_loader.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';
import 'package:local_auth/local_auth.dart';

class PasscodeLoginView extends ConsumerStatefulWidget {
  const PasscodeLoginView({super.key});
  static const routeName = '/passcodeLoginView';

  @override
  ConsumerState<PasscodeLoginView> createState() => _FaceIdLoginState();
}

class _FaceIdLoginState extends ConsumerState<PasscodeLoginView> {
  // final LocalAuthApi _localAuthApi = LocalAuthApi();

  LocalAuthentication auth = LocalAuthentication();
  final otpController = TextEditingController();
  // bool _supportState = false;

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  String userName = '';
  String userPin = '';

  getUserName() async {
    final pin = await AppDataStorage().getUserPin();
    final name = await AppDataStorage().getUserAccountName();

    setState(() {
      userPin = pin;
      userName = name.toString();
    });
  }

  void _onKeyboardTap(String value) {
    if (otpController.text.length < 6) {
      setState(() {
        otpController.text += value;
      });
    }
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  void _onDelete() {
    if (otpController.text.isNotEmpty) {
      setState(() {
        otpController.text =
            otpController.text.substring(0, otpController.text.length - 1);
      });
    }
  }

  void setLogin({required String pin, required String userPin}) {
    if (pin == userPin) {
      _login();
    } else {
      context.showError(message: 'Incorrect Pin');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(loginNotifier.select((v) => v.state.isLoading));
    final colorScheme = Theme.of(context);
    return Scaffold(
      body: PageLoader(
        isLoading: isLoading,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 50),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // if (_supportState)
                  Text(
                    'Enter Pin Code',
                    style: context.textTheme.s24w400.copyWith(
                      color: colorScheme.colorScheme.onSurface,
                    ),
                  ),

                  Text(
                    'Choose a PIN code to secure your account',
                    style: context.textTheme.s14w400.copyWith(
                      color: colorScheme.colorScheme.onSurface,
                    ),
                  ),

                  const VerticalSpacing(60),
                  AppPinInputField(
                    otpController: otpController,
                    onCompleted: (pin) async {
                      final userPins = await AppDataStorage().getUserPin();
                      log('The user pins is: $userPins');
                      if (pin.length == 4) {
                        setLogin(pin: pin, userPin: userPins);
                      }
                    },
                  ),
                  const VerticalSpacing(44),
                  CustomKeyboard(
                    onKeyTap: _onKeyboardTap,
                    onDelete: _onDelete,
                  ),
                  GestureDetector(
                    onTap: () {
                      clearPin();
                      context.pushNamed(SetupPinPage.routeName);
                    },
                    child: Center(
                      child: Text(
                        'Forgot Passcode?',
                        style: context.textTheme.s16w500.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  clearPin() async {
    // await AppDataStorage().clearStoredPin();
    otpController.clear();
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
