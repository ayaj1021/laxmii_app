import 'package:laxmii_app/core/config/network_utils/async_response.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/transactions/data/model/get_all_expenses_response.dart';

class GetAllExpensesState {
  final LoadState loadState;
  final AsyncResponse<GetAllExpensesResponse> getAllExpenses;

  GetAllExpensesState({
    required this.loadState,
    required this.getAllExpenses,
  });

  factory GetAllExpensesState.initial() {
    return GetAllExpensesState(
      loadState: LoadState.loading,
      getAllExpenses: AsyncResponse.loading(),
    );
  }

  GetAllExpensesState copyWith({
    LoadState? loadState,
    AsyncResponse<GetAllExpensesResponse>? getAllExpenses,
  }) {
    return GetAllExpensesState(
      loadState: loadState ?? this.loadState,
      getAllExpenses: getAllExpenses ?? this.getAllExpenses,
    );
  }
}
