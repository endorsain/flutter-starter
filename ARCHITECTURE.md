# Arquitectura

## Propósito y estado actual

`flutter_starter` es una base genérica para aplicaciones Flutter que puedan crecer sin acoplar la lógica del producto a widgets, plugins o proveedores externos. La organización objetivo combina Feature-First con Clean Architecture.

La base incluye el sistema global de temas Cosmo y Wanda, la internacionalización español/inglés, una capa compartida de preferencias, la navegación con GoRouter y las pantallas iniciales. Los destinos Mapa, Perfil, Cámara y Pruebas son placeholders; no contienen integraciones funcionales.

## Estructura objetivo

```text
lib/
  main.dart
  app/
    bootstrap/
    localization/
      locale_controller.dart
    navigation/
      app_router.dart
      app_routes.dart
    providers/
    theme/
      app_theme.dart
      theme_controller.dart
  core/
    config/
    errors/
    network/
    preferences/
      preferences_store.dart
      shared_preferences_store.dart
    utils/
  shared/
    widgets/
      navigation_icon.dart
    models/
  features/
    auth/
      domain/
        auth_repository.dart
      application/
        auth_controller.dart
      infrastructure/
        auth_repository_provider.dart
        development_auth_repository.dart
      presentation/
        login_page.dart
        register_page.dart
    home/
      domain/
      application/
      infrastructure/
      presentation/
        home_shell.dart
    map/
      domain/
      application/
      infrastructure/
      presentation/
        map_page.dart
    users/
      domain/
      application/
      infrastructure/
      presentation/
        profile_page.dart
    settings/
      domain/
      application/
      infrastructure/
      presentation/
        settings_page.dart
    camera/
      domain/
      application/
      infrastructure/
      presentation/
        camera_page.dart
    playground/
      domain/
      application/
      infrastructure/
      presentation/
        playground_page.dart
  l10n/
    app_en.arb
    app_es.arb
    generated/
      app_localizations.dart
assets/
  fonts/
  icons/
    navigation/
  images/
```

Las carpetas de cada capa se crean cuando haya contenido real para ellas; no se agregan clases, contratos o implementaciones vacías para completar el árbol. `playground` es un área optativa de exploración y no debe convertirse en dependencia de funcionalidades de producto.

## Módulos y capas

Cada feature contiene su propia lógica y depende de otros módulos sólo a través de contratos explícitos y estables.

- **Domain:** entidades, objetos de valor, reglas de negocio y contratos de repositorio. Debe permanecer independiente de Flutter, Riverpod, Dio y los plugins de plataforma.
- **Application:** casos de uso y coordinación de flujos de la feature. Aquí se ubica el estado de Riverpod que representa operaciones y datos de esa feature.
- **Infrastructure:** implementaciones de contratos, fuentes de datos, clientes/adaptadores externos y conversión entre modelos externos y dominio.
- **Presentation:** páginas, widgets y componentes específicos de la feature; consume la capa Application y no accede directamente a fuentes de datos.

La dirección de dependencias es `Presentation -> Application -> Domain`. `Infrastructure` implementa contratos de Domain y se conecta en el composition root de `app/`. Domain no importa capas externas. Evitá dependencias entre features; si un elemento es genuinamente transversal y estable, evaluá `shared/` en vez de compartirlo por conveniencia.

## Composición y estado

`app/` será el punto de composición de la aplicación: inicialización, proveedores compartidos, configuración y conexión de implementaciones. No se convierte en un contenedor de lógica de negocio.

`flutter_riverpod` es la herramienta prevista para inyección de dependencias y estado. Mantené el estado cerca de la feature que lo posee; reservá proveedores globales para servicios y configuración realmente compartidos. Representá explícitamente carga, éxito y error, y evita duplicar estado derivable.

## Navegación

`go_router` administra el enrutamiento declarativo desde `lib/app/navigation/`. `app_router.dart` compone el router y sus reglas de acceso; `app_routes.dart` centraliza nombres y paths para que las pantallas naveguen por identificadores estables y no repitan literales. `MaterialApp.router` obtiene allí su configuración. El router crea destinos de Presentation, pero no ejecuta casos de uso ni contiene lógica de autenticación o de producto.

### Destinos y propiedad de pantallas

- `features/auth/presentation/login_page.dart`: inicio de sesión.
- `features/auth/presentation/register_page.dart`: registro.
- `features/home/presentation/home_shell.dart`: contenedor persistente de las pestañas principales.
- `features/map/presentation/map_page.dart`: pestaña Mapa.
- `features/users/presentation/profile_page.dart`: pestaña Perfil.
- `features/settings/presentation/settings_page.dart`: pestaña Configuración.
- `features/camera/presentation/camera_page.dart`: pestaña Cámara.
- `features/playground/presentation/playground_page.dart`: pestaña Pruebas.

