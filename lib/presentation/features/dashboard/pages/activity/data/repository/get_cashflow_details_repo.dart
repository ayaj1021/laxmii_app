import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/data/model/get_graph_details_request.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/data/model/get_graph_details_response.dart';

class GetCashFlowDetailsRepository {
  GetCashFlowDetailsRepository(this._restClient);
  final RestClient _restClient;

  Future<BaseResponse<GetIncomeGraphDetailsResponse>> getCashFlowDetails(
      GetGraphDetailsRequest request) async {
    try {
      final res = await _restClient.getCashFlowDetails(request);

      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final getCashFlowDetailsRepositoryProvider =
    Provider<GetCashFlowDetailsRepository>(
  (ref) => GetCashFlowDetailsRepository(
    ref.read(restClientProvider),
  ),
);
