import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/presentation/features/profile_setup/data/model/get_country_currency_response.dart';

class GetCountryCurrencyRepository {
  final Dio _dio = Dio();
  Future<AllCountriesResponse> getAllCountries() async {
    try {
      final res = await _dio.get('https://restcountries.com/v3.1/all');
      final data = await res.data;

      return AllCountriesResponse.fromJson(data);
    } on DioException catch (e) {
      return Future.error(e);
      // throw DioException(e.message);
    }
  }
}

final getAllCountriesProvider = Provider<GetCountryCurrencyRepository>(
  (ref) => GetCountryCurrencyRepository(),
);
