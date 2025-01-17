import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/logger.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/sign_up/data/model/sign_up_request.dart';
import 'package:laxmii_app/presentation/features/sign_up/data/repository/sign_up_repository.dart';
import 'package:laxmii_app/presentation/features/sign_up/notifier/sign_up_state.dart';

class RegisterNotifier extends AutoDisposeNotifier<SignUpNotifierState> {
  RegisterNotifier();

  late SignUpRepository _signUpRepository;

  @override
  SignUpNotifierState build() {
    _signUpRepository = ref.read(signUpRepositoryProvider);

    return SignUpNotifierState.initial();
  }

  void allInputValid({
    required bool name,
    required bool email,
    required bool password,
  }) {
    state = state.copyWith(inputValid: email && password && name);
  }

  Future<void> signUp({
    required SignUpRequest data,
    required void Function(String error) onError,
    required void Function(String message) onSuccess,
  }) async {
    state = state.copyWith(signUpState: LoadState.loading);

    try {
      final value = await _signUpRepository.signUp(data);
      debugLog(data);
      if (!value.status) throw value.message.toException;

      state = state.copyWith(signUpState: LoadState.idle);
      onSuccess(value.data.message.toString());
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(signUpState: LoadState.idle);
    }
  }
}

final signUpNotifier =
    NotifierProvider.autoDispose<RegisterNotifier, SignUpNotifierState>(
  RegisterNotifier.new,
);
