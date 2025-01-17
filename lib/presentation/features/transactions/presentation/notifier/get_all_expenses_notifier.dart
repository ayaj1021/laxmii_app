import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/config/network_utils/async_response.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/transactions/data/repository/get_all_expenses_repository.dart';
import 'package:laxmii_app/presentation/features/transactions/presentation/notifier/get_all_expenses_state.dart';

class GetAllExpensesNotifier extends AutoDisposeNotifier<GetAllExpensesState> {
  GetAllExpensesNotifier();

  late GetAllExpensesRepository _getAllExpensesRepository;

  @override
  GetAllExpensesState build() {
    _getAllExpensesRepository = ref.read(getAllExpensesRepositoryProvider);

    return GetAllExpensesState.initial();
  }

  Future<void> getAllExpenses() async {
    state = state.copyWith(loadState: LoadState.loading);

    try {
      final value = await _getAllExpensesRepository.getAllExpenses();

      if (!value.status) throw value.message.toException;

      state = state.copyWith(
          loadState: LoadState.idle,
          getAllExpenses: AsyncResponse.success(value.data!));
    } catch (e) {
      state = state.copyWith(loadState: LoadState.idle);
    }
  }
}

final getAllExpensesNotifierProvider =
    NotifierProvider.autoDispose<GetAllExpensesNotifier, GetAllExpensesState>(
        GetAllExpensesNotifier.new);
