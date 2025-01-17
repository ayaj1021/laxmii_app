import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/forgot_password/data/model/change_password_request.dart';

class ChangePasswordRepository {
  ChangePasswordRepository(this._restClient);
  final RestClient _restClient;
  Future<BaseResponse<dynamic>> changePassword(
      ChangePasswordRequest request) async {
    try {
      final res = await _restClient.changePassword(request);
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final changePasswordRepositoryProvider = Provider<ChangePasswordRepository>(
  (ref) => ChangePasswordRepository(
    ref.read(restClientProvider),
  ),
);
