import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/quotes/data/model/delete_quote_response.dart';

class DeleteQuotesRepository {
  DeleteQuotesRepository(this._restClient);
  final RestClient _restClient;
  Future<BaseResponse<DeleteQuoteResponse>> deleteQuote(
      {required String quoteId}) async {
    try {
      final res = await _restClient.deleteQuote(quoteId: quoteId);
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final deleteQuoteRepositoryProvider = Provider<DeleteQuotesRepository>(
  (ref) => DeleteQuotesRepository(
    ref.read(restClientProvider),
  ),
);
