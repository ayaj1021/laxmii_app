import 'package:laxmii_app/core/config/network_utils/async_response.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/invoice/data/model/get_invoice_number_response.dart';

class GetInvoiceNumberState {
  final LoadState loadState;
  final AsyncResponse<GetInvoiceNumberResponse> getInvoiceNumber;

  GetInvoiceNumberState({
    required this.loadState,
    required this.getInvoiceNumber,
  });

  factory GetInvoiceNumberState.initial() {
    return GetInvoiceNumberState(
      loadState: LoadState.loading,
      getInvoiceNumber: AsyncResponse.loading(),
    );
  }

  GetInvoiceNumberState copyWith({
    LoadState? loadState,
    AsyncResponse<GetInvoiceNumberResponse>? getInvoiceNumber,
  }) {
    return GetInvoiceNumberState(
      loadState: loadState ?? this.loadState,
      getInvoiceNumber: getInvoiceNumber ?? this.getInvoiceNumber,
    );
  }
}
