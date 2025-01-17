import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/invoice/data/model/update_invoice_response.dart';

class UpdateInvoiceNotifierState {
  UpdateInvoiceNotifierState({
    required this.inputValid,
    required this.updateInvoiceState,
    required this.updateInvoiceResponse,
  });
  factory UpdateInvoiceNotifierState.initial() {
    return UpdateInvoiceNotifierState(
      inputValid: false,
      updateInvoiceState: LoadState.idle,
      updateInvoiceResponse: UpdateInvoiceResponse(),
    );
  }
  final bool inputValid;
  final LoadState updateInvoiceState;
  final UpdateInvoiceResponse updateInvoiceResponse;
  UpdateInvoiceNotifierState copyWith({
    bool? inputValid,
    LoadState? updateInvoiceState,
    UpdateInvoiceResponse? updateInvoiceResponse,
  }) {
    return UpdateInvoiceNotifierState(
      inputValid: inputValid ?? this.inputValid,
      updateInvoiceState: updateInvoiceState ?? this.updateInvoiceState,
      updateInvoiceResponse:
          updateInvoiceResponse ?? this.updateInvoiceResponse,
    );
  }
}
