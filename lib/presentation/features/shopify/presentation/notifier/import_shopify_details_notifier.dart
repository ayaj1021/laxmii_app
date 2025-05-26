import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_state.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/login/data/model/get_user_details_response.dart';
import 'package:laxmii_app/presentation/features/shopify/data/repository/import_shopify_details_repository.dart';

class ImportShopifyDetailsNotifier
    extends AutoDisposeNotifier<BaseState<GetUserDetailsResponse>> {
  ImportShopifyDetailsNotifier();

  late ImportShopifyDetailsRepository _repository;

  @override
  BaseState<GetUserDetailsResponse> build() {
    _repository = ref.read(importShopifyDetailsRepositoryProvider);

    return BaseState<GetUserDetailsResponse>.initial();
  }

  Future<void> importShopifyDetails() async {
    state = state.copyWith(state: LoadState.loading);

    try {
      final value = await _repository.importShopifyDetails();
      // debugLog(data);
      if (!value.status) throw value.message.toException;

      state = state.copyWith(state: LoadState.idle);
      // onSuccess(value.message.toString());
    } catch (e) {
      // onError(e.toString());
      state = state.copyWith(state: LoadState.idle);
    }
  }
}

final importSpopifyDetailsNotifier = NotifierProvider.autoDispose<
    ImportShopifyDetailsNotifier, BaseState<GetUserDetailsResponse>>(
  ImportShopifyDetailsNotifier.new,
);
