import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/logger.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/tax/data/model/get_total_profit_request.dart';
import 'package:laxmii_app/presentation/features/tax/data/repository/get_total_profit_repository.dart';
import 'package:laxmii_app/presentation/features/tax/presentation/notifier/get_total_tax_profit_state.dart';

class GetTaxProfitNotifier
    extends AutoDisposeNotifier<GetTotalTaxProfitNotifierState> {
  GetTaxProfitNotifier();

  late GetTotalTaxProfitRepository _getTotalTaxProfitRepository;

  @override
  GetTotalTaxProfitNotifierState build() {
    _getTotalTaxProfitRepository =
        ref.read(getTotalTaxProfitRepositoryProvider);

    return GetTotalTaxProfitNotifierState.initial();
  }

  Future<void> getTotalTaxProfit({
    required GetTotalProfitRequest data,
    required void Function(String error) onError,
    required void Function(String message) onSuccess,
  }) async {
    state = state.copyWith(loadState: LoadState.loading);

    try {
      final value = await _getTotalTaxProfitRepository.getTotalTaxProfit(data);
      debugLog(data);
      if (!value.status) throw value.message.toException;

      state = state.copyWith(
        loadState: LoadState.idle,
        getTotalTaxProfitResponse: value.data,
      );
      onSuccess("${value.message}");
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(loadState: LoadState.idle);
    }
  }
}

final getTotalTaxProfitNotifier = NotifierProvider.autoDispose<
    GetTaxProfitNotifier, GetTotalTaxProfitNotifierState>(
  GetTaxProfitNotifier.new,
);
