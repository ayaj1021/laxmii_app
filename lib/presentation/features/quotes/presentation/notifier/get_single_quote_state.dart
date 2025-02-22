import 'package:laxmii_app/core/config/network_utils/async_response.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/quotes/data/model/get_single_quote_response.dart';

class GetSingleQuoteState {
  final LoadState loadState;
  final AsyncResponse<GetSingleQuoteResponse> getSingleQuote;

  GetSingleQuoteState({
    required this.loadState,
    required this.getSingleQuote,
  });

  factory GetSingleQuoteState.initial() {
    return GetSingleQuoteState(
      loadState: LoadState.loading,
      getSingleQuote: AsyncResponse.loading(),
    );
  }

  GetSingleQuoteState copyWith({
    LoadState? loadState,
    AsyncResponse<GetSingleQuoteResponse>? getSingleQuote,
  }) {
    return GetSingleQuoteState(
      loadState: loadState ?? this.loadState,
      getSingleQuote: getSingleQuote ?? this.getSingleQuote,
    );
  }
}
