CREATE TABLE Tiempos(
	idTiempo INT NOT NULL PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL
);

CREATE TABLE Estados(
	idEstado INT NOT NULL PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL
);

CREATE TABLE Conferencias(
	idConferencia INT NOT NULL PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL
);

CREATE TABLE DatosCargos(
	idCargo INT NOT NULL PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL
);

CREATE TABLE DatosPosiciones(
	idPosicion INT NOT NULL PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	descripcion VARCHAR(500) NOT NULL
);

CREATE TABLE DatosLeyendas(
	idLeyenda INT NOT NULL PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL
);

CREATE TABLE Temporadas(
	idTemporada INT NOT NULL PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL
);

CREATE TABLE EdicionesNBA(
	idEdicion INT NOT NULL PRIMARY KEY,
	añoEdicion VARCHAR(10) NOT NULL,
	fechaInicio DATE NOT NULL,
	fechaFin DATE NOT NULL
);

CREATE TABLE Premios(
	idPremio INT NOT NULL PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	descripcion VARCHAR(500) NULL
);

CREATE TABLE TiposAcciones(
	idTipoAccion INT NOT NULL PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	descripcion VARCHAR(500) NULL
);

CREATE TABLE Equipos(
	idEquipo INT NOT NULL PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	añoFundación INT NOT NULL
);

CREATE TABLE Ciudades(
	idCiudad INT NOT NULL PRIMARY KEY,
	idEstado INT NOT NULL,
	nombre VARCHAR(50) NOT NULL,
	FOREIGN KEY (idEstado) REFERENCES Estados(idEstado) 
);

CREATE TABLE Pabellones(
	idPabellon INT NOT NULL PRIMARY KEY,
	idCiudad INT NOT NULL,
	nombre VARCHAR(50) NOT NULL,
	capacidad INT NOT NULL,
    FOREIGN KEY (idCiudad) REFERENCES Ciudades(idCiudad) 
);

CREATE TABLE Partidos(
	idPartido INT NOT NULL PRIMARY KEY,
	fecha DATE NOT NULL,
	hora TIME NOT NULL,
	idPabellon INT NOT NULL,
	idEquipoLocal INT NOT NULL,
	idEquipoVisitante INT NOT NULL,
	idEdicion INT NOT NULL,
    FOREIGN KEY (idPabellon) REFERENCES Pabellones(idPabellon),
	FOREIGN KEY (idEquipoLocal) REFERENCES Equipos(idEquipo),
	FOREIGN KEY (idEquipoVisitante) REFERENCES Equipos(idEquipo),
	FOREIGN KEY (idEdicion) REFERENCES EdicionesNBA(idEdicion)
);

CREATE TABLE Alineaciones(
	idAlineacion INT NOT NULL PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	detalle VARCHAR(50) NULL,
	idEquipoCreador INT NOT NULL,
	FOREIGN KEY (idEquipoCreador) REFERENCES Equipos(idEquipo) 
);

CREATE TABLE AlineacionesUsadas(
	idAlineacionUsada INT NOT NULL PRIMARY KEY,
	idEquipoUsuario INT NOT NULL,
	idAlineacion INT NOT NULL,
	idPartido INT NOT NULL,
	idTiempo INT NOT NULL,
	FOREIGN KEY (idEquipoUsuario) REFERENCES Equipos(idEquipo), 
	FOREIGN KEY (idAlineacion) REFERENCES Alineaciones(idAlineacion),
	FOREIGN KEY (idPartido) REFERENCES Partidos(idPartido),
	FOREIGN KEY (idTiempo) REFERENCES Tiempos(idTiempo)
);

CREATE TABLE EdicionesTemporadas(
	idEdicionTemporada INT NOT NULL PRIMARY KEY,
	idEdicion INT NOT NULL,
	idTemporada INT NOT NULL,
	fechaInicio INT NOT NULL,
	fechaFin INT NOT NULL,
	FOREIGN KEY (idEdicion) REFERENCES EdicionesNBA(idEdicion),
	FOREIGN KEY (idTemporada) REFERENCES Temporadas(idTemporada)
);

CREATE TABLE Miembros(
	idMiembro INT NOT NULL PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	apellido VARCHAR(50) NOT NULL,
	fechaNacimiento DATE NOT NULL,
	fechaFallecimiento DATE NULL,
	fechaRetiro DATE NULL,
	estatura DOUBLE PRECISION NOT NULL,
	nacionalidad VARCHAR(50) NOT NULL,
	peso DOUBLE PRECISION NOT NULL
);

CREATE TABLE TiposMiembrosEquipos(
	idTipoMiembro INT NOT NULL PRIMARY KEY,
	idEquipo INT NOT NULL,
	idCargo INT NOT NULL,
	idMiembro INT NOT NULL,
	fechaInicioContrato DATE NOT NULL,
	fechaFinContrato DATE NOT NULL,
	FOREIGN KEY (idEquipo) REFERENCES Equipos(idEquipo),
	FOREIGN KEY (idCargo) REFERENCES DatosCargos(idCargo),
	FOREIGN KEY (idMiembro) REFERENCES Miembros(idMiembro)
);

