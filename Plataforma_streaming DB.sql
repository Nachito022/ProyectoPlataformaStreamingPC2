
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
DROP TABLE IF EXISTS Sagas;




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
    tipo_perfil BOOLEAN NOT NULL, #true es para cuando el perfil es de tipo niños
    nombre varchar(150) NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id)
);

-- Tabla categoria
CREATE TABLE Categorias(
	categoria_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre VARCHAR(255)
);

create table Sagas (
	saga_id int NOT null auto_increment,
	nombre_saga varchar(255) not null,
	primary key (saga_id)
);

-- Tabla Contenido
CREATE TABLE Contenido (
    contenido_id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(255) NOT NULL,
    puntuacion DECIMAL(2, 1),
    categoria_id INT,
    apto_kids BOOL,
    fecha_publicacion DATE,
    saga_id int,
    FOREIGN KEY (categoria_id) REFERENCES Categorias(categoria_id),
    FOREIGN KEY (saga_id) REFERENCES Sagas(saga_id)
);

-- Tabla Progreso de Contenido
CREATE TABLE Historial (
    perfil_id INT not null,
    contenido_id INT not null,
    capitulo_actual INT,
    temporada_actual INT,
    tiempo_visualizado TIME,
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
    duracion TIME not null,
    FOREIGN KEY (contenido_id,temporada_id) REFERENCES Temporada(contenido_id,temporada_id)
);




insert into Usuarios(usuario_id,nombre,email,contraseña)VALUES(1,'Test', 'test@gmail.com', "12345");
insert into Usuarios(usuario_id,nombre,email,contraseña)VALUES(2,'Nacho', 'nachoferre22@gmail.com', "123");
insert into Usuarios(usuario_id,nombre,email,contraseña)VALUES(3,'Nico', 'nicocricco@gmail.com', "123");
insert into Usuarios(nombre,email,contraseña)VALUES('Juan', 'juan@gmail.com', "123");
insert into Usuarios(nombre,email,contraseña)VALUES('Pepe', 'pepe@gmail.com', "123");
insert into Usuarios(nombre,email,contraseña)VALUES('Martin', 'martin@gmail.com', "123");
insert into Usuarios(nombre,email,contraseña)VALUES('Martin2', 'martin2@gmail.com', "123");
insert into Usuarios(nombre,email,contraseña)VALUES('Julian', 'julain@gmail.com', "123");

insert into categorias(nombre) values("Policial"); #1
insert into categorias(nombre) values("Romantica"); #2
insert into categorias(nombre) values("Suspenso"); #3
insert into categorias(nombre) values("Comedia"); #4
insert into categorias(nombre) values("RomCom"); #5
insert into categorias(nombre) values("Accion"); #6
insert into categorias(nombre) values("Animada"); #7
insert into categorias(nombre) values("Fantasía"); #8

insert into Sagas(saga_id,nombre_saga) values(1,"Star Wars");
insert into Sagas(saga_id,nombre_saga) values(2,"Kung Fu Panda");

insert into Artistas(nombre,artista_id) values("Tom Hanks",1);
insert into Artistas(nombre,artista_id) values("Robin Wright",2);
insert into Artistas(nombre,artista_id) values("Gary Sinise",3);
insert into Artistas(nombre,artista_id) values("Mykelti Williamson",4);
insert into Artistas(nombre,artista_id) values("Robert Zemeckis",5);
insert into Artistas(nombre,artista_id) values("Wendy Finerman",6);

insert into Artistas(nombre,artista_id) values("George Lucas",7);
insert into Artistas(nombre,artista_id) values("Dave Filoni",8);
insert into Artistas(nombre,artista_id) values("Rosario Dawson",9);
insert into Artistas(nombre,artista_id) values("Diego Luna",10);
insert into Artistas(nombre,artista_id) values("Ewan McGregor",11);
insert into Artistas(nombre,artista_id) values("Pedro Pascal",12);
insert into Artistas(nombre,artista_id) values("Ming-Na Wen",13);
insert into Artistas(nombre,artista_id) values("Temuera Morrison",14);

