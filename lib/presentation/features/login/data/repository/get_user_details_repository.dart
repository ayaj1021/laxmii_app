import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/login/data/model/get_user_details_response.dart';

class GetUserDetailsRepository {
  GetUserDetailsRepository(this._restClient);
  final RestClient _restClient;
  Future<BaseResponse<GetUserDetailsResponse>> getUserDetails() async {
    try {
      final res = await _restClient.getUserDetails();
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final getUserDetailsRepositoryProvider = Provider<GetUserDetailsRepository>(
  (ref) => GetUserDetailsRepository(
    ref.read(restClientProvider),
  ),
);
