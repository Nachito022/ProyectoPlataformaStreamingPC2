
#CREATE DATABASE Plataforma_streaming; 
USE Plataforma_streaming;

DROP TABLE IF EXISTS Formulario;
DROP TABLE IF EXISTS Historial;
DROP TABLE IF EXISTS Perfiles;
DROP TABLE IF EXISTS Contenido_Artistas;
DROP TABLE IF EXISTS Peliculas;
DROP TABLE IF EXISTS Capitulos;
DROP TABLE IF EXISTS Temporada;
DROP TABLE IF EXISTS Series;
DROP TABLE IF EXISTS Contenido;
DROP TABLE IF EXISTS Categorias;
DROP TABLE IF EXISTS Artistas;
DROP TABLE IF EXISTS Usuarios;




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
    usuario_id INT not null,
    exitoso BOOLEAN NOT NULL,
    fecha_hora datetime not null,
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


-- Tabla Artistas
CREATE TABLE Artistas (
    artista_id INT  not null AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    PRIMARY KEY (artista_id)
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
create table Peliculas (
	contenido_id INT not null,
	duracion TIME not null,
	primary key (contenido_id),
	FOREIGN KEY (contenido_id) REFERENCES Contenido(contenido_id)
);

-- Tabla Series
create table Series (
	contenido_id int not null,
	primary key (contenido_id),
	FOREIGN KEY (contenido_id) REFERENCES Contenido(contenido_id)
);

-- Tabla Temporada
create table Temporada (
	contenido_id int not null,
	temporada_id int not null,
	primary key (contenido_id,temporada_id),
	FOREIGN KEY (contenido_id) REFERENCES Series(contenido_id)
);


-- Tabla Capítulos (solo para contenido de tipo serie)
CREATE TABLE Capitulos (
    capitulo_id INT PRIMARY KEY AUTO_INCREMENT,
    contenido_id INT NOT NULL,
    temporada_id INT NOT NULL,
    numero_capitulo INT NOT null,
    FOREIGN KEY (contenido_id,temporada_id) REFERENCES Temporada(contenido_id,temporada_id)
);

insert into Usuarios(usuario_id, nombre,email,contraseña)
VALUES(1, 'Nacho', 'nachoferre22@gmail.com', "123");

insert into Usuarios(usuario_id, nombre,email,contraseña)
VALUES(2, 'Nico', 'nicocricco@gmail.com', "123");

insert into categorias(nombre) values("Policial");
insert into categorias(nombre) values("Romantica");
insert into categorias(nombre) values("Suspenso");
insert into categorias(nombre) values("Comedia");
insert into categorias(nombre) values("RomCom");
insert into categorias(nombre) values("Accion");

insert into Artistas(nombre) values("Tom Hanks");
insert into Artistas(nombre) values("Tom Cruz");
insert into Artistas(nombre) values("Tom Holland");
insert into Artistas(nombre) values("Tom Hiddleston");
insert into Artistas(nombre) values("Tom Hardy");
insert into Artistas(nombre) values("Tom Selleck");
insert into Artistas(nombre) values("Tom Ellis");

insert into contenido (titulo,puntuacion,categoria_id,apto_kids) values("Forrest Gump",4,4,FALSE); #1
insert into contenido (titulo,puntuacion,categoria_id,apto_kids) values("Mission Imposible",5,6,True); #2
insert into contenido (titulo,puntuacion,categoria_id,apto_kids) values("Spiderman",4,6,True); #3
insert into contenido (titulo,puntuacion,categoria_id,apto_kids) values("Loki",3,6,True); #4
insert into contenido (titulo,puntuacion,categoria_id,apto_kids) values("Venom",4,6,FALSE); #5
insert into contenido (titulo,puntuacion,categoria_id,apto_kids) values("Magnum PI",5,1,FALSE); #6
insert into contenido (titulo,puntuacion,categoria_id,apto_kids) values("Lucifer",3,5,FALSE); #7

insert into peliculas (contenido_id,duracion)values(1,"2:30:00");
insert into peliculas (contenido_id,duracion)values(2,"3:30:30");
insert into peliculas (contenido_id,duracion)values(3,"1:30:00");
insert into peliculas (contenido_id,duracion)values(4,"2:45:30");
insert into peliculas (contenido_id,duracion)values(5,"2:30:20");

insert into series (contenido_id)values(6);
insert into series (contenido_id)values(7);

insert into Temporada (contenido_id,temporada_id) values(6,1);
insert into Temporada (contenido_id,temporada_id) values(6,2);
insert into Temporada (contenido_id,temporada_id) values(7,1);

insert into capitulos (contenido_id,temporada_id,numero_capitulo) values(6,1,1);
insert into capitulos (contenido_id,temporada_id,numero_capitulo) values(6,1,2);
insert into capitulos (contenido_id,temporada_id,numero_capitulo) values(6,1,3);
insert into capitulos (contenido_id,temporada_id,numero_capitulo) values(6,1,4);
insert into capitulos (contenido_id,temporada_id,numero_capitulo) values(6,1,5);
insert into capitulos (contenido_id,temporada_id,numero_capitulo) values(6,1,6);
insert into capitulos (contenido_id,temporada_id,numero_capitulo) values(6,1,7);
insert into capitulos (contenido_id,temporada_id,numero_capitulo) values(6,1,8);
insert into capitulos (contenido_id,temporada_id,numero_capitulo) values(6,2,1);
insert into capitulos (contenido_id,temporada_id,numero_capitulo) values(6,2,2);
insert into capitulos (contenido_id,temporada_id,numero_capitulo) values(6,2,3);
insert into capitulos (contenido_id,temporada_id,numero_capitulo) values(6,2,4);
insert into capitulos (contenido_id,temporada_id,numero_capitulo) values(6,2,5);
insert into capitulos (contenido_id,temporada_id,numero_capitulo) values(6,2,6);
insert into capitulos (contenido_id,temporada_id,numero_capitulo) values(6,2,7);
insert into capitulos (contenido_id,temporada_id,numero_capitulo) values(6,2,8);

insert into capitulos (contenido_id,temporada_id,numero_capitulo) values(7,1,1);
insert into capitulos (contenido_id,temporada_id,numero_capitulo) values(7,1,2);
insert into capitulos (contenido_id,temporada_id,numero_capitulo) values(7,1,3);
insert into capitulos (contenido_id,temporada_id,numero_capitulo) values(7,1,4);
insert into capitulos (contenido_id,temporada_id,numero_capitulo) values(7,1,5);
insert into capitulos (contenido_id,temporada_id,numero_capitulo) values(7,1,6);
insert into capitulos (contenido_id,temporada_id,numero_capitulo) values(7,1,7);
insert into capitulos (contenido_id,temporada_id,numero_capitulo) values(7,1,8);

insert into perfiles(usuario_id,tipo_perfil,nombre) values(1,'normal',"Nacho");    
insert into perfiles(usuario_id,tipo_perfil,nombre) values(1,'normal',"Nacho2"); 
insert into perfiles(usuario_id,tipo_perfil,nombre) values(1,'normal',"Julian"); 
insert into perfiles(usuario_id,tipo_perfil,nombre) values(1,'infantil',"Pato"); 
insert into perfiles(usuario_id,tipo_perfil,nombre) values(1,'infantil',"Child"); 

insert into perfiles(usuario_id,tipo_perfil,nombre) values(2,'normal',"Nico");    
insert into perfiles(usuario_id,tipo_perfil,nombre) values(2,'normal',"Nico2"); 
insert into perfiles(usuario_id,tipo_perfil,nombre) values(2,'normal',"Nico3"); 
insert into perfiles(usuario_id,tipo_perfil,nombre) values(2,'infantil',"Nico4"); 
insert into perfiles(usuario_id,tipo_perfil,nombre) values(2,'infantil',"Nico5"); 



