import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_state.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/transactions/data/model/delete_recurring_expense_response.dart';
import 'package:laxmii_app/presentation/features/transactions/data/repository/delete_recurring_expense_repo.dart';

class DeleteRecurringExpenseNotifier
    extends AutoDisposeNotifier<BaseState<DeleteRecurringExpensesResponse>> {
  DeleteRecurringExpenseNotifier();

  late DeleteRecurringExpenseRepository _repository;

  @override
  BaseState<DeleteRecurringExpensesResponse> build() {
    _repository = ref.read(deleteRecurringExpenseRepositoryProvider);

    return BaseState<DeleteRecurringExpensesResponse>.initial();
  }

  Future<void> deleteRecurring(String itemId,
      {required Function(String) onSuccess}) async {
    state = state.copyWith(state: LoadState.loading);

    try {
      final value = await _repository.deleteRecurring(itemId);

      if (!value.status) throw value.message.toException;

      state = state.copyWith(state: LoadState.idle, data: value.data);
      onSuccess(value.message ?? '');
    } catch (e) {
      state = state.copyWith(state: LoadState.idle);
    }
  }
}

final deleteRecurringNotifierProvider = NotifierProvider.autoDispose<
        DeleteRecurringExpenseNotifier,
        BaseState<DeleteRecurringExpensesResponse>>(
    DeleteRecurringExpenseNotifier.new);
