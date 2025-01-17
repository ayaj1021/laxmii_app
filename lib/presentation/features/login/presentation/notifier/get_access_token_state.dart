import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/login/data/model/get_access_token_response.dart';

class GetAccessTokenNotifierState {
  GetAccessTokenNotifierState({
    required this.getAccessTokenState,
    required this.getAccessTokenResponse,
  });
  factory GetAccessTokenNotifierState.initial() {
    return GetAccessTokenNotifierState(
      getAccessTokenState: LoadState.idle,
      getAccessTokenResponse: GetAccessTokenResponse(),
    );
  }
  final LoadState getAccessTokenState;

  final GetAccessTokenResponse getAccessTokenResponse;
  GetAccessTokenNotifierState copyWith({
    LoadState? getAccessTokenState,
    GetAccessTokenResponse? getAccessTokenResponse,
  }) {
    return GetAccessTokenNotifierState(
        getAccessTokenState: getAccessTokenState ?? this.getAccessTokenState,
        getAccessTokenResponse:
            getAccessTokenResponse ?? this.getAccessTokenResponse);
  }
}
