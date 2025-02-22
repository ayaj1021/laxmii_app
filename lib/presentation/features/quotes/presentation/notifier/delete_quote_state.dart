import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/quotes/data/model/delete_quote_response.dart';

class DeleteQuotesNotifierState {
  DeleteQuotesNotifierState({
    required this.loadState,
    required this.deleteQuotesResponse,
  });
  factory DeleteQuotesNotifierState.initial() {
    return DeleteQuotesNotifierState(
      loadState: LoadState.idle,
      deleteQuotesResponse: DeleteQuoteResponse(),
    );
  }

  final LoadState loadState;
  final DeleteQuoteResponse deleteQuotesResponse;
  DeleteQuotesNotifierState copyWith({
    LoadState? loadState,
    DeleteQuoteResponse? deleteQuotesResponse,
  }) {
    return DeleteQuotesNotifierState(
      loadState: loadState ?? this.loadState,
      deleteQuotesResponse: deleteQuotesResponse ?? this.deleteQuotesResponse,
    );
  }
}
