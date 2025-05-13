import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/transactions/data/model/create_expense_request.dart';
import 'package:laxmii_app/presentation/features/transactions/data/model/create_expense_response.dart';

class CreateExpensesRepository {
  CreateExpensesRepository(this._restClient);
  final RestClient _restClient;
  Future<BaseResponse<CreateExpenseResponse>> createExpenses(
      CreateExpenseRequest request) async {
    try {
      final res = await _restClient.createExpenses(request);

      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final createExpensesRepositoryProvider = Provider<CreateExpensesRepository>(
  (ref) => CreateExpensesRepository(
    ref.read(restClientProvider),
  ),
);