Cada pantalla pertenece al módulo funcional que representa; el shell y la composición visual común pertenecen a `home`. Login y Register están implementadas; el resto son destinos iniciales, con Configuración conectada a los controladores existentes. La navegación entre módulos se expresa mediante rutas públicas, evitando que una feature importe widgets internos de otra. Los nombres centralizados son `login`, `register`, `map`, `profile`, `settings`, `camera` y `playground`; los paths se definen en `AppRoutes`.

### Shell y estado de navegación

`HomeShell` se construye con `StatefulShellRoute.indexedStack` y cinco ramas en este orden fijo: Mapa, Perfil, Configuración, Cámara y Pruebas. Cada rama tiene su propio `Navigator` y clave, conserva el estado de su página y su historial al cambiar de pestaña. La barra de navegación cambia la rama activa sin reinicializar las otras. Los destinos se rotulan mediante `AppLocalizations` y usan los temas activos, sin colores de marca definidos en las páginas.

`shared/widgets/navigation_icon.dart` es el componente reutilizable para los iconos de navegación. Encapsula los estados seleccionado/no seleccionado y el recurso visual; mientras no estén disponibles los SVG definitivos de `assets/icons/navigation/`, utiliza Material Icons como fallback. La sustitución por SVG no debe requerir cambios en las ramas ni en las pantallas.

### Autenticación, sesión y flujo

La autenticación permanece separada del router. Login envía una acción a `AuthController` en Application; el contrato `AuthRepository` de Domain representa consulta, inicio y cierre de sesión. El proveedor de composición conecta `DevelopmentAuthRepository`, una sesión en memoria que concede acceso al enviar Login y no se comunica con ningún servidor ni valida credenciales reales. Esta implementación es exclusivamente una simulación local de desarrollo y debe sustituirse antes de usar la plantilla en una aplicación con autenticación real. Register es una pantalla informativa y no crea cuentas ni concede acceso.

El estado de sesión lo administra `AuthController`, no el router ni los widgets de navegación. El router observa ese estado para resolver redirecciones de acceso: sin sesión, un destino protegido conduce a Login; con sesión, Login/Register conducen a `HomeShell`; tras Login exitoso, la sesión simulada provoca el acceso a `HomeShell`. Cerrar sesión invalida el estado por medio de `AuthController` y devuelve al flujo público. Las redirecciones sólo traducen el estado de sesión a destinos; no crean sesiones ni contienen reglas de negocio.

La sesión simulada queda detrás de `AuthRepository` y `authRepositoryProvider`. Para adoptar autenticación real se reemplaza la implementación simulada por una implementación conectada al proveedor real, conservando el contrato consumido por Application y la interfaz observada por el router. Así, rutas, shell y pantallas no dependen de detalles del mecanismo de autenticación.

Todas las pantallas usan `Theme.of(context)` y los estilos globales Cosmo/Wanda, además de `AppLocalizations` para los textos de interfaz. Los destinos iniciales y Login/Register ya usan las localizaciones generadas; las futuras pantallas pueden ampliar los mismos catálogos sin reestructurar navegación ni features.

## Internacionalización

La aplicación admite español (`es`) e inglés (`en`). La selección inicial es automática: mientras no haya una preferencia manual, Flutter usa la configuración regional del dispositivo y debe responder a cambios de idioma del sistema sin requerir reiniciar la aplicación. Si el idioma del sistema no es compatible, la resolución de locales debe seleccionar inglés como fallback. Una selección manual de español o inglés tiene prioridad sobre el dispositivo, se persiste y puede cambiarse desde Configuración; Configuración debe permitir volver al modo automático.

`lib/l10n/` contiene `app_en.arb` y `app_es.arb` y los recursos generados por Flutter en `lib/l10n/generated/`. `l10n.yaml` declara el ARB inglés como plantilla, la carpeta de salida y la clase `AppLocalizations`; `flutter: generate: true` activa la generación. `flutter_localizations` provee los delegates y formatos del SDK, e `intl` ofrece formato y pluralización. `MaterialApp` registra los delegates y `AppLocalizations.supportedLocales` generados.

Los textos traducibles de la interfaz se obtienen del recurso localizado generado, nunca de literales repartidos por widgets. Las claves ARB deben describir el significado y contexto del texto, permanecer estables y evitar nombres dependientes de una pantalla o idioma cuando no sean necesarios. Los catálogos incluyen las cadenas de navegación y de las pantallas iniciales Login/Register; deben ampliarse con los textos de las funcionalidades posteriores a la autenticación. La autenticación real y sus flujos completos todavía no están implementados.

