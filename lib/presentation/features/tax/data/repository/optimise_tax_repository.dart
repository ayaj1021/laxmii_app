import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/tax/data/model/optimize_tax_request.dart';
import 'package:laxmii_app/presentation/features/tax/data/model/optimize_tax_response.dart';

class OptimizeTaxRepository {
  OptimizeTaxRepository(this._restClient);
  final RestClient _restClient;
  Future<BaseResponse<OptimizeTaxResponse>> optimizeTax(
      OptimizeTaxRequest request) async {
    try {
      final res = await _restClient.optimizeTax(request);
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final optimizeTaxRepositoryProvider = Provider<OptimizeTaxRepository>(
  (ref) => OptimizeTaxRepository(
    ref.read(restClientProvider),
  ),
);
