import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/logger.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/profile_setup/data/model/setup_profile_request.dart';
import 'package:laxmii_app/presentation/features/profile_setup/data/repository/setup_profile_repository.dart';
import 'package:laxmii_app/presentation/features/profile_setup/presentation/notifier/setup_profile_state.dart';

class SetupProfileNotifier
    extends AutoDisposeNotifier<SetupProfileNotifierState> {
  SetupProfileNotifier();

  late SetupProfileRepository _setupProfileRepository;

  @override
  SetupProfileNotifierState build() {
    _setupProfileRepository = ref.read(setupProfileRepositoryProvider);

    return SetupProfileNotifierState.initial();
  }

  void allInputValid({
    required bool name,
    required bool email,
    required bool password,
  }) {
    state = state.copyWith(inputValid: email && password && name);
  }

  Future<void> setupProfile({
    required SetupUpProfileRequest data,
    required void Function(String error) onError,
    required void Function(String message) onSuccess,
  }) async {
    state = state.copyWith(setupProfileState: LoadState.loading);

    try {
      final value = await _setupProfileRepository.setupProfile(data);
      debugLog(data);
      if (!value.status) throw value.message.toException;

      state = state.copyWith(setupProfileState: LoadState.idle);
      await AppDataStorage().saveCurrentState(CurrentState.onboarded);
      onSuccess(
        value.data.message.toString(),
      );
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(setupProfileState: LoadState.idle);
    }
  }
}

final setupProfileNotifier = NotifierProvider.autoDispose<SetupProfileNotifier,
    SetupProfileNotifierState>(
  SetupProfileNotifier.new,
);
