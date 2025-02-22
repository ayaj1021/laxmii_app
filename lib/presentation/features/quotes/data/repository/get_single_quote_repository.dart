import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/quotes/data/model/get_single_quote_response.dart';

class GetSingleQuotesRepository {
  GetSingleQuotesRepository(this._restClient);
  final RestClient _restClient;

  Future<BaseResponse<GetSingleQuoteResponse>> getSingleQuote(
      {required String quoteId}) async {
    try {
      final res = await _restClient.getSingleQuote(quoteId: quoteId);
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final getSingleQuoteRepositoryProvider = Provider<GetSingleQuotesRepository>(
  (ref) => GetSingleQuotesRepository(
    ref.read(restClientProvider),
  ),
);
