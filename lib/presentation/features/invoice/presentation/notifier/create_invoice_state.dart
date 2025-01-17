import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/invoice/data/model/create_invoice_response.dart';

class CreateInvoiceNotifierState {
  CreateInvoiceNotifierState({
    required this.inputValid,
    required this.createInvoiceState,
    required this.createInvoiceResponse,
  });
  factory CreateInvoiceNotifierState.initial() {
    return CreateInvoiceNotifierState(
      inputValid: false,
      createInvoiceState: LoadState.idle,
      createInvoiceResponse: CreateInvoiceResponse(),
    );
  }
  final bool inputValid;
  final LoadState createInvoiceState;
  final CreateInvoiceResponse createInvoiceResponse;
  CreateInvoiceNotifierState copyWith({
    bool? inputValid,
    LoadState? createInvoiceState,
    CreateInvoiceResponse? createInvoiceResponse,
  }) {
    return CreateInvoiceNotifierState(
      inputValid: inputValid ?? this.inputValid,
      createInvoiceState: createInvoiceState ?? this.createInvoiceState,
      createInvoiceResponse:
          createInvoiceResponse ?? this.createInvoiceResponse,
    );
  }
}