CREATE TABLE GanadoresPremios(
	idGanadorPremio INT NOT NULL PRIMARY KEY,
	idEdicion INT NOT NULL,
	idPremio INT NOT NULL,
	idTipoMiembro INT NOT NULL,
	FOREIGN KEY (idEdicion) REFERENCES EdicionesNBA(idEdicion),
	FOREIGN KEY (idPremio) REFERENCES Premios(idPremio),
	FOREIGN KEY (idTipoMiembro) REFERENCES TiposMiembrosEquipos(idTipoMiembro)
);

CREATE TABLE SalariosMiembros(
	idSalarioMiembro INT NOT NULL PRIMARY KEY,
	valor INT NOT NULL,
	idEdicion INT NOT NULL,
	idTipoMiembro INT NOT NULL,
	FOREIGN KEY (idEdicion) REFERENCES EdicionesNBA(idEdicion),
	FOREIGN KEY (idTipoMiembro) REFERENCES TiposMiembrosEquipos(idTipoMiembro)
);

CREATE TABLE CampeonesNBA(
	idEdicion INT NOT NULL PRIMARY KEY,
	idEquipo INT NOT NULL,
	FOREIGN KEY (idEdicion) REFERENCES EdicionesNBA(idEdicion),
	FOREIGN KEY (idEquipo) REFERENCES Equipos(idEquipo)
);

CREATE TABLE EstadiaPabellones(
	idEstadiaPabellon INT NOT NULL PRIMARY KEY,
	idEquipo INT NOT NULL,
	idPabellon INT NOT NULL,
	añoInicio INT NOT NULL,
	añoFin INT NOT NULL,
	FOREIGN KEY (idEquipo) REFERENCES Equipos(idEquipo), 
	FOREIGN KEY (idPabellon) REFERENCES Pabellones(idPabellon)
);

CREATE TABLE Divisiones(
	idDivision INT NOT NULL PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL
);

CREATE TABLE DivisionesDeConferencias(
	idConferencia INT NOT NULL,
	idDivision INT NOT NULL,
	PRIMARY KEY(idConferencia, idDivision),
	FOREIGN KEY (idConferencia) REFERENCES Conferencias(idConferencia),
	FOREIGN KEY (idDivision) REFERENCES Divisiones(idDivision)
);

CREATE TABLE EquiposConferencias(
	idEquipoConferencia INT NOT NULL PRIMARY KEY,
	idEquipo INT NOT NULL,
	idDivision INT NOT NULL,
	idConferencia INT NOT NULL,
	idEdicion INT NOT NULL,	
	FOREIGN KEY (idEquipo) REFERENCES Equipos(idEquipo),
	FOREIGN KEY (idDivision) REFERENCES Divisiones(idDivision),
	FOREIGN KEY (idConferencia) REFERENCES Conferencias(idConferencia),
	FOREIGN KEY (idEdicion) REFERENCES EdicionesNBA(idEdicion)
);

CREATE TABLE MiembrosJugadores(
	idMiembroJugador INT NOT NULL PRIMARY KEY,
	idTipoMiembro INT NOT NULL,
	idLeyenda INT NULL,
	añoDraft INT NULL,
	idPosicion INT NOT NULL,
	numeroDorsal INT NOT NULL,
    FOREIGN KEY (idTipoMiembro) REFERENCES TiposMiembrosEquipos(idTipoMiembro),
    FOREIGN KEY (idLeyenda) REFERENCES DatosLeyendas(idLeyenda),
    FOREIGN KEY (idPosicion) REFERENCES DatosPosiciones(idPosicion)
);

CREATE TABLE AccionesPartidos(
	idAccionPartido INT NOT NULL PRIMARY KEY,
	tiempoAccion TIME NOT NULL,
	idPartido INT NOT NULL,
	idTiempo INT NOT NULL,
	idTipoAccion INT NOT NULL,
	idMiembroJugador INT NOT NULL,
	FOREIGN KEY (idPartido) REFERENCES Partidos(idPartido),
	FOREIGN KEY (idTiempo) REFERENCES Tiempos(idTiempo),
	FOREIGN KEY (idTipoAccion) REFERENCES TiposAcciones(idTipoAccion),
	FOREIGN KEY (idMiembroJugador) REFERENCES MiembrosJugadores(idMiembroJugador)
);

CREATE TABLE AccionesConjuntas(
	idAccionPartidoPrincipal INT NOT NULL PRIMARY KEY,
	idAccionPartidoSecundaria INT NOT NULL,
	FOREIGN KEY (idAccionPartidoPrincipal) REFERENCES AccionesPartidos(idAccionPartido),
	FOREIGN KEY (idAccionPartidoSecundaria) REFERENCES AccionesPartidos(idAccionPartido)
);

--funciones--

--1
CREATE OR REPLACE FUNCTION AñosCarrera(añoInicio INT)
RETURNS INT
AS
$BODY$
       DECLARE
	   añosCarrera INT;
	   añoActual INT;
	   BEGIN
	         añoActual := EXTRACT(YEAR FROM NOW());
			 añosCarrera := añoActual - añoInicio;
			 return añosCarrera;
	   END;
