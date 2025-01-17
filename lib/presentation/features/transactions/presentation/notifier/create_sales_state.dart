import 'package:laxmii_app/core/utils/enums.dart';

class CreateSalesNotifierState {
  CreateSalesNotifierState({
    required this.inputValid,
    required this.createSalesState,
  });
  factory CreateSalesNotifierState.initial() {
    return CreateSalesNotifierState(
      inputValid: false,
      createSalesState: LoadState.idle,
    );
  }
  final bool inputValid;
  final LoadState createSalesState;
  CreateSalesNotifierState copyWith({
    bool? inputValid,
    LoadState? createSalesState,
  }) {
    return CreateSalesNotifierState(
      inputValid: inputValid ?? this.inputValid,
      createSalesState: createSalesState ?? this.createSalesState,
    );
  }
}
