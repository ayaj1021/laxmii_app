import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/logger.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/generate_report/data/model/delete_report_favorite_request.dart';
import 'package:laxmii_app/presentation/features/generate_report/data/repository/delete_report_favorite_repository.dart';
import 'package:laxmii_app/presentation/features/generate_report/presentation/notifier/delete_report_favorite_state.dart';

class DeleteReportFavoriteNotifier
    extends AutoDisposeNotifier<DeleteReportsFavoriteNotifierState> {
  DeleteReportFavoriteNotifier();

  late DeleteFavoriteReportRepository _deleteReportFavoriteRepository;

  @override
  DeleteReportsFavoriteNotifierState build() {
    _deleteReportFavoriteRepository =
        ref.read(deleteReportFavoriteRepositoryProvider);

    return DeleteReportsFavoriteNotifierState.initial();
  }

  Future<void> deleteReportFavorite({
    required DeleteReportFavoriteRequest data,
    required void Function(String error) onError,
    required void Function(String message) onSuccess,
  }) async {
    state = state.copyWith(deleteReportFavoriteState: LoadState.loading);

    try {
      final value =
          await _deleteReportFavoriteRepository.deleteReportFavorite(data);
      debugLog(data);
      if (!value.status) throw value.message.toException;

      state = state.copyWith(
          deleteReportFavoriteState: LoadState.idle,
          deleteReportsFavoriteResponse: value.data,
          isAdded: false);
      onSuccess(value.data!.message.toString());
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(deleteReportFavoriteState: LoadState.idle);
    }
  }
}

final deleteReportFavoriteNotifier = NotifierProvider.autoDispose<
    DeleteReportFavoriteNotifier, DeleteReportsFavoriteNotifierState>(
  DeleteReportFavoriteNotifier.new,
);
