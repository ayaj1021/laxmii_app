import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/config/network_utils/async_response.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/invoice/data/model/get_invoice_by_name_request.dart';
import 'package:laxmii_app/presentation/features/invoice/data/repository/get_invoice_by_name_repository.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/notifier/get_invoice_by_name_state.dart';

class GetInvoiceByNameNotifier
    extends AutoDisposeNotifier<GetInvoiceByNameState> {
  GetInvoiceByNameNotifier();

  late GetInvoiceByNameRepository _getInvoiceByNameRepository;

  @override
  GetInvoiceByNameState build() {
    _getInvoiceByNameRepository = ref.read(getInvoiceByNameRepositoryProvider);

    return GetInvoiceByNameState.initial();
  }

  Future<void> getInvoiceByName({
    required GetInvoiceByNameRequest request,
  }) async {
    state = state.copyWith(loadState: LoadState.loading);

    try {
      final value = await _getInvoiceByNameRepository.getInvoiceByName(request);

      if (!value.status) throw value.message.toException;

      state = state.copyWith(
          loadState: LoadState.idle,
          getInvoiceByName: AsyncResponse.success(value.data!));
    } catch (e) {
      state = state.copyWith(loadState: LoadState.idle);
    }
  }
}

final getInvoiceByNameNotifierProvider = NotifierProvider.autoDispose<
    GetInvoiceByNameNotifier,
    GetInvoiceByNameState>(GetInvoiceByNameNotifier.new);
