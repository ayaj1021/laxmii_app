import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/config/network_utils/async_response.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/data/model/get_cashflow_request.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/data/repository/get_cashflow_repository.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/presentation/notifier/get_cashflow_state.dart';

class GetCashFlowNotifier extends AutoDisposeNotifier<GetCashFlowState> {
  GetCashFlowNotifier();

  late GetCashFlowRepository _getCashFlowRepository;

  @override
  GetCashFlowState build() {
    _getCashFlowRepository = ref.read(getCashFlowRepositoryProvider);

    return GetCashFlowState.initial();
  }

  Future<void> getCashFlow({required String query}) async {
    state = state.copyWith(loadState: LoadState.loading);
    final request = GetCashFlowRequest(queryBy: query);
    try {
      final value = await _getCashFlowRepository.getCashFlow(request);

      if (!value.status) throw value.message.toException;

      state = state.copyWith(
          loadState: LoadState.idle,
          getCashFlow: AsyncResponse.success(value.data!));
    } catch (e) {
      state = state.copyWith(loadState: LoadState.idle);
    }
  }
}

final getCashFlowNotifierProvider =
    NotifierProvider.autoDispose<GetCashFlowNotifier, GetCashFlowState>(
        GetCashFlowNotifier.new);
