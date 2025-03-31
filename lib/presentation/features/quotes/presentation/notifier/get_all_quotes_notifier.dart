import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/config/network_utils/async_response.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/quotes/data/repository/get_all_quotes_repository.dart';
import 'package:laxmii_app/presentation/features/quotes/presentation/notifier/get_all_quotes_state.dart';

class GetAllQuotesNotifier extends AutoDisposeNotifier<GetAllQuotesState> {
  GetAllQuotesNotifier();

  late GetAllQuotesRepository _getAllQuotesRepository;

  @override
  GetAllQuotesState build() {
    _getAllQuotesRepository = ref.read(getAllTQuotesRepositoryProvider);

    return GetAllQuotesState.initial();
  }

  Future<void> getAllQuotes() async {
    state = state.copyWith(loadState: LoadState.loading);

    try {
      final value = await _getAllQuotesRepository.getAllQuotes();

      if (!value.status) throw value.message.toException;

      state = state.copyWith(
          loadState: LoadState.idle,
          getAllQuotes: AsyncResponse.success(value.data!));
      await AppDataStorage()
          .saveUserId(value.data?.quote?.map((e) => e.user).toString() ?? '');
    } catch (e) {
      state = state.copyWith(loadState: LoadState.idle);
    }
  }
}

final getAllQuotesNotifierProvider =
    NotifierProvider.autoDispose<GetAllQuotesNotifier, GetAllQuotesState>(
        GetAllQuotesNotifier.new);
