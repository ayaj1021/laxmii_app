import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/logger.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/tax/data/model/calculate_tax_request.dart';
import 'package:laxmii_app/presentation/features/tax/data/repository/calculate_tax_repository.dart';
import 'package:laxmii_app/presentation/features/tax/presentation/notifier/calculate_tax_state.dart';

class CalculateTaxNotifier
    extends AutoDisposeNotifier<CalculateTaxNotifierState> {
  CalculateTaxNotifier();

  late CalculateTaxRepository _calculateTaxRepository;

  @override
  CalculateTaxNotifierState build() {
    _calculateTaxRepository = ref.read(calculateTaxRepositoryProvider);

    return CalculateTaxNotifierState.initial();
  }

  Future<void> calculateTax({
    required CalculateTaxRequest data,
    required void Function(String error) onError,
    required void Function(String message) onSuccess,
  }) async {
    state = state.copyWith(loadState: LoadState.loading);

    try {
      final value = await _calculateTaxRepository.calculateTax(data);
      debugLog(data);
      if (!value.status) throw value.message.toException;

      state = state.copyWith(
        loadState: LoadState.idle,
        calculateTaxResponse: value.data,
      );
      onSuccess("${value.message}");
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(loadState: LoadState.idle);
    }
  }
}

final calculateTaxNotifier = NotifierProvider.autoDispose<CalculateTaxNotifier,
    CalculateTaxNotifierState>(
  CalculateTaxNotifier.new,
);
