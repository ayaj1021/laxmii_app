import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/ai_chat/data/model/chat_ai_request.dart';
import 'package:laxmii_app/presentation/features/ai_chat/data/model/chat_ai_response.dart';

class ChatAiRepository {
  ChatAiRepository(this._restClient);
  final RestClient _restClient;
  Future<BaseResponse<ChatAiResponse>> chatAi(
    ChatAiRequest chatAiRequest,
  ) async {
    try {
      final res = await _restClient.chatAi(chatAiRequest);
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final chatAiRepositoryProvider = Provider<ChatAiRepository>(
  (ref) => ChatAiRepository(
    ref.read(restClientProvider),
  ),
);
