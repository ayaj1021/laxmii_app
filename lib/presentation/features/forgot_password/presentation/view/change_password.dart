import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/forgot_password/data/model/change_password_request.dart';
import 'package:laxmii_app/presentation/features/forgot_password/presentation/notifier/change_password_notifier.dart';
import 'package:laxmii_app/presentation/features/forgot_password/presentation/view/password_success_alert_dialog.dart';
import 'package:laxmii_app/presentation/features/login/presentation/login_view.dart';
import 'package:laxmii_app/presentation/general_widgets/app_button.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_password_field.dart';
import 'package:laxmii_app/presentation/general_widgets/page_loader.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class ChangePassword extends ConsumerStatefulWidget {
  const ChangePassword({required this.email, required this.otpCode, super.key});
  final String email;
  final String otpCode;
  static const routeName = '/changePassword';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends ConsumerState<ChangePassword> {
  final ValueNotifier<bool> _isChangePasswordEnabled = ValueNotifier(false);
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmNewPasswordController;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _newPasswordController = TextEditingController()
      ..addListener(_validateInput);
    _confirmNewPasswordController = TextEditingController()
      ..addListener(_validateInput);
  }

  void _validateInput() {
    _isChangePasswordEnabled.value = _newPasswordController.text.isNotEmpty &&
        _confirmNewPasswordController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
      changePasswordNotifier.select((v) => v.changePasswordState.isLoading),
    );
    return PageLoader(
      isLoading: isLoading,
      child: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 53),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create new password',
                  style: context.textTheme.s24w400.copyWith(
                    color: AppColors.white,
                  ),
                ),
                const VerticalSpacing(2),
                Text(
                  'Fantastic! Let\'s get a new  password for your account.',
                  style: context.textTheme.s14w400.copyWith(
                    color: AppColors.white,
                  ),
                ),
                const VerticalSpacing(50),
                LaxmiiPasswordField(
                  controller: _newPasswordController,
                  hintText: 'New Password',
                  hintStyle: context.textTheme.s14w400.copyWith(
                      color: AppColors.primary212121,
                      fontWeight: FontWeight.w300),
                  backgroundColor: Colors.transparent,
                  bordercolor: AppColors.primary212121,
                ),
                const VerticalSpacing(16),
                LaxmiiPasswordField(
                  controller: _confirmNewPasswordController,
                  hintText: 'Confirm New Password',
                  hintStyle: context.textTheme.s14w400.copyWith(
                      color: AppColors.primary212121,
                      fontWeight: FontWeight.w300),
                  backgroundColor: Colors.transparent,
                  bordercolor: AppColors.primary212121,
                ),
                const VerticalSpacing(37),
                ValueListenableBuilder(
                    valueListenable: _isChangePasswordEnabled,
                    builder: (context, r, c) {
                      return LaxmiiSendButton(
                        isEnabled: r,
                        onTap: () {
                          if (_newPasswordController.text !=
                              _confirmNewPasswordController.text) {
                            context.showError(
                                message: 'Passwords do not match');
                          } else {
                            _changePassword();
                          }
                        },
                        title: 'Change Password',
                      );
                    }),
              ],
            ),
          ),
        )),
      ),
    );
  }

  void _changePassword() {
    ref.read(changePasswordNotifier.notifier).changePassword(
          data: ChangePasswordRequest(
              email: widget.email.trim(),
              otp: widget.otpCode.trim(),
              newPassword: _newPasswordController.text),
          onError: (error) {
            context.showError(message: error);
          },
          onSuccess: (message) {
            context.hideOverLay();
            context.showSuccess(message: message);
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      contentPadding: EdgeInsets.zero,
                      content: PasswordSuccessAlertDialog(
                        message: message,
                        onTap: () =>
                            context.pushReplacementNamed(LoginView.routeName),
                      ),
                    ));
          },
        );
  }
}
