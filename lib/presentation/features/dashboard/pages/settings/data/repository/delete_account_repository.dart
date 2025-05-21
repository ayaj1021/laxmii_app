import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/settings/data/model/delete_account_response.dart';

class DeleteAccountRepository {
  DeleteAccountRepository(this._restClient);
  final RestClient _restClient;

  Future<BaseResponse<DeleteAccountResponse>> deleteAccount() async {
    try {
      final response = await _restClient.deleteAccount();
      return BaseResponse<DeleteAccountResponse>(status: true, data: response);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final deleteAccountRepositoryProvider = Provider<DeleteAccountRepository>(
  (ref) => DeleteAccountRepository(
    ref.read(restClientProvider),
  ),
);