$BODY$
language 'plpgsql';
--2
CREATE OR REPLACE FUNCTION GanadorPremio(nombrePremio VARCHAR(50))
RETURNS SETOF Miembros
AS
$BODY$
BEGIN
	  RETURN QUERY
	  SELECT DISTINCT nombre, apellido
	  FROM Miembros
	  WHERE idMiembro = (SELECT idMiembro
						 FROM TiposMiembrosEquipos
						 WHERE idTipoMiembro =(SELECT idTipoMiembro
											   FROM GanadoresPremios
											   WHERE idPremio = (SELECT idPremio
																 FROM Premios
																 WHERE nombre = nombrePremio)));
END
$BODY$
language 'plpgsql';
--3
CREATE OR REPLACE FUNCTION EquiposPabellones(nombreEquipo VARCHAR(50))
RETURNS SETOF RECORD
AS
$BODY$
BEGIN
      RETURN QUERY
	  SELECT DISTINCT Pabellones.nombre, añoInicio, añoFin
	  FROM Equipos 
	       JOIN EstadiaPabellones ON EstadiaPabellones.idEquipo = Equipos.idEquipo
		   JOIN Pabellones ON Pabellones.idPabellon = EstadiaPabellones.idPabellon
	  WHERE Equipos.nombre = nombreEquipo;
END
$BODY$
language 'plpgsql';
--4
CREATE OR REPLACE FUNCTION EquiposEnDivisionesYConferencias(division VARCHAR(50), conferencia VARCHAR(50))
RETURNS SETOF RECORD
AS
$BODY$
BEGIN
      RETURN QUERY
	  SELECT DISTINCT Equipos.nombre
	  FROM Equipos
	       JOIN EquiposConferencias ON EquiposConferencias.idEquipo = Equipos.idEquipo
		   JOIN Divisiones ON Divisiones.idDivision = EquiposConferencias.idDivision
		   JOIN Conferencias ON Conferencias.idConferencia = EquiposConferencias.idConferencia
	  WHERE division = Divisiones.nombre AND conferencia = Conferencias.nombre;
END
$BODY$
language 'plpgsql';
--5
CREATE OR REPLACE FUNCTION PartidosDeLocal(nombreEquipo VARCHAR(50))
RETURNS SETOF RECORD
AS
$BODY$
BEGIN
      RETURN QUERY
	  SELECT DISTINCT Pabellones.nombre, fecha, hora
	  FROM Pabellones
	       JOIN EstadiasPabellones ON EstadiasPabellones.idPabellon = Pabellones.idPabellon
		   JOIN Equipos ON Equipos.idEquipo = EstadiasPabellones.idEquipo
		   JOIN Partidos ON Partidos.idEquipoLocal = Equipos.idEquipo
	  WHERE Equipos.nombre = nombreEquipo;
END
$BODY$
language 'plpgsql';
--6
CREATE OR REPLACE FUNCTION PromAnotacionEnPartido(nombrePabellon varchar(50), fechaPartido date, horaPartido time)
RETURNS SETOF RECORD
AS
$BODY$
BEGIN
      RETURN QUERY
	  SELECT DISTINCT CONCAT(Miembros.nombre, ' ',Miembros.apellido) AS "Jugador",
	                  AVG(COUNT(AccionesPartidos.idAccionPartido)*3) AS "Promedio de puntos"
	  FROM Miembros
	       JOIN TiposMiembrosEquipos ON TiposMiembrosEquipos.idMiembro = Miembros.idMiembro
	       JOIN MiembrosJugadores ON MiembrosJugadores.idTipoMiembro = TiposMiembrosEquipos.idTipoMiembro
		   JOIN AccionesPartidos ON AccionesPartidos.idMiembroJugador = MiembrosJugadores.idMiembroJugador
		   JOIN TiposAcciones ON TiposAcciones.idTipoAccion = AccionesPartidos.idTipoAccion
		   JOIN Partidos ON Partidos.idPartido = AccionesPartidos.idPartido
		   JOIN Pabellones ON Pabellones.idPabellon = Partidos.idPabellon
	  WHERE nombrePabellon = Pabellones.nombre AND fechaPartido = Partidos.fecha 
	        AND horaPartido = Partidos.hora AND AccionesPartidos.nombre IN (1,3,5);
END
$BODY$
language 'plpgsql';
--7
CREATE OR REPLACE FUNCTION EquiposCampeones()
RETURNS SETOF RECORD
AS
$BODY$
BEGIN
      RETURN QUERY
	  SELECT DISTINCT Equipos.nombre, añoEdicion
	  FROM Equipos
	       JOIN CampeonesNBA ON CampeonesNBA.idEquipo = Equipos.idEquipo
		   JOIN EdicionesNBA ON EdicionesNBA.idEdicion = CampeonesNBA.idEdicion;
