import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_state.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/settings/data/model/settings_response.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/settings/data/repository/get_settings_repository.dart';

class GetSettingsNotifer
    extends AutoDisposeNotifier<BaseState<SettingsResponse>> {
  GetSettingsNotifer();
  late final GetSettingsRepository _getSettingsRepository;
  @override
  BaseState<SettingsResponse> build() {
    _getSettingsRepository = ref.read(getSettingsRepositoryProvider);
    return BaseState<SettingsResponse>.initial();
  }

  Future<void> getSettings() async {
    try {
      state = state.copyWith(state: LoadState.loading);
      final value = await _getSettingsRepository.getSettings();
      if (!value.status) throw value.message.toException;

      state = state.copyWith(state: LoadState.idle, data: value.data);
    } catch (e) {
      state = state.copyWith(state: LoadState.idle);
    }
  }
}

final settingsNotifer = NotifierProvider.autoDispose<GetSettingsNotifer,
    BaseState<SettingsResponse>>(
  GetSettingsNotifer.new,
);
