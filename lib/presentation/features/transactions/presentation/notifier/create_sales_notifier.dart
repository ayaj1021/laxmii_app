import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/logger.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/transactions/data/model/create_sales_request.dart';
import 'package:laxmii_app/presentation/features/transactions/data/repository/create_sales_repository.dart';
import 'package:laxmii_app/presentation/features/transactions/presentation/notifier/create_sales_state.dart';

class CreateSalesNotifier
    extends AutoDisposeNotifier<CreateSalesNotifierState> {
  CreateSalesNotifier();

  late CreateSalesRepository _createSalesRepository;

  @override
  CreateSalesNotifierState build() {
    _createSalesRepository = ref.read(createSalesRepositoryProvider);

    return CreateSalesNotifierState.initial();
  }

  Future<void> createSales({
    required CreateSalesRequest data,
    required void Function(String error) onError,
    required void Function(String message) onSuccess,
  }) async {
    state = state.copyWith(createSalesState: LoadState.loading);

    try {
      final value = await _createSalesRepository.createSales(data);
      debugLog(data);
      if (!value.status) throw value.message.toException;

      state = state.copyWith(createSalesState: LoadState.idle);
      onSuccess(value.data!.message.toString());
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(createSalesState: LoadState.idle);
    }
  }
}

final createSalesNotifier =
    NotifierProvider.autoDispose<CreateSalesNotifier, CreateSalesNotifierState>(
  CreateSalesNotifier.new,
);
