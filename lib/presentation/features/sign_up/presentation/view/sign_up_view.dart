import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/dashboard/dashboard.dart';
import 'package:laxmii_app/presentation/features/login/data/model/google_sign_in_request.dart';
import 'package:laxmii_app/presentation/features/login/presentation/login_view.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_user_details_notifier.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/google_sign_in_notifier.dart';
import 'package:laxmii_app/presentation/features/profile_setup/presentation/view/profile_setup_view.dart';
import 'package:laxmii_app/presentation/features/sign_up/data/model/sign_up_request.dart';
import 'package:laxmii_app/presentation/features/sign_up/notifier/sign_up_notifier.dart';
import 'package:laxmii_app/presentation/features/sign_up/presentation/view/privacy_policy_view.dart';
import 'package:laxmii_app/presentation/features/sign_up/presentation/widgets/sign_up_header_section.dart';
import 'package:laxmii_app/presentation/features/sign_up/presentation/widgets/sign_up_input_section.dart';
import 'package:laxmii_app/presentation/features/verify_email/presentation/view/verify_email.dart';
import 'package:laxmii_app/presentation/general_widgets/app_button.dart';
import 'package:laxmii_app/presentation/general_widgets/app_outline_button.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_checkbox.dart';
import 'package:laxmii_app/presentation/general_widgets/page_loader.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});
  static const routeName = '/sign-up';

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final ValueNotifier<bool> _isSignUpEnabled = ValueNotifier(false);
  late TextEditingController _emailController;
  late TextEditingController _nameController;
  late TextEditingController _passwordController;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController()..addListener(_validateInput);
    _passwordController = TextEditingController()..addListener(_validateInput);
    _nameController = TextEditingController()..addListener(_validateInput);
  }

  void _validateInput() {
    _isSignUpEnabled.value = _emailController.text.isNotEmpty &&
        _nameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;
  }

  bool _isChecked = false;

  Future<void> signInAndSendToken() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Step 3: Get ID token
      final idToken = await userCredential.user?.getIdToken();
      final data = GoogleSignInRequest(idToken: idToken ?? '');

      ref.read(googleSignInNotifier.notifier).googleSignIn(
            data: data,
            onError: (error) {
              context.showError(message: error);
            },
            onSuccess: (message, isVerified, isAccountSetup) {
              context.hideOverLay();
              context.showSuccess(message: 'Login Successful');

              isVerified == false
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => VerifyEmail(
                                email: _emailController.text.trim(),
                                isForgotPassword: false,
                              )))
                  : isAccountSetup
                      ? context.replaceAll(Dashboard.routeName)
                      //   : context.pushReplacementNamed(Dashboard.routeName);
                      : context
                          .pushReplacementNamed(ProfileSetupView.routeName);
              ref.read(getUserDetailsNotifier.notifier).getUserDetails();
            },
          );
    } catch (e) {
      log('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
      signUpNotifier.select((v) => v.signUpState.isLoading),
    );

    final isGoogleSignInLoading =
        ref.watch(googleSignInNotifier.select((v) => v.state.isLoading));
    final colorScheme = Theme.of(context);
    return Scaffold(
      body: PageLoader(
        isLoading: isLoading,
        child: PageLoader(
          isLoading: isGoogleSignInLoading,
          child: SafeArea(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 53),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SignUpHeaderSection(),
                  const VerticalSpacing(40),
                  SignUpInputSection(
                    emailController: _emailController,
                    nameController: _nameController,
                    passwordController: _passwordController,
                  ),
                  const VerticalSpacing(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      LaxmiiCheckbox(
                        isChecked: _isChecked,
                        onChecked: () {
                          setState(() {
                            _isChecked = !_isChecked;
                          });
                        },
                      ),
                      const HorizontalSpacing(10),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: 'I agree to the company ',
                            style: context.textTheme.s12w400
                                .copyWith(color: AppColors.primaryA29FB3),
                            children: [
                              TextSpan(
                                  text: 'Terms of Service',
                                  style: context.textTheme.s14w400
                                      .copyWith(color: AppColors.primaryColor),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  const PdfViewerPage()));
                                      // AppUtils.openPdf(
                                      //     'https://www.laxmiiapp.com/t&c.pdf');
                                      // LauncherHelpers.openDSUrl(
                                      //       path: '/terms.html',
                                      //     );
                                    }),
                              TextSpan(
                                text: ' and ',
                                style: context.textTheme.s12w400
                                    .copyWith(color: AppColors.primaryA29FB3),
                              ),
                              TextSpan(
                                  text: 'Privacy Policy',
                                  style: context.textTheme.s14w400
                                      .copyWith(color: AppColors.primaryColor),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  const PdfViewerPage()));
                                      // LauncherHelpers.openDSUrl(
                                      //                                       path: '/policy.html',
                                      //                                     ),
                                    }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const VerticalSpacing(30),
                  ValueListenableBuilder(
                      valueListenable: _isSignUpEnabled,
                      builder: (context, r, c) {
                        return LaxmiiSendButton(
                            isEnabled: r && _isChecked == true,
                            onTap: () {
                              if (_passwordController.text.length < 9) {
                                context.showError(
                                    message:
                                        'Password must be at least 9 characters long');
                              } else {
                                _signUp();
                              }
                            },
                            title: 'Sign Up');
                      }),
                  const VerticalSpacing(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 135.w,
                        child: Divider(
                          color: colorScheme.colorScheme.onSurface,
                        ),
                      ),
                      const HorizontalSpacing(7),
                      Text(
                        'Or',
                        style: context.textTheme.s14w400.copyWith(
                            color: colorScheme.colorScheme.onSurface,
                            fontWeight: FontWeight.w300),
                      ),
                      const HorizontalSpacing(7),
                      SizedBox(
                        width: 135.w,
                        child: Divider(
                          color: colorScheme.colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  const VerticalSpacing(20),
                  LaxmiiOutlineSendButton(
                    onTap: () {
                      signInAndSendToken();
                    },
                    title: 'Continue with Google',
                    hasBorder: true,
                    icon: 'assets/icons/google.svg',
                    backgroundColor: Colors.transparent,
                    borderColor: AppColors.primary212121,
                  ),
                  const VerticalSpacing(100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: context.textTheme.s14w400.copyWith(
                            color: colorScheme.colorScheme.onSurface,
                            fontWeight: FontWeight.w300),
                      ),
                      GestureDetector(
                        onTap: () => context.pushNamed(LoginView.routeName),
                        child: Text(
                          'Sign in',
                          style: context.textTheme.s14w500.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }

  void _signUp() {
    ref.read(signUpNotifier.notifier).signUp(
          data: SignUpRequest(
            name: _nameController.text.trim(),
            email: _emailController.text.toLowerCase().trim(),
            password: _passwordController.text.trim(),
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
                          isForgotPassword: false,
                        )));
          },
        );
  }
}
