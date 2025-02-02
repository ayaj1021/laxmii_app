import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/config/network_utils/async_response.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/invoice/data/repository/get_invoice_number_repository.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/notifier/get_invoice_number_state.dart';

class GetInvoiceNumberNotifier
    extends AutoDisposeNotifier<GetInvoiceNumberState> {
  GetInvoiceNumberNotifier();

  late GetInvoiceNumberRepository _getInvoiceNumberRepository;

  @override
  GetInvoiceNumberState build() {
    _getInvoiceNumberRepository = ref.read(getInvoiceNumberRepositoryProvider);

    return GetInvoiceNumberState.initial();
  }

  Future<void> getAllInvoices() async {
    state = state.copyWith(loadState: LoadState.loading);

    try {
      final value = await _getInvoiceNumberRepository.getInvoiceNumberRepo();

      if (!value.status) throw value.message.toException;

      state = state.copyWith(
          loadState: LoadState.idle,
          getInvoiceNumber: AsyncResponse.success(value.data!));
    } catch (e) {
      state = state.copyWith(loadState: LoadState.idle);
    }
  }
}

final getInvoiceNumberNotifierProvider = NotifierProvider.autoDispose<
    GetInvoiceNumberNotifier,
    GetInvoiceNumberState>(GetInvoiceNumberNotifier.new);
