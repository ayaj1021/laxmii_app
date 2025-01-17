import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/verify_email/data/model/resend_otp_request.dart';

class ResendOtpRepository {
  ResendOtpRepository(this._restClient);
  final RestClient _restClient;
  Future<BaseResponse<dynamic>> resendOtp(ResendOtpRequest request) async {
    try {
      final res = await _restClient.resendOtp(request);
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final resendOtpRepositoryProvider = Provider<ResendOtpRepository>(
  (ref) => ResendOtpRepository(
    ref.read(restClientProvider),
  ),
);
