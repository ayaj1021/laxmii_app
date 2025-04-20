import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/manage_account/data/model/update_profile_request.dart';
import 'package:laxmii_app/presentation/features/manage_account/data/model/update_profile_response.dart';

class UpdateProfileRepository {
  UpdateProfileRepository(this._restClient);
  final RestClient _restClient;
  // Future<BaseResponse<UpdateProfileResponse>> updateProfile(
  //     UpdateProfileRequest request) async {
  //   try {
  //     final res = await _restClient.updateProfile(request);
  //     return BaseResponse(status: true, data: res);
  //   } on DioException catch (e) {
  //     return AppException.handleError(e);
  //   }
  // }

  Future<BaseResponse<UpdateProfileResponse>> updateImage(
    UpdateProfileRequest request,
    String imagePath,
  ) async {
    try {
      final formData = FormData();
      log('This is formdata ${formData.fields}');

      formData.fields.add(MapEntry('profile', jsonEncode(request.toJson())));

      if (imagePath.isNotEmpty) {
        final imageFile = await MultipartFile.fromFile(
          imagePath,
          filename: imagePath.split('/').last,
        );
        formData.files.add(MapEntry('profilePicture', imageFile));
      }

      // Make API call
      final res = await _restClient.updateProfile(formData);

      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final updateProfileRepositoryProvider = Provider<UpdateProfileRepository>(
  (ref) => UpdateProfileRepository(
    ref.read(restClientProvider),
  ),
);
