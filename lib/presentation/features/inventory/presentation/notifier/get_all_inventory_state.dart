import 'package:laxmii_app/core/config/network_utils/async_response.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/inventory/data/model/get_all_inventory_response.dart';

class GetAllInventoryState {
  final LoadState loadState;
  final AsyncResponse<GetInventoryResponse> getAllInventory;
  // final GetAllUserDetailsResponse getAllDetails;

  GetAllInventoryState({
    required this.loadState,
    required this.getAllInventory,
  });

  factory GetAllInventoryState.initial() {
    return GetAllInventoryState(
      loadState: LoadState.loading,
      getAllInventory: AsyncResponse.loading(),
      // getAllDetails: GetAllUserDetailsResponse(),
    );
  }

  GetAllInventoryState copyWith({
    LoadState? loadState,
    AsyncResponse<GetInventoryResponse>? getAllInventory,
    //GetAllUserDetailsResponse? getAllDetails,
  }) {
    return GetAllInventoryState(
      loadState: loadState ?? this.loadState,
      getAllInventory: getAllInventory ?? this.getAllInventory,
    );
  }
}
