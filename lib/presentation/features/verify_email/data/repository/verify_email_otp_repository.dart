import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/verify_email/data/model/verify_email_otp_request.dart';

class VerifyEmailOtpRepository {
  VerifyEmailOtpRepository(this._restClient);
  final RestClient _restClient;
  Future<BaseResponse<dynamic>> verifyEmailOtp(VerifyEmailOtpRequest request) async {
    try {
      final res = await _restClient.verifyEmailOtp(request);
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final verifyEmailOtpRepositoryProvider = Provider<VerifyEmailOtpRepository>(
  (ref) => VerifyEmailOtpRepository(
    ref.read(restClientProvider),
  ),
);
