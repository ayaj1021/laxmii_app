import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/inventory/data/model/create_inventory_request.dart';
import 'package:laxmii_app/presentation/features/inventory/data/model/create_inventory_response.dart';

class CreateInventoryRepository {
  CreateInventoryRepository(this._restClient);
  final RestClient _restClient;
  Future<BaseResponse<CreateInventoryResponse>> createInventory(
      CreateInventoryRequest request) async {
    try {
      final res = await _restClient.createInventory(request);
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final createInventoryRepositoryProvider = Provider<CreateInventoryRepository>(
  (ref) => CreateInventoryRepository(
    ref.read(restClientProvider),
  ),
);