insert into Artistas(nombre,artista_id) values("Mark Hamill",15);
insert into Artistas(nombre,artista_id) values("Harrison Ford",16);
insert into Artistas(nombre,artista_id) values("Carrie Fisher",17);
insert into Artistas(nombre,artista_id) values("Alec Guinness",18);
insert into Artistas(nombre,artista_id) values("Liam Neeson",19);
insert into Artistas(nombre,artista_id) values("Natalie Portman",20);
insert into Artistas(nombre,artista_id) values("Hayden Christensen",21);

insert into Artistas(nombre) values("Tom Cruz");
insert into Artistas(nombre) values("Tom Holland");
insert into Artistas(nombre) values("Tom Hiddleston");
insert into Artistas(nombre) values("Tom Hardy");
insert into Artistas(nombre) values("Tom Selleck");
insert into Artistas(nombre) values("Tom Ellis");

insert into contenido (contenido_id,titulo,puntuacion,categoria_id,apto_kids,fecha_publicacion) values(1,"Forrest Gump",4,4,false,"2020:06:13"); #1
insert into contenido (contenido_id,titulo,puntuacion,categoria_id,apto_kids,fecha_publicacion) values(2,"Mission Imposible",5,6,True,"2023:06:13"); #2
insert into contenido (contenido_id,titulo,puntuacion,categoria_id,apto_kids,fecha_publicacion) values(3,"Spiderman",4,6,True,"2022:06:13"); #3
insert into contenido (contenido_id,titulo,puntuacion,categoria_id,apto_kids,fecha_publicacion) values(4,"Loki",3,6,True,"2020:01:20"); #4
insert into contenido (contenido_id,titulo,puntuacion,categoria_id,apto_kids,fecha_publicacion) values(5,"Venom",4,6,false,"2024:11:10"); #5
insert into contenido (contenido_id,titulo,puntuacion,categoria_id,apto_kids,fecha_publicacion) values(6,"Magnum PI",5,1,FALSE,"2020:06:13"); #6
insert into contenido (contenido_id,titulo,puntuacion,categoria_id,apto_kids,fecha_publicacion) values(7,"Lucifer",3,5,FALSE,"2024:07:29"); #7
insert into contenido (titulo,puntuacion,categoria_id,apto_kids,fecha_publicacion,saga_id) values("Kung Fu Panda",5,7,TRUE,"2024:11:10",2); #8
insert into contenido (titulo,puntuacion,categoria_id,apto_kids,fecha_publicacion,saga_id) values("Kung Fu Panda 2",5,7,TRUE,"2024:11:10",2); #9
insert into contenido (titulo,puntuacion,categoria_id,apto_kids,fecha_publicacion,saga_id) values("Kung Fu Panda 3",5,7,TRUE,"2024:11:10",2); #10
insert into contenido (titulo,puntuacion,categoria_id,apto_kids,fecha_publicacion) values("Game of Thrones",5,8,FALSE,"2019:05:02"); #11
insert into contenido (titulo,puntuacion,categoria_id,apto_kids,fecha_publicacion,saga_id) values("The Phantom Menace",5,8,TRUE,"2005:11:10",1); #12
insert into contenido (titulo,puntuacion,categoria_id,apto_kids,fecha_publicacion,saga_id) values("Attack of the Clones",5,8,TRUE,"2005:11:10",1); #13
insert into contenido (titulo,puntuacion,categoria_id,apto_kids,fecha_publicacion,saga_id) values("Revenge of the Sith",5,8,TRUE,"2005:11:10",1); #14
insert into contenido (titulo,puntuacion,categoria_id,apto_kids,fecha_publicacion,saga_id) values("A New Hope",5,8,TRUE,"1987:11:10",1); #15
insert into contenido (titulo,puntuacion,categoria_id,apto_kids,fecha_publicacion,saga_id) values("The Empire Strikes Back",5,8,TRUE,"1987:11:10",1); #16
insert into contenido (titulo,puntuacion,categoria_id,apto_kids,fecha_publicacion,saga_id) values("Return of the Jedi",5,8,TRUE,"1987:11:10",1); #17
insert into contenido (titulo,puntuacion,categoria_id,apto_kids,fecha_publicacion,saga_id) values("Rogue One: A Star Wars Story",5,8,TRUE,"2015:11:10",1); #18
insert into contenido (titulo,puntuacion,categoria_id,apto_kids,fecha_publicacion,saga_id) values("The Mandalorian",5,8,TRUE,"2024:11:10",1); #19
insert into contenido (titulo,puntuacion,categoria_id,apto_kids,fecha_publicacion,saga_id) values("The Book of Boba Fett",5,8,TRUE,"2024:11:10",1); #20
insert into contenido (titulo,puntuacion,categoria_id,apto_kids,fecha_publicacion,saga_id) values("Obi-Wan Kenobi",5,5,TRUE,"2024:11:10",1); #21
insert into contenido (titulo,puntuacion,categoria_id,apto_kids,fecha_publicacion,saga_id) values("Andor",3,8,TRUE,"2024:11:10",1); #22
insert into contenido (titulo,puntuacion,categoria_id,apto_kids,fecha_publicacion,saga_id) values("Ahsoka",4,8,TRUE,"2024:11:10",1); #23

