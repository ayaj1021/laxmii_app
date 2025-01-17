import 'package:laxmii_app/core/utils/enums.dart';

class CreateExpensesNotifierState {
  CreateExpensesNotifierState({
    required this.inputValid,
    required this.createExpensesState,
  });
  factory CreateExpensesNotifierState.initial() {
    return CreateExpensesNotifierState(
      inputValid: false,
      createExpensesState: LoadState.idle,
    );
  }
  final bool inputValid;
  final LoadState createExpensesState;
  CreateExpensesNotifierState copyWith({
    bool? inputValid,
    LoadState? createExpensesState,
  }) {
    return CreateExpensesNotifierState(
      inputValid: inputValid ?? this.inputValid,
      createExpensesState: createExpensesState ?? this.createExpensesState,
    );
  }
}
