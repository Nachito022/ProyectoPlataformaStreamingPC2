# Plataforma de streaming para peliculas y series en Python y MySQL

El presente proyecto consiste en el diseño e implementación de una base de datos para una plataforma de streaming de 
contenido audiovisual, en la materia Principio de Computadoras II. La estructura de la base de datos se organiza en varias 
tablas relacionadas, optimizando la gestión de usuarios, contenido, y su interacción. A continuación, se describen 
brevemente las principales tablas:

Usuarios: Almacena la información básica de los usuarios registrados, como nombre, correo electrónico y contraseña.
Formulario: Registra los intentos de autenticación realizados por los usuarios, indicando si fueron exitosos.
Perfiles: Permite a los usuarios crear perfiles personalizados, diferenciando entre perfiles estándar y perfiles para niños.
Categorías: Clasifica el contenido en diferentes géneros o temas.
Sagas: Agrupa contenido relacionado bajo una misma saga o franquicia.
Contenido: Contiene información de películas y series, incluyendo título, puntuación, categoría, aptitud para niños y fecha de publicación.
Historial: Lleva el progreso de visualización de los perfiles sobre el contenido, registrando capítulos, temporadas, tiempo visualizado y valoraciones.
Artistas y Contenido_Artistas: Gestionan información sobre los artistas involucrados en el contenido y su relación con el mismo, incluyendo roles y nombres ficticios.
Películas y Series: Diferencian el contenido según su tipo, con detalles adicionales como duración en el caso de las películas.
Temporada y Capítulos: Estructuran el contenido de tipo serie, permitiendo registrar temporadas y capítulos con sus respectivas duraciones.
Este esquema asegura la integridad de los datos mediante claves primarias y foráneas, permitiendo una interacción eficiente entre las tablas y ofreciendo una solución robusta para la gestión de datos en la plataforma.


