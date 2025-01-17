import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/logger.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/inventory/data/repository/delete_inventory_repository.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/notifier/delete_inventory_state.dart';

class DeleteInventoryNotifier
    extends AutoDisposeNotifier<DeleteInventoryNotifierState> {
  DeleteInventoryNotifier();

  late DeleteInventoryRepository _deleteInventoryRepository;

  @override
  DeleteInventoryNotifierState build() {
    _deleteInventoryRepository = ref.read(deleteInventoryRepositoryProvider);

    return DeleteInventoryNotifierState.initial();
  }

  Future<void> deleteInventory({
    required String inventoryId,
    required void Function(String error) onError,
    required void Function(String message) onSuccess,
  }) async {
    state = state.copyWith(deleteInventoryState: LoadState.loading);

    try {
      final value = await _deleteInventoryRepository.deleteInventory(
          inventoryId: inventoryId);
      debugLog(inventoryId);
      if (!value.status) throw value.message.toException;

      state = state.copyWith(deleteInventoryState: LoadState.idle);
      onSuccess(value.data!.message.toString());
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(deleteInventoryState: LoadState.idle);
    }
  }
}

final deleteInventoryNotifier = NotifierProvider.autoDispose<
    DeleteInventoryNotifier, DeleteInventoryNotifierState>(
  DeleteInventoryNotifier.new,
);
