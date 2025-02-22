import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/logger.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/config/network_utils/async_response.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/ai_chat/data/model/get_chat_history_request.dart';
import 'package:laxmii_app/presentation/features/ai_chat/data/repository/get_chat_history_repository.dart';
import 'package:laxmii_app/presentation/features/ai_chat/presentation/notifier/get_chat_history_state.dart';

class GetChatHistoryNotifier extends AutoDisposeNotifier<GetChatHistoryState> {
  GetChatHistoryNotifier();

  late GetChatHistoryRepository _getChatHistoryRepository;

  @override
  GetChatHistoryState build() {
    _getChatHistoryRepository = ref.read(getChatHistoryRepositoryProvider);

    return GetChatHistoryState.initial();
  }

  Future<void> getChatHistory({
    required GetChatHistoryRequest data,
    required void Function(String error) onError,
  }) async {
    state = state.copyWith(loadState: LoadState.loading);

    try {
      final value = await _getChatHistoryRepository.getChatHistory(data);
      debugLog(data);

      if (!value.status) throw value.message.toException;

      state = state.copyWith(
          loadState: LoadState.idle,
          getChatHistoryResponse: AsyncResponse.success(value.data!));
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(loadState: LoadState.idle);
    }
  }
}

final getChatHistoryNotifier =
    NotifierProvider.autoDispose<GetChatHistoryNotifier, GetChatHistoryState>(
  GetChatHistoryNotifier.new,
);
