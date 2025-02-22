import 'package:laxmii_app/core/config/network_utils/async_response.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/data/model/get_cashflow_response.dart';

class GetCashFlowState {
  final LoadState loadState;
  final AsyncResponse<GetCashFlowResponse> getCashFlow;

  GetCashFlowState({
    required this.loadState,
    required this.getCashFlow,
  });

  factory GetCashFlowState.initial() {
    return GetCashFlowState(
      loadState: LoadState.loading,
      getCashFlow: AsyncResponse.loading(),
    );
  }

  GetCashFlowState copyWith({
    LoadState? loadState,
    AsyncResponse<GetCashFlowResponse>? getCashFlow,
  }) {
    return GetCashFlowState(
      loadState: loadState ?? this.loadState,
      getCashFlow: getCashFlow ?? this.getCashFlow,
    );
  }
}
