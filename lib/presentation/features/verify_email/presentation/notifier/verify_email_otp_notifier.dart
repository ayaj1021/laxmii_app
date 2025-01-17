import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/logger.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/verify_email/data/model/verify_email_otp_request.dart';
import 'package:laxmii_app/presentation/features/verify_email/data/repository/verify_email_otp_repository.dart';
import 'package:laxmii_app/presentation/features/verify_email/presentation/notifier/verify_email_otp_state.dart';

class VerifyEmailOtpNotifier
    extends AutoDisposeNotifier<VerifyEmailOtpNotifierState> {
  VerifyEmailOtpNotifier();

  late VerifyEmailOtpRepository _verifyEmailOtpRepository;

  @override
  VerifyEmailOtpNotifierState build() {
    _verifyEmailOtpRepository = ref.read(verifyEmailOtpRepositoryProvider);

    return VerifyEmailOtpNotifierState.initial();
  }

  Future<void> verifyEmailOtp({
    required VerifyEmailOtpRequest data,
    required void Function(String error) onError,
    required void Function(String message) onSuccess,
  }) async {
    state = state.copyWith(verifyEmailOtpState: LoadState.loading);

    try {
      final value = await _verifyEmailOtpRepository.verifyEmailOtp(data);
      debugLog(data);
      if (!value.status) throw value.message.toException;

      state = state.copyWith(verifyEmailOtpState: LoadState.idle);
      onSuccess(value.data.message.toString());
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(verifyEmailOtpState: LoadState.idle);
    }
  }
}

final verifyEmailOtpNotifier = NotifierProvider.autoDispose<
    VerifyEmailOtpNotifier, VerifyEmailOtpNotifierState>(
  VerifyEmailOtpNotifier.new,
);
