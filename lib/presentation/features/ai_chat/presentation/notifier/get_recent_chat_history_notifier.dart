import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_state.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/ai_chat/data/model/get_recent_chats_response.dart';
import 'package:laxmii_app/presentation/features/ai_chat/data/repository/get_recent_chats_repo.dart';

class GetRecentChatNotifier
    extends AutoDisposeNotifier<BaseState<GetRecentChatsResponse>> {
  GetRecentChatNotifier();

  late GetRecentChatRepository _getRecentChatRepository;

  @override
  BaseState<GetRecentChatsResponse> build() {
    _getRecentChatRepository = ref.read(getRecentChatsRepositoryProvider);

    return BaseState<GetRecentChatsResponse>.initial();
  }

  Future<void> getRecentChatHistory() async {
    state = state.copyWith(state: LoadState.loading);

    try {
      final value = await _getRecentChatRepository.getRecentChatHistory();

      if (!value.status) throw value.message.toException;

      state = state.copyWith(state: LoadState.idle, data: value.data);
    } catch (e) {
      state = state.copyWith(state: LoadState.idle);
    }
  }
}

final getRecentChatsNotifier = NotifierProvider.autoDispose<
    GetRecentChatNotifier, BaseState<GetRecentChatsResponse>>(
  GetRecentChatNotifier.new,
);
