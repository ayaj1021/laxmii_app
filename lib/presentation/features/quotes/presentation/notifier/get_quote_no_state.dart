import 'package:laxmii_app/core/config/network_utils/async_response.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/quotes/data/model/get_quote_no_response.dart';

class GetQuoteNoState {
  final LoadState loadState;
  final AsyncResponse<GetQuoteNoResponse> getSingleNo;

  GetQuoteNoState({
    required this.loadState,
    required this.getSingleNo,
  });

  factory GetQuoteNoState.initial() {
    return GetQuoteNoState(
      loadState: LoadState.loading,
      getSingleNo: AsyncResponse.loading(),
    );
  }

  GetQuoteNoState copyWith({
    LoadState? loadState,
    AsyncResponse<GetQuoteNoResponse>? getSingleNo,
  }) {
    return GetQuoteNoState(
      loadState: loadState ?? this.loadState,
      getSingleNo: getSingleNo ?? this.getSingleNo,
    );
  }
}
