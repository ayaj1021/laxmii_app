import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/tax/data/model/optimize_tax_response.dart';

class OptimizeNotifierState {
  OptimizeNotifierState({
    required this.loadState,
    required this.optimizeTaxResponse,
  });
  factory OptimizeNotifierState.initial() {
    return OptimizeNotifierState(
      loadState: LoadState.idle,
      optimizeTaxResponse: OptimizeTaxResponse(),
    );
  }

  final LoadState loadState;

  final OptimizeTaxResponse optimizeTaxResponse;

  OptimizeNotifierState copyWith({
    LoadState? loadState,
    OptimizeTaxResponse? optimizeTaxResponse,
  }) {
    return OptimizeNotifierState(
      loadState: loadState ?? this.loadState,
      optimizeTaxResponse: optimizeTaxResponse ?? this.optimizeTaxResponse,
    );
  }
}
