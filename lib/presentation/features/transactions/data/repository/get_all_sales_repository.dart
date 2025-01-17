import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/transactions/data/model/get_all_sales_response.dart';

class GetAllSalesRepository {
  GetAllSalesRepository(this._restClient);
  final RestClient _restClient;

  Future<BaseResponse<GetAllSalesResponse>> getAllSales() async {
    try {
      final res = await _restClient.getAllSales();
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final getAllSalesRepositoryProvider = Provider<GetAllSalesRepository>(
  (ref) => GetAllSalesRepository(
    ref.read(restClientProvider),
  ),
);
