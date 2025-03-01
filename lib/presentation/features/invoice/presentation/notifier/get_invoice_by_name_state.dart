import 'package:laxmii_app/core/config/network_utils/async_response.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/invoice/data/model/get_invoice_by_name_response.dart';

class GetInvoiceByNameState {
  final LoadState loadState;
  final AsyncResponse<GetInvoiceByNameResponse> getInvoiceByName;

  GetInvoiceByNameState({
    required this.loadState,
    required this.getInvoiceByName,
  });

  factory GetInvoiceByNameState.initial() {
    return GetInvoiceByNameState(
      loadState: LoadState.loading,
      getInvoiceByName: AsyncResponse.loading(),
    );
  }

  GetInvoiceByNameState copyWith({
    LoadState? loadState,
    AsyncResponse<GetInvoiceByNameResponse>? getInvoiceByName,
  }) {
    return GetInvoiceByNameState(
      loadState: loadState ?? this.loadState,
      getInvoiceByName: getInvoiceByName ?? this.getInvoiceByName,
    );
  }
}
