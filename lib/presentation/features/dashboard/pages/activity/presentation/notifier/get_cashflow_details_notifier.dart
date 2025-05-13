import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_state.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/data/model/get_graph_details_request.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/data/model/get_graph_details_response.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/data/repository/get_cashflow_details_repo.dart';

class GetCashFlowDetailsNotifier
    extends AutoDisposeNotifier<BaseState<GetIncomeGraphDetailsResponse>> {
  GetCashFlowDetailsNotifier();

  late GetCashFlowDetailsRepository _repository;

  @override
  BaseState<GetIncomeGraphDetailsResponse> build() {
    _repository = ref.read(getCashFlowDetailsRepositoryProvider);

    return BaseState<GetIncomeGraphDetailsResponse>.initial();
  }

  Future<void> getCashFlowDetails(
      {required GetGraphDetailsRequest request}) async {
    state = state.copyWith(state: LoadState.loading);

    try {
      final value = await _repository.getCashFlowDetails(request);

      if (!value.status) throw value.message.toException;

      state = state.copyWith(state: LoadState.idle, data: value.data);
    } catch (e) {
      state = state.copyWith(state: LoadState.idle);
    }
  }
}

final getCashFlowDetailsNotifierProvider = NotifierProvider.autoDispose<
    GetCashFlowDetailsNotifier,
    BaseState<GetIncomeGraphDetailsResponse>>(GetCashFlowDetailsNotifier.new);
