import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/profile_setup/data/model/set_up_profile_response.dart';
import 'package:laxmii_app/presentation/features/profile_setup/data/model/setup_profile_request.dart';

class SetupProfileRepository {
  SetupProfileRepository(this._restClient);
  final RestClient _restClient;
  Future<BaseResponse<SetupUpProfileResponse>> setupProfile(
      SetupUpProfileRequest request) async {
    try {
      final res = await _restClient.setupProfile(request);
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final setupProfileRepositoryProvider = Provider<SetupProfileRepository>(
  (ref) => SetupProfileRepository(
    ref.read(restClientProvider),
  ),
);
