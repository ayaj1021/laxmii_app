import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_state.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/expenses/data/model/delete_expense_response.dart';
import 'package:laxmii_app/presentation/features/expenses/data/repository/delete_expense_repository.dart';

class DeleteExpenseNotifier
    extends AutoDisposeNotifier<BaseState<DeleteExpenseResponse>> {
  DeleteExpenseNotifier();

  late DeleteExpenseRepository _repository;

  @override
  BaseState<DeleteExpenseResponse> build() {
    _repository = ref.read(deleteExpenseRepositoryProvider);

    return BaseState<DeleteExpenseResponse>.initial();
  }

  Future<void> deleteExpense(
    String invoiceId, {
    required void Function(String error) onError,
    required void Function(String message) onSuccess,
  }) async {
    state = state.copyWith(state: LoadState.loading);

    try {
      final value = await _repository.deleteExpense(invoiceId);

      if (!value.status) throw value.message.toException;

      state = state.copyWith(state: LoadState.idle, data: value.data);
      onSuccess(value.message ?? 'Expense deleted successfully');
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(state: LoadState.idle);
    }
  }
}

final deleteExpenseNotifierProvider = NotifierProvider.autoDispose<
    DeleteExpenseNotifier,
    BaseState<DeleteExpenseResponse>>(DeleteExpenseNotifier.new);
