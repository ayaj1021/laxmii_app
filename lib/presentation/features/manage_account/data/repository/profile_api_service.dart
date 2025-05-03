import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
// Import your dio provider or create one
import 'package:laxmii_app/presentation/features/manage_account/data/model/update_profile_response.dart';

/// Service class that handles profile-related API calls without using retrofit
class ProfileApiService {
  final Dio _dio;

  ProfileApiService(this._dio);

  /// Updates user profile with optional image upload
  ///
  /// This method manually creates a multipart request to update the profile
  Future<UpdateProfileResponse> updateProfile({
    required String businessName,
    required String phoneNumber,
    required String address,
    required String accountName,
    required String accountNumber,
    required String bankName,
    MultipartFile? profilePicture,
  }) async {
    try {
      // Create form data for multipart request
      final formData = FormData.fromMap({
        'businessName': businessName,
        'phoneNumber': phoneNumber,
        'address': address,
        'accountName': accountName,
        'accountNumber': accountNumber,
        'bankName': bankName,
        // Only add profile picture if it's not null
        if (profilePicture != null) 'profilePicture': profilePicture,
      });

      final accessToken = await AppDataStorage().getUserAccessToken();

      // Make the API call with multipart data
      final response = await _dio.put(
        '/auth/profile/',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      // Parse the response data into the response model
      return UpdateProfileResponse.fromJson(response.data);
    } on DioException {
      // Let the repository handle DioExceptions
      rethrow;
    } catch (e) {
      // Rethrow other exceptions
      rethrow;
    }
  }
}

/// Provider for ProfileApiService
final profileApiServiceProvider = Provider<ProfileApiService>((ref) {
  // This assumes you have a dioProvider defined elsewhere
  // If you don't, you'll need to create one
  final dio = ref.read(dioProvider);
  return ProfileApiService(dio);
});

/// If you don't have a dioProvider yet, here's a simple implementation
/// You can move this to a separate file
final dioProvider = Provider<Dio>((ref) {
  // You may want to get these values from your configuration
  final baseUrl =
      'https://laxmii.onrender.com'; // Replace with your actual base URL

  final dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {
      'Accept': 'application/json',
    },
  ));

  // Add any interceptors you need
  // dio.interceptors.add(YourInterceptor());

  return dio;
});
