# Datos importante:

El programa funciona mediante la ejecución del archivo "interfase.py". Para la configuración de la base de datos, se debe introducir los datos correspondientes 
en el archivo "ConfigDatabase.py" en la carpeta de utils (utils/ConfigDatabase.py). Allí se encuentra una función en la cual deben estar introducidos los datos 
correspondientes. EL programa cuenta con un usuario por defecto utilizado como prueba, llamado "Test". En caso que si quisiera ingresar con otro ususario, se ingresa con los datos correspondientes.

# Requerimientos:
Se deben tener las siguientes librerías instaladas:
- **datetime**: pip install DateTime
- **mysql.connector**: pip install mysql-connector-python
- **tkinter**: pip install tk

# Plataforma de streaming para peliculas y series en Python y MySQL

El presente proyecto consiste en el diseño e implementación de una base de datos para una plataforma de streaming de 
contenido audiovisual, en la materia Principio de Computadoras II. La estructura de la base de datos se organiza en varias 
tablas relacionadas, optimizando la gestión de usuarios, contenido, y su interacción. A continuación, se describen 
brevemente las principales tablas:

- **Usuarios**: Almacena la información básica de los usuarios registrados, como nombre, correo electrónico y contraseña.
- **Formulario**: Registra los intentos de autenticación realizados por los usuarios, indicando si fueron exitosos.
- **Perfiles**: Permite a los usuarios crear perfiles personalizados, diferenciando entre perfiles estándar y perfiles para niños.
- **Categorías**: Clasifica el contenido en diferentes géneros o temas.
- **Sagas**: Agrupa contenido relacionado bajo una misma saga o franquicia.
- **Contenido**: Contiene información de películas y series, incluyendo título, puntuación, categoría, aptitud para niños y fecha de publicación.
- **Historial**: Lleva el progreso de visualización de los perfiles sobre el contenido, registrando capítulos, temporadas, tiempo visualizado y valoraciones.
- **Artistas**: Almacena los artistas y sus datos relevantes.
- **Contenido_Artistas**: Gestionan información sobre los artistas involucrados en el contenido y su relación con el mismo, incluyendo roles y nombres ficticios.
- **Películas y Series**: Diferencian el contenido según su tipo, con detalles adicionales como duración en el caso de las películas.
- **Temporada**: Esta tabla contiene las temporadas de una serie
- **Capítulos**: Registran capítulos con los datos correspondientes.
Este esquema asegura la integridad de los datos mediante claves primarias y foráneas, permitiendo una interacción eficiente entre las tablas y ofreciendo una solución robusta para la gestión de datos en la plataforma. La base de datos adjunta tiene la cantidad de información necesaria para hacer funcionar el programa, con diversos perfiles con historiales asociados. 

# Desarrollo 
La fase inicial del proyecto se centró en el análisis detallado de los requisitos, seguido por la elaboración de un diagrama entidad-relación que sirve como guía fundamental para la implementación de la base de datos en SQL.

También se adjunta un pseudo diagrama que realiza DBeaver donde se pueden ver las tablas adjuntas a cada entidad o relación:

Nos centramos en la creación de un sistema robusto que permitiera la gestión eficiente de los datos y contenidos.
Se utilizó SQL para diseñar una base de datos relacional que proporciona una estructura organizada para el almacenamiento de información. Esta base de datos fue elaborada con tablas específicas para cada tipo de dato, asegurando coherencia y facilitando la realización de consultas complejas.

Posteriormente, se desarrolló un programa en Python para interactuar con la base de datos. El programa ofrece un conjunto de funciones que permiten realizar consultas detalladas(las pedidas por la cátedra). La integración de la programación en Python con la base de datos SQL proporciona una herramienta ágil y potente para el análisis continuo.

En este proceso de desarrollo, se prestó especial atención a la modularidad y la escalabilidad del código, permitiendo futuras expansiones del proyecto con facilidad.

![EntidadRelacion](IMG/EntidadRelacion.png)
![Diagrama DBeaver](IMG/plataforma_streaming.png)

# Estructura del Sistema
### 1. Conficuración inicial

