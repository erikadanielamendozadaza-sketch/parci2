CREATE DATABASE Parcial2Edmd;
USE master
GO
CREATE LOGIN usrparcial2 WITH PASSWORD = '12345678',
	CHECK_POLICY = ON,
	CHECK_EXPIRATION = OFF,
	DEFAULT_DATABASE = Parcial2Edmd
GO
USE Parcial2Edmd
GO
CREATE USER usrparcial2 FOR LOGIN usrparcial2
GO
ALTER ROLE db_owner ADD MEMBER usrparcial2
GO

DROP TABLE IF EXISTS Programa;
DROP TABLE IF EXISTS Canal;

CREATE TABLE Canal(
	id INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
	nombre VARCHAR(50) NOT NULL,
	frecuencia VARCHAR(20) NOT NULL,
	estado SMALLINT NOT NULL DEFAULT (1)
);

CREATE TABLE Programa(
	id INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
	idCanal INT NOT NULL,
	titulo VARCHAR(100) NOT NULL,
	descripcion VARCHAR(255) NOT NULL,
	duracion INT NOT NULL,
	productor VARCHAR(100) NOT NULL,
	fechaEstreno DATE NOT NULL,
	estado SMALLINT NOT NULL DEFAULT (1),
	CONSTRAINT fk_Programa_Canal FOREIGN KEY (idCanal) REFERENCES Canal(id)
);

GO
DROP PROC IF EXISTS paCanalListar;
GO
CREATE PROC paCanalListar @parametro VARCHAR(50)
AS
BEGIN
    SELECT c.id, c.nombre, c.frecuencia, c.estado
    FROM Canal c
    WHERE c.estado > -1 
      AND (c.nombre + c.frecuencia) LIKE '%' + REPLACE(@parametro, ' ', '%') + '%'
    ORDER BY c.estado DESC, c.nombre ASC;
END;
GO

EXEC paCanalListar '';

GO
DROP PROC IF EXISTS paProgramaListar;
GO
CREATE PROC paProgramaListar @parametro VARCHAR(50)
AS
BEGIN
    SELECT p.id, p.idCanal, c.nombre AS nombreCanal, p.titulo, p.descripcion, p.duracion, p.productor, p.fechaEstreno, p.estado
    FROM Programa p
    INNER JOIN Canal c ON c.id = p.idCanal
    WHERE p.estado > -1 
      AND p.titulo + p.descripcion + c.nombre LIKE '%' + REPLACE(@parametro, ' ', '%') + '%'
    ORDER BY p.estado DESC, p.titulo ASC;
END;
GO

EXEC paProgramaListar '';

INSERT INTO Canal (nombre,frecuencia)
VALUES ('Disney Chanel', 'Canal 36');

INSERT INTO Canal (nombre,frecuencia)
VALUES ('Televisa', 'Canal 45');

INSERT INTO Programa (idCanal,titulo,descripcion,duracion,productor,fechaEstreno)
VALUES (1, 'Phineas y Ferb', 'Programa de dos niños constructores', 20, 'Dan Povenmire Jeff', '2007-08-17');

INSERT INTO Programa (idCanal,titulo,descripcion,duracion,productor,fechaEstreno)
VALUES (1, 'Hannah Montana', 'Miley tiene una vida secreta', 40, 'Michael Poryes', '2006-04-26');

INSERT INTO Programa (idCanal,titulo,descripcion,duracion,productor,fechaEstreno)
VALUES (2, 'La Rosa de Guadalupe', 'Serie de drama y milagros', 45, 'Carlos Mercado Orduña', '2008-02-05'),
	   (2, 'El Chavo del 8', 'Comedia de un niño huérfano', 30, 'Roberto Gómez Bolaños', '1971-06-20');
