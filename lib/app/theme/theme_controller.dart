import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/preferences/preferences_store.dart';
import '../providers/preferences_provider.dart';
import 'app_theme.dart';

const String _themePreferenceKey = 'app_theme_id';

final themeControllerProvider =
    AsyncNotifierProvider<ThemeController, AppThemeId>(ThemeController.new);

class ThemeController extends AsyncNotifier<AppThemeId> {
  @override
  Future<AppThemeId> build() async {
    final PreferencesStore preferences = await ref.read(
      preferencesStoreProvider.future,
    );
    final storedThemeId = await preferences.getString(_themePreferenceKey);

    if (storedThemeId == null) {
      return AppThemeId.cosmo;
    }

    for (final themeId in AppThemeId.values) {
      if (themeId.name == storedThemeId) {
        return themeId;
      }
    }

    throw FormatException('El tema guardado "$storedThemeId" no es válido.');
  }

  Future<void> setTheme(AppThemeId themeId) async {
    final PreferencesStore preferences = await ref.read(
      preferencesStoreProvider.future,
    );
    await preferences.setString(_themePreferenceKey, themeId.name);
    state = AsyncData<AppThemeId>(themeId);
  }
}
