import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';

//final rememberMeProvider = StateProvider<bool>((ref) => false);

class EnableFaceIdNotifier extends StateNotifier<bool> {
  EnableFaceIdNotifier() : super(false) {
    _loadFaceId();
  }

  Future<void> _loadFaceId() async {
    final savedValue = await AppDataStorage().getFaceId();
    state = savedValue;
  }

  Future<void> toggle() async {
    state = !state;
    await AppDataStorage().saveFaceId(state);
  }

  Future<void> set(bool value) async {
    state = value;
    await AppDataStorage().saveFaceId(value);
  }
}

final enableFaceIdProvider = StateNotifierProvider<EnableFaceIdNotifier, bool>(
  (ref) => EnableFaceIdNotifier(),
);