END
$BODY$
language 'plpgsql';
--8
CREATE OR REPLACE FUNCTION AlineacionesUsadasPorEquipo(nombreEquipo VARCHAR(50))
RETURNS SETOF RECORD
AS
$BODY$
BEGIN
      RETURN QUERY
	  SELECT DISTINCT Alineaciones.nombre, 
	                  fecha AS "Fecha del partido", 
	                  hora AS "Hora del Partido",
	                  Tiempos.nombre AS "Tiempo en el que se uso"
	  FROM Alineaciones
	       JOIN AlineacionesUsadas ON AlineacionesUsadas.idAlineacion = Alineaciones.idAlineacion
		   JOIN Equipos ON Equipos.idEquipo = AlineacionesUsadas.idEquipoUsuario
		   JOIN Tiempos ON Tiempos.idTiempo = AlineacionesUsadas.idTiempo
		   JOIN Partidos ON Partidos.idPartido = AlineacionesUsadas.idPartido
	  WHERE nombreEquipo = Equipos.nombre;
END
$BODY$
language 'plpgsql';
--9
CREATE OR REPLACE FUNCTION JugadoresLesionados(nombreEquipo VARCHAR(50))
RETURNS SETOF RECORD
AS
$BODY$
BEGIN
      RETURN QUERY
	  SELECT DISTINCT CONCAT(Miembros.nombre, ' ',Miembros.apellido) AS "Jugador Lesionado"
	  FROM Miembros
	       JOIN TiposMiembrosEquipos ON TiposMiembrosEquipos.idMiembro = Miembros.idMiembro
	       JOIN MiembrosJugadores ON MiembrosJugadores.idTipoMiembro = TiposMiembrosEquipos.idTipoMiembro
		   JOIN DatosLeyendas ON DatosLeyendas.idLeyenda = MiembrosJugadores.idLeyenda
	  WHERE DatosLeyendas.nombre = 'lesionado';
END
$BODY$
language 'plpgsql';
--10
CREATE OR REPLACE FUNCTION PromedioDePagoMiembro(nombreMiembro VARCHAR(50), apellidoMiembro VARCHAR(50))
RETURNS SETOF RECORD
AS
$BODY$
BEGIN
	  SELECT AVG(SalariosMiembros)
	  FROM Miembros
		   JOIN TiposMiembrosEquipos ON TiposMiembrosEquipos.idMiembro = Miembros.idMiembro
		   JOIN SalariosMiembros ON SalariosMiembros.idTipoMiembro = TiposMiembrosEquipos.idTipoMiembro
	  WHERE nombreMiembro = Miembros.nombre AND apellidoMiembro = Miembros.apellido;
END
$BODY$
language 'plpgsql';
--11
CREATE OR REPLACE FUNCTION ListaMiembros()
RETURNS SETOF RECORD
AS
$BODY$
BEGIN
      SELECT CONCAT(Miembros.nombre, ' ',Miembros.apellido) AS "Jugador",
	         DatosPosiciones.nombre AS "posicion"
	  FROM Miembros
	       JOIN TiposMiembrosEquipos ON TiposMiembrosEquipos.idMiembro = Miembros.idMiembro
	       JOIN MiembrosJugadores ON MiembrosJugadores.idTipoMiembro = TiposMiembrosEquipos.idTipoMiembro
		   JOIN DatosPosiciones ON DatosPosiciones.idPosicion;
END
$BODY$
language 'plpgsql';
--12
CREATE OR REPLACE FUNCTION FaltasJugador(nombreJugador VARCHAR(50), apellidoJugador VARCHAR(50))
RETURNS SETOF RECORD
AS
$BODY$
BEGIN
      SELECT DISTINCT COUNT(idAccionPartido)
	  FROM Miembros
	       JOIN TiposMiembrosEquipos ON TiposMiembrosEquipos.idMiembro = Miembros.idMiembro
	       JOIN MiembrosJugadores ON MiembrosJugadores.idTipoMiembro = TiposMiembrosEquipos.idTipoMiembro
		   JOIN AccionesPartidos ON AccionesPartidos.idMiembroJugador = MiembrosJugadores.idMiembroJugador
		   JOIN TiposAcciones ON TiposAcciones.idTipoAccion = AccionesPartidos.idTipoAccion
	  WHERE TiposAcciones.nombre = 'falta';
END
$BODY$
language 'plpgsql';

--Procesedimientos almacenados--

--1.

USE basketball;
DELIMITER //
CREATE PROCEDURE ALINEACIONES_CREADAS()
BEGIN
	SELECT alineaciones.nombre AS NOMBRE_ALINEACION, equipos.nombre as NOMBRE_EQUIPO 
	FROM alineaciones INNER JOIN equipos on equipos.idEquipo = alineaciones.idEquipoCreador = equipos.idEquipo;
END
//

--2. 
USE basketball;
DELIMITER //
CREATE PROCEDURE PERSON_REGISTRADAS()
BEGIN
	SELECT nombre, apellido, fechaNacimiento, nacionalidad FROM miembros;
END
//

--3.
 
