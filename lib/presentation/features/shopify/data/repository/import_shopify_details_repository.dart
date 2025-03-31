import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/shopify/data/model/import_shopify_details_response.dart';

class ImportShopifyDetailsRepository {
  ImportShopifyDetailsRepository(this._restClient);
  final RestClient _restClient;
  Future<BaseResponse<ImportShopifyDetailsResponse>>
      importShopifyDetails() async {
    try {
      final res = await _restClient.importShopifyDetails();
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final importShopifyDetailsRepositoryProvider =
    Provider<ImportShopifyDetailsRepository>(
  (ref) => ImportShopifyDetailsRepository(
    ref.read(restClientProvider),
  ),
);
