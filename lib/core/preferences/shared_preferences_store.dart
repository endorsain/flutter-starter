import 'package:shared_preferences/shared_preferences.dart';

import 'preferences_store.dart';

class SharedPreferencesStore implements PreferencesStore {
  SharedPreferencesStore(this._preferences);

  final SharedPreferences _preferences;

  static Future<SharedPreferencesStore> create() async {
    return SharedPreferencesStore(await SharedPreferences.getInstance());
  }

  @override
  Future<String?> getString(String key) async {
    return _preferences.getString(key);
  }

  @override
  Future<void> setString(String key, String value) async {
    final saved = await _preferences.setString(key, value);

    if (!saved) {
      throw StateError('No se pudo guardar la preferencia "$key".');
    }
  }
}
