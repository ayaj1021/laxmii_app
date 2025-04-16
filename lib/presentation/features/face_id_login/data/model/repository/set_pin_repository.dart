import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/face_id_login/data/model/set_pin_request.dart';
import 'package:laxmii_app/presentation/features/face_id_login/data/model/set_pin_response.dart';

class SetPinRepository {
  SetPinRepository(this._restClient);
  final RestClient _restClient;
  Future<BaseResponse<SetPinResponse>> setPin(SetPinRequest request) async {
    try {
      final res = await _restClient.setPin(request);
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final setPinRepositoryProvider = Provider<SetPinRepository>(
  (ref) => SetPinRepository(
    ref.read(restClientProvider),
  ),
);
