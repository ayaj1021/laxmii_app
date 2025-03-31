import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/forgot_password/data/model/forgot_password_request.dart';
import 'package:laxmii_app/presentation/features/forgot_password/presentation/notifier/forgot_password_notifier.dart';
import 'package:laxmii_app/presentation/features/verify_email/data/model/resend_otp_request.dart';
import 'package:laxmii_app/presentation/features/verify_email/presentation/notifier/resend_otp_notifier.dart';
import 'package:laxmii_app/presentation/features/verify_email/presentation/view/verify_email.dart';
import 'package:laxmii_app/presentation/general_widgets/app_button.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_email_field.dart';
import 'package:laxmii_app/presentation/general_widgets/page_loader.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class ForgotPassword extends ConsumerStatefulWidget {
  const ForgotPassword({super.key});
  static const routeName = '/forgotPassword';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPassword> {
  final ValueNotifier<bool> _isForgotPasswordEnabled = ValueNotifier(false);
  late TextEditingController _emailController;

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController()..addListener(_validateInput);
  }

  void _validateInput() {
    _isForgotPasswordEnabled.value = _emailController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
      forgotPasswordNotifier.select((v) => v.forgotPasswordState.isLoading),
    );
    final colorScheme = Theme.of(context);
    return PageLoader(
      isLoading: isLoading,
      child: Scaffold(
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 53),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Forgot password?',
                style: context.textTheme.s24w400.copyWith(
                  color: colorScheme.colorScheme.onSurface,
                ),
              ),
              const VerticalSpacing(2),
              Text(
                'It\'s not your fault, it happens sometimes. Enter your email to recover your password.',
                style: context.textTheme.s14w400.copyWith(
                  color: colorScheme.colorScheme.onSurface,
                ),
              ),
              const VerticalSpacing(50),
              LaxmiiEmailField(
                controller: _emailController,
                backgroundColor: Colors.transparent,
                bordercolor: AppColors.primary212121,
                hintText: 'Enter email address',
                hintStyle: context.textTheme.s14w400.copyWith(
                    color: AppColors.primary212121,
                    fontWeight: FontWeight.w300),
              ),
              const VerticalSpacing(30),
              ValueListenableBuilder(
                  valueListenable: _isForgotPasswordEnabled,
                  builder: (context, r, c) {
                    return LaxmiiSendButton(
                        isEnabled: r,
                        onTap: () => _forgotPassword(),
                        title: 'Continue');
                  }),
              const VerticalSpacing(23),
              Center(
                child: GestureDetector(
                  onTap: () => _resendOtp(),
                  child: Text(
                    'Resend',
                    style: context.textTheme.s14w400.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }

  void _forgotPassword() {
    ref.read(forgotPasswordNotifier.notifier).forgotPassword(
          data: ForgotPasswordRequest(
            email: _emailController.text.trim(),
          ),
          onError: (error) {
            context.showError(message: error);
          },
          onSuccess: (message) {
            context.hideOverLay();
            context.showSuccess(message: message);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => VerifyEmail(
                          email: _emailController.text,
                          isForgotPassword: true,
                        )));
          },
        );
  }

  void _resendOtp() {
    ref.read(resendOtpNotifier.notifier).resendOtp(
          data: ResendOtpRequest(
            email: _emailController.text.trim(),
          ),
          onError: (error) {
            context.showError(message: error);
          },
          onSuccess: (message) {
            context.hideOverLay();
            context.showSuccess(message: message);
          },
        );
  }
}
