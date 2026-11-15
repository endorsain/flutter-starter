// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get localePreferenceRestoreError =>
      'The saved language preference could not be restored.';

  @override
  String get themePreferenceRestoreError =>
      'The saved theme preference could not be restored.';

  @override
  String get languageSystem => 'Automatic (device language)';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageSpanish => 'Spanish';

  @override
  String get loginTitle => 'Log in';

  @override
  String get loginDescription =>
      'Development sign-in is simulated and does not contact a server.';

  @override
  String get authDebugOnly =>
      'Simulated sign-in is available only in debug builds.';

  @override
  String get loginAction => 'Continue';

  @override
  String get registerTitle => 'Create an account';

  @override
  String get registerUnavailable => 'Registration is not connected yet.';

  @override
  String get registerPrompt => 'Don\'t have an account? Register';

  @override
  String get backToLogin => 'Back to login';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get requiredFieldError => 'This field is required.';

  @override
  String get logoutAction => 'Log out';

  @override
  String get mapTab => 'Map';

  @override
  String get profileTab => 'Profile';

  @override
  String get settingsTab => 'Settings';

  @override
  String get cameraTab => 'Camera';

  @override
  String get playgroundTab => 'Playground';

  @override
  String get mapTitle => 'Map';

  @override
  String get mapPlaceholder =>
      'Map integration will be added when this feature is implemented.';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profilePlaceholder =>
      'Profile details will be added when this feature is implemented.';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get themeSettingTitle => 'Appearance';

  @override
  String get themeCosmo => 'Cosmo';

  @override
  String get themeWanda => 'Wanda';

  @override
  String get languageSettingTitle => 'Language';

  @override
  String get cameraTitle => 'Camera';

  @override
  String get cameraPlaceholder => 'Camera capture is not implemented yet.';

  @override
  String get playgroundTitle => 'Playground';

  @override
  String get playgroundPlaceholder =>
      'This area is reserved for development experiments.';
}
