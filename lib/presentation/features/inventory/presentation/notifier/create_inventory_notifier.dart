import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/logger.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/inventory/data/model/create_inventory_request.dart';
import 'package:laxmii_app/presentation/features/inventory/data/repository/create_inventory_repository.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/notifier/create_inventory_state.dart';

class CreateInventoryNotifier
    extends AutoDisposeNotifier<CreateInventoryNotifierState> {
  CreateInventoryNotifier();

  late CreateInventoryRepository _createInventoryRepository;

  @override
  CreateInventoryNotifierState build() {
    _createInventoryRepository = ref.read(createInventoryRepositoryProvider);

    return CreateInventoryNotifierState.initial();
  }

  Future<void> createInventory({
    required CreateInventoryRequest data,
    required void Function(String error) onError,
    required void Function(String message) onSuccess,
  }) async {
    state = state.copyWith(createInventoryState: LoadState.loading);

    try {
      final value = await _createInventoryRepository.createInventory(data);
      debugLog(data);
      if (!value.status) throw value.message.toException;

      state = state.copyWith(createInventoryState: LoadState.idle);
      onSuccess(value.data!.message.toString());
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(createInventoryState: LoadState.idle);
    }
  }
}

final createInventoryNotifier = NotifierProvider.autoDispose<
    CreateInventoryNotifier, CreateInventoryNotifierState>(
  CreateInventoryNotifier.new,
);
