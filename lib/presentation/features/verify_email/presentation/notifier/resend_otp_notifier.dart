import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/logger.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/verify_email/data/model/resend_otp_request.dart';
import 'package:laxmii_app/presentation/features/verify_email/data/repository/resend_otp_repository.dart';
import 'package:laxmii_app/presentation/features/verify_email/presentation/notifier/resend_otp_state.dart';

class ResendOtpNotifier extends AutoDisposeNotifier<ResendOtpNotifierState> {
  ResendOtpNotifier();

  late ResendOtpRepository _resendOtpRepository;

  @override
  ResendOtpNotifierState build() {
    _resendOtpRepository = ref.read(resendOtpRepositoryProvider);

    return ResendOtpNotifierState.initial();
  }

  Future<void> resendOtp({
    required ResendOtpRequest data,
    required void Function(String error) onError,
    required void Function(String message) onSuccess,
  }) async {
    state = state.copyWith(resendOtpState: LoadState.loading);

    try {
      final value = await _resendOtpRepository.resendOtp(data);
      debugLog(data);
      if (!value.status) throw value.message.toException;

      state = state.copyWith(resendOtpState: LoadState.idle);
      onSuccess(value.data.message.toString());
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(resendOtpState: LoadState.idle);
    }
  }
}

final resendOtpNotifier =
    NotifierProvider.autoDispose<ResendOtpNotifier, ResendOtpNotifierState>(
  ResendOtpNotifier.new,
);
