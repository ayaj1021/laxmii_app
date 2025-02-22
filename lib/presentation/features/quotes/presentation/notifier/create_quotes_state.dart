import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/quotes/data/model/create_quotes_response.dart';

class CreateQuotesNotifierState {
  CreateQuotesNotifierState({
    required this.createQuotesState,
    required this.createQuotesResponse,
  });
  factory CreateQuotesNotifierState.initial() {
    return CreateQuotesNotifierState(
      createQuotesState: LoadState.idle,
      createQuotesResponse: CreateQuotesResponse(),
    );
  }

  final LoadState createQuotesState;
  final CreateQuotesResponse createQuotesResponse;
  CreateQuotesNotifierState copyWith({
    LoadState? createQuotesState,
    CreateQuotesResponse? createQuotesResponse,
  }) {
    return CreateQuotesNotifierState(
      createQuotesState: createQuotesState ?? this.createQuotesState,
      createQuotesResponse: createQuotesResponse ?? this.createQuotesResponse,
    );
  }
}
