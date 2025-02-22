import 'package:laxmii_app/core/config/network_utils/async_response.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/quotes/data/model/get_all_quotes_response.dart';

class GetAllQuotesState {
  final LoadState loadState;
  final AsyncResponse<GetAllQuotesReponse> getAllQuotes;

  GetAllQuotesState({
    required this.loadState,
    required this.getAllQuotes,
  });

  factory GetAllQuotesState.initial() {
    return GetAllQuotesState(
      loadState: LoadState.loading,
      getAllQuotes: AsyncResponse.loading(),
    );
  }

  GetAllQuotesState copyWith({
    LoadState? loadState,
    AsyncResponse<GetAllQuotesReponse>? getAllQuotes,
  }) {
    return GetAllQuotesState(
      loadState: loadState ?? this.loadState,
      getAllQuotes: getAllQuotes ?? this.getAllQuotes,
    );
  }
}
