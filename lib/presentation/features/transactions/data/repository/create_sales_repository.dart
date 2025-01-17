import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/transactions/data/model/create_sales_request.dart';
import 'package:laxmii_app/presentation/features/transactions/data/model/create_sales_response.dart';

class CreateSalesRepository {
  CreateSalesRepository(this._restClient);
  final RestClient _restClient;
  Future<BaseResponse<CreateSalesResponse>> createSales(
      CreateSalesRequest request) async {
    try {
      final res = await _restClient.createSales(request);
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final createSalesRepositoryProvider = Provider<CreateSalesRepository>(
  (ref) => CreateSalesRepository(
    ref.read(restClientProvider),
  ),
);
