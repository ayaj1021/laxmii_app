import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/quotes/data/model/get_quote_no_response.dart';

class GetQuoteNoRepository {
  GetQuoteNoRepository(this._restClient);
  final RestClient _restClient;

  Future<BaseResponse<GetQuoteNoResponse>> getQuoteNo() async {
    try {
      final res = await _restClient.getQuoteNo();
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final getQuoteNoRepositoryProvider = Provider<GetQuoteNoRepository>(
  (ref) => GetQuoteNoRepository(
    ref.read(restClientProvider),
  ),
);
