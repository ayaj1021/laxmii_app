import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/generate_report/data/model/get_single_report_response.dart';

class GetSingleReportNotifierState {
  GetSingleReportNotifierState({
    required this.getSingleReportState,
    required this.getSingleReportResponse,
  });
  factory GetSingleReportNotifierState.initial() {
    return GetSingleReportNotifierState(
      getSingleReportState: LoadState.idle,
      getSingleReportResponse: GetSingleReportResponse(),
    );
  }

  final LoadState getSingleReportState;

  final GetSingleReportResponse getSingleReportResponse;
  GetSingleReportNotifierState copyWith({
    LoadState? getSingleReportState,
    GetSingleReportResponse? getSingleReportResponse,
  }) {
    return GetSingleReportNotifierState(
      getSingleReportState: getSingleReportState ?? this.getSingleReportState,
      getSingleReportResponse:
          getSingleReportResponse ?? this.getSingleReportResponse,
    );
  }
}
