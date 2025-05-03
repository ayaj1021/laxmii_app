// // import 'package:dio/dio.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import 'package:laxmii_app/core/config/base_response/base_response.dart';
// // import 'package:laxmii_app/core/config/exception/app_exception.dart';
// // import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
// // import 'package:laxmii_app/presentation/features/manage_account/data/model/update_profile_request.dart';
// // import 'package:laxmii_app/presentation/features/manage_account/data/model/update_profile_response.dart';

// // class UpdateProfileRepository {
// //   final RestClient _restClient;

// //   UpdateProfileRepository(this._restClient);

// //   Future<BaseResponse<UpdateProfileResponse>> updateImage(
// //     UpdateProfileRequest request,
// //     String imagePath,
// //   ) async {
// //     try {
// //       final imageFile = imagePath.isNotEmpty
// //           ? await MultipartFile.fromFile(
// //               imagePath,
// //               filename: imagePath.split('/').last,
// //             )
// //           : null;

// //       final response = await _restClient.updateProfile(
// //         businessName: request.businessName,
// //         phoneNumber: request.phoneNumber,
// //         address: request.address,
// //         accountName: request.accountName,
// //         accountNumber: request.accountNumber,
// //         bankName: request.bankName,
// //         profilePicture: imageFile,
// //       );

// //       return BaseResponse(status: true, data: response);
// //     } on DioException catch (e) {
// //       return AppException.handleError(e);
// //     }
// //   }
// // }

// import 'package:dio/dio.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:laxmii_app/presentation/features/manage_account/data/model/update_profile_response.dart';

// class UpdateProfileRepository {
//   final Dio _dio;

//   UpdateProfileRepository(this._dio);

//   Future<UpdateProfileResponse> updateImage({
//     required String businessName,
//     required String phoneNumber,
//     required String address,
//     required String accountName,
//     required String accountNumber,
//     required String bankName,
//     MultipartFile? profilePicture,
//   }) async {
//     try {
//       // Create form data
//       final formData = FormData.fromMap({
//         'businessName': businessName,
//         'phoneNumber': phoneNumber,
//         'address': address,
//         'accountName': accountName,
//         'accountNumber': accountNumber,
//         'bankName': bankName,
//         if (profilePicture != null) 'profilePicture': profilePicture,
//       });

//       // Make the API call
//       final response = await _dio.post(
//         '/auth/profile/',
//         data: formData,
//       );

//       // Parse the response
//       return UpdateProfileResponse.fromJson(response.data);
//     } catch (e) {
//       rethrow;
//     }
//   }
// }

// // Provider for the service
// final updateProfileRepositoryProvider = Provider<UpdateProfileRepository>((ref) {
//   final dio = ref.read(dioProvider); // You'll need to create this provider
//   return UpdateProfileRepository(dio);
// });

// // You might already have this provider in your app
// final dioProvider = Provider<Dio>((ref) {
//   final dio = Dio(BaseOptions(
//     baseUrl: 'YOUR_BASE_URL', // Replace with your actual base URL
//     connectTimeout: const Duration(seconds: 30),
//     receiveTimeout: const Duration(seconds: 30),
//   ));

//   // Add your interceptors here if needed

//   return dio;
// });

// // final updateProfileRepositoryProvider = Provider<UpdateProfileRepository>(
// //   (ref) => UpdateProfileRepository(
// //     ref.read(restClientProvider),
// //   ),
// // );

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/presentation/features/manage_account/data/model/update_profile_request.dart';
import 'package:laxmii_app/presentation/features/manage_account/data/model/update_profile_response.dart';
import 'package:laxmii_app/presentation/features/manage_account/data/repository/profile_api_service.dart';

class UpdateProfileRepository {
  final ProfileApiService _profileApiService;

  UpdateProfileRepository(this._profileApiService);

  /// Updates the user profile with optional image upload
  ///
  /// [request] contains the profile data
  /// [imagePath] is the local path to the profile image file (empty string if no image)
  Future<BaseResponse<UpdateProfileResponse>> updateImage(
    UpdateProfileRequest request,
    String imagePath,
  ) async {
    try {
      // Only create MultipartFile if imagePath is not empty
      final imageFile = imagePath.isNotEmpty
          ? await MultipartFile.fromFile(
              imagePath,
              filename: imagePath.split('/').last,
            )
          : null;

      // Call the manual API service instead of RestClient
      final response = await _profileApiService.updateProfile(
        businessName: request.businessName,
        phoneNumber: request.phoneNumber,
        address: request.address,
        accountName: request.accountName,
        accountNumber: request.accountNumber,
        bankName: request.bankName,
        profilePicture: imageFile,
      );

      // Return successful response
      return BaseResponse(
        status: true,
        data: response,
        message: 'Profile updated successfully',
      );
    } on DioException catch (e) {
      // Handle API errors
      return AppException.handleError(e);
    } catch (e) {
      // Handle other errors
      return BaseResponse(
        status: false,
        message: e.toString(),
      );
    }
  }
}

// Update the provider to use ProfileApiService
final updateProfileRepositoryProvider = Provider<UpdateProfileRepository>(
  (ref) => UpdateProfileRepository(
    ref.read(profileApiServiceProvider),
  ),
);
