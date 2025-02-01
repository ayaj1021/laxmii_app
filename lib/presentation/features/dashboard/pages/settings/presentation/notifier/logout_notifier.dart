import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/settings/data/model/logout_request.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/settings/data/repository/logout_repository.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/settings/presentation/notifier/logout_state.dart';

class LogOutNotifer extends AutoDisposeNotifier<LogoutNotiferState> {
  LogOutNotifer();
  late final LogoutRepository _logOutRepository;
  @override
  LogoutNotiferState build() {
    _logOutRepository = ref.read(logOutRepositoryProvider);
    return LogoutNotiferState.initial();
  }

  Future<void> logOut({
    required LogoutRequest data,
    required void Function(String error) onError,
    required void Function(String message) onSuccess,
  }) async {
    try {
      state = state.copyWith(logOut: LoadState.loading);
      final value = await _logOutRepository.logOut(data);
      if (!value.status) throw value.message.toException;

      state = state.copyWith(logOut: LoadState.idle);
      onSuccess(value.data!.message.toString());
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(logOut: LoadState.idle);
    }
  }

  Future<void> expireLogOut() async {
    // _userRepository.saveCurrentState(CurrentState.onboarded);
    state = state.copyWith(homeSessionState: HomeSessionState.logout);
  }

  Future<void> logout() async {
    await AppDataStorage().saveCurrentState(CurrentState.onboarded);

    state = state.copyWith(homeSessionState: HomeSessionState.logout);
  }
}

final logOutNotifer =
    NotifierProvider.autoDispose<LogOutNotifer, LogoutNotiferState>(
  LogOutNotifer.new,
);
