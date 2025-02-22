import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/ai_chat/data/model/start_new_chat_response.dart';

class StartNewChatRepository {
  StartNewChatRepository(this._restClient);
  final RestClient _restClient;
  Future<BaseResponse<StartNewChatResponse>> startNewChat() async {
    try {
      final res = await _restClient.startNewChat();
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final startNewChatRepositoryProvider = Provider<StartNewChatRepository>(
  (ref) => StartNewChatRepository(
    ref.read(restClientProvider),
  ),
);
