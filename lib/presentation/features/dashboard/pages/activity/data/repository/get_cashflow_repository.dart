import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/data/model/get_cashflow_request.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/data/model/get_cashflow_response.dart';

class GetCashFlowRepository {
  GetCashFlowRepository(this._restClient);
  final RestClient _restClient;

  Future<BaseResponse<GetCashFlowResponse>> getCashFlow(
      GetCashFlowRequest request) async {
    try {
      final res = await _restClient.getCashFlow(request);
      log('This is cashflow response $res');
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final getCashFlowRepositoryProvider = Provider<GetCashFlowRepository>(
  (ref) => GetCashFlowRepository(
    ref.read(restClientProvider),
  ),
);