USE basketball;
DELIMITER //
CREATE PROCEDURE JUGADORES_SALARIO_LIMITER()
BEGIN
    SELECT miembros.nombre as NOMBRE, miembros.apellido as APELLIDO, salariosmiembros.valor as SALARIO FROM salariosmiembros INNER JOIN tiposmiembrosequipos ON salariosmiembros.idTipoMiembro = tiposmiembrosequipos.idTipoMiembro INNER JOIN miembros ON tiposmiembrosequipos.idMiembro = miembros.idMiembro WHERE salariosmiembros.valor <=5000 and salariosmiembros.valor >= 2000;
END
//

--4. 

USE basketball;
DELIMITER //
CREATE PROCEDURE JUGADORES_POSICION_ALERO(
	IN _NAME VARCHAR(16)
)
BEGIN
    SELECT miembros.nombre as NOMBRE, miembros.apellido as APELLIDO FROM miembros 
    INNER JOIN tiposmiembrosequipos ON tiposmiembrosequipos.idMiembro = miembros.idMiembro 
    INNER JOIN miembrosjugadores on miembrosjugadores.idTipoMiembro = tiposmiembrosequipos.idMiembro 
    INNER JOIN datosposiciones on datosposiciones.idPosicion = miembrosjugadores.idPosicion WHERE datosposiciones.nombre = _NAME;
END
//

--5.

USE basketball;
DELIMITER //
CREATE LISTADO_TEMPORADAS()
BEGIN
    SELECT temporadas.nombre FROM `temporadas`;
END
//

--6. 

USE basketball
DELIMITER //
CREATE PROCEDURE INSERTAR_EQUIPOS(
	IN _NAME VARCHAR(30),
    IN _AÑO INT
)
BEGIN
    INSERT INTO equipos(nombre,añoFundacion) VALUES (_NAME,_AÑO);
END
//

--7. 

USE basketball
DELIMITER //
CREATE PROCEDURE ELIMINAR_CIUDAD(
    IN _ID INT
)
BEGIN
    DELETE FROM ciudades WHERE ciudades.idCiudad = _ID;
END
//

--8. 

USE basketball
DELIMITER //
CREATE PROCEDURE MODIFICAR_MIEMBROS(
    IN _NOMBRE VARCHAR (20),
    IN _APELLIDO VARCHAR (20),
    IN _NACIONALIDAD VARCHAR (20),
    IN _PESO DOUBLE,
    IN _FECHANAC DATE,
    IN _FECHAFALL DATE,
    IN _FECHARET DATE,
    IN _ID INT
)
BEGIN
    UPDATE miembros SET miembros.nombre = _NOMBRE, miembros.apellido = _APELLIDO,
    miembros.nacionalidad = _NACIONALIDAD, miembros.peso = _PESO, miembros.fechaNacimiento = _FECHANAC,
    miembros.fechaFallecimiento = _FECHAFALL, miembros.fechaRetiro = FECHARET
    WHERE miembros.idMiembro = _ID;
END
//

--9. 

USE basketball;
DELIMITER //
CREATE PROCEDURE MOSTRAR_ESTADOS_C()
BEGIN
    SELECT estados.nombre FROM estados WHERE estados.nombre LIKE 'C%';
END
//

--10. 

USE basketball;
DELIMITER //
CREATE PROCEDURE JUGADORES_LESIONADOS(
   IN nombreEquipo VARCHAR(50)
)
BEGIN
    SELECT DISTINCT CONCAT(Miembros.nombre, ' ',Miembros.apellido) AS "Jugador Lesionado"
	  FROM Miembros
	       JOIN TiposMiembrosEquipos ON TiposMiembrosEquipos.idMiembro = Miembros.idMiembro
	       JOIN MiembrosJugadores ON MiembrosJugadores.idTipoMiembro = TiposMiembrosEquipos.idTipoMiembro
		   JOIN DatosLeyendas ON DatosLeyendas.idLeyenda = MiembrosJugadores.idLeyenda
	  WHERE DatosLeyendas.nombre = 'lesionado';
END
//

--11.

USE basketball;
DELIMITER //
CREATE PROCEDURE ALINEACIONES_USADAS_POREQUIPO(
   IN nombreEquipo VARCHAR(50)
)
BEGIN
	  SELECT DISTINCT Alineaciones.nombre, 
	                  fecha AS "Fecha del partido", 
	                  hora AS "Hora del Partido",
	                  Tiempos.nombre AS "Tiempo en el que se uso"
	  FROM Alineaciones
	       JOIN AlineacionesUsadas ON AlineacionesUsadas.idAlineacion = Alineaciones.idAlineacion
		   JOIN Equipos ON Equipos.idEquipo = AlineacionesUsadas.idEquipoUsuario
		   JOIN Tiempos ON Tiempos.idTiempo = AlineacionesUsadas.idTiempo
		   JOIN Partidos ON Partidos.idPartido = AlineacionesUsadas.idPartido
	  WHERE nombreEquipo = Equipos.nombre;
END
//

--12.

