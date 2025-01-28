import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/generate_report/data/model/add_report_to_favorite_request.dart';
import 'package:laxmii_app/presentation/features/generate_report/data/model/add_report_to_favorite_response.dart';

class AddReportToFavoriteRepository {
  AddReportToFavoriteRepository(this._restClient);
  final RestClient _restClient;
  Future<BaseResponse<AddReportToFavoriteResponse>> addReportToFavorite(
      AddReportToFavoriteRequest request) async {
    try {
      final res = await _restClient.addReportToFavorite(request);
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final addReportToFavoriteRepositoryProvider =
    Provider<AddReportToFavoriteRepository>(
  (ref) => AddReportToFavoriteRepository(
    ref.read(restClientProvider),
  ),
);
