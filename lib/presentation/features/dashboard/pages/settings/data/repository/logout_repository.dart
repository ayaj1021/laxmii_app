import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/settings/data/model/logout_request.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/settings/data/model/logout_response.dart';

class LogoutRepository {
  LogoutRepository(this._restClient);
  final RestClient _restClient;

  Future<BaseResponse<LogoutResponse>> logOut(LogoutRequest request) async {
    try {
      final response = await _restClient.logout(request);
      return BaseResponse<LogoutResponse>(status: true, data: response);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final logOutRepositoryProvider = Provider<LogoutRepository>(
  (ref) => LogoutRepository(
    ref.read(restClientProvider),
  ),
);
