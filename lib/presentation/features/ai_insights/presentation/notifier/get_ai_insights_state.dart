import 'package:laxmii_app/core/config/network_utils/async_response.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/ai_insights/data/model/ai_insights_response.dart';

class GetAiInsightsState {
  final LoadState loadState;
  final AsyncResponse<AiInsightsResponse> getAiInsights;

  GetAiInsightsState({
    required this.loadState,
    required this.getAiInsights,
  });

  factory GetAiInsightsState.initial() {
    return GetAiInsightsState(
      loadState: LoadState.loading,
      getAiInsights: AsyncResponse.loading(),
    );
  }

  GetAiInsightsState copyWith({
    LoadState? loadState,
    AsyncResponse<AiInsightsResponse>? getAiInsights,
  }) {
    return GetAiInsightsState(
      loadState: loadState ?? this.loadState,
      getAiInsights: getAiInsights ?? this.getAiInsights,
    );
  }
}
