import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/config/network_utils/async_response.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/transactions/data/repository/get_all_sales_repository.dart';
import 'package:laxmii_app/presentation/features/transactions/presentation/notifier/get_all_sales_state.dart';

class GetAllSalesNotifier extends AutoDisposeNotifier<GetAllSalesState> {
  GetAllSalesNotifier();

  late GetAllSalesRepository _getAllSalesRepository;

  @override
  GetAllSalesState build() {
    _getAllSalesRepository = ref.read(getAllSalesRepositoryProvider);

    return GetAllSalesState.initial();
  }

  Future<void> getAllSales() async {
    state = state.copyWith(loadState: LoadState.loading);

    try {
      final value = await _getAllSalesRepository.getAllSales();

      if (!value.status) throw value.message.toException;

      state = state.copyWith(
          loadState: LoadState.idle,
          getAllSales: AsyncResponse.success(value.data!));
    } catch (e) {
      state = state.copyWith(loadState: LoadState.idle);
    }
  }
}

final getAllSalesNotifierProvider =
    NotifierProvider.autoDispose<GetAllSalesNotifier, GetAllSalesState>(
        GetAllSalesNotifier.new);