`LocaleController` en `lib/app/localization/locale_controller.dart` administra `LocalePreference` mediante Riverpod. El estado admite `system` (sin override) y selecciones manuales `english`/`spanish`. `MaterialApp.locale` queda nulo en modo sistema; el callback de resolución recorre las preferencias regionales del dispositivo, acepta coincidencias por idioma y devuelve inglés si ninguna coincide. Así Flutter continúa observando cambios de idioma del sistema en modo automático. En modo manual, el locale seleccionado se aplica a `MaterialApp`; cambiarlo actualiza la interfaz en ejecución.

La lectura y escritura de preferencias se abstraen en `lib/core/preferences/`: `PreferencesStore` declara las operaciones y `SharedPreferencesStore` las implementa sobre `shared_preferences`. `preferencesStoreProvider`, en `app/providers/`, crea una única instancia compartida. `LocaleController` y `ThemeController` dependen de la abstracción, no del plugin directamente. Cada selección usa su propia clave: `app_locale_preference` guarda `system`, `english` o `spanish`; `app_theme_id` guarda la identidad visual. Si no existe preferencia de idioma, se usa automático. Los errores de lectura/escritura se propagan y no se convierten en éxitos silenciosos. No se guardan credenciales en este mecanismo.

Flujo de datos: `LocaleController` lee la preferencia mediante `PreferencesStore` y publica `LocalePreference`. `MaterialApp` observa ese estado y usa un locale explícito si es manual o nulo si es automático. Flutter elige entre inglés y español mediante el callback de resolución en el inicio y al cambiar los locales del sistema; los delegates consultan los recursos generados desde ARB, mientras `intl` proporciona formato localizado. Una acción de Configuración puede invocar `ref.read(localeControllerProvider.notifier).setPreference(LocalePreference.spanish)` (o `english`/`system`); el controlador persiste el cambio y Riverpod actualiza `MaterialApp` sin reinicio. No se implementa todavía la pantalla de Configuración.

Las traducciones propias de la aplicación se destinan inicialmente a pantallas posteriores a la autenticación. La autenticación aún no es parte del alcance; sus futuras cadenas pueden incorporarse a los mismos catálogos y claves estables sin reorganizar el proyecto.

## Sistema de temas

El sistema vive en `lib/app/theme/`. `AppThemeId` distingue las identidades visuales `cosmo` y `wanda`; son paletas completas y no representan `ThemeMode.light` y `ThemeMode.dark`. `AppTheme.fromId` crea un `ThemeData` por identidad y `MaterialApp` aplica globalmente el tema activo. El fondo de `Scaffold` es el rol `ColorScheme.primary`.

### Paletas acordadas

| Rol visual | Cosmo | Wanda |
|---|---|---|
| Primary y fondo de pantalla | `#A3D99B` | `#D99BD8` |
| Secondary, AppBar, NavigationBar y contenedor de formulario | `#669060` | `#AE57AC` |
| Botón en estado normal (`tertiary`) | `#7ABD70` | `#883387` |
| Texto normal de botón (`onTertiary`) | `#FFFFFF` | `#FFFFFF` |
| Iconos y etiquetas de navegación | `#A3D99B` | `#D99BD8` |
| Fondo de input | `#A3D99B` | `#D99BD8` |
| Texto de input | `#FFFFFF` | `#FFFFFF` |
| Botón presionado (`primary`) | `#A3D99B` | `#D99BD8` |
| Texto de botón presionado (`onPrimary`) | `#000000` | `#000000` |

Los valores específicos de identidad se definen en `AppTheme`; widgets y features deben consumir `Theme.of(context)` y no ramificarse por Cosmo o Wanda.

### Roles y valores derivados

Los roles generales aprovechan `ColorScheme`: `primary` es el fondo global y el fondo de input, `secondary` es el fondo de AppBar, NavigationBar y formulario, `tertiary` y `onTertiary` son el fondo y texto del botón normal. `onSecondary` es blanco para el contenido sobre superficies secundarias; `onPrimary` es negro para el texto de botón presionado. La navegación usa `primary` en ambos estados, y su indicador usa `tertiary`.

`AppThemeColors`, extensión tipada en `app_theme.dart`, aporta `inputForeground`, blanco en ambas paletas, porque un único rol `on*` de Material no representa el texto blanco sobre el fondo `primary` de input sin alterar otros componentes. No se duplican en la extensión los roles que ya corresponden a `ColorScheme`.

