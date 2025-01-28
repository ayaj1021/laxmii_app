import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/logger.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/generate_report/data/model/get_single_report_request.dart';
import 'package:laxmii_app/presentation/features/generate_report/data/repository/get_single_report_repository.dart';
import 'package:laxmii_app/presentation/features/generate_report/presentation/notifier/get_single_report_state.dart';

class GetSingleReportNotifier
    extends AutoDisposeNotifier<GetSingleReportNotifierState> {
  GetSingleReportNotifier();

  late GetSingleReportRepository _getSingleReportRepository;

  @override
  GetSingleReportNotifierState build() {
    _getSingleReportRepository = ref.read(getSingleReportRepositoryProvider);

    return GetSingleReportNotifierState.initial();
  }

  Future<void> getSingleReport({
    required GetSingleReportRequest data,
    required void Function(String error) onError,
    // required void Function(String message) onSuccess,
  }) async {
    state = state.copyWith(getSingleReportState: LoadState.loading);

    try {
      final value = await _getSingleReportRepository.getSingleReport(data);
      debugLog(data);
      if (!value.status) throw value.message.toException;

      state = state.copyWith(
        getSingleReportState: LoadState.idle,
        getSingleReportResponse: value.data,
      );
      //  onSuccess("${value.message}");
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(getSingleReportState: LoadState.idle);
    }
  }
}

final getSingleReportNotifier = NotifierProvider.autoDispose<
    GetSingleReportNotifier, GetSingleReportNotifierState>(
  GetSingleReportNotifier.new,
);
