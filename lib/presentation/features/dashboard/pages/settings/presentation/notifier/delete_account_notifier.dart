import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_state.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/settings/data/model/delete_account_response.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/settings/data/repository/delete_account_repository.dart';

class DeleteAccountNotifer
    extends AutoDisposeNotifier<BaseState<DeleteAccountResponse>> {
  DeleteAccountNotifer();
  late final DeleteAccountRepository _repository;
  @override
  BaseState<DeleteAccountResponse> build() {
    _repository = ref.read(deleteAccountRepositoryProvider);
    return BaseState<DeleteAccountResponse>.initial();
  }

  Future<void> deleteAccount({
    required void Function(String error) onError,
    required void Function(String message) onSuccess,
  }) async {
    try {
      state = state.copyWith(state: LoadState.loading);
      final value = await _repository.deleteAccount();
      if (!value.status) throw value.message.toException;

      state = state.copyWith(state: LoadState.success);
      onSuccess(value.data!.message.toString());
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(state: LoadState.error);
    }
  }
}

final deleteAccountNotifer = NotifierProvider.autoDispose<DeleteAccountNotifer,
    BaseState<DeleteAccountResponse>>(
  DeleteAccountNotifer.new,
);
