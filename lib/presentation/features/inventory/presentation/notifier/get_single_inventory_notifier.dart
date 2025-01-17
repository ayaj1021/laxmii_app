import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/config/network_utils/async_response.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/inventory/data/repository/get_single_inventory_respository.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/notifier/get_single_inventory_state.dart';

class GetSingleInventoryNotifier
    extends AutoDisposeNotifier<GetSingleInventoryState> {
  GetSingleInventoryNotifier();

  late GetSingleInventoryRepository _getSingleInventoryRepository;

  @override
  GetSingleInventoryState build() {
    _getSingleInventoryRepository =
        ref.read(getSingleInventoryRepositoryProvider);

    return GetSingleInventoryState.initial();
  }

  Future<void> getSingleInventory({required String singleInventoryId}) async {
    state = state.copyWith(loadState: LoadState.loading);

    try {
      final value = await _getSingleInventoryRepository.getSingleInventory(
          singleInventoryId: singleInventoryId);

      if (!value.status) throw value.message.toException;

      state = state.copyWith(
          loadState: LoadState.idle,
          getSingleInventory: AsyncResponse.success(value.data!));
    } catch (e) {
      state = state.copyWith(loadState: LoadState.idle);
    }
  }
}

final getSingleInventoryNotifierProvider = NotifierProvider.autoDispose<
    GetSingleInventoryNotifier,
    GetSingleInventoryState>(GetSingleInventoryNotifier.new);