Los roles Material no especificados se derivan de `ColorScheme.fromSeed` con el `primary` de cada paleta. `surface` es un neutro levemente tintado (`#F7FAF6` Cosmo, `#FCF6FC` Wanda), `onSurface` es `#252225`, `error` es `#B3261E`, `onError` es blanco y `outline` usa `secondary`. Los controles deshabilitados usan `onSurface` con opacidad Material; el input deshabilitado usa `surfaceContainerHighest`. Estos valores son comunes salvo el `surface` tintado por tema.

### Estado y persistencia

`ThemeController` (`AsyncNotifier<AppThemeId>`) administra la selección con Riverpod. `sharedPreferencesProvider` obtiene `SharedPreferences`; la clave `app_theme_id` guarda el nombre del enum. Si no hay valor guardado, se inicia Cosmo. Al iniciar, `MaterialApp` muestra Cosmo mientras se restaura la preferencia y aplica el tema persistido en cuanto Riverpod entrega el estado. Un valor almacenado inválido o un fallo de lectura se muestra como error y no se sustituye silenciosamente. `setTheme(AppThemeId)` guarda la preferencia y actualiza el estado sin reiniciar la aplicación; los fallos de escritura se propagan.

Una futura pantalla puede cambiar la selección mediante `ref.read(themeControllerProvider.notifier).setTheme(AppThemeId.wanda)`; esta plantilla aún no implementa esa pantalla. El `ThemeData` activo se configura con la propiedad `theme` de `MaterialApp`; no se usa `ThemeMode` para seleccionar Cosmo o Wanda.

### Estilos y componentes compartidos

`AppTheme` configura `ThemeData`, `ColorScheme`, `TextTheme`, `AppBarTheme`, `NavigationBarThemeData`, `InputDecorationTheme` y `FilledButtonThemeData`. Los dos temas usan idéntica tipografía `Typography.material2021().black` y una propiedad central `fontFamily` actualmente nula; puede asignarse una fuente local futura sin cambiar pantallas ni referencias a archivos inexistentes.

- `AppButton` usa `FilledButtonThemeData`: normal usa `tertiary`/`onTertiary`, presionado cambia a `primary`/`onPrimary`, y deshabilitado usa los roles de estado deshabilitado. Los estados se resuelven con `WidgetStateProperty`, no con estado local de cada botón.
- `AppTextField` usa el fondo `primary`, texto blanco de `AppThemeColors`, cursor y bordes definidos por el tema, placeholder y etiqueta centralizados, y conserva estilos de error y deshabilitado.
- `AppFormContainer` usa `secondary` y radios redondeados. `AppThemeDimensions` centraliza padding de formulario (24), separación (16), radio de controles (16), alto de botón (52) y paddings de controles.

Los componentes compartidos se encuentran en `lib/shared/widgets/` y no conocen las identidades Cosmo/Wanda. No se asignan colores de marca directamente desde pantallas o componentes. `shared/` contiene widgets o modelos de presentación reutilizables entre features, no un lugar genérico para lógica de negocio.

Los recursos se organizan en `assets/icons/navigation/`, `assets/fonts/` y `assets/images/`. Declará en `pubspec.yaml` sólo recursos existentes y efectivamente utilizados; no se incluyen imágenes, fuentes ni iconos ficticios. `flutter_svg` queda disponible para SVG reales.

## Servicios externos y persistencia

- `dio`: transporte HTTP y configuración transversal en `core/network/`; las APIs concretas y su interpretación pertenecen a Infrastructure de la feature correspondiente.
- `shared_preferences`: almacenamiento simple de preferencias no sensibles; no usarlo como base de datos ni para credenciales.
- `flutter_map` y `latlong2`: presentación cartográfica y tipos de coordenadas. La selección de proveedor de teselas, atribución, límites de uso y claves se debe resolver antes de integrar un mapa.
- `camera`, `image_picker` y `permission_handler`: acceso a capacidades del dispositivo desde adaptadores de Infrastructure. Solicitar permisos en contexto, manejar denegación/revocación y añadir sólo las descripciones y permisos nativos requeridos por el flujo real.

No hay endpoints, proveedores de teselas, credenciales ni permisos funcionales configurados en esta base.

## Convenciones técnicas

- Archivos, clases, funciones, variables, rutas y APIs en inglés; usar `snake_case.dart` para archivos Dart y `UpperCamelCase` para tipos.
- Comentarios técnicos y documentación en español, salvo contenido que requiera otro idioma.
- Preferir tipos explícitos, APIs pequeñas y errores modelados; no ocultar fallos con valores por defecto.
- Mantener dependencias y abstracciones al mínimo; cada dependencia debe tener un consumidor real.
- Mantener la documentación alineada con el código y la configuración existentes.