USE basketball;
DELIMITER //
CREATE PROCEDURE FALTAS_JUGADOR(
	IN nombreJugador VARCHAR(50),
    IN apellidoJugador VARCHAR(50)
)
BEGIN
      SELECT DISTINCT COUNT(idAccionPartido)
	  FROM Miembros
	       JOIN TiposMiembrosEquipos ON TiposMiembrosEquipos.idMiembro = Miembros.idMiembro
	       JOIN MiembrosJugadores ON MiembrosJugadores.idTipoMiembro = TiposMiembrosEquipos.idTipoMiembro
		   JOIN AccionesPartidos ON AccionesPartidos.idMiembroJugador = MiembrosJugadores.idMiembroJugador
		   JOIN TiposAcciones ON TiposAcciones.idTipoAccion = AccionesPartidos.idTipoAccion
	  WHERE TiposAcciones.nombre = 'falta';
END
//
1. ACTUALIZAR TABLA MIEMBROS

INSERT INTO miembros VALUES ('101','Jay2len','Brown','24/10/1996',NULL,NULL,'1.98','Estadounidense','1012');

select * from miembros
select * from t_miembros

CREATE FUNCTION SP_Miembros() returns trigger
as
$$
Begin
 	INSERT INTO "t_miembros" values(old.idmiembro,old.nombre,old.apellido,old.fechanacimiento,
								   old.fechafallecimiento,old.fecharetiro,old.estatura,
								   old.nacionalidad,old.peso);
return new;
End
$$
Language plpgsql;


CREATE TRIGGER T_UpdateMiembro
BEFORE UPDATE ON miembros
FOR EACH ROW
	 SP_Miembros();

UPDATE miembros set 
idmiembro = '123' where idmiembro = '101'

INSERT INTO miembros VALUES ('1','Jay2len','Brown','24/10/1996',NULL,NULL,'1.98','Estadounidense','1012');




2. INSERTAR EN DATOSCARGOS

INSERT INTO datoscargos VALUES('455','Entrenador');

SELECT * FROM datoscargos;
SELECT * FROM t_datoscargos;

CREATE FUNCTION f_Insert_datoscargos() returns trigger
as
$$
Begin
 	INSERT INTO "t_datoscargos" values(new.idcargo,new.nombre);
return new;
End
$$
Language plpgsql;

CREATE TRIGGER TR_INSERT AFTER INSERT ON datoscargos
FOR EACH ROW
EXECUTE PROCEDURE f_Insert_datoscargos();


3. MODIFICAR EQUIPOS



SELECT * FROM equipos;
SELECT * FROM t_equipos;


CREATE OR REPLACE FUNCTION Actualizar_equipos() returns trigger
as
$$
Begin
 	INSERT INTO "t_equipos" values(old.idequipo,old.nombre,old.añofunda);
return new;
End
$$
Language plpgsql;



CREATE TRIGGER TR_UPDATE_EQUIPOS BEFORE UPDATE ON equipos
FOR EACH ROW EXECUTE PROCEDURE Actualizar_equipos();

UPDATE equipos set nombre = 'PEDRO' where idequipo = 144


4. AGREGAR UN NUEVO ESTADO CUANDO SE ACTUALICE EL ANTERIOR

CREATE OR REPLACE FUNCTION f_UPDATE_ESTADOS() returns trigger
as
$$
BEGIN 
   INSERT INTO t_estados VALUES(old.idestado,CONCAT(old.nombre,'_K',old.idestado));
   RETURN new;
END
$$
Language plpgsql;


CREATE TRIGGER trigger_estados_identificador
AFTER UPDATE ON estados
FOR EACH ROW EXECUTE PROCEDURE f_UPDATE_ESTADOS()


select * from estados;
INSERT INTO estados values('123','Juan2')
Update estados set idestado = '235' where idestado='25'


5. MOSTRAR MENSAJE CUANDO SE MODIFIQUE UNA CIUDAD




CREATE OR REPLACE FUNCTION f_UPDATE_CIUDAD() returns trigger
as
$$
BEGIN 
  RAISE NOTICE ' Se ha modificado una ciudad de los miembros.';
   RETURN new;
END
$$
Language plpgsql;


CREATE TRIGGER trigger_update_ciudades
AFTER UPDATE ON ciudades
FOR EACH ROW EXECUTE PROCEDURE f_UPDATE_CIUDAD()



update ciudades set nombre = 'Meridita' where idciudad = '1'

select * from ciudades;
INSERT INTO ciudades values('1','25','Merida');
select* from estados;



6. MOSTRAR MENSAJE CUANDO SE INSERTE UNA CONFERENCIA


CREATE OR REPLACE FUNCTION f_INSERT_CONFERENCIA() returns trigger as
$$
BEGIN 
  RAISE NOTICE ' Se ha AGREGADO una nueva conferencia.';
   RETURN new;
END
$$
Language plpgsql;


CREATE TRIGGER tr_insert_conferencia
AFTER INSERT ON conferencias
FOR EACH ROW EXECUTE PROCEDURE f_INSERT_CONFERENCIA()


INSERT INTO conferencias values('3','Esta es una nueva conferencia');



7. MOSTRAR MENSAJE DE CAMBIAR NOMBRE DE CONFERENCIA


