import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/forgot_password/data/model/forgot_password_request.dart';

class ForgotPasswordRepository {
  ForgotPasswordRepository(this._restClient);
  final RestClient _restClient;
  Future<BaseResponse<dynamic>> forgotPassword(
      ForgotPasswordRequest request) async {
    try {
      final res = await _restClient.forgotPassword(request);
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final forgotPasswordRepositoryProvider = Provider<ForgotPasswordRepository>(
  (ref) => ForgotPasswordRepository(
    ref.read(restClientProvider),
  ),
);
