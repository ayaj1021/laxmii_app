import 'package:laxmii_app/core/config/network_utils/async_response.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/transactions/data/model/get_all_sales_response.dart';

class GetAllSalesState {
  final LoadState loadState;
  final AsyncResponse<GetAllSalesResponse> getAllSales;

  GetAllSalesState({
    required this.loadState,
    required this.getAllSales,
  });

  factory GetAllSalesState.initial() {
    return GetAllSalesState(
      loadState: LoadState.loading,
      getAllSales: AsyncResponse.loading(),
    );
  }

  GetAllSalesState copyWith({
    LoadState? loadState,
    AsyncResponse<GetAllSalesResponse>? getAllSales,
  }) {
    return GetAllSalesState(
      loadState: loadState ?? this.loadState,
      getAllSales: getAllSales ?? this.getAllSales,
    );
  }
}
