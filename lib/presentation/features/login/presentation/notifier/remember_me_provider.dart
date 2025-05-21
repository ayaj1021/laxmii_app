import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';

//final rememberMeProvider = StateProvider<bool>((ref) => false);

class RememberMeNotifier extends StateNotifier<bool> {
  RememberMeNotifier() : super(false) {
    _loadRememberMe();
  }

  Future<void> _loadRememberMe() async {
    final savedValue = await AppDataStorage().getRememberMe();
    state = savedValue;
  }

  Future<void> toggle() async {
    state = !state;
    await AppDataStorage().saveRememberMe(state);
  }

  Future<void> set(bool value) async {
    state = value;
    await AppDataStorage().saveRememberMe(value);
  }
}

final rememberMeProvider = StateNotifierProvider<RememberMeNotifier, bool>(
  (ref) => RememberMeNotifier(),
);
