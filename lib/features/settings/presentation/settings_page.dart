import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/localization/locale_controller.dart';
import '../../../app/theme/app_theme.dart';
import '../../../app/theme/theme_controller.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/widgets/app_form_container.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final themeId =
        ref.watch(themeControllerProvider).asData?.value ?? AppThemeId.cosmo;
    final localePreference =
        ref.watch(localeControllerProvider).asData?.value ??
        LocalePreference.system;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        AppFormContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                localizations.themeSettingTitle,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onSecondary,
                ),
              ),
              const SizedBox(height: 12),
              SegmentedButton<AppThemeId>(
                segments: [
                  ButtonSegment<AppThemeId>(
                    value: AppThemeId.cosmo,
                    label: Text(localizations.themeCosmo),
                  ),
                  ButtonSegment<AppThemeId>(
                    value: AppThemeId.wanda,
                    label: Text(localizations.themeWanda),
                  ),
                ],
                selected: <AppThemeId>{themeId},
                onSelectionChanged: (selection) {
                  ref
                      .read(themeControllerProvider.notifier)
                      .setTheme(selection.first);
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        AppFormContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                localizations.languageSettingTitle,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onSecondary,
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<LocalePreference>(
                initialValue: localePreference,
                items: [
                  DropdownMenuItem<LocalePreference>(
                    value: LocalePreference.system,
                    child: Text(localizations.languageSystem),
                  ),
                  DropdownMenuItem<LocalePreference>(
                    value: LocalePreference.english,
                    child: Text(localizations.languageEnglish),
                  ),
                  DropdownMenuItem<LocalePreference>(
                    value: LocalePreference.spanish,
                    child: Text(localizations.languageSpanish),
                  ),
                ],
                onChanged: (preference) {
                  if (preference == null) {
                    return;
                  }

                  ref
                      .read(localeControllerProvider.notifier)
                      .setPreference(preference);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