insert into contenido_artistas (contenido_id,artista_id,rol,nom_ficticio) values(1,1,"Actor","Forrest Gump");
insert into contenido_artistas (contenido_id,artista_id,rol,nom_ficticio) values(1,2,"Actor","Jenny Curran");
insert into contenido_artistas (contenido_id,artista_id,rol,nom_ficticio) values(1,3,"Actor","Teniente Dan Taylor");
insert into contenido_artistas (contenido_id,artista_id,rol,nom_ficticio) values(1,4,"Actor","Benjamin Buford Bubba Blue");
insert into contenido_artistas (contenido_id,artista_id,rol) values(1,5,"Director");
insert into contenido_artistas (contenido_id,artista_id,rol) values(1,6,"Productor");

insert into contenido_artistas (contenido_id,artista_id,rol) values(12,7,"Director");
insert into contenido_artistas (contenido_id,artista_id,rol) values(13,7,"Director");
insert into contenido_artistas (contenido_id,artista_id,rol) values(14,7,"Director");
insert into contenido_artistas (contenido_id,artista_id,rol) values(15,7,"Director");
insert into contenido_artistas (contenido_id,artista_id,rol) values(16,7,"Director");
insert into contenido_artistas (contenido_id,artista_id,rol) values(17,7,"Director");
insert into contenido_artistas (contenido_id,artista_id,rol) values(19,8,"Director");
insert into contenido_artistas (contenido_id,artista_id,rol) values(20,8,"Director");
insert into contenido_artistas (contenido_id,artista_id,rol,nom_ficticio) values(23,9,"Actor","Ahsoka");
insert into contenido_artistas (contenido_id,artista_id,rol,nom_ficticio) values(19,9,"Actor","Ahsoka");
insert into contenido_artistas (contenido_id,artista_id,rol,nom_ficticio) values(18,10,"Actor","Cassian Andor");
insert into contenido_artistas (contenido_id,artista_id,rol,nom_ficticio) values(22,10,"Actor","Cassian Andor");
insert into contenido_artistas (contenido_id,artista_id,rol,nom_ficticio) values(12,11,"Actor","Obi-Wan Kenobi");
insert into contenido_artistas (contenido_id,artista_id,rol,nom_ficticio) values(13,11,"Actor","Obi-Wan Kenobi");
insert into contenido_artistas (contenido_id,artista_id,rol,nom_ficticio) values(14,11,"Actor","Obi-Wan Kenobi");
insert into contenido_artistas (contenido_id,artista_id,rol,nom_ficticio) values(21,11,"Actor","Obi-Wan Kenobi");
insert into contenido_artistas (contenido_id,artista_id,rol,nom_ficticio) values(19,12,"Actor","Din Djarin");
insert into contenido_artistas (contenido_id,artista_id,rol,nom_ficticio) values(20,12,"Actor","Din Djarin");
insert into contenido_artistas (contenido_id,artista_id,rol,nom_ficticio) values(19,13,"Actor","Fennec Shand");
insert into contenido_artistas (contenido_id,artista_id,rol,nom_ficticio) values(20,13,"Actor","Fennec Shand");
insert into contenido_artistas (contenido_id,artista_id,rol,nom_ficticio) values(19,14,"Actor","Boba Fett");
insert into contenido_artistas (contenido_id,artista_id,rol,nom_ficticio) values(20,14,"Actor","Boba Fett");

