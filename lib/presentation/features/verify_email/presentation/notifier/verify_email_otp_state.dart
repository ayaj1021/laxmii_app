import 'package:laxmii_app/core/utils/enums.dart';

class VerifyEmailOtpNotifierState {
  VerifyEmailOtpNotifierState({
    required this.inputValid,
    required this.verifyEmailOtpState,
  });
  factory VerifyEmailOtpNotifierState.initial() {
    return VerifyEmailOtpNotifierState(
      inputValid: false,
      verifyEmailOtpState: LoadState.idle,
    );
  }
  final bool inputValid;
  final LoadState verifyEmailOtpState;
  VerifyEmailOtpNotifierState copyWith({
    bool? inputValid,
    LoadState? verifyEmailOtpState,
  }) {
    return VerifyEmailOtpNotifierState(
      inputValid: inputValid ?? this.inputValid,
      verifyEmailOtpState: verifyEmailOtpState ?? this.verifyEmailOtpState,
    );
  }
}
