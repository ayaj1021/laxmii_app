import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/logger.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/generate_report/data/model/add_report_to_favorite_request.dart';
import 'package:laxmii_app/presentation/features/generate_report/data/repository/add_report_to_favorite_repository.dart';
import 'package:laxmii_app/presentation/features/generate_report/presentation/notifier/add_reports_to_favorite_state.dart';

class AddReportToFavoriteNotifier
    extends AutoDisposeNotifier<AddReportsToFavoriteNotifierState> {
  AddReportToFavoriteNotifier();

  late AddReportToFavoriteRepository _addReportToFavoriteRepository;

  @override
  AddReportsToFavoriteNotifierState build() {
    _addReportToFavoriteRepository =
        ref.read(addReportToFavoriteRepositoryProvider);

    return AddReportsToFavoriteNotifierState.initial();
  }

  Future<void> addReportToFavorite({
    required AddReportToFavoriteRequest data,
    required void Function(String error) onError,
    required void Function(String message) onSuccess,
  }) async {
    state = state.copyWith(addReportToFavoriteState: LoadState.loading);

    try {
      final value =
          await _addReportToFavoriteRepository.addReportToFavorite(data);
      debugLog(data);
      if (!value.status) throw value.message.toException;

      state = state.copyWith(
          addReportToFavoriteState: LoadState.idle,
          addReportsToFavoriteResponse: value.data,
          isAdded: value.status);
      onSuccess(value.data!.message.toString());
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(addReportToFavoriteState: LoadState.idle);
    }
  }
}

final addReportsToFavoriteNotifier = NotifierProvider.autoDispose<
    AddReportToFavoriteNotifier, AddReportsToFavoriteNotifierState>(
  AddReportToFavoriteNotifier.new,
);
