import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_state.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/settings/data/model/update_settings_request.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/settings/data/model/update_settings_response.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/settings/data/repository/update_settings_repository.dart';

class UpdateSettingsNotifer
    extends AutoDisposeNotifier<BaseState<UpdateSettingsResponse>> {
  UpdateSettingsNotifer();
  late final UpdateSettingsRepository _updateSettingsRepository;
  @override
  BaseState<UpdateSettingsResponse> build() {
    _updateSettingsRepository = ref.read(updateSettingsRepositoryProvider);
    return BaseState<UpdateSettingsResponse>.initial();
  }

  Future<void> updateSettings({
    required UpdateSettingsRequest data,
    required Function(String error) onError,
    required Function(String message) onSuccess,
  }) async {
    try {
      state = state.copyWith(state: LoadState.loading);
      final value = await _updateSettingsRepository.updateSettings(data);
      if (!value.status) throw value.message.toException;

      state = state.copyWith(state: LoadState.idle, data: value.data);
      onSuccess(value.message ?? 'Notifications updated');
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(state: LoadState.idle);
    }
  }
}

final updateSettingsNotifer = NotifierProvider.autoDispose<
    UpdateSettingsNotifer, BaseState<UpdateSettingsResponse>>(
  UpdateSettingsNotifer.new,
);
