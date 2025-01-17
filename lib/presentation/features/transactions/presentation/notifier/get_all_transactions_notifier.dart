import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/config/network_utils/async_response.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/transactions/data/repository/get_all_transactions_repository.dart';
import 'package:laxmii_app/presentation/features/transactions/presentation/notifier/get_all_transactions_state.dart';

class GetAllTransactionsNotifier
    extends AutoDisposeNotifier<GetAllTransactionsState> {
  GetAllTransactionsNotifier();

  late GetAllTransactionsRepository _getAllTransactionsRepository;

  @override
  GetAllTransactionsState build() {
    _getAllTransactionsRepository =
        ref.read(getAllTransactionsRepositoryProvider);

    return GetAllTransactionsState.initial();
  }

  Future<void> getAllTransactions() async {
    state = state.copyWith(loadState: LoadState.loading);

    try {
      final value = await _getAllTransactionsRepository.getAllTransactions();

      if (!value.status) throw value.message.toException;

      state = state.copyWith(
          loadState: LoadState.idle,
          getAllTransactions: AsyncResponse.success(value.data!));
    } catch (e) {
      state = state.copyWith(loadState: LoadState.idle);
    }
  }
}

final getAllTransactionsNotifierProvider = NotifierProvider.autoDispose<
    GetAllTransactionsNotifier,
    GetAllTransactionsState>(GetAllTransactionsNotifier.new);
