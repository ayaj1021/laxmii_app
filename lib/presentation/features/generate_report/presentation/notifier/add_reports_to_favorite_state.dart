import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/generate_report/data/model/add_report_to_favorite_response.dart';

class AddReportsToFavoriteNotifierState {
  AddReportsToFavoriteNotifierState({
    required this.addReportToFavoriteState,
    required this.addReportsToFavoriteResponse,
    required this.isAdded,
  });
  factory AddReportsToFavoriteNotifierState.initial() {
    return AddReportsToFavoriteNotifierState(
      addReportToFavoriteState: LoadState.idle,
      isAdded: false,
      addReportsToFavoriteResponse: AddReportToFavoriteResponse(),
    );
  }

  final LoadState addReportToFavoriteState;
  final bool isAdded;
  final AddReportToFavoriteResponse addReportsToFavoriteResponse;
  AddReportsToFavoriteNotifierState copyWith({
    LoadState? addReportToFavoriteState,
    bool? isAdded,
    AddReportToFavoriteResponse? addReportsToFavoriteResponse,
  }) {
    return AddReportsToFavoriteNotifierState(
      addReportToFavoriteState:
          addReportToFavoriteState ?? this.addReportToFavoriteState,
      addReportsToFavoriteResponse:
          addReportsToFavoriteResponse ?? this.addReportsToFavoriteResponse,
      isAdded: isAdded ?? this.isAdded,
    );
  }
}
