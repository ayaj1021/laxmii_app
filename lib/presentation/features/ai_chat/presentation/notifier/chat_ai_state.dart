import 'package:laxmii_app/core/config/network_utils/async_response.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/ai_chat/data/model/chat_ai_response.dart';

class ChatAiState {
  final LoadState loadState;
  final AsyncResponse<ChatAiResponse> chatAiResponse;

  ChatAiState({
    required this.loadState,
    required this.chatAiResponse,
  });

  factory ChatAiState.initial() {
    return ChatAiState(
      loadState: LoadState.loading,
      chatAiResponse: AsyncResponse.loading(),
    );
  }

  ChatAiState copyWith({
    LoadState? loadState,
    AsyncResponse<ChatAiResponse>? chatAiResponse,
  }) {
    return ChatAiState(
      loadState: loadState ?? this.loadState,
      chatAiResponse: chatAiResponse ?? this.chatAiResponse,
    );
  }
}
