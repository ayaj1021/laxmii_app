import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/logger.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/transactions/data/model/create_expense_request.dart';
import 'package:laxmii_app/presentation/features/transactions/data/repository/create_expense_repository.dart';
import 'package:laxmii_app/presentation/features/transactions/presentation/notifier/create_expenses_state.dart';

class CreateExpensesNotifier
    extends AutoDisposeNotifier<CreateExpensesNotifierState> {
  CreateExpensesNotifier();

  late CreateExpensesRepository _createExpensesRepository;

  @override
  CreateExpensesNotifierState build() {
    _createExpensesRepository = ref.read(createExpensesRepositoryProvider);

    return CreateExpensesNotifierState.initial();
  }

  Future<void> createExpenses({
    required CreateExpenseRequest data,
    required void Function(String error) onError,
    required void Function(String message) onSuccess,
  }) async {
    state = state.copyWith(createExpensesState: LoadState.loading);

    try {
      final value = await _createExpensesRepository.createExpenses(data);
      debugLog(data);
      if (!value.status) throw value.message.toException;

      state = state.copyWith(createExpensesState: LoadState.idle);
      onSuccess(value.data!.message.toString());
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(createExpensesState: LoadState.idle);
    }
  }
}

final createExpensesNotifier = NotifierProvider.autoDispose<
    CreateExpensesNotifier, CreateExpensesNotifierState>(
  CreateExpensesNotifier.new,
);
