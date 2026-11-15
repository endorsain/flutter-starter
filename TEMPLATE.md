# Usar esta plantilla

## Crear un repositorio independiente

1. En GitHub, abrí este repositorio y elegí **Use this template** > **Create a new repository**.
2. Elegí el propietario, el nombre y la visibilidad del nuevo repositorio.
3. Cloná el repositorio creado (no trabajes sobre el repositorio de la plantilla) y abrilo en el entorno de desarrollo.
4. Confirmá que Flutter cumple la restricción de SDK de `pubspec.yaml` y ejecutá:

   ```shell
   flutter pub get
   ```

## Cambiar la identidad del proyecto

Actualizá la identidad en todos los lugares correspondientes; buscá también apariciones residuales del nombre o identificador anteriores.

- En `pubspec.yaml`, cambiá `name` a un identificador Dart válido en `snake_case`, y completá la descripción del proyecto.
- En Android, reemplazá `namespace` y `applicationId` en `android/app/build.gradle.kts` por el identificador único de la nueva aplicación. Revisá los paquetes Kotlin/Java si existen clases nativas.
- En iOS, cambiá `PRODUCT_BUNDLE_IDENTIFIER` para Runner en las configuraciones pertinentes de `ios/Runner.xcodeproj/project.pbxproj`. Revisá también el identificador de tests y la configuración de firma en Xcode.
- Revisá el nombre visible, esquemas, configuraciones de build, imports Dart basados en el nombre del paquete y metadatos de plataforma que correspondan.
- Conservá archivos de proyecto y ajustes nativos necesarios. No sustituyas directorios Android/iOS completos por valores genéricos.

## Configuración y secretos

- Ajustá la versión mínima de SDK, configuración de compilación, firma y entornos según los requisitos concretos de la aplicación.
- No guardes secretos, credenciales, claves privadas ni archivos `.env` con valores reales en Git. Usá el mecanismo de secretos del entorno de CI o de la plataforma correspondiente. Si se agrega configuración de ejemplo, debe contener sólo valores ficticios y estar claramente identificada como ejemplo.
- Configurá permisos nativos de cámara, fotos, ubicación u otras capacidades sólo cuando una funcionalidad real los necesite, junto con su justificación y experiencia de denegación.

## Assets

Agregá archivos reales bajo `assets/icons/navigation/`, `assets/fonts/` o `assets/images/` según corresponda. Declará en `pubspec.yaml` únicamente rutas existentes; retiralas al borrar el recurso. Verificá licencias y atribución antes de incorporar contenido de terceros. No agregues claves de servicios externos en assets.

## Temas y estilo visual

La plantilla incluye los temas Cosmo y Wanda. Para adaptar sus paletas o roles, modificá `lib/app/theme/app_theme.dart` y mantené los componentes compartidos libres de colores de marca; actualizá también las paletas documentadas en `ARCHITECTURE.md`. Si se incorpora una fuente local, configurá la propiedad central `AppTheme.fontFamily`, agregá el archivo real a `assets/fonts/` y declará el asset en `pubspec.yaml`; no cambies las pantallas para sustituir tipografía.

## Idiomas y traducciones

La plantilla admite español e inglés, sigue el idioma del dispositivo por defecto y utiliza inglés como fallback. Para cambiar el contenido traducible, actualizá `lib/l10n/app_en.arb` y `lib/l10n/app_es.arb` con claves semánticas estables y mantené ambas traducciones sincronizadas. Luego ejecutá `flutter gen-l10n`; `l10n.yaml` y `flutter: generate: true` configuran la salida. Los widgets consumen `AppLocalizations`, no literales traducibles. La preferencia manual o automática se administra mediante `LocaleController` y el almacenamiento común de `core/preferences/`. Consultá `ARCHITECTURE.md` antes de agregar un idioma o cambiar el fallback.

## Documentación y estructura

Actualizá `README.md` con los requisitos, instalación y ejecución específicos del nuevo proyecto. Revisá `ARCHITECTURE.md` para reflejar cualquier decisión de arquitectura que se aparte de la plantilla y actualizá `.github/copilot-instructions.md` si cambian las reglas de trabajo. `TEMPLATE.md` puede conservarse como guía o adaptarse a las necesidades del repositorio independiente.

Agregá módulos y capas al aparecer funcionalidades reales; evitá clases vacías o carpetas con contenido ficticio. Para más detalle sobre dependencias, límites de capas, estado, navegación y servicios, consultá `ARCHITECTURE.md`.
