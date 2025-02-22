import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/ai_insights/data/model/ai_insights_request.dart';
import 'package:laxmii_app/presentation/features/ai_insights/data/model/ai_insights_response.dart';

class GetAiInsightsRepository {
  GetAiInsightsRepository(this._restClient);
  final RestClient _restClient;

  Future<BaseResponse<AiInsightsResponse>> getAiInsights(
      AiInsightsRequest request) async {
    try {
      final res = await _restClient.getAiInsights(request);
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final getAiInsightsRepositoryProvider = Provider<GetAiInsightsRepository>(
  (ref) => GetAiInsightsRepository(
    ref.read(restClientProvider),
  ),
);
