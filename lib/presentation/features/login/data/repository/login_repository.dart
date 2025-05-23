import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/login/data/model/login_request.dart';
import 'package:laxmii_app/presentation/features/login/data/model/login_response.dart';

class LoginRepository {
  LoginRepository(this._restClient);
  final RestClient _restClient;
  Future<BaseResponse<LoginResponse>> login(LoginRequest request) async {
    try {
      final res = await _restClient.login(request);

      return BaseResponse(
        status: res.status ?? false,
        data: res,
      );
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final loginRepositoryProvider = Provider<LoginRepository>((ref) {
  return LoginRepository(
    ref.read(restClientProvider),
  );
});
