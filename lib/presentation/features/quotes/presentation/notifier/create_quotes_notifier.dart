import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/logger.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/quotes/data/model/create_quotes_request.dart';
import 'package:laxmii_app/presentation/features/quotes/data/repository/create_quotes_repository.dart';
import 'package:laxmii_app/presentation/features/quotes/presentation/notifier/create_quotes_state.dart';

class CreateQuotesNotifier
    extends AutoDisposeNotifier<CreateQuotesNotifierState> {
  CreateQuotesNotifier();

  late CreateQuotesRepository _createQuotesRepository;

  @override
  CreateQuotesNotifierState build() {
    _createQuotesRepository = ref.read(createQuotesRepositoryProvider);

    return CreateQuotesNotifierState.initial();
  }

  Future<void> createQuotes({
    required CreateQuotesRequest data,
    required void Function(String error) onError,
    required void Function(String message) onSuccess,
  }) async {
    state = state.copyWith(createQuotesState: LoadState.loading);

    try {
      final value = await _createQuotesRepository.createQuotes(data);
      debugLog(data);
      if (!value.status) throw value.message.toException;

      state = state.copyWith(
          createQuotesState: LoadState.idle, createQuotesResponse: value.data);
      onSuccess(value.data!.message.toString());
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(createQuotesState: LoadState.idle);
    }
  }
}

final createQuotesNotifier = NotifierProvider.autoDispose<CreateQuotesNotifier,
    CreateQuotesNotifierState>(
  CreateQuotesNotifier.new,
);
