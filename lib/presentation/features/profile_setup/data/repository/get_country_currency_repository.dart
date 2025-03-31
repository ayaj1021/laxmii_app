// import 'package:dio/dio.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:laxmii_app/presentation/features/profile_setup/data/model/get_country_currency_response.dart';

// class GetCountryCurrencyRepository {
//   final Dio _dio = Dio();
//   Future<AllCountriesResponse> getAllCountries() async {
//     try {
//       final res = await _dio.get('https://restcountries.com/v3.1/all');
//       final data = await res.data;

//       return AllCountriesResponse.fromJson(data);
//     } on DioException catch (e) {
//       return Future.error(e);
//       // throw DioException(e.message);
//     }
//   }
// }

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/presentation/features/profile_setup/data/model/get_country_currency_response.dart';

class GetCountryCurrencyRepository {
  final Dio _dio = Dio();

  Future<List<AllCountriesResponse>> getAllCountries() async {
    try {
      final res = await _dio.get('https://restcountries.com/v3.1/all');
      log('This are countries $res');
      final data = res.data as List<dynamic>;
      return data.map((json) => AllCountriesResponse.fromJson(json)).toList();
    } on DioException catch (e) {
      return Future.error(e);
    }
  }
}

final getAllCountriesProvider = Provider<GetCountryCurrencyRepository>(
  (ref) => GetCountryCurrencyRepository(),
);
