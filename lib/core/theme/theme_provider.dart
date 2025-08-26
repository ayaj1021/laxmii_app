// theme_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';

// Async provider that reads from storage
final themeProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(true) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    try {
      final theme = await AppDataStorage().getAppTheme();
      state = theme;
    } catch (e) {
      // Handle error, keep default value
      state = true;
    }
  }

  void toggleTheme(bool isLight) {
    state = isLight;
    _saveTheme(isLight);
  }

  Future<void> _saveTheme(bool value) async {
    await AppDataStorage().setAppTheme(value);
  }
}
