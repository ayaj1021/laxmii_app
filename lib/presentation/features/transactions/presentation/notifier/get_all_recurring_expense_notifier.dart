import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_state.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/transactions/data/model/get_recurring_expense_response.dart';
import 'package:laxmii_app/presentation/features/transactions/data/repository/get_recurring_expense_repo.dart';

class GetRecurringExpenseNotifier
    extends AutoDisposeNotifier<BaseState<GetRecurringExpensesResponse>> {
  GetRecurringExpenseNotifier();

  late GetAllRecurringExpenseRepository _repository;

  @override
  BaseState<GetRecurringExpensesResponse> build() {
    _repository = ref.read(getRecurringExpenseRepositoryProvider);

    return BaseState<GetRecurringExpensesResponse>.initial();
  }

  Future<void> getAllRecurring() async {
    state = state.copyWith(state: LoadState.loading);

    try {
      final value = await _repository.getAllRecurring();

      if (!value.status) throw value.message.toException;

      state = state.copyWith(state: LoadState.idle, data: value.data);
    } catch (e) {
      state = state.copyWith(state: LoadState.idle);
    }
  }
}

final getRecurringNotifierProvider = NotifierProvider.autoDispose<
    GetRecurringExpenseNotifier,
    BaseState<GetRecurringExpensesResponse>>(GetRecurringExpenseNotifier.new);
