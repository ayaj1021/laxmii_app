import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/tax/data/model/calculate_tax_request.dart';
import 'package:laxmii_app/presentation/features/tax/data/model/calculate_tax_response.dart';

class CalculateTaxRepository {
  CalculateTaxRepository(this._restClient);
  final RestClient _restClient;
  Future<BaseResponse<CalculateTaxResponse>> calculateTax(
      CalculateTaxRequest request) async {
    try {
      final res = await _restClient.calculateTax(request);
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final calculateTaxRepositoryProvider = Provider<CalculateTaxRepository>(
  (ref) => CalculateTaxRepository(
    ref.read(restClientProvider),
  ),
);
