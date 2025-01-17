import 'package:laxmii_app/core/utils/enums.dart';

class DeleteInventoryNotifierState {
  DeleteInventoryNotifierState({
    required this.inputValid,
    required this.deleteInventoryState,
  });
  factory DeleteInventoryNotifierState.initial() {
    return DeleteInventoryNotifierState(
      inputValid: false,
      deleteInventoryState: LoadState.idle,
    );
  }
  final bool inputValid;
  final LoadState deleteInventoryState;
  DeleteInventoryNotifierState copyWith({
    bool? inputValid,
    LoadState? deleteInventoryState,
  }) {
    return DeleteInventoryNotifierState(
      inputValid: inputValid ?? this.inputValid,
      deleteInventoryState: deleteInventoryState ?? this.deleteInventoryState,
    );
  }
}
