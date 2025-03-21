import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckboxStateNotifier extends StateNotifier<Map<String, bool>> {
  CheckboxStateNotifier() : super({});

  void toggleCheckbox(String key, bool value) {
    state = {...state, key: value};
  }

  Map<String, bool> get selectedCheckboxes {
    return state;
  }
}

// Create a provider
final checkboxStateProvider =
    StateNotifierProvider<CheckboxStateNotifier, Map<String, bool>>((ref) {
  return CheckboxStateNotifier();
});
