import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/transactions/data/model/get_recurring_expense_response.dart';

class GetAllRecurringExpenseRepository {
  GetAllRecurringExpenseRepository(this._restClient);
  final RestClient _restClient;

  Future<BaseResponse<GetRecurringExpensesResponse>> getAllRecurring() async {
    try {
      final res = await _restClient.getAllRecurring();
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final getRecurringExpenseRepositoryProvider =
    Provider<GetAllRecurringExpenseRepository>(
  (ref) => GetAllRecurringExpenseRepository(
    ref.read(restClientProvider),
  ),
);
