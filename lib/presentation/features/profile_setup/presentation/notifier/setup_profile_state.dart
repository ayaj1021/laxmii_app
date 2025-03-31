import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/profile_setup/data/model/set_up_profile_response.dart';

class SetupProfileNotifierState {
  SetupProfileNotifierState({
    required this.inputValid,
    required this.setupProfileState,
    required this.setupUpProfileResponse,
  });
  factory SetupProfileNotifierState.initial() {
    return SetupProfileNotifierState(
      inputValid: false,
      setupProfileState: LoadState.idle,
      setupUpProfileResponse: SetupUpProfileResponse(),
    );
  }
  final bool inputValid;
  final LoadState setupProfileState;
  final SetupUpProfileResponse setupUpProfileResponse;
  SetupProfileNotifierState copyWith(
      {bool? inputValid,
      LoadState? setupProfileState,
      SetupUpProfileResponse? setupUpProfileResponse}) {
    return SetupProfileNotifierState(
      inputValid: inputValid ?? this.inputValid,
      setupProfileState: setupProfileState ?? this.setupProfileState,
      setupUpProfileResponse:
          setupUpProfileResponse ?? this.setupUpProfileResponse,
    );
  }
}
