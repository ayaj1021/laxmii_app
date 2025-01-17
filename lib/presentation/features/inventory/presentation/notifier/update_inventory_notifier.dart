import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/logger.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/inventory/data/model/update_inventory_request.dart';
import 'package:laxmii_app/presentation/features/inventory/data/repository/update_inventory_repository.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/notifier/update_inventory_state.dart';

class UpdateInventoryNotifier
    extends AutoDisposeNotifier<UpdateInventoryNotifierState> {
  UpdateInventoryNotifier();

  late UpdateInventoryRepository _updateInventoryRepository;

  @override
  UpdateInventoryNotifierState build() {
    _updateInventoryRepository = ref.read(updateInventoryRepositoryProvider);

    return UpdateInventoryNotifierState.initial();
  }

  Future<void> updateInventory({
    required UpdateInventoryRequest data,
    required String inventoryId,
    required void Function(String error) onError,
    required void Function(String message) onSuccess,
  }) async {
    state = state.copyWith(updateInventoryState: LoadState.loading);

    try {
      final value = await _updateInventoryRepository.updateInventory(data,
          inventoryId: inventoryId);
      debugLog(data);
      if (!value.status) throw value.message.toException;

      state = state.copyWith(
          updateInventoryState: LoadState.idle,
          updateInventoryResponse: value.data);
      onSuccess(value.data!.message.toString());
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(updateInventoryState: LoadState.idle);
    }
  }
}

final updateInventoryNotifier = NotifierProvider.autoDispose<
    UpdateInventoryNotifier, UpdateInventoryNotifierState>(
  UpdateInventoryNotifier.new,
);
