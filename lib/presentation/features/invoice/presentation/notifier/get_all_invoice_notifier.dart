import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/config/network_utils/async_response.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/invoice/data/repository/get_all_invoices_repository.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/notifier/get_all_invoices_state.dart';

class GetAllInvoicesNotifier extends AutoDisposeNotifier<GetAllInvoicesState> {
  GetAllInvoicesNotifier();

  late GetAllInvoicesRepository _getAllInvoicesRepository;

  @override
  GetAllInvoicesState build() {
    _getAllInvoicesRepository = ref.read(getAllInvoicesRepositoryProvider);

    return GetAllInvoicesState.initial();
  }

  Future<void> getAllInvoices() async {
    state = state.copyWith(loadState: LoadState.loading);

    try {
      final value = await _getAllInvoicesRepository.getAllInvoices();

      if (!value.status) throw value.message.toException;

      state = state.copyWith(
          loadState: LoadState.idle,
          getAllInvoice: AsyncResponse.success(value.data!));
    } catch (e) {
      state = state.copyWith(loadState: LoadState.idle);
    }
  }
}

final getAllInvoiceNotifierProvider =
    NotifierProvider.autoDispose<GetAllInvoicesNotifier, GetAllInvoicesState>(
        GetAllInvoicesNotifier.new);