insert into contenido_artistas (contenido_id,artista_id,rol,nom_ficticio) values(19,15,"Actor","Luke Skywalker");
insert into contenido_artistas (contenido_id,artista_id,rol,nom_ficticio) values(15,15,"Actor","Luke Skywalker");
insert into contenido_artistas (contenido_id,artista_id,rol,nom_ficticio) values(16,15,"Actor","Luke Skywalker");
insert into contenido_artistas (contenido_id,artista_id,rol,nom_ficticio) values(17,15,"Actor","Luke Skywalker");
insert into contenido_artistas (contenido_id,artista_id,rol,nom_ficticio) values(15,16,"Actor","Han Solo");
insert into contenido_artistas (contenido_id,artista_id,rol,nom_ficticio) values(16,16,"Actor","Han Solo");
insert into contenido_artistas (contenido_id,artista_id,rol,nom_ficticio) values(17,16,"Actor","Han Solo");
insert into contenido_artistas (contenido_id,artista_id,rol,nom_ficticio) values(15,17,"Actor","Princess Leia Organa");
insert into contenido_artistas (contenido_id,artista_id,rol,nom_ficticio) values(16,17,"Actor","Princess Leia Organa");
insert into contenido_artistas (contenido_id,artista_id,rol,nom_ficticio) values(17,17,"Actor","Princess Leia Organa");
insert into contenido_artistas (contenido_id,artista_id,rol,nom_ficticio) values(15,18,"Actor","Ben (Obi-Wan) Kenobi");
insert into contenido_artistas (contenido_id,artista_id,rol,nom_ficticio) values(16,18,"Actor","Ben (Obi-Wan) Kenobi");
insert into contenido_artistas (contenido_id,artista_id,rol,nom_ficticio) values(17,18,"Actor","Ben (Obi-Wan) Kenobi");
insert into contenido_artistas (contenido_id,artista_id,rol,nom_ficticio) values(12,19,"Actor","Qui-Gon Jinn");
insert into contenido_artistas (contenido_id,artista_id,rol,nom_ficticio) values(13,19,"Actor","Qui-Gon Jinn");
insert into contenido_artistas (contenido_id,artista_id,rol,nom_ficticio) values(14,19,"Actor","Qui-Gon Jinn");
insert into contenido_artistas (contenido_id,artista_id,rol,nom_ficticio) values(12,20,"Actor","Padmé Amidala");
insert into contenido_artistas (contenido_id,artista_id,rol,nom_ficticio) values(13,20,"Actor","Padmé Amidala");
insert into contenido_artistas (contenido_id,artista_id,rol,nom_ficticio) values(14,20,"Actor","Padmé Amidala");
insert into contenido_artistas (contenido_id,artista_id,rol,nom_ficticio) values(12,21,"Actor","Anakin Skywalker / Darth Vader");
insert into contenido_artistas (contenido_id,artista_id,rol,nom_ficticio) values(13,21,"Actor","Anakin Skywalker / Darth Vader");
insert into contenido_artistas (contenido_id,artista_id,rol,nom_ficticio) values(14,21,"Actor","Anakin Skywalker / Darth Vader");

