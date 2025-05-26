import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/face_id_login/data/model/set_pin_request.dart';
import 'package:laxmii_app/presentation/features/face_id_login/presentation/notifier/set_pin_notifier.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/login_notifier.dart';
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
  @override
  void initState() {
    getStoreValue();
    super.initState();
  }

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

  bool enablePinSignIn = false;

  void storePinValue(bool val) async {
    await AppDataStorage().setEnablePin(val);
  }

  void getStoreValue() async {
    final setPin = await AppDataStorage().getEnablePin();

    setState(() {
      enablePinSignIn = setPin;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(loginNotifier.select((v) => v.state.isLoading));

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
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 30),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // if (_supportState)

                    IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          size: 18,
                        )),

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

                    const VerticalSpacing(30),
                    AppPinInputField(
                      otpController: otpController,
                      onCompleted: (pin) {
                        // if (pin.length == 6) {
                        //   _login();
                        // }
                      },
                    ),
                    const VerticalSpacing(14),
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
                            } else if (otpController.text.length < 4) {
                              context.showError(
                                  message: 'Pin must be 4 digits');
                            } else {
                              setPin();
                            }
                          },
                          title: 'Set Pin',
                        ),
                      ),
                    ),

                    // const VerticalSpacing(30),
                    // NotificationsOptionsWidget(
                    //     title: 'Enable Pin Sign in',
                    //     onChanged: (v) {
                    //       setState(() {
                    //         enablePinSignIn = v;
                    //       });
                    //       storePinValue(v);
                    //     },
                    //     value: enablePinSignIn),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setPin() async {
    final data = SetPinRequest(pin: otpController.text.trim());
    await AppDataStorage().clearStoredPin();
    ref.read(setPinNotifier.notifier).setPin(
        data: data,
        onError: (error) {
          context.showError(message: error);
        },
        onSuccess: (message) {
          context.showSuccess(message: message);
          //  AppDataStorage().setEnablePin(true);
          AppDataStorage().saveUserPin(otpController.text.trim());
          //   _login();
          context.pop();
        });
  }
}
