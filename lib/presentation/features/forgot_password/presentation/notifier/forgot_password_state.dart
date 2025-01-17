import 'package:laxmii_app/core/utils/enums.dart';

class ForgotPasswordNotifierState {
  ForgotPasswordNotifierState({
    required this.inputValid,
    required this.forgotPasswordState,
  });
  factory ForgotPasswordNotifierState.initial() {
    return ForgotPasswordNotifierState(
      inputValid: false,
      forgotPasswordState: LoadState.idle,
    );
  }
  final bool inputValid;
  final LoadState forgotPasswordState;
  ForgotPasswordNotifierState copyWith({
    bool? inputValid,
    LoadState? forgotPasswordState,
  }) {
    return ForgotPasswordNotifierState(
      inputValid: inputValid ?? this.inputValid,
      forgotPasswordState: forgotPasswordState ?? this.forgotPasswordState,
    );
  }
}
