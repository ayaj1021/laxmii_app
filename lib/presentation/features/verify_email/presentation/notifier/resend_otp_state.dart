import 'package:laxmii_app/core/utils/enums.dart';

class ResendOtpNotifierState {
  ResendOtpNotifierState({
    required this.inputValid,
    required this.resendOtpState,
  });
  factory ResendOtpNotifierState.initial() {
    return ResendOtpNotifierState(
      inputValid: false,
      resendOtpState: LoadState.idle,
    );
  }
  final bool inputValid;
  final LoadState resendOtpState;
  ResendOtpNotifierState copyWith({
    bool? inputValid,
    LoadState? resendOtpState,
  }) {
    return ResendOtpNotifierState(
      inputValid: inputValid ?? this.inputValid,
      resendOtpState: resendOtpState ?? this.resendOtpState,
    );
  }
}
