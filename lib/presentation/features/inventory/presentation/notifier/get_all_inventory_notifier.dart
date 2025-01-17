import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/config/network_utils/async_response.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/inventory/data/repository/get_all_inventory_repository.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/notifier/get_all_inventory_state.dart';

class GetAllInventoryNotifier extends AutoDisposeNotifier<GetAllInventoryState> {
  GetAllInventoryNotifier();

  late GetAllInventoryRepository _getAllInventoryRepository;

  @override
  GetAllInventoryState build() {
    _getAllInventoryRepository = ref.read(getAllInventoryRepositoryProvider);

    return GetAllInventoryState.initial();
  }

  Future<void> getAllInventory() async {
    state = state.copyWith(loadState: LoadState.loading);

    try {
      final value = await _getAllInventoryRepository.getAllInventory();

      if (!value.status) throw value.message.toException;

      state = state.copyWith(
          loadState: LoadState.idle,
          getAllInventory: AsyncResponse.success(value.data!));
    } catch (e) {
      state = state.copyWith(loadState: LoadState.idle);
    }
  }
}

final getAllInventoryNotifierProvider =
    NotifierProvider.autoDispose<GetAllInventoryNotifier, GetAllInventoryState>(
        GetAllInventoryNotifier.new);
