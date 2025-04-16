import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/dashboard/dashboard.dart';
import 'package:laxmii_app/presentation/features/face_id_login/data/model/set_pin_request.dart';
import 'package:laxmii_app/presentation/features/face_id_login/presentation/notifier/set_pin_notifier.dart';
import 'package:laxmii_app/presentation/features/login/data/model/login_request.dart';
import 'package:laxmii_app/presentation/features/login/presentation/login_view.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/login_notifier.dart';
import 'package:laxmii_app/presentation/features/profile_setup/presentation/view/profile_setup_view.dart';
import 'package:laxmii_app/presentation/features/verify_email/presentation/view/verify_email.dart';
import 'package:laxmii_app/presentation/general_widgets/app_button.dart';
import 'package:laxmii_app/presentation/general_widgets/app_pin_input_field.dart';
import 'package:laxmii_app/presentation/general_widgets/custom_keyboard.dart';
import 'package:laxmii_app/presentation/general_widgets/page_loader.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class SetupPinPage extends ConsumerStatefulWidget {
  const SetupPinPage({super.key});
  static const String routeName = '/setPin';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SetupPinPageState();
}

class _SetupPinPageState extends ConsumerState<SetupPinPage> {
  final otpController = TextEditingController();

  void _onKeyboardTap(String value) {
    if (otpController.text.length < 6) {
      setState(() {
        otpController.text += value;
      });
    }
  }

  void _onDelete() {
    if (otpController.text.isNotEmpty) {
      setState(() {
        otpController.text =
            otpController.text.substring(0, otpController.text.length - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        ref.watch(loginNotifier.select((v) => v.loginState.isLoading));

    final isSetPinLoading =
        ref.watch(setPinNotifier.select((v) => v.state.isLoading));
    final colorScheme = Theme.of(context);
    return Scaffold(
      body: PageLoader(
        isLoading: isSetPinLoading,
        child: PageLoader(
          isLoading: isLoading,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // if (_supportState)
                  Text(
                    'Set up Pin Code',
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
                    onCompleted: (pin) {
                      // if (pin.length == 6) {
                      //   _login();
                      // }
                    },
                  ),
                  const VerticalSpacing(44),
                  CustomKeyboard(
                    onKeyTap: _onKeyboardTap,
                    onDelete: _onDelete,
                  ),
                  const VerticalSpacing(24),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.7,
                      child: LaxmiiSendButton(
                        onTap: () {
                          if (otpController.text.isEmpty) {
                            context.showError(message: 'Pls enter pin');
                          } else if (otpController.text.length < 6) {
                            context.showError(message: 'Pin must be 6 digits');
                          } else {
                            setPin();
                          }
                        },
                        title: 'Set Pin',
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

  void setPin() {
    final data = SetPinRequest(pin: otpController.text.trim());
    ref.read(setPinNotifier.notifier).setPin(
        data: data,
        onError: (error) {
          context.showError(message: error);
        },
        onSuccess: (message) {
          context.showSuccess(message: message);
          _login();
        });
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
