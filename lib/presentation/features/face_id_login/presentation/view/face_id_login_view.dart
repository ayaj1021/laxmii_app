import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/security/biometrics.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/dashboard/dashboard.dart';
import 'package:laxmii_app/presentation/features/login/data/model/login_request.dart';
import 'package:laxmii_app/presentation/features/login/presentation/login_view.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/login_notifier.dart';
import 'package:laxmii_app/presentation/features/profile_setup/presentation/view/profile_setup_view.dart';
import 'package:laxmii_app/presentation/features/verify_email/presentation/view/verify_email.dart';
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
  final otpController = TextEditingController();

  bool authenticated = false;
  // bool _supportState = false;

  @override
  void initState() {
    super.initState();
    authenticate();
    //  getUserName();
  }

  String userName = '';
  String userPin = '';

  void authenticate() async {
    final authenticate = await LocalAuth.authenticate();
    setState(() {
      authenticated = authenticate;
    });
    if (authenticated) {
      _login();
    } else {
      if (mounted) {
        context.showError(message: 'Authentication failed');
      }
    }
  }

  void setLogin(String pin) {
    if (userPin == pin) {
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
                    'Sign in with face id',
                    style: context.textTheme.s24w400.copyWith(
                      color: colorScheme.colorScheme.onSurface,
                    ),
                  ),

                  const SizedBox(height: 20),
                  Center(
                      child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: colorScheme.cardColor,
                          width: 2,
                        ),
                        shape: BoxShape.circle),
                  )

                      // Image.asset(
                      //   'assets/images/face_id_image.png',
                      //   height: 200,
                      //   width: 200,
                      // ),
                      ),
                  const VerticalSpacing(60),
                  GestureDetector(
                    onTap: () {
                      clearPin();
                      context.pushReplacementNamed(LoginView.routeName);
                    },
                    child: Center(
                      child: Text(
                        'Login with email and password',
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
    await AppDataStorage().clearStoredPin();
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
