import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/logger.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/forgot_password/data/model/change_password_request.dart';
import 'package:laxmii_app/presentation/features/forgot_password/data/repository/change_password_repository.dart';
import 'package:laxmii_app/presentation/features/forgot_password/presentation/notifier/change_password_state.dart';

class ForgotPasswordNotifier
    extends AutoDisposeNotifier<ChangePasswordNotifierState> {
  ForgotPasswordNotifier();

  late ChangePasswordRepository _changePasswordRepository;

  @override
  ChangePasswordNotifierState build() {
    _changePasswordRepository = ref.read(changePasswordRepositoryProvider);

    return ChangePasswordNotifierState.initial();
  }

  Future<void> changePassword({
    required ChangePasswordRequest data,
    required void Function(String error) onError,
    required void Function(String message) onSuccess,
  }) async {
    state = state.copyWith(changePasswordState: LoadState.loading);

    try {
      final value = await _changePasswordRepository.changePassword(data);
      debugLog(data);
      if (!value.status) throw value.message.toException;

      state = state.copyWith(changePasswordState: LoadState.idle);
      onSuccess(value.data.message.toString());
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(changePasswordState: LoadState.idle);
    }
  }
}

final changePasswordNotifier = NotifierProvider.autoDispose<
    ForgotPasswordNotifier, ChangePasswordNotifierState>(
  ForgotPasswordNotifier.new,
);
