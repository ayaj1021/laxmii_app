import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/forgot_password/presentation/view/change_password.dart';
import 'package:laxmii_app/presentation/features/login/presentation/login_view.dart';
import 'package:laxmii_app/presentation/features/verify_email/data/model/resend_otp_request.dart';
import 'package:laxmii_app/presentation/features/verify_email/data/model/verify_email_otp_request.dart';
import 'package:laxmii_app/presentation/features/verify_email/presentation/notifier/resend_otp_notifier.dart';
import 'package:laxmii_app/presentation/features/verify_email/presentation/notifier/verify_email_otp_notifier.dart';
import 'package:laxmii_app/presentation/features/verify_email/presentation/widgets/verify_email_header_section.dart';
import 'package:laxmii_app/presentation/general_widgets/app_button.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_form_field.dart';
import 'package:laxmii_app/presentation/general_widgets/page_loader.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class VerifyEmail extends ConsumerStatefulWidget {
  const VerifyEmail(
      {required this.email, required this.isForgotPassword, super.key});
  final String email;
  final bool isForgotPassword;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends ConsumerState<VerifyEmail> {
  final ValueNotifier<bool> _isOtpEnabled = ValueNotifier(false);
  late TextEditingController _otpController;

  @override
  void dispose() {
    _otpController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController()..addListener(_validateInput);
  }

  void _validateInput() {
    _isOtpEnabled.value = _otpController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
      verifyEmailOtpNotifier.select((v) => v.verifyEmailOtpState.isLoading),
    );
    final isResendOtpLoading = ref.watch(
      resendOtpNotifier.select((v) => v.resendOtpState.isLoading),
    );
    return PageLoader(
      isLoading: isResendOtpLoading,
      child: PageLoader(
        isLoading: isLoading,
        child: Scaffold(
          body: SafeArea(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 53),
              child: Column(
                children: [
                  VerifyEmailHeaderSection(
                    email: widget.email,
                  ),
                  const VerticalSpacing(29),
                  LaxmiiFormfield(
                    controller: _otpController,
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    backgroundColor: Colors.transparent,
                    bordercolor: AppColors.primary212121,
                    hintText: 'Enter 6-digits code',
                    hintStyle: context.textTheme.s14w400.copyWith(
                        color: AppColors.primary212121,
                        fontWeight: FontWeight.w300),
                  ),
                  const VerticalSpacing(30),
                  ValueListenableBuilder(
                      valueListenable: _isOtpEnabled,
                      builder: (context, r, c) {
                        return LaxmiiSendButton(
                            isEnabled: r,
                            onTap: () => _verifyOtp(widget.isForgotPassword),
                            title: 'Continue');
                      }),
                  const VerticalSpacing(23),
                  GestureDetector(
                    onTap: () => _resendOtp(),
                    child: Text(
                      'Resend',
                      style: context.textTheme.s14w400.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }

  void _verifyOtp(bool isForgotPassword) {
    ref.read(verifyEmailOtpNotifier.notifier).verifyEmailOtp(
          data: VerifyEmailOtpRequest(
            email: widget.email,
            otp: _otpController.text.trim(),
          ),
          onError: (error) {
            context.showError(message: error);
          },
          onSuccess: (message) {
            context.hideOverLay();
            context.showSuccess(message: message);
            isForgotPassword == true
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ChangePassword(
                              email: widget.email,
                              otpCode: _otpController.text.trim(),
                            )))

                //context.pushNamed(ChangePassword.routeName)
                : context.pushReplacementNamed(LoginView.routeName);
          },
        );
  }

  void _resendOtp() {
    ref.read(resendOtpNotifier.notifier).resendOtp(
          data: ResendOtpRequest(
            email: widget.email,
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
