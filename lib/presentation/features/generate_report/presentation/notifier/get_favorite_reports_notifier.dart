import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/config/network_utils/async_response.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/generate_report/data/repository/get_all_favorite_report_repository.dart';
import 'package:laxmii_app/presentation/features/generate_report/presentation/notifier/get_favorite_reports_state.dart';

class GetFavoriteReportsNotifier
    extends AutoDisposeNotifier<GetAllFavoriteReportsState> {
  GetFavoriteReportsNotifier();

  late GetAllFavoriteReportsRepository _getFavoritesReportsRepository;

  @override
  GetAllFavoriteReportsState build() {
    _getFavoritesReportsRepository =
        ref.read(getAllFavoriteReportsRepositoryProvider);

    return GetAllFavoriteReportsState.initial();
  }

  Future<void> getAllFavoriteReports() async {
    state = state.copyWith(loadState: LoadState.loading);

    try {
      final value =
          await _getFavoritesReportsRepository.getAllFavoriteReports();

      if (!value.status) throw value.message.toException;

      state = state.copyWith(
          loadState: LoadState.idle,
          getAllFavoriteReports: AsyncResponse.success(value.data!));
    } catch (e) {
      state = state.copyWith(loadState: LoadState.idle);
    }
  }
}

final getFavoriteReportsNotifierProvider = NotifierProvider.autoDispose<
    GetFavoriteReportsNotifier,
    GetAllFavoriteReportsState>(GetFavoriteReportsNotifier.new);
