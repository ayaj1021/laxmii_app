import 'package:laxmii_app/core/config/network_utils/async_response.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/generate_report/data/model/get_all_report_response.dart';

class GetAllReportsState {
  final LoadState loadState;
  final AsyncResponse<GetAllReportsResponse> getAllReports;

  GetAllReportsState({
    required this.loadState,
    required this.getAllReports,
  });

  factory GetAllReportsState.initial() {
    return GetAllReportsState(
      loadState: LoadState.loading,
      getAllReports: AsyncResponse.loading(),
    );
  }

  GetAllReportsState copyWith({
    LoadState? loadState,
    bool? isAdded,
    AsyncResponse<GetAllReportsResponse>? getAllReports,
  }) {
    return GetAllReportsState(
      loadState: loadState ?? this.loadState,
      getAllReports: getAllReports ?? this.getAllReports,
    );
  }
}
