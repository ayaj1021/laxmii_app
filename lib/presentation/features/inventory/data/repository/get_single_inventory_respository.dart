import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/inventory/data/model/get_single_inventory_response.dart';

class GetSingleInventoryRepository {
  GetSingleInventoryRepository(this._restClient);
  final RestClient _restClient;

  Future<BaseResponse<GetSingleInventoryResponse>> getSingleInventory(
      {required String singleInventoryId}) async {
    try {
      final res =
          await _restClient.getSingleInventory(inventoryId: singleInventoryId);
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final getSingleInventoryRepositoryProvider =
    Provider<GetSingleInventoryRepository>(
  (ref) => GetSingleInventoryRepository(
    ref.read(restClientProvider),
  ),
);
