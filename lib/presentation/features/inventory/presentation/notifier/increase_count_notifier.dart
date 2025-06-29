import 'package:flutter_riverpod/flutter_riverpod.dart';

class IncreaseCountNotifier extends StateNotifier<num> {
  IncreaseCountNotifier(num initial) : super(initial);

  void increment() {
    state++;
  }

  void decrement() {
    state--;
  }

  // void decrement() {
  //   if (state > 1) state--;
  // }

  void set(num value) => state = value;
}

final increaseCountProvider =
    StateNotifierProvider.family<IncreaseCountNotifier, num, num>(
        (ref, initial) {
  return IncreaseCountNotifier(initial);
});
