import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/config/network_utils/async_response.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/quotes/data/repository/get_single_quote_repository.dart';
import 'package:laxmii_app/presentation/features/quotes/presentation/notifier/get_single_quote_state.dart';

class GetSingleQuoteNotifier extends AutoDisposeNotifier<GetSingleQuoteState> {
  GetSingleQuoteNotifier();

  late GetSingleQuotesRepository _getSingleQuotesRepository;

  @override
  GetSingleQuoteState build() {
    _getSingleQuotesRepository = ref.read(getSingleQuoteRepositoryProvider);

    return GetSingleQuoteState.initial();
  }

  Future<void> getSingleQuote({required String quoteId}) async {
    state = state.copyWith(loadState: LoadState.loading);

    try {
      final value =
          await _getSingleQuotesRepository.getSingleQuote(quoteId: quoteId);

      if (!value.status) throw value.message.toException;

      state = state.copyWith(
          loadState: LoadState.idle,
          getSingleQuote: AsyncResponse.success(value.data!));
    } catch (e) {
      state = state.copyWith(loadState: LoadState.idle);
    }
  }
}

final getSingleQuoteNotifierProvider =
    NotifierProvider.autoDispose<GetSingleQuoteNotifier, GetSingleQuoteState>(
        GetSingleQuoteNotifier.new);
