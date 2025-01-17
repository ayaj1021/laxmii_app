import 'package:laxmii_app/core/utils/enums.dart';

class ChangePasswordNotifierState {
  ChangePasswordNotifierState({
    required this.inputValid,
    required this.changePasswordState,
  });
  factory ChangePasswordNotifierState.initial() {
    return ChangePasswordNotifierState(
      inputValid: false,
      changePasswordState: LoadState.idle,
    );
  }
  final bool inputValid;
  final LoadState changePasswordState;
  ChangePasswordNotifierState copyWith({
    bool? inputValid,
    LoadState? changePasswordState,
  }) {
    return ChangePasswordNotifierState(
      inputValid: inputValid ?? this.inputValid,
      changePasswordState: changePasswordState ?? this.changePasswordState,
    );
  }
}
