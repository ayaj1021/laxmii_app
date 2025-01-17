import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/inventory/data/model/delete_inventory_response.dart';

class DeleteInventoryRepository {
  DeleteInventoryRepository(this._restClient);
  final RestClient _restClient;
  Future<BaseResponse<DeleteInventoryResponse>> deleteInventory(
      {required String inventoryId}) async {
    try {
      final res = await _restClient.deleteInventory(inventoryId: inventoryId);
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final deleteInventoryRepositoryProvider = Provider<DeleteInventoryRepository>(
  (ref) => DeleteInventoryRepository(
    ref.read(restClientProvider),
  ),
);
