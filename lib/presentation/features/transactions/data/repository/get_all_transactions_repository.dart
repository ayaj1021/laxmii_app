import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/transactions/data/model/get_all_transactions_response.dart';

class GetAllTransactionsRepository {
  GetAllTransactionsRepository(this._restClient);
  final RestClient _restClient;

  Future<BaseResponse<GetAllTransactionsResponse>> getAllTransactions() async {
    try {
      final res = await _restClient.getAllTransactions();
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final getAllTransactionsRepositoryProvider =
    Provider<GetAllTransactionsRepository>(
  (ref) => GetAllTransactionsRepository(
    ref.read(restClientProvider),
  ),
);
