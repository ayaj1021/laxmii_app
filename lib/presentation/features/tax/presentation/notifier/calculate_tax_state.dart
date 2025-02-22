import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/tax/data/model/calculate_tax_response.dart';

class CalculateTaxNotifierState {
  CalculateTaxNotifierState({
    required this.loadState,
    required this.calculateTaxResponse,
  });
  factory CalculateTaxNotifierState.initial() {
    return CalculateTaxNotifierState(
      loadState: LoadState.idle,
      calculateTaxResponse: CalculateTaxResponse(),
    );
  }

  final LoadState loadState;

  final CalculateTaxResponse calculateTaxResponse;

  CalculateTaxNotifierState copyWith({
    LoadState? loadState,
    CalculateTaxResponse? calculateTaxResponse,
  }) {
    return CalculateTaxNotifierState(
      loadState: loadState ?? this.loadState,
      calculateTaxResponse: calculateTaxResponse ?? this.calculateTaxResponse,
    );
  }
}
