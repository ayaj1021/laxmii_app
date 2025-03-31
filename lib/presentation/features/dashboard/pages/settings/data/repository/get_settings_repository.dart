import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/settings/data/model/settings_response.dart';

class GetSettingsRepository {
  GetSettingsRepository(this._restClient);
  final RestClient _restClient;

  Future<BaseResponse<SettingsResponse>> getSettings() async {
    try {
      final response = await _restClient.getSettings();
      return BaseResponse<SettingsResponse>(status: true, data: response);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final getSettingsRepositoryProvider = Provider<GetSettingsRepository>(
  (ref) => GetSettingsRepository(
    ref.read(restClientProvider),
  ),
);
