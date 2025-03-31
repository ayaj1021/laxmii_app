import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/settings/data/model/update_settings_request.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/settings/data/model/update_settings_response.dart';

class UpdateSettingsRepository {
  UpdateSettingsRepository(this._restClient);
  final RestClient _restClient;

  Future<BaseResponse<UpdateSettingsResponse>> updateSettings(
      UpdateSettingsRequest request) async {
    try {
      final response = await _restClient.updateSettings(request);
      return BaseResponse<UpdateSettingsResponse>(status: true, data: response);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final updateSettingsRepositoryProvider = Provider<UpdateSettingsRepository>(
  (ref) => UpdateSettingsRepository(
    ref.read(restClientProvider),
  ),
);
