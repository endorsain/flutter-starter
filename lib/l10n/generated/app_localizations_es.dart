// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get localePreferenceRestoreError =>
      'No se pudo restaurar la preferencia de idioma guardada.';

  @override
  String get themePreferenceRestoreError =>
      'No se pudo restaurar la preferencia de tema guardada.';

  @override
  String get languageSystem => 'Automático (idioma del dispositivo)';

  @override
  String get languageEnglish => 'Inglés';

  @override
  String get languageSpanish => 'Español';

  @override
  String get loginTitle => 'Iniciar sesión';

  @override
  String get loginDescription =>
      'El acceso de desarrollo es simulado y no se comunica con un servidor.';

  @override
  String get authDebugOnly =>
      'El acceso simulado sólo está disponible en compilaciones debug.';

  @override
  String get loginAction => 'Continuar';

  @override
  String get registerTitle => 'Crear una cuenta';

  @override
  String get registerUnavailable => 'El registro todavía no está conectado.';

  @override
  String get registerPrompt => '¿No tenés una cuenta? Registrate';

  @override
  String get backToLogin => 'Volver al inicio de sesión';

  @override
  String get emailLabel => 'Correo electrónico';

  @override
  String get passwordLabel => 'Contraseña';

  @override
  String get requiredFieldError => 'Este campo es obligatorio.';

  @override
  String get logoutAction => 'Cerrar sesión';

  @override
  String get mapTab => 'Mapa';

  @override
  String get profileTab => 'Perfil';

  @override
  String get settingsTab => 'Configuración';

  @override
  String get cameraTab => 'Cámara';

  @override
  String get playgroundTab => 'Pruebas';

  @override
  String get mapTitle => 'Mapa';

  @override
  String get mapPlaceholder =>
      'La integración de mapas se agregará cuando se implemente esta función.';

  @override
  String get profileTitle => 'Perfil';

  @override
  String get profilePlaceholder =>
      'Los detalles del perfil se agregarán cuando se implemente esta función.';

  @override
  String get settingsTitle => 'Configuración';

  @override
  String get themeSettingTitle => 'Apariencia';

  @override
  String get themeCosmo => 'Cosmo';

  @override
  String get themeWanda => 'Wanda';

  @override
  String get languageSettingTitle => 'Idioma';

  @override
  String get cameraTitle => 'Cámara';

  @override
  String get cameraPlaceholder =>
      'La captura con la cámara todavía no está implementada.';

  @override
  String get playgroundTitle => 'Pruebas';

  @override
  String get playgroundPlaceholder =>
      'Esta área está reservada para experimentos de desarrollo.';
}