CREATE OR REPLACE FUNCTION f_UPDATE_CONFERENCIA() returns trigger as
$$
BEGIN 
	 IF NEW.nombre <> OLD.nombre THEN
	 RAISE NOTICE 'Cambiando';
	 RETURN NEW;
	END IF;
	 RAISE NOTICE 'no se puede cambiar';
	RETURN NULL;
   RETURN new;
END;
$$
Language plpgsql;


CREATE TRIGGER tr_Update_conferencia
BEFORE UPDATE ON conferencias
FOR EACH ROW EXECUTE PROCEDURE f_UPDATE_CONFERENCIA()


INSERT INTO conferencias values('3','Esta es una nueva conferencia');
UPDATE conferencias SET nombre = 'Esta es una nueva conferencia' where idconferencia = '1';

SELECT * FROM conferencias;


8. DICE SI ES EL PRIMER EQUIPO AGG O NO


CREATE OR REPLACE FUNCTION f_mostarEquipos() returns trigger as
$$
DECLARE
cantidad INT :=0;
BEGIN 
	Select COUNT (*) INTO cantidad from equipos;
	 IF cantidad>2 THEN
		 RAISE NOTICE 'Hay mas de 2 equipos agregados';
		 RETURN NEW;
	END IF;
	
	RAISE NOTICE 'Se agrego el primer equipo';
	RETURN NULL;
	
END;
$$
Language plpgsql;


CREATE TRIGGER tr_Insert_Equipos_
BEFORE INSERT ON equipos
FOR EACH ROW EXECUTE PROCEDURE f_mostarEquipos();

SELECT * FROM equipos;
INSERT INTO equipos values('2','Los Ganadores','2222');






9. MOSTRAR MENSAJE CUANDO SE QUIERA INSERTAR EL NOMBRE DE LA CIUDAD Y ESTA YA SE ENCUENTRA REGISTRADA



CREATE OR REPLACE FUNCTION f_InsertNewTemporada() returns trigger as
$$
DECLARE
temporada VARCHAR(20);
BEGIN 
	SELECT nombre INTO temporada from temporadas where idtemporada = old.idtemporada;
	 
	 IF old.nombre <> temporada THEN
	 	RAISE NOTICE 'Insentando nueva temporada';
	 	RETURN NEW;
	END IF;
	
	RAISE NOTICE 'Ya se encuentra una temporada con ese nombre';
	RETURN NULL;
	
END;
$$
Language plpgsql;


CREATE TRIGGER tr_InsertNewTemporada
AFTER INSERT ON temporadas
FOR EACH ROW EXECUTE PROCEDURE f_InsertNewTemporada();


SELECT * FROM temporadas;
INSERT INTO temporadas values('6','Temporada 1');





10.MOSTRAR MENSAJE CUANDO SE ELIMINE UNA CIUDAD


CREATE OR REPLACE FUNCTION f_EliminarCiudad() returns trigger as
$$
BEGIN 
	 RAISE NOTICE 'Se ha eliminado una Ciudad';
   RETURN new;
END;
$$
Language plpgsql;


CREATE TRIGGER tr_DeleteCiudad
BEFORE DELETE ON ciudades
FOR EACH ROW EXECUTE PROCEDURE f_EliminarCiudad()

DELETE FROM ciudades where idciudad='1'; 
Select * from ciudades 




11. CONTROL DE ESTADOS


CREATE OR REPLACE FUNCTION f_controlEstadoss() RETURNS trigger as
$$
DECLARE
cantidad INT := 0;
BEGIN
	SELECT COUNT(*) INTO cantidad FROM estados
	WHERE estados.idestado = NEW.idestado;
	
	IF cantidad < 100 THEN
	 RAISE NOTICE 'insertando estado';
	 RETURN NEW;
	END IF;
	
	RAISE NOTICE 'no se puede insertar estado, ya se cumplio el limite';
	RETURN NULL;
END;
$$
LANGUAGE 'plpgsql';


CREATE TRIGGER tr_ControlEstados
BEFORE INSERT ON estados
FOR EACH ROW EXECUTE PROCEDURE f_controlEstadoss();

INSERT INTO estados values('123','NuevoEstado');
Select * from estados; 





12. ELIMINAR CONFERENCIA Y MOSTRAR CUAL SE ELIMINO.




CREATE OR REPLACE FUNCTION f_ElimConferencia() returns trigger as
$$
BEGIN 
	 RAISE NOTICE 'Se ha eliminado la conferencia con el nombre de: %',old.nombre;
   RETURN old;
END;
$$
Language plpgsql;


CREATE TRIGGER tr_ElimConferencia
BEFORE DELETE ON conferencias
FOR EACH ROW EXECUTE PROCEDURE f_ElimConferencia()

Select * from conferencias 
DELETE FROM conferencias where idconferencia = '2'
CREATE VIEW datosÚltimosPartidos 
AS SELECT DISTINCT fecha,hora,Equiposlocales,FundaciónLocales,EquiposVisitantes,FundaciónVisitantes,nombrepabellón
FROM partidos
INNER JOIN (SELECT idequipo,equipos.nombre AS EquiposLocales, añofundación AS FundaciónLocales,pabellones.nombre AS NombrePabellón
			FROM partidos 
			INNER JOIN equipos ON partidos.idequipolocal = equipos.idequipo or partidos.idequipovisitante = equipos.idequipo
			INNER JOIN pabellones ON pabellones.idpabellon = partidos.idpabellon
			ORDER BY fecha,hora ASC) AS NombresEquiposLocales
