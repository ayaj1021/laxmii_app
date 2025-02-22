import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/logger.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/tax/data/model/optimize_tax_request.dart';
import 'package:laxmii_app/presentation/features/tax/data/repository/optimise_tax_repository.dart';
import 'package:laxmii_app/presentation/features/tax/presentation/notifier/optimize_tax_state.dart';

class OptimizeTaxNotifier extends AutoDisposeNotifier<OptimizeNotifierState> {
  OptimizeTaxNotifier();

  late OptimizeTaxRepository _optimizeTaxRepository;

  @override
  OptimizeNotifierState build() {
    _optimizeTaxRepository = ref.read(optimizeTaxRepositoryProvider);

    return OptimizeNotifierState.initial();
  }

  Future<void> optimizeTax({
    required OptimizeTaxRequest data,
    required void Function(String error) onError,
    required void Function(String message) onSuccess,
  }) async {
    state = state.copyWith(loadState: LoadState.loading);

    try {
      final value = await _optimizeTaxRepository.optimizeTax(data);
      debugLog(data);
      if (!value.status) throw value.message.toException;

      state = state.copyWith(
        loadState: LoadState.idle,
        optimizeTaxResponse: value.data,
      );
      onSuccess("${value.message}");
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(loadState: LoadState.idle);
    }
  }
}

final optimizeTaxProfitNotifier =
    NotifierProvider.autoDispose<OptimizeTaxNotifier, OptimizeNotifierState>(
  OptimizeTaxNotifier.new,
);
