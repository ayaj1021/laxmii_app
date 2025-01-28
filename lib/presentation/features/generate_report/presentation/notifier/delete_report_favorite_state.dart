import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/generate_report/data/model/delete_favorite_response.dart';

class DeleteReportsFavoriteNotifierState {
  DeleteReportsFavoriteNotifierState({
    required this.deleteReportFavoriteState,
    required this.deleteReportsFavoriteResponse,
    this.isAdded,
  });
  factory DeleteReportsFavoriteNotifierState.initial() {
    return DeleteReportsFavoriteNotifierState(
      deleteReportFavoriteState: LoadState.idle,
      deleteReportsFavoriteResponse: DeleteFavoriteReportResponse(),
    );
  }

  final LoadState deleteReportFavoriteState;
  final bool? isAdded;
  final DeleteFavoriteReportResponse deleteReportsFavoriteResponse;
  DeleteReportsFavoriteNotifierState copyWith({
    LoadState? deleteReportFavoriteState,
    bool? isAdded,
    DeleteFavoriteReportResponse? deleteReportsFavoriteResponse,
  }) {
    return DeleteReportsFavoriteNotifierState(
      deleteReportFavoriteState:
          deleteReportFavoriteState ?? this.deleteReportFavoriteState,
      deleteReportsFavoriteResponse:
          deleteReportsFavoriteResponse ?? this.deleteReportsFavoriteResponse,
      isAdded: isAdded ?? this.isAdded,
    );
  }
}
