import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// Shown when the saved language preference cannot be loaded.
  ///
  /// In en, this message translates to:
  /// **'The saved language preference could not be restored.'**
  String get localePreferenceRestoreError;

  /// Shown when the saved theme preference cannot be loaded.
  ///
  /// In en, this message translates to:
  /// **'The saved theme preference could not be restored.'**
  String get themePreferenceRestoreError;

  /// Language option that follows the device language.
  ///
  /// In en, this message translates to:
  /// **'Automatic (device language)'**
  String get languageSystem;

  /// Manual language option for English.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// Manual language option for Spanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get languageSpanish;

  /// Title of the login screen.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get loginTitle;

  /// Explains that login is a local development simulation.
  ///
  /// In en, this message translates to:
  /// **'Development sign-in is simulated and does not contact a server.'**
  String get loginDescription;

  /// Shown when trying to use simulated authentication outside debug mode.
  ///
  /// In en, this message translates to:
  /// **'Simulated sign-in is available only in debug builds.'**
  String get authDebugOnly;

  /// Submits the development login form.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get loginAction;

  /// Title of the registration screen.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get registerTitle;

  /// Explains that registration is not implemented.
  ///
  /// In en, this message translates to:
  /// **'Registration is not connected yet.'**
  String get registerUnavailable;

  /// Link from the login screen to registration.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? Register'**
  String get registerPrompt;

  /// Returns from registration to login.
  ///
  /// In en, this message translates to:
  /// **'Back to login'**
  String get backToLogin;

  /// Email field label.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// Password field label.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// Validation message for a required form field.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get requiredFieldError;

  /// Accessible label for the log out action.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logoutAction;

  /// Navigation destination label for the map tab.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get mapTab;

  /// Navigation destination label for the profile tab.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTab;

  /// Navigation destination label for the settings tab.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTab;

  /// Navigation destination label for the camera tab.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get cameraTab;

  /// Navigation destination label for the playground tab.
  ///
  /// In en, this message translates to:
  /// **'Playground'**
  String get playgroundTab;

  /// Heading for the map destination.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get mapTitle;

  /// Placeholder explaining that no real map is available yet.
  ///
  /// In en, this message translates to:
  /// **'Map integration will be added when this feature is implemented.'**
  String get mapPlaceholder;

  /// Heading for the profile destination.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// Placeholder explaining that profile functionality is not implemented.
  ///
  /// In en, this message translates to:
  /// **'Profile details will be added when this feature is implemented.'**
  String get profilePlaceholder;

  /// Heading for settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// Heading for the theme selection setting.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get themeSettingTitle;

  /// Name of the Cosmo visual theme.
  ///
  /// In en, this message translates to:
  /// **'Cosmo'**
  String get themeCosmo;

  /// Name of the Wanda visual theme.
  ///
  /// In en, this message translates to:
  /// **'Wanda'**
  String get themeWanda;

  /// Heading for the language selection setting.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageSettingTitle;

  /// Heading for the camera destination.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get cameraTitle;

  /// Placeholder explaining that camera capture is not available.
  ///
  /// In en, this message translates to:
  /// **'Camera capture is not implemented yet.'**
  String get cameraPlaceholder;

  /// Heading for the playground destination.
  ///
  /// In en, this message translates to:
  /// **'Playground'**
  String get playgroundTitle;

  /// Placeholder explaining the purpose of the playground.
  ///
  /// In en, this message translates to:
  /// **'This area is reserved for development experiments.'**
  String get playgroundPlaceholder;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
