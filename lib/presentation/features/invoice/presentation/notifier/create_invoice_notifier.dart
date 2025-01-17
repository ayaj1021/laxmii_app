import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/logger.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/invoice/data/model/create_invoice_request.dart';
import 'package:laxmii_app/presentation/features/invoice/data/repository/create_invoice_repository.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/notifier/create_invoice_state.dart';

class CreateInvoiceNotifier
    extends AutoDisposeNotifier<CreateInvoiceNotifierState> {
  CreateInvoiceNotifier();

  late CreateInvoiceRepository _createInvoiceRepository;

  @override
  CreateInvoiceNotifierState build() {
    _createInvoiceRepository = ref.read(createInvoiceRepositoryProvider);

    return CreateInvoiceNotifierState.initial();
  }

  Future<void> createInvoice({
    required CreateInvoiceRequest data,
    required void Function(String error) onError,
    required void Function(String message) onSuccess,
  }) async {
    state = state.copyWith(createInvoiceState: LoadState.loading);

    try {
      final value = await _createInvoiceRepository.createInvoice(data);
      debugLog(data);
      if (!value.status) throw value.message.toException;

      state = state.copyWith(
          createInvoiceState: LoadState.idle,
          createInvoiceResponse: value.data);
      onSuccess(value.data!.message.toString());
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(createInvoiceState: LoadState.idle);
    }
  }
}

final createInvoiceNotifier = NotifierProvider.autoDispose<
    CreateInvoiceNotifier, CreateInvoiceNotifierState>(
  CreateInvoiceNotifier.new,
);
