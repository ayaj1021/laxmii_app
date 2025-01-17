import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/inventory/data/model/update_inventory_request.dart';
import 'package:laxmii_app/presentation/features/inventory/data/model/update_inventory_response.dart';

class UpdateInventoryRepository {
  UpdateInventoryRepository(this._restClient);
  final RestClient _restClient;
  Future<BaseResponse<UpdateInventoryResponse>> updateInventory(
      UpdateInventoryRequest request,
      {required String inventoryId}) async {
    try {
      final res =
          await _restClient.updateInventory(request, inventoryId: inventoryId);
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final updateInventoryRepositoryProvider = Provider<UpdateInventoryRepository>(
  (ref) => UpdateInventoryRepository(
    ref.read(restClientProvider),
  ),
);
