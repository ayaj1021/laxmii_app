import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/tax/data/model/get_total_profit_response.dart';

class GetTotalTaxProfitNotifierState {
  GetTotalTaxProfitNotifierState({
    required this.loadState,
    required this.getTotalTaxProfitResponse,
  });
  factory GetTotalTaxProfitNotifierState.initial() {
    return GetTotalTaxProfitNotifierState(
      loadState: LoadState.idle,
      getTotalTaxProfitResponse: GetTotalProfitResponse(),
    );
  }

  final LoadState loadState;

  final GetTotalProfitResponse getTotalTaxProfitResponse;

  GetTotalTaxProfitNotifierState copyWith({
    LoadState? loadState,
    GetTotalProfitResponse? getTotalTaxProfitResponse,
  }) {
    return GetTotalTaxProfitNotifierState(
      loadState: loadState ?? this.loadState,
      getTotalTaxProfitResponse:
          getTotalTaxProfitResponse ?? this.getTotalTaxProfitResponse,
    );
  }
}
