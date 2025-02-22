import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/quotes/data/model/create_quotes_request.dart';
import 'package:laxmii_app/presentation/features/quotes/data/model/create_quotes_response.dart';

class CreateQuotesRepository {
  CreateQuotesRepository(this._restClient);
  final RestClient _restClient;
  Future<BaseResponse<CreateQuotesResponse>> createQuotes(
      CreateQuotesRequest request) async {
    try {
      final res = await _restClient.createQuotes(request);
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final createQuotesRepositoryProvider = Provider<CreateQuotesRepository>(
  (ref) => CreateQuotesRepository(
    ref.read(restClientProvider),
  ),
);
