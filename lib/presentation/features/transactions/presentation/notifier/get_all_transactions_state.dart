import 'package:laxmii_app/core/config/network_utils/async_response.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/transactions/data/model/get_all_transactions_response.dart';

class GetAllTransactionsState {
  final LoadState loadState;
  final AsyncResponse<GetAllTransactionsResponse> getAllTransactions;

  GetAllTransactionsState({
    required this.loadState,
    required this.getAllTransactions,
  });

  factory GetAllTransactionsState.initial() {
    return GetAllTransactionsState(
      loadState: LoadState.loading,
      getAllTransactions: AsyncResponse.loading(),
    );
  }

  GetAllTransactionsState copyWith({
    LoadState? loadState,
    AsyncResponse<GetAllTransactionsResponse>? getAllTransactions,
  }) {
    return GetAllTransactionsState(
      loadState: loadState ?? this.loadState,
      getAllTransactions: getAllTransactions ?? this.getAllTransactions,
    );
  }
}
