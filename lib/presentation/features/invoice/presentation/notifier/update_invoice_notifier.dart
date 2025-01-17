import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/logger.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/invoice/data/model/update_invoice_request.dart';
import 'package:laxmii_app/presentation/features/invoice/data/repository/update_invoice_repository.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/notifier/update_invoice_state.dart';

class UpdateInvoiceNotifier
    extends AutoDisposeNotifier<UpdateInvoiceNotifierState> {
  UpdateInvoiceNotifier();

  late UpdateInvoiceRepository _updateInvoiceRepository;

  @override
  UpdateInvoiceNotifierState build() {
    _updateInvoiceRepository = ref.read(updateInvoiceRepositoryProvider);

    return UpdateInvoiceNotifierState.initial();
  }

  Future<void> updateInvoice({
    required UpdateInvoiceRequest data,
    required String invoiceId,
    required void Function(String error) onError,
    required void Function(String message) onSuccess,
  }) async {
    state = state.copyWith(updateInvoiceState: LoadState.loading);

    try {
      final value = await _updateInvoiceRepository.unpdateInvoice(data,
          invoiceId: invoiceId);
      debugLog(data);
      if (!value.status) throw value.message.toException;

      state = state.copyWith(
          updateInvoiceState: LoadState.idle,
          updateInvoiceResponse: value.data);
      onSuccess(value.data!.message.toString());
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(updateInvoiceState: LoadState.idle);
    }
  }
}

final updateInvoiceNotifier = NotifierProvider.autoDispose<
    UpdateInvoiceNotifier, UpdateInvoiceNotifierState>(
  UpdateInvoiceNotifier.new,
);
