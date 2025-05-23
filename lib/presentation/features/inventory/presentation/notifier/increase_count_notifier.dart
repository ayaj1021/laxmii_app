import 'package:flutter_riverpod/flutter_riverpod.dart';

class IncreaseCountNotifier extends StateNotifier<int> {
  IncreaseCountNotifier(int initial) : super(initial);

  void increment() {
    state++;
  }

  void decrement() {
    state--;
  }

  // void decrement() {
  //   if (state > 1) state--;
  // }

  void set(int value) => state = value;
}

final increaseCountProvider =
    StateNotifierProvider.family<IncreaseCountNotifier, int, int>(
        (ref, initial) {
  return IncreaseCountNotifier(initial);
});
