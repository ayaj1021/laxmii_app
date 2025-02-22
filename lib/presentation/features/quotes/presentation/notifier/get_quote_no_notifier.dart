import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/config/network_utils/async_response.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/quotes/data/repository/get_quote_no_repository.dart';
import 'package:laxmii_app/presentation/features/quotes/presentation/notifier/get_quote_no_state.dart';

class GetQuoteNoNotifier extends AutoDisposeNotifier<GetQuoteNoState> {
  GetQuoteNoNotifier();

  late GetQuoteNoRepository _getQuoteNoRepository;

  @override
  GetQuoteNoState build() {
    _getQuoteNoRepository = ref.read(getQuoteNoRepositoryProvider);

    return GetQuoteNoState.initial();
  }

  Future<void> getQuoteNo() async {
    state = state.copyWith(loadState: LoadState.loading);

    try {
      final value = await _getQuoteNoRepository.getQuoteNo();

      if (!value.status) throw value.message.toException;

      state = state.copyWith(
          loadState: LoadState.idle,
          getSingleNo: AsyncResponse.success(value.data!));
    } catch (e) {
      state = state.copyWith(loadState: LoadState.idle);
    }
  }
}

final getQuoteNoNotifierProvider =
    NotifierProvider.autoDispose<GetQuoteNoNotifier, GetQuoteNoState>(
        GetQuoteNoNotifier.new);
