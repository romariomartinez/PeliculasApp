# 🎬 **Películas App** 

**Películas App** es una aplicación desarrollada con **Flutter** que te permite explorar, gestionar y disfrutar de tus películas favoritas. Gracias a la API de **The Movie Database (TMDb)**, podrás obtener una lista de películas populares, ver detalles de cada una, y añadirlas a tus favoritos. Además, la app soporta varios idiomas y un modo oscuro/ligero para mayor comodidad. 🌗

## Características 🌟

- **Explora películas populares**: Obtén la lista de películas más populares.
- **Detalles de cada película**: Accede a la sinopsis, género, calificación y duración.
- **Modo oscuro/ligero**: Cambia el tema de la aplicación según tus preferencias.
- **Favoritos**: Guarda tus películas favoritas y accede a ellas rápidamente.
- **Filtros por género**: Filtra las películas por género para encontrar lo que más te interesa.
- **Búsqueda**: Encuentra películas por título.
- **Reproducir tráiler**: Mira el tráiler de cada película directamente en YouTube.
- **Compartir**: Comparte tus películas favoritas con amigos.

---

##  **Decisiones Técnicas**

### Flutter como framework

- **Flutter** fue elegido por su capacidad para desarrollar aplicaciones nativas de alto rendimiento en Android e iOS con un solo código base, lo que mejora la eficiencia en desarrollo y mantenimiento.

### BLoC (Business Logic Component) para manejo de estado

- Se utiliza el patrón **BLoC** para manejar el estado de la aplicación, permitiendo un flujo de datos limpio y predecible, ideal para aplicaciones con datos complejos.

### API TMDB (The Movie Database)

- Usamos la **API TMDB** para obtener información sobre películas. Las solicitudes HTTP devuelven detalles relevantes como sinopsis, calificación y duración.

### Hive para almacenamiento local

- **Hive** es una base de datos ligera y rápida que se utiliza para almacenar las películas favoritas de los usuarios de manera persistente.

### Internacionalización (i18n)

- La aplicación está disponible en **español** e **inglés**, permitiendo cambiar de idioma según la preferencia del usuario. Implementado mediante **flutter_localizations**.

---

## ⚙️ **Instrucciones para Ejecutar el Proyecto**

### Requisitos Previos

- Tener instalado **Flutter** en tu máquina.
- Contar con un dispositivo Android o iOS configurado, o usar un emulador.

### Pasos para Ejecutar el Proyecto

1. **Clonar el repositorio**:
    ```bash
    git clone https://github.com/tu_usuario/peliculasapp.git
    ```

2. **Acceder al directorio del proyecto**:
    ```bash
    cd peliculasapp
    ```

3. **Instalar dependencias**:
    ```bash
    flutter pub get
    ```

4. **Ejecutar la aplicación**:
    - Asegúrate de que tu dispositivo o emulador esté funcionando y luego ejecuta:
    ```bash
    flutter run
    ```

5. **Generación de APK**:
    - Para generar el APK en modo release:
    ```bash
    flutter build apk --release
    ```
    - El archivo APK se encontrará en `build/app/outputs/flutter-apk/`.

---

## **Funcionalidades Implementadas**

- **Pantalla de Listado de Películas**: Muestra las películas populares con información básica como título, calificación y póster.
- **Detalles de la Película**: Al seleccionar una película, se muestra una pantalla con detalles como género, duración, tráiler (si disponible) y sinopsis.
- **Favoritos**: Los usuarios pueden añadir o eliminar películas de sus favoritos. Las películas se guardan localmente usando Hive.
- **Búsqueda de Películas**: Permite buscar películas por título.
- **Filtrado por Género**: Filtra películas usando **ChoiceChip**.
- **Internacionalización**: La app soporta español e inglés, y permite cambiar el idioma.
- **Modo Claro/Oscuro**: Cambia entre el modo claro y oscuro según lo prefieras.

---

##  **Funcionalidades Pendientes**

- **Paginación Infinita**: Implementar paginación para cargar más películas al hacer scroll hacia abajo.
- **Pruebas Unitarias y de Widget**: Mejorar la cobertura de pruebas para garantizar el correcto funcionamiento en todos los escenarios.


---

## **Contribuciones**

1. **Forkea el repositorio**.
2. **Crea una nueva rama** para trabajar en tus cambios:
    ```bash
    git checkout -b feature/nueva-funcionalidad
    ```
3. **Haz commit de tus cambios**:
    ```bash
    git commit -m "Agregado nueva funcionalidad"
    ```
4. **Haz push a tu rama**:
    ```bash
    git push origin feature/nueva-funcionalidad
    ```
5. **Crea un Pull Request** en GitHub para integrar tus cambios.

---

¡Gracias por contribuir y hacer que **Películas App** sea aún mejor! 🎬💥


