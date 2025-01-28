import 'package:laxmii_app/core/config/network_utils/async_response.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/generate_report/data/model/get_all_favorite_response.dart';

class GetAllFavoriteReportsState {
  final LoadState loadState;
  final AsyncResponse<GetAllFavoriteResponse> getAllFavoriteReports;

  GetAllFavoriteReportsState({
    required this.loadState,
    required this.getAllFavoriteReports,
  });

  factory GetAllFavoriteReportsState.initial() {
    return GetAllFavoriteReportsState(
      loadState: LoadState.loading,
      getAllFavoriteReports: AsyncResponse.loading(),
    );
  }

  GetAllFavoriteReportsState copyWith({
    LoadState? loadState,
    AsyncResponse<GetAllFavoriteResponse>? getAllFavoriteReports,
  }) {
    return GetAllFavoriteReportsState(
      loadState: loadState ?? this.loadState,
      getAllFavoriteReports:
          getAllFavoriteReports ?? this.getAllFavoriteReports,
    );
  }
}
