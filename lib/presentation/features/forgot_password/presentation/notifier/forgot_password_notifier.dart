import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/logger.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/forgot_password/data/model/forgot_password_request.dart';
import 'package:laxmii_app/presentation/features/forgot_password/data/repository/forgot_password_repository.dart';
import 'package:laxmii_app/presentation/features/forgot_password/presentation/notifier/forgot_password_state.dart';

class ForgotPasswordNotifier
    extends AutoDisposeNotifier<ForgotPasswordNotifierState> {
  ForgotPasswordNotifier();

  late ForgotPasswordRepository _forgotPasswordRepository;

  @override
  ForgotPasswordNotifierState build() {
    _forgotPasswordRepository = ref.read(forgotPasswordRepositoryProvider);

    return ForgotPasswordNotifierState.initial();
  }

  Future<void> forgotPassword({
    required ForgotPasswordRequest data,
    required void Function(String error) onError,
    required void Function(String message) onSuccess,
  }) async {
    state = state.copyWith(forgotPasswordState: LoadState.loading);

    try {
      final value = await _forgotPasswordRepository.forgotPassword(data);
      debugLog(data);
      if (!value.status) throw value.message.toException;

      state = state.copyWith(forgotPasswordState: LoadState.idle);
      onSuccess(value.data.message.toString());
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(forgotPasswordState: LoadState.idle);
    }
  }
}

final forgotPasswordNotifier = NotifierProvider.autoDispose<
    ForgotPasswordNotifier, ForgotPasswordNotifierState>(
  ForgotPasswordNotifier.new,
);