ON partidos.idequipolocal = NombresEquiposLocales.idequipo
INNER JOIN (SELECT idequipo,equipos.nombre AS EquiposVisitantes,añofundación AS FundaciónVisitantes
			FROM partidos 
			INNER JOIN equipos ON partidos.idequipolocal = equipos.idequipo or partidos.idequipovisitante = equipos.idequipo
			INNER JOIN pabellones ON pabellones.idpabellon = partidos.idpabellon
			ORDER BY fecha,hora ASC) AS NombresEquiposVisitantes
ON partidos.idequipovisitante = NombresEquiposVisitantes.idequipo	
ORDER BY FECHA,HORA
LIMIT 3

-----------------------------------------------------------------------------------------------------------------------

CREATE VIEW TiempoEquiposPabellones
AS
SELECT equipos.nombre AS Equipos, pabellones.nombre AS Pabellones, añoinicio,añofin
		FROM estadiapabellones
		INNER JOIN pabellones ON estadiapabellones.idpabellon = pabellones.idpabellon
		INNER JOIN equipos ON estadiapabellones.idequipo = equipos.idequipo


---------------------------------------------------------------------------------------------------------------------

CREATE VIEW JugadoresPremiados
AS
SELECT datosposiciones.nombre AS Posición,miembrosjugadores.numerodorsal AS NúmeroDorsal, equipos.nombre AS Equipo,
miembros.nombre,miembros.apellido
	FROM ganadorespremios
	INNER JOIN tiposmiembrosequipos
	ON tiposmiembrosequipos.idtipomiembro = ganadorespremios.idtipomiembro
	INNER JOIN miembrosjugadores
	ON miembrosjugadores.idtipomiembro = ganadorespremios.idtipomiembro
	INNER JOIN datosposiciones
	ON datosposiciones.idposicion = miembrosjugadores.idposicion
	INNER JOIN equipos
	ON equipos.idequipo = tiposmiembrosequipos.idequipo
	INNER JOIN miembros
	ON miembros.idmiembro = tiposmiembrosequipos.idmiembro

-----------------------------------------------------------------------------------------

CREATE VIEW InfoCapitanesCampeones
AS
SELECT equipos.nombre AS Equipos, miembros.nombre,miembros.apellido,tiposmiembrosequipos.fechainiciocontrato,
edicionesnba.añoedicion
	FROM equipos
	INNER JOIN tiposmiembrosequipos
	ON tiposmiembrosequipos.idequipo = equipos.idequipo
	INNER JOIN campeonesnba
	ON campeonesnba.idequipo = equipos.idequipo
	INNER JOIN edicionesnba
	ON edicionesnba.idedicion = campeonesnba.idedicion
	INNER JOIN miembros
	ON miembros.idmiembro = tiposmiembrosequipos.idmiembro
WHERE idcargo = '444'

------------------------------------------------------------------------------------

CREATE VIEW JugadoresAleros
AS
SELECT miembros.nombre,miembros.apellido
	FROM tiposmiembrosequipos
	INNER JOIN miembros
	ON miembros.idmiembro = tiposmiembrosequipos.idmiembro
	INNER JOIN miembrosjugadores
	ON miembrosjugadores.idtipomiembro = tiposmiembrosequipos.idtipomiembro
WHERE miembrosjugadores.idposicion = '5'

------------------------------------------------------------------------------------------

CREATE VIEW GanadoresMVP
AS
SELECT miembros.nombre,miembros.apellido,datosposiciones.nombre AS Posicion,miembrosjugadores.numerodorsal AS NumeroDorsal,
equipos.nombre AS Equipos
	FROM miembros
	INNER JOIN tiposmiembrosequipos
	ON miembros.idmiembro = tiposmiembrosequipos.idmiembro
	INNER JOIN miembrosjugadores
	ON miembrosjugadores.idtipomiembro = tiposmiembrosequipos.idtipomiembro
	INNER JOIN equipos
	ON equipos.idequipo = tiposmiembrosequipos.idequipo
	INNER JOIN ganadorespremios
	ON ganadorespremios.idtipomiembro = tiposmiembrosequipos.idtipomiembro
	INNER JOIN datosposiciones
	ON datosposiciones.idposicion = miembrosjugadores.idposicion
WHERE ganadorespremios.idpremio = '5'

-----------------------------------------------------------------

CREATE VIEW TotalAsistentes
AS
SELECT miembros.nombre,miembros.apellido,miembros.fechanacimiento,equipos.nombre AS Equipos
FROM miembros
INNER JOIN tiposmiembrosequipos
ON miembros.idmiembro = tiposmiembrosequipos.idmiembro
INNER JOIN equipos
ON equipos.idequipo = tiposmiembrosequipos.idequipo
WHERE tiposmiembrosequipos.idcargo = '222'
