import 'package:laxmii_app/core/utils/enums.dart';

class SetupProfileNotifierState {
  SetupProfileNotifierState({
    required this.inputValid,
    required this.setupProfileState,
  });
  factory SetupProfileNotifierState.initial() {
    return SetupProfileNotifierState(
      inputValid: false,
      setupProfileState: LoadState.idle,
    );
  }
  final bool inputValid;
  final LoadState setupProfileState;
  SetupProfileNotifierState copyWith({
    bool? inputValid,
    LoadState? setupProfileState,
  }) {
    return SetupProfileNotifierState(
      inputValid: inputValid ?? this.inputValid,
      setupProfileState: setupProfileState ?? this.setupProfileState,
    );
  }
}
