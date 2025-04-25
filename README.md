# Películas App 🎬

**Películas App** es una aplicación construida con **Flutter** que te permite explorar y gestionar tus películas favoritas. Utiliza la API de **The Movie Database (TMDb)** para obtener una lista de las películas más populares, ver detalles de cada una, y añadirlas a tus favoritos. Además, soporta varios idiomas (inglés y español) y tiene un modo oscuro/ligero para que la uses como más te guste. 🌗

## Características 🌟

- **Explora películas populares**: Obtén la lista de películas más populares.
- **Detalles de cada película**: Accede a la sinopsis, género, calificación y duración.
- **Modo oscuro/ligero**: Cambia el tema de la aplicación para ajustarlo a tus preferencias.
- **Favoritos**: Añade películas a tus favoritos y accede a ellas rápidamente.
- **Filtros por género**: Filtra las películas por género para encontrar lo que más te interesa.
- **Búsqueda**: Busca películas por su título.
- **Reproducir tráiler**: Mira el tráiler de cada película en YouTube.
- **Compartir**: Comparte tus películas favoritas con amigos.

## Requisitos

Antes de comenzar, asegúrate de tener los siguientes requisitos:

- **Flutter**: [Sigue la guía oficial de instalación](https://flutter.dev/docs/get-started/install) si aún no lo tienes.
- **Dependencias**:
  - `flutter_bloc`: Para la gestión del estado de la aplicación.
  - `hive`: Para almacenar las películas favoritas localmente.
  - `http`: Para consumir la API de TMDb.
  - `url_launcher`: Para abrir los tráileres de YouTube.
  - `share_plus`: Para compartir películas con amigos.
  - `flutter_localizations`: Para traducir la aplicación a diferentes idiomas.
  
Todas las dependencias están listadas en el archivo `pubspec.yaml`.

## Instalación 🚀

### 1. Clona el repositorio:

```bash
git clone https://github.com/tu-usuario/peliculas-app.git
2. Navega al directorio del proyecto:
bash
Copiar
cd peliculas-app
3. Instala las dependencias:
bash
Copiar
flutter pub get
4. Genera los archivos de localización:
bash
Copiar
flutter pub run build_runner build
Esto generará los archivos de localización para los idiomas configurados.

5. Ejecuta la aplicación:
bash
Copiar
flutter run
Esto debería lanzar la aplicación en tu emulador o dispositivo físico.

Estructura del Proyecto 📂
La estructura del proyecto está organizada de manera que puedas entender fácilmente cómo están distribuidas las responsabilidades:

bash
Copiar
lib/
├── core/
│   ├── theme_controller.dart    # Lógica para cambiar entre modo claro/oscuro
│   └── constants.dart          # Constantes globales
├── data/
│   ├── datasources/            # Fuentes de datos (API, almacenamiento local)
│   ├── models/                 # Modelos de datos
│   ├── repositories/           # Implementación del repositorio
├── domain/
│   ├── entities/               # Entidades (Movie, Genre)
│   ├── usecases/               # Casos de uso
│   └── repositories/           # Interfaces del repositorio
├── presentation/
│   ├── bloc/                   # Gestión del estado (MovieBloc)
│   ├── pages/                  # Páginas de la aplicación (MovieListPage, MovieDetailPage)
│   └── widgets/                # Widgets reutilizables
├── injection_container.dart    # Contenedor de dependencias (GetIt)
├── main.dart                   # Entrada principal de la aplicación
└── l10n/                       # Archivos de localización (español, inglés)

¿Cómo Contribuir? 🤝
¡Nos encantaría que contribuyas! Si tienes alguna mejora o corrección que te gustaría hacer, sigue estos pasos:

Haz un fork de este repositorio.

Crea una nueva rama (git checkout -b feature/nueva-caracteristica).

Realiza los cambios que desees.

Haz commit de tus cambios (git commit -am 'Añadir nueva característica').

Haz push a tu rama (git push origin feature/nueva-caracteristica).

Abre un Pull Request.


Recursos 🌍
API de TMDb: https://www.themoviedb.org/

Flutter: https://flutter.dev/

Bloc: https://bloclibrary.dev/



