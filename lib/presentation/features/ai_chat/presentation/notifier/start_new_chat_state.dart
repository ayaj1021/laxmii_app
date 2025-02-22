import 'package:laxmii_app/core/config/network_utils/async_response.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/ai_chat/data/model/start_new_chat_response.dart';

class StartNewChatState {
  final LoadState loadState;
  final AsyncResponse<StartNewChatResponse> startNewChatResponse;

  StartNewChatState({
    required this.loadState,
    required this.startNewChatResponse,
  });

  factory StartNewChatState.initial() {
    return StartNewChatState(
      loadState: LoadState.loading,
      startNewChatResponse: AsyncResponse.loading(),
    );
  }

  StartNewChatState copyWith({
    LoadState? loadState,
    AsyncResponse<StartNewChatResponse>? startNewChatResponse,
  }) {
    return StartNewChatState(
      loadState: loadState ?? this.loadState,
      startNewChatResponse: startNewChatResponse ?? this.startNewChatResponse,
    );
  }
}
