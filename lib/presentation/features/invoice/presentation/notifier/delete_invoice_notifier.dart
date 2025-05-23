import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_state.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/invoice/data/model/delete_invoice_response.dart';
import 'package:laxmii_app/presentation/features/invoice/data/repository/delete_invoice_repo.dart';

class DeleteInvoiceNotifier
    extends AutoDisposeNotifier<BaseState<DeleteInvoiceResponse>> {
  DeleteInvoiceNotifier();

  late DeleteInvoiceRepository _repository;

  @override
  BaseState<DeleteInvoiceResponse> build() {
    _repository = ref.read(deleteInvoiceRepositoryProvider);

    return BaseState<DeleteInvoiceResponse>.initial();
  }

  Future<void> deleteInvoice(
    String invoiceId, {
    required void Function(String error) onError,
    required void Function(String message) onSuccess,
  }) async {
    state = state.copyWith(state: LoadState.loading);

    try {
      final value = await _repository.deleteInvoice(invoiceId);

      if (!value.status) throw value.message.toException;

      state = state.copyWith(state: LoadState.idle, data: value.data);
      onSuccess(value.message ?? 'Invoice deleted successfully');
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(state: LoadState.idle);
    }
  }
}

final deleteInvoiceNotifierProvider = NotifierProvider.autoDispose<
    DeleteInvoiceNotifier,
    BaseState<DeleteInvoiceResponse>>(DeleteInvoiceNotifier.new);
