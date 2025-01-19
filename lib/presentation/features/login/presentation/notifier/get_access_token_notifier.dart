import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/logger.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/login/data/model/get_access_token_request.dart';
import 'package:laxmii_app/presentation/features/login/data/repository/get_access_token_repository.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_state.dart';

class GetAccessTokenNotifier
    extends AutoDisposeNotifier<GetAccessTokenNotifierState> {
  GetAccessTokenNotifier();

  late GetAccessTokenRepository _getAccessTokenRepository;

  @override
  GetAccessTokenNotifierState build() {
    _getAccessTokenRepository = ref.read(getAccessTokenRepositoryProvider);

    return GetAccessTokenNotifierState.initial();
  }

  Future<void> accessToken() async {
    state = state.copyWith(getAccessTokenState: LoadState.loading);
    final refreshToken = await AppDataStorage().getUserRefreshToken();
    final data = GetAccessTokenRequest(token: '$refreshToken');
    try {
      final value = await _getAccessTokenRepository.getAccessToken(data);
      debugLog(data);
      if (!value.status) throw value.message.toException;
      await AppDataStorage().saveUserAccessToken('${value.data?.accessToken}');

      state = state.copyWith(getAccessTokenState: LoadState.idle);
      // onSuccess(value.message.toString());
    } catch (e) {
      // onError(e.toString());
      state = state.copyWith(getAccessTokenState: LoadState.idle);
    }
  }
}

final getAccessTokenNotifier = NotifierProvider.autoDispose<
    GetAccessTokenNotifier, GetAccessTokenNotifierState>(
  GetAccessTokenNotifier.new,
);
