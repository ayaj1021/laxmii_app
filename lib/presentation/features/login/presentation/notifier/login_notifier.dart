import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_state.dart';
import 'package:laxmii_app/core/config/exception/logger.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/login/data/model/login_request.dart';
import 'package:laxmii_app/presentation/features/login/data/model/login_response.dart';
import 'package:laxmii_app/presentation/features/login/data/repository/login_repository.dart';

class LoginNotifier extends AutoDisposeNotifier<BaseState<LoginResponse>> {
  LoginNotifier();

  late LoginRepository _loginRepository;

  @override
  BaseState<LoginResponse> build() {
    _loginRepository = ref.read(loginRepositoryProvider);

    return BaseState<LoginResponse>.initial();
  }

  Future<void> login({
    required LoginRequest data,
    required void Function(String error) onError,
    required void Function(String message, bool isVerified, bool isAccountSetup)
        onSuccess,
  }) async {
    state = state.copyWith(state: LoadState.loading);

    try {
      final value = await _loginRepository.login(data);
      debugLog(data);
      if (!value.status) throw value.message.toException;
      log('Verified ${value.data?.isVerified}');
      log('message ${value.data?.profileSetup}');

      await AppDataStorage().saveUserAccessToken('${value.data?.accessToken}');
      await AppDataStorage()
          .saveUserRefreshToken('${value.data?.refreshToken}');
      await AppDataStorage().saveUserAccountName('${value.data?.name}');
      await AppDataStorage().saveUserEmail('${value.data?.email}');

      await AppDataStorage().saveCurrentState(CurrentState.loggedIn);
      await AppDataStorage().saveProfileSetup(
        value.data?.profileSetup ?? false,
      );

      state = state.copyWith(state: LoadState.success);
      onSuccess(value.message.toString(), (value.data?.isVerified ?? false),
          value.data?.profileSetup ?? false);
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(state: LoadState.idle);
    }
  }
}

final loginNotifier =
    NotifierProvider.autoDispose<LoginNotifier, BaseState<LoginResponse>>(
  LoginNotifier.new,
);
