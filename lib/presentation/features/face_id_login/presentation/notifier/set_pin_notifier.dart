import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_state.dart';
import 'package:laxmii_app/core/config/exception/logger.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/face_id_login/data/model/set_pin_request.dart';
import 'package:laxmii_app/presentation/features/face_id_login/data/model/set_pin_response.dart';
import 'package:laxmii_app/presentation/features/face_id_login/data/repository/set_pin_repository.dart';

class SetPinNotifier extends AutoDisposeNotifier<BaseState<SetPinResponse>> {
  SetPinNotifier();

  late SetPinRepository _repository;

  @override
  BaseState<SetPinResponse> build() {
    _repository = ref.read(setPinRepositoryProvider);

    return BaseState<SetPinResponse>.initial();
  }

  Future<void> setPin({
    required SetPinRequest data,
    required void Function(String error) onError,
    required void Function(String message) onSuccess,
  }) async {
    state = state.copyWith(state: LoadState.loading);

    try {
      final value = await _repository.setPin(data);
      debugLog(data);
      if (!value.status) throw value.message.toException;

      await AppDataStorage().saveUserPin('${value.data?.pin}');
      await AppDataStorage().saveIsPinSet(value.data?.pinSet ?? false);

      state = state.copyWith(state: LoadState.success);
      onSuccess(value.message ?? 'Pin set successfully');
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(state: LoadState.idle);
    }
  }
}

final setPinNotifier =
    NotifierProvider.autoDispose<SetPinNotifier, BaseState<SetPinResponse>>(
  SetPinNotifier.new,
);
