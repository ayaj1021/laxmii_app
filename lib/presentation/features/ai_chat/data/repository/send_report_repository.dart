import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/ai_chat/data/model/send_report_request.dart';
import 'package:laxmii_app/presentation/features/ai_chat/data/model/send_request_response.dart';

class SendReportRepository {
  SendReportRepository(this._restClient);
  final RestClient _restClient;
  Future<BaseResponse<SendReportResponse>> sendAiReport(
    SendReportRequest request,
  ) async {
    try {
      final res = await _restClient.sendAiReport(request);
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final sendAiReportRepositoryProvider = Provider<SendReportRepository>(
  (ref) => SendReportRepository(
    ref.read(restClientProvider),
  ),
);