insert into peliculas (contenido_id,duracion)values(1,"2:30:00");
insert into peliculas (contenido_id,duracion)values(2,"3:30:30");
insert into peliculas (contenido_id,duracion)values(3,"1:30:00");
insert into peliculas (contenido_id,duracion)values(4,"2:45:30");
insert into peliculas (contenido_id,duracion)values(5,"2:30:20");
insert into peliculas (contenido_id,duracion)values(8,"1:32:00");
insert into peliculas (contenido_id,duracion)values(9,"1:35:00");
insert into peliculas (contenido_id,duracion)values(10,"1:35:00");
insert into peliculas (contenido_id,duracion)values(12,"2:14:00");
insert into peliculas (contenido_id,duracion)values(13,"2:22:00");
insert into peliculas (contenido_id,duracion)values(14,"2:20:00");
insert into peliculas (contenido_id,duracion)values(15,"2:01:00");
insert into peliculas (contenido_id,duracion)values(16,"2:04:00");
insert into peliculas (contenido_id,duracion)values(17,"2:12:00");
insert into peliculas (contenido_id,duracion)values(18,"2:14:00");

insert into series (contenido_id)values(6);
insert into series (contenido_id)values(7);
insert into series (contenido_id)values(11);
insert into series (contenido_id)values(19);
insert into series (contenido_id)values(20);
insert into series (contenido_id)values(21);
insert into series (contenido_id)values(22);
insert into series (contenido_id)values(23);

insert into Temporada (contenido_id,temporada_id) values(6,1);
insert into Temporada (contenido_id,temporada_id) values(6,2);
insert into Temporada (contenido_id,temporada_id) values(7,1);
insert into Temporada (contenido_id,temporada_id) values(7,2);
insert into Temporada (contenido_id,temporada_id) values(7,3);
insert into Temporada (contenido_id,temporada_id) values(11,1);
insert into Temporada (contenido_id,temporada_id) values(11,2);
insert into Temporada (contenido_id,temporada_id) values(11,3);
insert into Temporada (contenido_id,temporada_id) values(11,4);
insert into Temporada (contenido_id,temporada_id) values(11,5);
insert into Temporada (contenido_id,temporada_id) values(11,6);
insert into Temporada (contenido_id,temporada_id) values(11,7);
insert into Temporada (contenido_id,temporada_id) values(11,8);
insert into Temporada (contenido_id,temporada_id) values(19,1);
insert into Temporada (contenido_id,temporada_id) values(19,2);
insert into Temporada (contenido_id,temporada_id) values(19,3);
insert into Temporada (contenido_id,temporada_id) values(20,1);
insert into Temporada (contenido_id,temporada_id) values(21,1);
insert into Temporada (contenido_id,temporada_id) values(22,1);
insert into Temporada (contenido_id,temporada_id) values(23,1);

insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(6,1,1,"0:39:16");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(6,1,2,"0:42:30");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(6,1,3,"0:48:48");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(6,1,4,"0:55:27");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(6,1,5,"0:34:2");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(6,1,6,"0:20:19");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(6,1,7,"0:24:11");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(6,1,8,"0:55:3");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(6,2,1,"0:45:28");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(6,2,2,"0:24:9");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(6,2,3,"0:30:23");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(6,2,4,"0:20:8");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(6,2,5,"0:20:53");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(6,2,6,"0:44:25");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(6,2,7,"0:32:17");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(6,2,8,"0:23:59");

insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,1,1,"0:37:23");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,1,2,"0:43:22");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,1,3,"0:39:36");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,1,4,"0:26:41");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,1,5,"0:25:51");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,1,6,"0:52:15");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,1,7,"0:47:36");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,1,8,"0:22:1");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,1,9,"0:38:20");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,1,10,"0:57:57");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,1,11,"0:40:24");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,1,12,"0:52:32");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,1,13,"0:49:46");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,1,14,"0:26:39");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,1,15,"0:23:30");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,1,16,"0:20:51");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,1,17,"0:43:53");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,1,18,"0:45:28");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,1,19,"0:39:43");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,1,20,"0:40:14");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,2,1,"0:56:18");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,2,2,"0:28:7");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,2,3,"0:29:55");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,2,4,"0:48:3");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,2,5,"0:36:3");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,2,6,"0:27:1");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,2,7,"0:47:33");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,2,8,"0:46:38");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,2,9,"0:54:17");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,2,10,"0:24:3");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,2,11,"0:39:48");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,2,12,"0:38:29");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,2,13,"0:40:48");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,2,14,"0:54:46");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,2,15,"0:49:13");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,2,16,"0:42:52");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,2,17,"0:29:45");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,2,18,"0:27:28");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,2,19,"0:40:37");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,2,20,"0:34:32");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,3,1,"0:38:29");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,3,2,"0:46:20");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,3,3,"0:23:47");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,3,4,"0:24:45");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,3,5,"0:45:41");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,3,6,"0:26:16");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,3,7,"0:55:36");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,3,8,"0:59:21");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,3,9,"0:27:39");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,3,10,"0:32:14");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,3,11,"0:36:8");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,3,12,"0:55:17");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,3,13,"0:32:20");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,3,14,"0:35:18");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,3,15,"0:42:35");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,3,16,"0:38:18");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,3,17,"0:22:27");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,3,18,"0:20:56");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,3,19,"0:59:43");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(7,3,20,"0:20:9");

insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,1,1,"0:45:52");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,1,2,"0:31:20");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,1,3,"0:49:45");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,1,4,"0:42:54");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,1,5,"0:42:19");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,1,6,"0:39:12");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,1,7,"0:57:15");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,1,8,"0:53:37");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,1,9,"0:56:51");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,1,10,"0:56:53");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,2,1,"0:21:10");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,2,2,"0:55:17");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,2,3,"0:38:44");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,2,4,"0:24:14");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,2,5,"0:57:58");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,2,6,"0:30:17");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,2,7,"0:38:57");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,2,8,"0:38:39");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,2,9,"0:46:58");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,2,10,"0:54:44");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,3,1,"0:25:45");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,3,2,"0:38:2");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,3,3,"0:34:7");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,3,4,"0:47:30");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,3,5,"0:20:39");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,3,6,"0:49:59");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,3,7,"0:50:34");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,3,8,"0:53:30");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,3,9,"0:31:19");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,3,10,"0:33:28");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,4,1,"0:48:33");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,4,2,"0:23:17");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,4,3,"0:27:55");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,4,4,"0:47:38");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,4,5,"0:33:17");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,4,6,"0:51:51");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,4,7,"0:40:59");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,4,8,"0:38:55");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,4,9,"0:42:8");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,4,10,"0:53:0");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,5,1,"0:25:51");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,5,2,"0:25:51");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,5,3,"0:38:22");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,5,4,"0:29:37");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,5,5,"0:45:27");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,5,6,"0:53:21");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,5,7,"0:40:47");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,5,8,"0:55:59");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,5,9,"0:23:4");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,5,10,"0:20:58");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,6,1,"0:55:28");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,6,2,"0:52:52");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,6,3,"0:28:21");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,6,4,"0:29:47");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,6,5,"0:23:6");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,6,6,"0:40:17");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,6,7,"0:47:33");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,6,8,"0:22:8");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,6,9,"0:23:1");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,6,10,"0:40:4");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,7,1,"0:50:35");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,7,2,"0:51:54");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,7,3,"0:42:30");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,7,4,"0:42:21");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,7,5,"0:41:41");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,7,6,"0:39:51");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,7,7,"0:42:30");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,7,8,"0:39:18");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,7,9,"0:59:29");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,7,10,"0:45:31");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,8,1,"0:58:9");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,8,2,"0:27:45");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,8,3,"0:29:4");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,8,4,"0:59:9");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,8,5,"0:57:47");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,8,6,"0:55:19");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,8,7,"0:42:28");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,8,8,"0:24:44");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,8,9,"0:20:17");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(11,8,10,"0:28:34");

insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(19,1,1,"0:20:19");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(19,1,2,"0:39:32");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(19,1,3,"0:22:15");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(19,1,4,"0:33:23");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(19,1,5,"0:37:23");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(19,1,6,"0:27:21");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(19,1,7,"0:33:6");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(19,1,8,"0:32:7");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(19,2,1,"0:35:42");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(19,2,2,"0:39:36");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(19,2,3,"0:24:45");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(19,2,4,"0:40:28");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(19,2,5,"0:35:35");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(19,2,6,"0:36:18");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(19,2,7,"0:45:19");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(19,2,8,"0:52:49");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(19,3,1,"0:56:19");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(19,3,2,"0:29:50");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(19,3,3,"0:35:3");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(19,3,4,"0:26:29");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(19,3,5,"0:51:42");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(19,3,6,"0:42:9");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(19,3,7,"0:44:9");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(19,3,8,"0:29:40");

insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(20,1,1,"0:48:40");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(20,1,2,"0:52:51");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(20,1,3,"0:53:48");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(20,1,4,"0:32:22");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(20,1,5,"0:20:7");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(20,1,6,"0:23:56");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(20,1,7,"0:24:52");

insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(21,1,1,"0:50:1");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(21,1,2,"0:53:44");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(21,1,3,"0:55:11");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(21,1,4,"0:40:4");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(21,1,5,"0:26:14");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(21,1,6,"0:52:51");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(21,1,7,"0:30:59");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(21,1,8,"0:40:16");

insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(22,1,1,"0:26:6");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(22,1,2,"0:53:5");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(22,1,3,"0:51:13");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(22,1,4,"0:43:32");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(22,1,5,"0:30:56");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(22,1,6,"0:49:22");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(22,1,7,"0:21:28");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(22,1,8,"0:23:6");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(22,1,9,"0:50:49");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(22,1,10,"0:38:42");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(22,1,11,"0:32:4");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(22,1,12,"0:39:41");

insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(23,1,1,"0:20:43");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(23,1,2,"0:39:48");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(23,1,3,"0:29:15");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(23,1,4,"0:37:52");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(23,1,5,"0:54:51");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(23,1,6,"0:38:22");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(23,1,7,"0:24:3");
insert into capitulos (contenido_id,temporada_id,numero_capitulo,duracion) values(23,1,8,"0:56:25");

insert into perfiles(usuario_id,tipo_perfil,nombre) values(2,FALSE,"Nacho");    
insert into perfiles(usuario_id,tipo_perfil,nombre) values(2,FALSE,"Nacho2"); 
insert into perfiles(usuario_id,tipo_perfil,nombre) values(2,FALSE,"Julian"); 
insert into perfiles(usuario_id,tipo_perfil,nombre) values(2,TRUE,"Pato"); 
insert into perfiles(usuario_id,tipo_perfil,nombre) values(2,TRUE,"Child"); 

insert into perfiles(usuario_id,tipo_perfil,nombre) values(1,FALSE,"test1");    
insert into perfiles(usuario_id,tipo_perfil,nombre) values(1,FALSE,"test2"); 
insert into perfiles(usuario_id,tipo_perfil,nombre) values(1,FALSE,"test3"); 
insert into perfiles(usuario_id,tipo_perfil,nombre) values(1,FALSE,"test4"); 
insert into perfiles(usuario_id,tipo_perfil,nombre) values(1,TRUE,"testChild1"); 
insert into perfiles(usuario_id,tipo_perfil,nombre) values(1,TRUE,"testChild2"); 

