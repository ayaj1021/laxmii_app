import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_state.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/login/data/model/get_user_details_response.dart';
import 'package:laxmii_app/presentation/features/login/data/repository/get_user_details_repository.dart';

class GetUserDetailsNotifier
    extends AutoDisposeNotifier<BaseState<GetUserDetailsResponse>> {
  GetUserDetailsNotifier();

  late GetUserDetailsRepository _getUserDetailsRepository;

  @override
  BaseState<GetUserDetailsResponse> build() {
    _getUserDetailsRepository = ref.read(getUserDetailsRepositoryProvider);

    return BaseState<GetUserDetailsResponse>.initial();
  }

  Future<void> getUserDetails() async {
    state = state.copyWith(state: LoadState.loading);

    try {
      final value = await _getUserDetailsRepository.getUserDetails();
      // debugLog(data);

      if (!value.status) throw value.message.toException;
      // onSuccess(value.message.toString());
      state = state.copyWith(state: LoadState.idle, data: value.data);
      await AppDataStorage().saveUserId('${value.data?.userId}');
      await AppDataStorage().saveUserCurrency('${value.data?.currency}');
      await AppDataStorage().saveUserCurrency('${value.data?.currency}');
      await AppDataStorage().saveUserImage('${value.data?.profilePicture}');
    } catch (e) {
      // onError(e.toString());
      state = state.copyWith(state: LoadState.idle);
    }
  }
}

final getUserDetailsNotifier = NotifierProvider.autoDispose<
    GetUserDetailsNotifier, BaseState<GetUserDetailsResponse>>(
  GetUserDetailsNotifier.new,
);
