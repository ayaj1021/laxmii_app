import 'package:laxmii_app/core/config/network_utils/async_response.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/inventory/data/model/get_single_inventory_response.dart';

class GetSingleInventoryState {
  final LoadState loadState;
  final AsyncResponse<GetSingleInventoryResponse> getSingleInventory;

  GetSingleInventoryState({
    required this.loadState,
    required this.getSingleInventory,
  });

  factory GetSingleInventoryState.initial() {
    return GetSingleInventoryState(
      loadState: LoadState.loading,
      getSingleInventory: AsyncResponse.loading(),
    );
  }

  GetSingleInventoryState copyWith({
    LoadState? loadState,
    AsyncResponse<GetSingleInventoryResponse>? getSingleInventory,
  }) {
    return GetSingleInventoryState(
      loadState: loadState ?? this.loadState,
      getSingleInventory: getSingleInventory ?? this.getSingleInventory,
    );
  }
}
