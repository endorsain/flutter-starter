import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/preferences/preferences_store.dart';
import '../providers/preferences_provider.dart';

enum LocalePreference {
  system,
  english,
  spanish;

  Locale? get locale => switch (this) {
    LocalePreference.system => null,
    LocalePreference.english => const Locale('en'),
    LocalePreference.spanish => const Locale('es'),
  };
}

const String _localePreferenceKey = 'app_locale_preference';

final localeControllerProvider =
    AsyncNotifierProvider<LocaleController, LocalePreference>(
      LocaleController.new,
    );

class LocaleController extends AsyncNotifier<LocalePreference> {
  @override
  Future<LocalePreference> build() async {
    final preferences = await ref.read(preferencesStoreProvider.future);
    final storedPreference = await preferences.getString(_localePreferenceKey);

    if (storedPreference == null) {
      return LocalePreference.system;
    }

    for (final preference in LocalePreference.values) {
      if (preference.name == storedPreference) {
        return preference;
      }
    }

    throw FormatException(
      'La preferencia de idioma guardada "$storedPreference" no es válida.',
    );
  }

  Future<void> setPreference(LocalePreference preference) async {
    final PreferencesStore preferences = await ref.read(
      preferencesStoreProvider.future,
    );
    await preferences.setString(_localePreferenceKey, preference.name);
    state = AsyncData<LocalePreference>(preference);
  }
}
