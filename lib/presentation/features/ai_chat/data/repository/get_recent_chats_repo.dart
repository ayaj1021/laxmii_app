import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/ai_chat/data/model/get_recent_chats_response.dart';

class GetRecentChatRepository {
  GetRecentChatRepository(this._restClient);
  final RestClient _restClient;

  Future<BaseResponse<GetRecentChatsResponse>> getRecentChatHistory() async {
    try {
      final res = await _restClient.getRecentChatHistory();
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final getRecentChatsRepositoryProvider = Provider<GetRecentChatRepository>(
  (ref) => GetRecentChatRepository(
    ref.read(restClientProvider),
  ),
);
