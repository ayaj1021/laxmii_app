import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/expenses/data/model/delete_expense_response.dart';

class DeleteExpenseRepository {
  DeleteExpenseRepository(this._restClient);
  final RestClient _restClient;

  Future<BaseResponse<DeleteExpenseResponse>> deleteExpense(
      String invoiceId) async {
    try {
      final res = await _restClient.deleteExpense(invoiceId: invoiceId);
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final deleteExpenseRepositoryProvider = Provider<DeleteExpenseRepository>(
  (ref) => DeleteExpenseRepository(
    ref.read(restClientProvider),
  ),
);
