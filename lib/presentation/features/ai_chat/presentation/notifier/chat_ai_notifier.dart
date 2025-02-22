import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/logger.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/config/network_utils/async_response.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/ai_chat/data/model/chat_ai_request.dart';
import 'package:laxmii_app/presentation/features/ai_chat/data/repository/chat_ai_repository.dart';
import 'package:laxmii_app/presentation/features/ai_chat/presentation/notifier/chat_ai_state.dart';

class ChatAiNotifier extends AutoDisposeNotifier<ChatAiState> {
  ChatAiNotifier();

  late ChatAiRepository _chatAiRepository;

  @override
  ChatAiState build() {
    _chatAiRepository = ref.read(chatAiRepositoryProvider);

    return ChatAiState.initial();
  }

  Future<void> chatAi({
    required ChatAiRequest data,
    required void Function(String error) onError,
    required void Function() onSuccess,
  }) async {
    state = state.copyWith(loadState: LoadState.loading);

    try {
      final value = await _chatAiRepository.chatAi(data);
      debugLog(data);

      if (!value.status) throw value.message.toException;

      state = state.copyWith(
          loadState: LoadState.idle,
          chatAiResponse: AsyncResponse.success(value.data!));

      onSuccess();
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(loadState: LoadState.idle);
    }
  }
}

final chatAiNotifier =
    NotifierProvider.autoDispose<ChatAiNotifier, ChatAiState>(
  ChatAiNotifier.new,
);
