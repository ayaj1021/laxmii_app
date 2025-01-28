import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/generate_report/data/model/get_all_report_response.dart';

class GetAllReportsRepository {
  GetAllReportsRepository(this._restClient);
  final RestClient _restClient;

  Future<BaseResponse<GetAllReportsResponse>> getAllReports() async {
    try {
      final res = await _restClient.getAllReports();
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final getAllReportsRepositoryProvider = Provider<GetAllReportsRepository>(
  (ref) => GetAllReportsRepository(
    ref.read(restClientProvider),
  ),
);
