
#CREATE DATABASE Plataforma_streaming; 
USE Plataforma_streaming;

DROP TABLE IF EXISTS Formulario;
DROP TABLE IF EXISTS Historial;
DROP TABLE IF EXISTS Perfiles;
DROP TABLE IF EXISTS Contenido_Artistas;
DROP TABLE IF EXISTS Contenido;
DROP TABLE IF EXISTS Categorias;
DROP TABLE IF EXISTS Capitulos;
DROP TABLE IF EXISTS Artistas;
DROP TABLE IF EXISTS Usuarios;
DROP TABLE IF EXISTS Peliculas;

-- Tabla Usuarios
CREATE TABLE Usuarios (
    usuario_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre varchar(150) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    contraseña VARCHAR(255) NOT NULL
);

-- Tabla Intentos de Autenticación
CREATE TABLE Formulario (
    intento_id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT,
    exitoso BOOLEAN NOT NULL,
    fecha_hora DATETIME,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id)
);

-- Tabla Perfiles
CREATE TABLE Perfiles (
    perfil_id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT,
    tipo_perfil ENUM('normal', 'infantil') NOT NULL,
    nombre varchar(150) NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id)
);

-- Tabla categoria
CREATE TABLE Categorias(
	categoria_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre VARCHAR(255)
);

-- Tabla Contenido
CREATE TABLE Contenido (
    contenido_id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(255) NOT NULL,
    tipo ENUM('pelicula', 'serie') NOT NULL,
    puntuacion DECIMAL(2, 1),
    categoria_id INT,
    apto_kids BOOL,
    fecha_publicacion DATE,
    FOREIGN KEY (categoria_id) REFERENCES Categorias(categoria_id)
);

-- Tabla Progreso de Contenido
CREATE TABLE Historial (
    perfil_id INT,
    contenido_id INT,
    capitulo_actual INT,
    fecha_visto DATE,
    valoracion INT CHECK (valoracion BETWEEN 1 AND 5),
    PRIMARY KEY (perfil_id, contenido_id),
    FOREIGN KEY (perfil_id) REFERENCES Perfiles(perfil_id),
    FOREIGN KEY (contenido_id) REFERENCES Contenido(contenido_id)
);

-- Tabla Capítulos (solo para contenido de tipo serie)
CREATE TABLE Capitulos (
    capitulo_id INT PRIMARY KEY AUTO_INCREMENT,
    contenido_id INT,
    temporada_id INT NOT NULL,
    numero_capitulo INT NOT NULL
);

-- Tabla Artistas
CREATE TABLE Artistas (
    artista_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    rol ENUM('actor', 'director', 'productor') NOT NULL,
    personaje VARCHAR(255) NULL
);

-- Tabla de relación entre Artistas y Contenido
CREATE TABLE Contenido_Artistas (
    contenido_id INT,
    artista_id INT,
    rol varchar(255),
    nom_ficticio varchar(255),
    FOREIGN KEY (contenido_id) REFERENCES Contenido(contenido_id),
    FOREIGN KEY (artista_id) REFERENCES Artistas(artista_id),
    PRIMARY KEY (contenido_id, artista_id)
);

-- Tabla Peliculas
create table Peliculas(
	contenido_id INT not null,
	primary key (contenido_id),
	FOREIGN KEY (contenido_id) REFERENCES Contenido(contenido_id)
);

-- Tabla Series
create table Series(
	contenido_id int not null,
	primary key (contenido_id),
	FOREIGN KEY (contenido_id) REFERENCES Contenido(contenido_id)
);







