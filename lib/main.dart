import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/localization/locale_controller.dart';
import 'app/navigation/app_router.dart';
import 'app/theme/app_theme.dart';
import 'app/theme/theme_controller.dart';
import 'l10n/generated/app_localizations.dart';

Locale _resolveAppLocale(
  List<Locale>? locales,
  Iterable<Locale> supportedLocales,
) {
  for (final locale in locales ?? const <Locale>[]) {
    for (final supportedLocale in supportedLocales) {
      if (locale.languageCode == supportedLocale.languageCode) {
        return supportedLocale;
      }
    }
  }

  return const Locale('en');
}

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeControllerProvider);
    final localeState = ref.watch(localeControllerProvider);
    final themeId = themeState.asData?.value ?? AppThemeId.cosmo;
    final localePreference =
        localeState.asData?.value ?? LocalePreference.system;
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Flutter Starter',
      theme: AppTheme.fromId(themeId),
      locale: localePreference.locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      localeListResolutionCallback: _resolveAppLocale,
      routerConfig: router,
      builder: (context, child) {
        if (!themeState.hasError && !localeState.hasError) {
          return child ?? const SizedBox.shrink();
        }

        final localizations = AppLocalizations.of(context);
        final errorMessage = themeState.hasError
            ? localizations.themePreferenceRestoreError
            : localizations.localePreferenceRestoreError;

        return Scaffold(body: Center(child: Text(errorMessage)));
      },
    );
  }
}
