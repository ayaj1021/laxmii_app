import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_state.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/profile_setup/data/model/get_country_currency_response.dart';
import 'package:laxmii_app/presentation/features/profile_setup/data/repository/get_country_currency_repository.dart';

// class GetCountriesNotifier
//     extends AutoDisposeNotifier<BaseState<AllCountriesResponse>> {
//   GetCountriesNotifier();

//   late GetCountryCurrencyRepository _getCountryCurrencyRepository;

//   @override
//   BaseState<AllCountriesResponse> build() {
//     _getCountryCurrencyRepository = ref.read(getAllCountriesProvider);

//     return BaseState<AllCountriesResponse>.initial();
//   }

//   Future<void> getCountries() async {
//     state = state.copyWith(state: LoadState.loading);

//     try {
//       final value = await _getCountryCurrencyRepository.getAllCountries();

//       //  if (!value.status) throw value.message.toException;

//       state = state.copyWith(state: LoadState.success, data: value);
//     } catch (e) {
//       state = state.copyWith(state: LoadState.idle);
//     }
//   }
// }

// final getCountriesNotifier = NotifierProvider.autoDispose<GetCountriesNotifier,
//     BaseState<AllCountriesResponse>>(
//   GetCountriesNotifier.new,
// );

class GetCountriesNotifier
    extends AutoDisposeNotifier<BaseState<List<AllCountriesResponse>>> {
  GetCountriesNotifier();

  late GetCountryCurrencyRepository _getCountryCurrencyRepository;

  @override
  BaseState<List<AllCountriesResponse>> build() {
    _getCountryCurrencyRepository = ref.read(getAllCountriesProvider);
    return BaseState<List<AllCountriesResponse>>.initial();
  }

  Future<void> getCountries() async {
    state = state.copyWith(state: LoadState.loading);

    try {
      final value = await _getCountryCurrencyRepository.getAllCountries();
      state = state.copyWith(state: LoadState.success, data: value);
    } catch (e) {
      state = state.copyWith(state: LoadState.error);
    }
  }
}

final getCountriesNotifier = NotifierProvider.autoDispose<GetCountriesNotifier,
    BaseState<List<AllCountriesResponse>>>(
  GetCountriesNotifier.new,
);