insert into perfiles(usuario_id,tipo_perfil,nombre) values(3,FALSE,"Nico");    
insert into perfiles(usuario_id,tipo_perfil,nombre) values(3,FALSE,"Nico2"); 
insert into perfiles(usuario_id,tipo_perfil,nombre) values(3,FALSE,"Nico3"); 
insert into perfiles(usuario_id,tipo_perfil,nombre) values(3,TRUE,"Nico4"); 
insert into perfiles(usuario_id,tipo_perfil,nombre) values(3,TRUE,"Nico5"); 

insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(1,5,null,null,"2:20:00","2020:05:16",5);
insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(1,6,5,1,"0:20:00","2020:05:16",5);

insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(2,16,null,null,"2:20:00","2020:05:16",5);
insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(2,21,3,1,"0:20:00","2020:08:16",5);
insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(2,17,null,null,"2:20:00","2020:08:17",5);
insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(2,22,5,1,"0:20:00","2020:09:02",5);

insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(3,5,null,null,"2:20:00","2020:05:16",5);
insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(3,6,5,1,"0:20:00","2020:05:16",5);

insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(5,5,null,null,"2:20:00","2020:05:16",5);

insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(6,5,null,null,"2:20:00","2020:05:16",5);
insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(6,6,5,1,"0:20:00","2020:05:16",5);
insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(6,14,null,null,"2:20:00","2020:05:16",5);
insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(6,19,5,2,"0:20:00","2020:05:16",5);

insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(7,8,null,null,"0:00:00","2020:05:16",5);
insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(7,9,null,null,"0:59:00","2020:05:17",5);
insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(7,10,null,null,"0:55:00","2020:05:18",5);
insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(7,12,null,null,"0:42:00","2020:05:19",5);
insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(7,13,null,null,"0:35:00","2020:05:20",5);
insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(7,14,null,null,"0:20:00","2020:05:21",5);
insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(7,15,null,null,"0:10:00","2020:05:22",5);
insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(7,11,5,4,"0:20:00","2020:05:23",5);

insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(9,5,null,null,"2:20:00","2020:05:16",5);

insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(10,5,null,null,"2:20:00","2020:05:16",5);
insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(10,6,5,1,"0:20:00","2020:05:16",5);



insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(12,5,null,null,"2:20:00","2020:05:16",5);
insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(12,6,5,1,"0:20:00","2020:05:16",5);

insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(12,16,null,null,"2:20:00","2020:05:16",5);
insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(12,21,3,1,"0:20:00","2020:08:16",5);
insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(12,17,null,null,"2:20:00","2020:08:17",5);
insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(12,22,5,1,"0:20:00","2020:09:02",5);

insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(13,5,null,null,"2:20:00","2020:05:16",5);
insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(13,6,5,1,"0:20:00","2020:05:16",5);

insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(14,5,null,null,"2:20:00","2020:05:16",5);

insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(15,5,null,null,"2:20:00","2020:05:16",5);
insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(15,6,5,1,"0:20:00","2020:05:16",5);
insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(15,14,null,null,"2:20:00","2020:05:16",5);
insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(15,19,5,2,"0:20:00","2020:05:16",5);

insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(16,8,null,null,"0:00:00","2020:05:16",5);
insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(16,9,null,null,"0:59:00","2020:05:17",5);
insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(16,10,null,null,"0:55:00","2020:05:18",5);
insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(16,12,null,null,"0:42:00","2020:05:19",5);
insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(16,13,null,null,"0:35:00","2020:05:20",5);
insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(16,14,null,null,"0:20:00","2020:05:21",5);
insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(16,15,null,null,"0:10:00","2020:05:22",5);
insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(16,11,5,4,"0:20:00","2020:05:23",5);

insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(14,5,null,null,"2:20:00","2020:05:16",5);

insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(15,5,null,null,"2:20:00","2020:05:16",5);
insert into Historial(perfil_id,contenido_id,capitulo_actual,temporada_actual,tiempo_visualizado,fecha_visto,valoracion) values(15,6,5,1,"0:20:00","2020:05:16",5);



