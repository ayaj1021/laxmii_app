import 'package:laxmii_app/core/utils/enums.dart';

class SignUpNotifierState {
  SignUpNotifierState({
    required this.inputValid,
    required this.signUpState,
  });
  factory SignUpNotifierState.initial() {
    return SignUpNotifierState(
      inputValid: false,
      signUpState: LoadState.idle,
    );
  }
  final bool inputValid;
  final LoadState signUpState;
  SignUpNotifierState copyWith({
    bool? inputValid,
    LoadState? signUpState,
  }) {
    return SignUpNotifierState(
      inputValid: inputValid ?? this.inputValid,
      signUpState: signUpState ?? this.signUpState,
    );
  }
}
