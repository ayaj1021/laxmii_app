import 'package:laxmii_app/core/config/network_utils/async_response.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/ai_chat/data/model/get_chat_history_response.dart';

class GetChatHistoryState {
  final LoadState loadState;
  final AsyncResponse<GetChatHistoryResponse> getChatHistoryResponse;

  GetChatHistoryState({
    required this.loadState,
    required this.getChatHistoryResponse,
  });

  factory GetChatHistoryState.initial() {
    return GetChatHistoryState(
      loadState: LoadState.loading,
      getChatHistoryResponse: AsyncResponse.loading(),
    );
  }

  GetChatHistoryState copyWith({
    LoadState? loadState,
    AsyncResponse<GetChatHistoryResponse>? getChatHistoryResponse,
  }) {
    return GetChatHistoryState(
      loadState: loadState ?? this.loadState,
      getChatHistoryResponse:
          getChatHistoryResponse ?? this.getChatHistoryResponse,
    );
  }
}
