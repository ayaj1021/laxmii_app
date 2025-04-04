import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_state.dart';
import 'package:laxmii_app/core/config/exception/logger.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/manage_account/data/model/update_profile_request.dart';
import 'package:laxmii_app/presentation/features/manage_account/data/model/update_profile_response.dart';
import 'package:laxmii_app/presentation/features/manage_account/data/repository/update_profile_repository.dart';

class SetupProfileNotifier
    extends AutoDisposeNotifier<BaseState<UpdateProfileResponse>> {
  SetupProfileNotifier();

  late UpdateProfileRepository _updateProfileRepository;

  @override
  BaseState<UpdateProfileResponse> build() {
    _updateProfileRepository = ref.read(updateProfileRepositoryProvider);

    return BaseState<UpdateProfileResponse>.initial();
  }

  Future<void> updateProfile({
    required UpdateProfileRequest data,
    required void Function(String error) onError,
    required void Function(String message) onSuccess,
  }) async {
    state = state.copyWith(state: LoadState.loading);

    try {
      final value = await _updateProfileRepository.updateProfile(data);
      debugLog(data);
      if (!value.status) throw value.message.toException;

      state = state.copyWith(state: LoadState.idle, data: value.data);

      await AppDataStorage().storeProfile(value.data!);

      onSuccess(
        value.message ?? 'Profile updated successfully',
      );
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(state: LoadState.idle);
    }
  }
}

final updateProfileNotifier = NotifierProvider.autoDispose<SetupProfileNotifier,
    BaseState<UpdateProfileResponse>>(
  SetupProfileNotifier.new,
);
