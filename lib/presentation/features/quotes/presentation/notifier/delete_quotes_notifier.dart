import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/logger.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/quotes/data/repository/delete_quote_repository.dart';
import 'package:laxmii_app/presentation/features/quotes/presentation/notifier/delete_quote_state.dart';

class CreateQuotesNotifier
    extends AutoDisposeNotifier<DeleteQuotesNotifierState> {
  CreateQuotesNotifier();

  late DeleteQuotesRepository _deleteQuotesRepository;

  @override
  DeleteQuotesNotifierState build() {
    _deleteQuotesRepository = ref.read(deleteQuoteRepositoryProvider);

    return DeleteQuotesNotifierState.initial();
  }

  Future<void> deleteQuote({
    required String quoteId,
    required void Function(String error) onError,
    required void Function(String message) onSuccess,
  }) async {
    state = state.copyWith(loadState: LoadState.loading);

    try {
      final value = await _deleteQuotesRepository.deleteQuote(quoteId: quoteId);
      debugLog(quoteId);
      if (!value.status) throw value.message.toException;

      state = state.copyWith(
          loadState: LoadState.success, deleteQuotesResponse: value.data);
      onSuccess(value.data!.message.toString());
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(loadState: LoadState.idle);
    }
  }
}

final deleteQuoteNotifier = NotifierProvider.autoDispose<CreateQuotesNotifier,
    DeleteQuotesNotifierState>(
  CreateQuotesNotifier.new,
);
