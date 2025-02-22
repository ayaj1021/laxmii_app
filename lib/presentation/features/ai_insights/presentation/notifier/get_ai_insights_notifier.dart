import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/config/network_utils/async_response.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/ai_insights/data/model/ai_insights_request.dart';
import 'package:laxmii_app/presentation/features/ai_insights/data/repository/ai_insights_repository.dart';
import 'package:laxmii_app/presentation/features/ai_insights/presentation/notifier/get_ai_insights_state.dart';

class GetAiInsightsNotifier extends AutoDisposeNotifier<GetAiInsightsState> {
  GetAiInsightsNotifier();

  late GetAiInsightsRepository _getAiInsightsRepository;

  @override
  GetAiInsightsState build() {
    _getAiInsightsRepository = ref.read(getAiInsightsRepositoryProvider);

    return GetAiInsightsState.initial();
  }

  Future<void> getAiInsights({
    required AiInsightsRequest request,
  }) async {
    state = state.copyWith(loadState: LoadState.loading);

    try {
      final value = await _getAiInsightsRepository.getAiInsights(request);

      if (!value.status) throw value.message.toException;

      state = state.copyWith(
          loadState: LoadState.idle,
          getAiInsights: AsyncResponse.success(value.data!));
    } catch (e) {
      state = state.copyWith(loadState: LoadState.idle);
    }
  }
}

final getAiIsightsNotifierProvider =
    NotifierProvider.autoDispose<GetAiInsightsNotifier, GetAiInsightsState>(
        GetAiInsightsNotifier.new);
