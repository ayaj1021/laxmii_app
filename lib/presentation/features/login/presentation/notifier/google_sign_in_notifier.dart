import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_state.dart';
import 'package:laxmii_app/core/config/exception/logger.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/login/data/model/google_sign_in_request.dart';
import 'package:laxmii_app/presentation/features/login/data/model/login_response.dart';
import 'package:laxmii_app/presentation/features/login/data/repository/sign_in_google_repo.dart';

class GoogleSignInNotifier
    extends AutoDisposeNotifier<BaseState<LoginResponse>> {
  GoogleSignInNotifier();

  late GoogleSignInRepository _repository;

  @override
  BaseState<LoginResponse> build() {
    _repository = ref.read(googleSignInRepositoryProvider);

    return BaseState<LoginResponse>.initial();
  }

  Future<void> googleSignIn({
    required GoogleSignInRequest data,
    required void Function(String error) onError,
    required void Function(String message, bool isVerified, bool isAccountSetup)
        onSuccess,
  }) async {
    state = state.copyWith(state: LoadState.loading);

    try {
      final value = await _repository.googleSignIn(data);
      debugLog(data);
      if (!value.status) throw value.message.toException;

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

final googleSignInNotifier = NotifierProvider.autoDispose<GoogleSignInNotifier,
    BaseState<LoginResponse>>(
  GoogleSignInNotifier.new,
);
