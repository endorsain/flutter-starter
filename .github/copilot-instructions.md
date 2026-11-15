# Instrucciones de Copilot

## Antes de cambiar código

- Leé la documentación relevante y el código relacionado antes de modificarlo.
- Interpretá las solicitudes breves usando estas instrucciones persistentes; no exijas que se repitan las convenciones en cada solicitud.
- Mantené el repositorio genérico y reutilizable. No incorpores identidad, configuración, dependencias o lógica específica de un producto sin un requisito explícito.

## Arquitectura y código

- Respetá Feature-First y Clean Architecture según `ARCHITECTURE.md`, con límites claros entre Domain, Application, Infrastructure y Presentation.
- Mantené los nombres de archivos, clases, funciones, variables, rutas y APIs en inglés.
- Escribí comentarios técnicos y documentación en español, salvo textos que requieran otro idioma.
- No agregues abstracciones, dependencias ni código innecesario. No crees clases, interfaces o implementaciones vacías para completar carpetas.
- Conservá la configuración nativa necesaria de Android e iOS. Incorporá permisos de plataforma sólo cuando un flujo real los requiera.
- Centralizá los temas y roles visuales en `lib/app/theme/`; respetá las paletas Cosmo/Wanda de `ARCHITECTURE.md` y no definas colores de marca directamente en pantallas o componentes compartidos.
- Usá `AppLocalizations` y claves ARB descriptivas para todo texto de interfaz traducible; mantené sincronizados los catálogos admitidos y no agregues literales traducibles en widgets.
- No incluyas secretos, credenciales ni archivos de entorno privados en Git.

## Calidad y verificación

- No crees ni ejecutes tests salvo solicitud explícita.
- No ejecutes verificaciones costosas automáticamente; solicitá autorización cuando sean necesarias.
- Si una comprobación pequeña y necesaria puede detectar un error directo de los cambios, explicá su alcance y mantenela acotada.
- No ocultes errores con capturas amplias, defaults silenciosos o respuestas que aparenten éxito.

## Documentación

- Mantené la documentación consistente con el código y la configuración reales.
- Cuando un cambio afecte arquitectura, uso, personalización o convenciones, actualizá `ARCHITECTURE.md`, `README.md`, `TEMPLATE.md` y estas instrucciones de Copilot según corresponda.
- No documentes pantallas, recursos, rutas, permisos ni configuraciones que no existan.

## Git y comunicación

- Usá Conventional Commits con descripciones en español cuando se solicite crear un commit.
- No realices commits automáticamente.
- No ejecutes operaciones Git rutinarias o destructivas sin necesidad y autorización explícitas.
- Explicá brevemente los cambios y las verificaciones realizadas, sin afirmar que se ejecutaron acciones que no se hicieron.
