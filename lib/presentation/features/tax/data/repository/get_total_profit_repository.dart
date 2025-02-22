import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/tax/data/model/get_total_profit_request.dart';
import 'package:laxmii_app/presentation/features/tax/data/model/get_total_profit_response.dart';

class GetTotalTaxProfitRepository {
  GetTotalTaxProfitRepository(this._restClient);
  final RestClient _restClient;
  Future<BaseResponse<GetTotalProfitResponse>> getTotalTaxProfit(
      GetTotalProfitRequest request) async {
    try {
      final res = await _restClient.getTotalTaxProfit(request);
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final getTotalTaxProfitRepositoryProvider =
    Provider<GetTotalTaxProfitRepository>(
  (ref) => GetTotalTaxProfitRepository(
    ref.read(restClientProvider),
  ),
);
