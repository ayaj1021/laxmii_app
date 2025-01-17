import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/sign_up/data/model/sign_up_request.dart';

class SignUpRepository {
  SignUpRepository(this._restClient);
  final RestClient _restClient;
  Future<BaseResponse<dynamic>> signUp(SignUpRequest request) async {
    try {
      final res = await _restClient.signUp(request);
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final signUpRepositoryProvider = Provider<SignUpRepository>(
  (ref) => SignUpRepository(
    ref.read(restClientProvider),
  ),
);
