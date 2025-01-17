import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/logger.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/login/data/model/login_request.dart';
import 'package:laxmii_app/presentation/features/login/data/repository/login_repository.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/login_state.dart';

class LoginNotifier extends AutoDisposeNotifier<LoginNotifierState> {
  LoginNotifier();

  late LoginRepository _loginRepository;

  @override
  LoginNotifierState build() {
    _loginRepository = ref.read(loginRepositoryProvider);

    return LoginNotifierState.initial();
  }

  Future<void> login({
    required LoginRequest data,
    required void Function(String error) onError,
    required void Function(String message) onSuccess,
  }) async {
    state = state.copyWith(loginState: LoadState.loading);

    try {
      final value = await _loginRepository.login(data);
      debugLog(data);
      if (!value.status) throw value.message.toException;
      await SecureStorage().saveUserAccessToken('${value.data?.accessToken}');
      await SecureStorage().saveUserRefreshToken('${value.data?.refreshToken}');
      await SecureStorage().saveUserAccountName('${value.data?.name}');
      await SecureStorage().saveUserEmail('${value.data?.email}');
      state = state.copyWith(loginState: LoadState.idle);
      onSuccess(value.message.toString());
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(loginState: LoadState.idle);
    }
  }
}

final loginNotifier =
    NotifierProvider.autoDispose<LoginNotifier, LoginNotifierState>(
  LoginNotifier.new,
);