El sistema comienza con la inicialización de la clase `Interfase`, que organiza las funcionalidades en cuatro áreas principales:
 
 - **Inicio de sesión (Login)**: Solicita nombre de usuario y contraseña.
 - **Plataforma principal**: Acceso a las secciones de contenido, como novedades y búsqueda.
 - **Registro de nuevos usuarios**: Permite crear cuentas y perfiles.
 - **Selección de perfiles**: Ofrece al usuario la opción de elegir entre diferentes perfiles.

Se utiliza un notebook de `ttk` para administrar las pestañas, facilitando la navegación entre las distintas funcionalidades.
#
### 2. Funcionalidades Principales
### 2.1. Inicio de Sesión

El sistema solicita al usuario ingresar su nombre de usuario y contraseña:

- **Validación de datos**: Se llama al método `check_username_and_password `, que verifica las credenciales ingresadas contra los registros almacenados.
- **Retroalimentación al usuario**:
  - Mensajes de error en caso de credenciales incorrectas.
  - Acceso a la selección de perfiles si los datos son válidos.

![pagina contraseña](IMG/pagina_contraseña.png)

### 2.2. Registro de Nuevos Usuarios

Los usuarios pueden registrarse a travéz de la pestaña de registro haciendo click en <ins> options </ins> - <ins> Registrarte</ins>:

- **Campos requeridos**: Nombre/s de usuario/s, correo electrónico, contraseña y hasta seis perfiles.
- **Opciones avanzadas**: Cada perfil puede configurarse como "Kids" mediante un checkbox.
- **Validación**: El método `interfase_create_new_user` asegura que los datos sean completos y únicos antes de agregarlos al sistema.

![pagina_nuevo_usuario](IMG/pagina_nuevo_usuario.png)

### 2.3. Selección de Perfiles
Después del inicio de sesión exitoso, el usuario elige un perfil para personalizar su experiencia:
- Cada perfil aparece como un botón, generado dinámicamente según los datos del usuario.
- Se navega a la interfaz principal al seleccionar un perfil.

![pagina_elegir_perfil](IMG/pagina_elegir_perfil.png)

### 2.4. Visualización de Contenido 
La pestaña principal incluye secciones como:
- **Novedades**: Muestra contenido destacado.
- **Continuar viendo**: Permite al usuario retomar contenido previamente iniciado.
- **Búsqueda**: Los usuarios pueden buscar contenido específico.

![pagina_principal_sin_busqueda](IMG/pagina_principal_con_pelicula.jpeg)
![pagina_principal_con_busqueda](IMG/pagina_principal_con_serie.jpeg)

#
### 3. Diseño de la Interfaz Gráfica
La interfaz utiliza las siguientes herramientas de `tkinter` y `ttk`:
- **Widgets utilizados:**
  - `Label`, `Entry`, `Button`, `Checkbutton` para elementos interactivos.
  -  `Notebook` para organizar las pestañas.
- **Estilo y diseño:**
  - Se aplican márgenes y alineaciones para asegurar una disposición visual coherente.
  - Contraseñas protegidas mediante el uso de un carácter oculto (`*`).

#
### 4. Interactividad y Navegación
- **Navegación dinámica:** Métodos como `set_mainframe_notebook_general` y `set_mainframe_notebook_newuser` permiten cambiar entre pestañas de forma fluida.
- **Validaciones y retroalimentación:** Mensajes visuales (`Label`) indican errores o éxitos, mejorando la experiencia del usuario.

# Pasos para una correcta ejecución
## Ejecutar archivo SQL
En la carpeta contenedora del proyecto existe el archivo "Plataforma_streaming DB" el cual cuenta con el código para generar la base de datos y todas las tablas además de una cantidad minima de datos para la ejecucion y la prueba del programa. Es importante aclarar que se debe respetar el orden de ejecución de este archivo para un correcto funcionamiento.

## Ejecutar programa en Python
Por ultimo ejecutar el archivo "interfase.py". Para la configuración de la base de datos, se debe introducir los datos correspondientes 
en el archivo "ConfigDatabase.py" en la carpeta de utils (utils/ConfigDatabase.py). Allí se encuentra una función en la cual deben estar introducidos los datos 
correspondientes.







