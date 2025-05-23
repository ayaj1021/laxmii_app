import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_state.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/ai_chat/data/model/send_report_request.dart';
import 'package:laxmii_app/presentation/features/ai_chat/data/model/send_request_response.dart';
import 'package:laxmii_app/presentation/features/ai_chat/data/repository/send_report_repository.dart';

class SendAiReportNotifier
    extends AutoDisposeNotifier<BaseState<SendReportResponse>> {
  SendAiReportNotifier();

  late SendReportRepository _repository;

  @override
  BaseState<SendReportResponse> build() {
    _repository = ref.read(sendAiReportRepositoryProvider);

    return BaseState<SendReportResponse>.initial();
  }

  Future<void> sendAiReport({
    required SendReportRequest request,
    required void Function(String error) onError,
    required void Function(String message) onSuccess,
  }) async {
    state = state.copyWith(state: LoadState.loading);

    try {
      final value = await _repository.sendAiReport(request);

      if (!value.status) throw value.message.toException;

      state = state.copyWith(state: LoadState.idle, data: value.data);
      onSuccess(value.message ?? 'Report sent successfully');
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(state: LoadState.idle);
    }
  }
}

final sendAiReportNotifier = NotifierProvider.autoDispose<SendAiReportNotifier,
    BaseState<SendReportResponse>>(
  SendAiReportNotifier.new,
);
