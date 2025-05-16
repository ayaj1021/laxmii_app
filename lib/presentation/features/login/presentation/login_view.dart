import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/dashboard/dashboard.dart';
import 'package:laxmii_app/presentation/features/forgot_password/presentation/view/forgot_password.dart';
import 'package:laxmii_app/presentation/features/login/data/model/google_sign_in_request.dart';
import 'package:laxmii_app/presentation/features/login/data/model/login_request.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_user_details_notifier.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/google_sign_in_notifier.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/login_notifier.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/remember_me_provider.dart';
import 'package:laxmii_app/presentation/features/login/presentation/widgets/login_header_section.dart';
import 'package:laxmii_app/presentation/features/profile_setup/presentation/view/profile_setup_view.dart';
import 'package:laxmii_app/presentation/features/sign_up/presentation/view/sign_up_view.dart';
import 'package:laxmii_app/presentation/features/verify_email/presentation/view/verify_email.dart';
import 'package:laxmii_app/presentation/general_widgets/app_button.dart';
import 'package:laxmii_app/presentation/general_widgets/app_outline_button.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_checkbox.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_email_field.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_password_field.dart';
import 'package:laxmii_app/presentation/general_widgets/page_loader.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});
  static const routeName = '/login';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final ValueNotifier<bool> _isLoginEnabled = ValueNotifier(false);
  late TextEditingController _emailController;

  late TextEditingController _passwordController;

  @override
  void dispose() {
    //  _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  String userEmail = '';

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController()..addListener(_validateInput);
    _passwordController = TextEditingController()..addListener(_validateInput);
    getUserEmail();
  }

  void _validateInput() {
    _isLoginEnabled.value =
        _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;
  }

  void getUserEmail() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final email = await AppDataStorage().getUserEmail();

    setState(() {
      userEmail = email ?? '';
    });

    _emailController.text = userEmail;
  }

  GoogleSignIn signIn = GoogleSignIn(
    serverClientId:
        '538188324651-2gt9uf174mlo5pqdpsc9ubuhe5tf29j3.apps.googleusercontent.com',
  );

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
    final colorScheme = Theme.of(context);
    final rememberMe = ref.watch(rememberMeProvider);
    final isLoading =
        ref.watch(loginNotifier.select((v) => v.loginState.isLoading));
    final isGoogleSignInLoading =
        ref.watch(googleSignInNotifier.select((v) => v.state.isLoading));
    return Scaffold(
      body: PageLoader(
        isLoading: isLoading,
        child: PageLoader(
          isLoading: isGoogleSignInLoading,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 53),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LoginHeaderSection(),
                    const VerticalSpacing(50),
                    LaxmiiEmailField(
                      controller: _emailController,
                      backgroundColor: Colors.transparent,
                      bordercolor: AppColors.primary212121,
                      hintText: 'Email',
                      hintStyle: context.textTheme.s14w400.copyWith(
                          color: AppColors.primary212121,
                          fontWeight: FontWeight.w300),
                    ),
                    const VerticalSpacing(26),
                    LaxmiiPasswordField(
                      controller: _passwordController,
                      hintText: 'Password',
                      hintStyle: context.textTheme.s14w400.copyWith(
                          color: colorScheme.colorScheme.onSurface,
                          fontWeight: FontWeight.w300),
                      backgroundColor: Colors.transparent,
                      bordercolor: AppColors.primary212121,
                    ),
                    const VerticalSpacing(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            LaxmiiCheckbox(
                                isChecked: rememberMe,
                                onChecked: () async {
                                  ref.read(rememberMeProvider.notifier).state =
                                      !rememberMe;
                                  await AppDataStorage()
                                      .saveRememberMe(!rememberMe);
                                }),
                            const HorizontalSpacing(10),
                            Text(
                              'Remember me',
                              style: context.textTheme.s14w400.copyWith(
                                color: colorScheme.colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () =>
                                context.pushNamed(ForgotPassword.routeName),
                            child: Text(
                              'Forgot Password?',
                              style: context.textTheme.s14w400.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const VerticalSpacing(37),
                    ValueListenableBuilder(
                        valueListenable: _isLoginEnabled,
                        builder: (context, r, c) {
                          return LaxmiiSendButton(
                            isEnabled: r,
                            onTap: () async {
                              await AppDataStorage().saveUserPassword(
                                  _passwordController.text.trim());
                              _login();
                            },
                            title: 'Sign In',
                          );
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
                    const VerticalSpacing(150),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account? ',
                          style: context.textTheme.s14w400.copyWith(
                              color: colorScheme.colorScheme.onSurface,
                              fontWeight: FontWeight.w300),
                        ),
                        GestureDetector(
                          onTap: () => context.pushNamed(SignUpView.routeName),
                          child: Text(
                            'Sign Up',
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
            ),
          ),
        ),
      ),
    );
  }

  void _login() async {
    await AppDataStorage().saveUserPassword(_passwordController.text.trim());
    ref.read(loginNotifier.notifier).login(
          data: LoginRequest(
              email: _emailController.text.toLowerCase().trim(),
              password: _passwordController.text.trim()),
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
                    : context.pushReplacementNamed(ProfileSetupView.routeName);
            ref.read(getUserDetailsNotifier.notifier).getUserDetails();
          },
        );
  }
}
