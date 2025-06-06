import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/login/data/model/google_sign_in_request.dart';
import 'package:laxmii_app/presentation/features/login/data/model/login_response.dart';

class AppleSignInRepository {
  AppleSignInRepository(this._restClient);
  final RestClient _restClient;
  Future<BaseResponse<LoginResponse>> appleSignIn(
      GoogleSignInRequest request) async {
    try {
      final res = await _restClient.appleAuth(request);
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final appleSignInRepositoryProvider = Provider<AppleSignInRepository>(
  (ref) => AppleSignInRepository(
    ref.read(restClientProvider),
  ),
);
