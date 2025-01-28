import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/generate_report/data/model/get_single_report_request.dart';
import 'package:laxmii_app/presentation/features/generate_report/data/model/get_single_report_response.dart';

class GetSingleReportRepository {
  GetSingleReportRepository(this._restClient);
  final RestClient _restClient;
  Future<BaseResponse<GetSingleReportResponse>> getSingleReport(
      GetSingleReportRequest request) async {
    try {
      final res = await _restClient.getSingleReport(request);
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final getSingleReportRepositoryProvider = Provider<GetSingleReportRepository>(
  (ref) => GetSingleReportRepository(
    ref.read(restClientProvider),
  ),
);
