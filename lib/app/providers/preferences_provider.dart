import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/preferences/preferences_store.dart';
import '../../core/preferences/shared_preferences_store.dart';

final preferencesStoreProvider = FutureProvider<PreferencesStore>(
  (ref) => SharedPreferencesStore.create(),
);
