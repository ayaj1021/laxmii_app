import 'package:laxmii_app/core/utils/enums.dart';

class CreateInventoryNotifierState {
  CreateInventoryNotifierState({
    required this.inputValid,
    required this.createInventoryState,
  });
  factory CreateInventoryNotifierState.initial() {
    return CreateInventoryNotifierState(
      inputValid: false,
      createInventoryState: LoadState.idle,
    );
  }
  final bool inputValid;
  final LoadState createInventoryState;
  CreateInventoryNotifierState copyWith({
    bool? inputValid,
    LoadState? createInventoryState,
  }) {
    return CreateInventoryNotifierState(
      inputValid: inputValid ?? this.inputValid,
      createInventoryState: createInventoryState ?? this.createInventoryState,
    );
  }
}
