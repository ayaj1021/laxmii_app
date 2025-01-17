import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/inventory/data/model/update_inventory_response.dart';

class UpdateInventoryNotifierState {
  UpdateInventoryNotifierState({
    required this.inputValid,
    required this.updateInventoryState,
    required this.updateInventoryResponse,
  });
  factory UpdateInventoryNotifierState.initial() {
    return UpdateInventoryNotifierState(
      inputValid: false,
      updateInventoryState: LoadState.idle,
      updateInventoryResponse: UpdateInventoryResponse(),
    );
  }
  final bool inputValid;
  final LoadState updateInventoryState;
  final UpdateInventoryResponse updateInventoryResponse;
  UpdateInventoryNotifierState copyWith({
    bool? inputValid,
    LoadState? updateInventoryState,
    UpdateInventoryResponse? updateInventoryResponse,
  }) {
    return UpdateInventoryNotifierState(
      inputValid: inputValid ?? this.inputValid,
      updateInventoryState: updateInventoryState ?? this.updateInventoryState,
      updateInventoryResponse:
          updateInventoryResponse ?? this.updateInventoryResponse,
    );
  }
}
