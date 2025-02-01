import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/env/dev_env.dart';
import 'package:laxmii_app/core/config/exception/logger.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/settings/presentation/notifier/logout_notifier.dart';

class HeaderInterCeptor extends Interceptor {
  HeaderInterCeptor({
    required this.dio,
    required this.secureStorage,
    required this.onTokenExpired,
    required this.ref,
  });
  final Dio dio;
  final Ref ref;
  final AppDataStorage secureStorage;
  final void Function() onTokenExpired;

  // final _authRoutes = [
  //   '/login',
  //   '/register',
  //   '/auth/create-pin',
  //   '/resendtoken',
  //   '/user/logout',
  //   '/auth/forgot-password',
  //   '/auth/reset-password',
  //   '/auth/verify-signup-otp',
  //   '/user/change-pin',
  //   '/user/change-password',
  //   '/user/delete',
  // ];

  // final _optionalRoutes = [
  //   '/user/change-pin',
  //   '/user/change-password',
  //   '/auth/recover',
  //   '/user/logout',
  //   '/user/refer',
  //   '/user/delete',
  // ];
  @override
  FutureOr<dynamic> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final accessToken = await secureStorage.getUserAccessToken();

      debugLog("This is user accesstoken $accessToken");
      // log("This is user token $token");

      debugLog('[ACCESS TOKEN]$accessToken');

      // options.headers['Authorization'] = 'Bearer $accessToken';

      if (accessToken.toString().isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
    } catch (e) {
      debugLog(e);
    }

    // try {
    //   final token = userRepository.getToken();
    //   if (token.isNotEmpty) {
    //     options.headers['Authorization'] = 'Bearer $token';
    //     debugLog('[TOKEN]$token');
    //   }
    // } catch (e) {
    //   debugLog(e);
    // }
    debugLog('[URL]${options.uri}');
    debugLog('[BODY] ${options.data}');
    debugLog('[METHOD] ${options.method}');
    debugLog('[QUERIES]${options.queryParameters}');
    debugLog('[HEADERS]${options.headers}');

    handler.next(options);
    return options;
  }

  @override
  FutureOr<dynamic> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response != null && err.response!.statusCode == 401) {
      await _refreshToken(err, handler, dio, secureStorage, ref);
      return;
    }
    debugLog('[ERROR] ${err.requestOptions.uri}');
    debugLog('[ERROR] ${err.response}');
    handler.next(err);
    return err;
  }

  @override
  FutureOr<dynamic> onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    debugLog(
      '[RESPONSE FROM ${response.requestOptions.path}]: ${response.data}',
    );
    handler.next(response);
    return response;
  }
}

// Future<void> _refreshToken(
//   DioException error,
//   ErrorInterceptorHandler handler,
//   Dio dio,
//   AppDataStorage secureStorage,
//   Ref ref,
// ) async {
//   final refreshToken = secureStorage.getUserRefreshToken();
//   try {
//     final r = await Dio().post<Response<Map<String, dynamic>?>>(
//       '${DevEnv().baseUrl}/auth/get-access-token',
//       data: {
//         'token': refreshToken,
//       },
//     );
//     if (r.statusCode == 200) {
//     //  userRepository.saveToken(r.data['newAccessToken']);
//       secureStorage.saveUserAccessToken(r.data);
//     }
//     return handleError(handler, error, dio);
//   } on DioException catch (_) {
//     // ref.read(homeNotifier.notifier).logout();
//     return;
//   }
// }

Future<void> _refreshToken(DioException error, ErrorInterceptorHandler handler,
    Dio dio, AppDataStorage secureStorage, Ref ref) async {
  final refreshToken = secureStorage.getUserRefreshToken();
  try {
    final r = await Dio().post(
      '${DevEnv().baseUrl}/auth/get-access-token',
      data: {"token": refreshToken},
    );

    if (r.statusCode == 200) {
      secureStorage.saveUserAccessToken(r.data['accessToken']);
      debugLog("Access Token gotten and saved");
    }
    return handleError(handler, error, dio);
  } on DioException catch (e) {
    debugLog('refresh error===>> $e');
    ref.read(logOutNotifer.notifier).logout();
    return;
  }
}

Future<void> handleError(
  ErrorInterceptorHandler handler,
  DioException err,
  Dio dio,
) async {
  final opts = Options(
    method: err.requestOptions.method,
    headers: err.requestOptions.headers,
  );
  final cloneReq = await dio.request<Map<String, dynamic>?>(
    err.requestOptions.path,
    options: opts,
    data: err.requestOptions.data,
    queryParameters: err.requestOptions.queryParameters,
  );

  return handler.resolve(cloneReq);
}
