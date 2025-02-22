import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/config/network_utils/async_response.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/ai_chat/data/repository/start_new_chat_repository.dart';
import 'package:laxmii_app/presentation/features/ai_chat/presentation/notifier/start_new_chat_state.dart';

class StartNewChatNotifier extends AutoDisposeNotifier<StartNewChatState> {
  StartNewChatNotifier();

  late StartNewChatRepository _startNewChatRepository;

  @override
  StartNewChatState build() {
    _startNewChatRepository = ref.read(startNewChatRepositoryProvider);

    return StartNewChatState.initial();
  }

  Future<void> startNewChat({
    required void Function(String error) onError,
  }) async {
    state = state.copyWith(loadState: LoadState.loading);

    try {
      final value = await _startNewChatRepository.startNewChat();

      if (!value.status) throw value.message.toException;

      state = state.copyWith(
          loadState: LoadState.idle,
          startNewChatResponse: AsyncResponse.success(value.data!));
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(loadState: LoadState.idle);
    }
  }
}

final startChatNotifier =
    NotifierProvider.autoDispose<StartNewChatNotifier, StartNewChatState>(
  StartNewChatNotifier.new,
);
