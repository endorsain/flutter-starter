# flutter_starter

Plantilla base para iniciar aplicaciones Flutter reutilizables y escalables con una arquitectura Feature-First y Clean Architecture.

> Incluye los temas globales Cosmo y Wanda, localización español/inglés, navegación inicial y placeholders de features. La autenticación es una simulación local de desarrollo; no hay servidor, mapas reales ni captura de cámara.

## Requisitos

- Flutter estable compatible con la restricción de Dart `^3.13.7` declarada en `pubspec.yaml`.
- Android Studio o Android SDK con las herramientas de compilación requeridas por la versión instalada de Flutter.
- Para ejecutar en iOS: macOS, Xcode y las herramientas de línea de comandos de Apple.

## Instalación

```shell
flutter pub get
```

## Ejecutar en un dispositivo Android físico

1. Instalar y habilitar las Android SDK Platform-Tools.
2. Activar las opciones de desarrollador y la depuración USB en el dispositivo.
3. Conectar el dispositivo y aceptar el diálogo de autorización de depuración.
4. Confirmar que Flutter lo detecta:

   ```shell
   flutter devices
   ```

5. Ejecutar la aplicación, indicando el identificador mostrado por el comando anterior:

   ```shell
   flutter run -d <device-id>
   ```

En Windows puede ser necesario instalar el controlador USB del fabricante. Para ejecutar en un emulador, iniciarlo desde Android Studio y usar `flutter run`.

## Dependencias principales

- Estado: `flutter_riverpod`.
- Navegación: `go_router`.
- HTTP y servicios: `dio`.
- Preferencias locales: `shared_preferences`.
- Internacionalización: `flutter_localizations` del SDK e `intl`.
- Vectores: `flutter_svg`.
- Mapas y coordenadas: `flutter_map` y `latlong2`.
- Cámara, selección de imágenes y permisos: `camera`, `image_picker` y `permission_handler`.

Los plugins están disponibles, pero su uso requiere implementación explícita y, cuando corresponda, configuración nativa de permisos. Consultá [ARCHITECTURE.md](./ARCHITECTURE.md) antes de incorporar funcionalidades.

## Temas

Cosmo es el tema predeterminado; la selección de Cosmo/Wanda se restaura desde preferencias. El controlador Riverpod permite cambiarla sin reiniciar la aplicación. Los estilos globales y componentes compartidos se describen en [ARCHITECTURE.md](./ARCHITECTURE.md).

## Internacionalización

La base admite español e inglés. Por defecto sigue el idioma del dispositivo y usa inglés como fallback; una selección manual se puede cambiar en tiempo de ejecución mediante `LocaleController` y se persiste en preferencias. Los catálogos ARB y la configuración de generación están en `lib/l10n/` y `l10n.yaml`. Las traducciones propias se aplicarán inicialmente a las pantallas posteriores a la autenticación.

Después de modificar los catálogos, generá los recursos con:

```shell
flutter gen-l10n
```

Los widgets deben usar `AppLocalizations` y claves ARB descriptivas, no literales de interfaz traducibles. Consultá [ARCHITECTURE.md](./ARCHITECTURE.md) para el flujo y las convenciones.

## Navegación inicial

GoRouter organiza Login y Register y un `HomeShell` de cinco pestañas (Mapa, Perfil, Configuración, Cámara y Pruebas). La sesión simulada se concede localmente desde Login sólo en modo debug, sin conexión externa; no es autenticación real y debe sustituirse antes de publicar una aplicación. Configuración permite cambiar idioma y tema; los demás destinos son placeholders. Consultá [ARCHITECTURE.md](./ARCHITECTURE.md) para rutas, estructura y límites de autenticación.

## Comandos principales

```shell
flutter pub get
flutter run
flutter analyze
flutter build apk
```

Para instrucciones de creación de un proyecto independiente desde esta plantilla, consultá [TEMPLATE.md](./TEMPLATE.md).
