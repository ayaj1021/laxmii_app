import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/ai_chat/data/model/get_chat_history_request.dart';
import 'package:laxmii_app/presentation/features/ai_chat/data/model/get_chat_history_response.dart';

class GetChatHistoryRepository {
  GetChatHistoryRepository(this._restClient);
  final RestClient _restClient;

  Future<BaseResponse<GetChatHistoryResponse>> getChatHistory(
    GetChatHistoryRequest request,
  ) async {
    try {
      final res = await _restClient.getChatHistory(request);
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final getChatHistoryRepositoryProvider = Provider<GetChatHistoryRepository>(
  (ref) => GetChatHistoryRepository(
    ref.read(restClientProvider),
  ),
);
