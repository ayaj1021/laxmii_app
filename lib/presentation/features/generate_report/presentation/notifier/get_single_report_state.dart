import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/generate_report/data/model/get_single_report_response.dart';
import 'package:laxmii_app/presentation/features/generate_report/data/model/get_single_sales_response.dart';

class GetSingleReportNotifierState {
  GetSingleReportNotifierState({
    required this.getSingleReportState,
    required this.getSingleReportResponse,
    required this.getSalesReportResponse,
  });
  factory GetSingleReportNotifierState.initial() {
    return GetSingleReportNotifierState(
      getSingleReportState: LoadState.idle,
      getSingleReportResponse: GetSingleReportResponse(),
      getSalesReportResponse: GetSingleSalesResponse(),
    );
  }

  final LoadState getSingleReportState;

  final GetSingleReportResponse getSingleReportResponse;
  final GetSingleSalesResponse getSalesReportResponse;
  GetSingleReportNotifierState copyWith({
    LoadState? getSingleReportState,
    GetSingleReportResponse? getSingleReportResponse,
    GetSingleSalesResponse? getSalesReportResponse,
  }) {
    return GetSingleReportNotifierState(
      getSingleReportState: getSingleReportState ?? this.getSingleReportState,
      getSalesReportResponse:
          getSalesReportResponse ?? this.getSalesReportResponse,
      getSingleReportResponse:
          getSingleReportResponse ?? this.getSingleReportResponse,
    );
  }
}
