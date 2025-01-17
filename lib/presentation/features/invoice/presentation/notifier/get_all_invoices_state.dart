import 'package:laxmii_app/core/config/network_utils/async_response.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/invoice/data/model/get_all_invoice_response.dart';

class GetAllInvoicesState {
  final LoadState loadState;
  final AsyncResponse<GetAllInvoiceResponse> getAllInvoice;

  GetAllInvoicesState({
    required this.loadState,
    required this.getAllInvoice,
  });

  factory GetAllInvoicesState.initial() {
    return GetAllInvoicesState(
      loadState: LoadState.loading,
      getAllInvoice: AsyncResponse.loading(),
    );
  }

  GetAllInvoicesState copyWith({
    LoadState? loadState,
    AsyncResponse<GetAllInvoiceResponse>? getAllInvoice,
  }) {
    return GetAllInvoicesState(
      loadState: loadState ?? this.loadState,
      getAllInvoice: getAllInvoice ?? this.getAllInvoice,
    );
  }
}
