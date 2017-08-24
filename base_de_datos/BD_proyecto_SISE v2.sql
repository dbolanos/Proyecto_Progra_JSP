-- DROP DATABASE BD_proyecto_SISE;

CREATE DATABASE BD_proyecto_SISE
ON PRIMARY
  (NAME = 'BD_proyecto_SISE',
  FILENAME = 'C:\BD\BD_proyecto_SISE.mdf',
  SIZE = 10500 KB,
  MAXSIZE = UNLIMITED,
  FILEGROWTH = 1024 KB)
LOG ON
  (NAME = 'BD_proyecto_SISELog',
  FILENAME = 'C:\BD\BD_proyecto_SISE.ldf',
  SIZE = 5536 KB,
  MAXSIZE = 2048 GB,
  FILEGROWTH = 10%)
GO


/* Drop Table */
USE BD_proyecto_SISE;

-- DROP TABLE detalles_factura;
-- DROP TABLE facturas;
-- DROP TABLE orden_servicios;
-- DROP TABLE ordenes;
-- DROP TABLE servicios;
-- DROP TABLE tipos_servicio;
-- DROP TABLE cliente_telefonos;
-- DROP TABLE tipos_telefono;
-- DROP TABLE clientes;
-- DROP TABLE distritos
-- DROP TABLE cantones;
-- DROP TABLE provincias;
-- DROP TABLE roles_usuarios;
-- DROP TABLE usuarios;
-- DROP TABLE roles;


/* Tablas */
USE BD_proyecto_SISE;

CREATE TABLE usuarios (
  id             INT IDENTITY (500, 2) NOT NULL,
  nombre         VARCHAR(160),
  apellido       VARCHAR(160),
  nombre_usuario VARCHAR(160),
  email          VARCHAR(250),
  contrasenna    VARCHAR(500),
  activo         INT,
);
ALTER TABLE usuarios
  ADD CONSTRAINT PK_usuarios PRIMARY KEY (id);

CREATE TABLE roles (
  id          INT IDENTITY (1, 5) NOT NULL,
  nombre      VARCHAR(150)        NOT NULL,
  descripcion VARCHAR(150)        NOT NULL,
  activo      INT,
);
ALTER TABLE roles
  ADD CONSTRAINT PK_roles PRIMARY KEY (id);

CREATE TABLE roles_usuarios (
  id_usuario INT NOT NULL,
  id_rol     INT NOT NULL,
  activo     INT,
);
ALTER TABLE roles_usuarios
  ADD CONSTRAINT PK_roles_usuarios PRIMARY KEY (id_usuario, id_rol);
ALTER TABLE roles_usuarios
  ADD CONSTRAINT FK_roles_usuarios_usuarios
FOREIGN KEY (id_usuario) REFERENCES usuarios (id);
ALTER TABLE roles_usuarios
  ADD CONSTRAINT FK_roles_usuarios_roles
FOREIGN KEY (id_rol) REFERENCES roles (id);

CREATE TABLE provincias (
  id     INT NOT NULL,
  nombre VARCHAR(150),
);
ALTER TABLE provincias
  ADD CONSTRAINT PK_provincias PRIMARY KEY (id);

CREATE TABLE cantones (
  id           INT NOT NULL,
  id_provincia INT NOT NULL,
  nombre       VARCHAR(150)
);
ALTER TABLE cantones
  ADD CONSTRAINT PK_cantones PRIMARY KEY (id);
ALTER TABLE cantones
  ADD CONSTRAINT FK_cantones_provincias
FOREIGN KEY (id_provincia) REFERENCES provincias (id);

CREATE TABLE distritos (
  id        INT NOT NULL,
  id_canton INT NOT NULL,
  nombre    VARCHAR(150),
);
ALTER TABLE distritos
  ADD CONSTRAINT PK_distritos PRIMARY KEY (id);
ALTER TABLE distritos
  ADD CONSTRAINT FK_distritos_cantones
FOREIGN KEY (id_canton) REFERENCES cantones (id);


CREATE TABLE tipos_telefono (
  id          INT IDENTITY (1, 1) NOT NULL,
  descripcion VARCHAR(150),
);
ALTER TABLE tipos_telefono
  ADD CONSTRAINT PK_tipos_telefono PRIMARY KEY (id);


CREATE TABLE clientes (
  id                  INT IDENTITY (10000, 5) NOT NULL,
  nombre              VARCHAR(150)            NOT NULL,
  provincia           VARCHAR(150),
  canton              VARCHAR(150),
  distrito            VARCHAR(150),
  barrio              VARCHAR(150),
  otras_sennas        VARCHAR(150),
  email               VARCHAR(230),
  descuento           DECIMAL(12, 3),
  id_usuario_registra INT                     NOT NULL,
  telefono            VARCHAR(12)             NOT NULL,
  id_tipo_telefono    INT                     NOT NULL,
  fecha_registra      DATE                    NOT NULL,
  id_usuario_edita    INT                     NOT NULL,
  fecha_edita         DATE                    NOT NULL,
  activo              INT,
);
ALTER TABLE clientes
  ADD CONSTRAINT PK_clientes PRIMARY KEY (id);
ALTER TABLE clientes
  ADD CONSTRAINT FK_clientes_tipos_telefono
FOREIGN KEY (id_tipo_telefono) REFERENCES tipos_telefono (id);
-- ALTER TABLE clientes
--   ADD CONSTRAINT FK_clientes_usuarios_registra
-- FOREIGN KEY (id_usuario_registra) REFERENCES usuarios (id);
-- ALTER TABLE clientes
--   ADD CONSTRAINT FK_clientes_usuarios_edita
-- FOREIGN KEY (id_usuario_edita) REFERENCES usuarios (id);


-- CREATE TABLE cliente_telefonos (
--   id_cliente       INT         NOT NULL,
--   id_tipo_telefono INT         NOT NULL,
--   telefono         VARCHAR(15) NOT NULL
-- );
/*ALTER TABLE cliente_telefonos
  ADD CONSTRAINT PK_clientes_telefonos PRIMARY KEY (id_cliente, telefono);
ALTER TABLE cliente_telefonos
  ADD CONSTRAINT FK_clientes_telefonos_clientes
FOREIGN KEY (id_cliente) REFERENCES clientes (id);
ALTER TABLE cliente_telefonos*/


CREATE TABLE tipos_servicio (
  id          INT IDENTITY (1, 1) NOT NULL,
  descripcion VARCHAR(150),
  activo      INT,
);
ALTER TABLE tipos_servicio
  ADD CONSTRAINT PK_tipos_servicio PRIMARY KEY (id);

CREATE TABLE servicios (
  id                  INT IDENTITY (100, 1) NOT NULL,
  descripcion         VARCHAR(200)          NOT NULL,
  precio_hora         DECIMAL(12, 2)        NOT NULL,
  activo              INT,
  id_tipo_servicio    INT                   NOT NULL,
  id_usuario_registra INT                   NOT NULL,
  fecha_registra      DATE                  NOT NULL,
  id_usuario_edita    INT                   NOT NULL,
  fecha_edita         DATE                  NOT NULL
);
ALTER TABLE servicios
  ADD CONSTRAINT PK_servicios PRIMARY KEY (id);
ALTER TABLE servicios
  ADD CONSTRAINT FK_servicios_tipos_servicio
FOREIGN KEY (id_tipo_servicio) REFERENCES tipos_servicio (id);
-- ALTER TABLE servicios
--   ADD CONSTRAINT FK_servicios_usuarios_registra
-- FOREIGN KEY (id_usuario_registra) REFERENCES usuarios (id);
-- ALTER TABLE servicios
--   ADD CONSTRAINT FK_servicios_usuarios_edita
-- FOREIGN KEY (id_usuario_edita) REFERENCES usuarios (id);

CREATE TABLE ordenes (
  id                           INT IDENTITY (1000, 1) NOT NULL,
  fecha_ejecucion              DATE                   NOT NULL,
  id_cliente                   INT                    NOT NULL,
  id_servicio                  INT                    NOT NULL,
  estimacion_horas_duracion    DECIMAL(5, 2)          NOT NULL,
  lugar_servicio               VARCHAR(150)           NOT NULL,
  id_distrito                  INT                    NOT NULL,
  otras_sennas                 VARCHAR(150),
  detalle_servicio             VARCHAR(250),
  costos_variables_descripcion VARCHAR(150),
  costos_variables_monto       DECIMAL(12, 2),
  estado                       VARCHAR(60),
  id_usuario_registra          INT                    NOT NULL,
  fecha_registra               DATE                   NOT NULL,
  id_usuario_edita             INT                    NOT NULL,
  fecha_edita                  DATE                   NOT NULL
);
ALTER TABLE ordenes
  ADD CONSTRAINT PK_ordenes PRIMARY KEY (id);
ALTER TABLE ordenes
  ADD CONSTRAINT FK_ordenes_clientes
FOREIGN KEY (id_cliente) REFERENCES clientes (id);
ALTER TABLE ordenes
  ADD CONSTRAINT FK_ordenes_servicios
FOREIGN KEY (id_servicio) REFERENCES servicios (id);
-- ALTER TABLE ordenes
--   ADD CONSTRAINT FK_ordeness_usuarios_registra
-- FOREIGN KEY (id_usuario_registra) REFERENCES usuarios (id);
-- ALTER TABLE ordenes
--   ADD CONSTRAINT FK_ordenes_usuarios_edita
-- FOREIGN KEY (id_usuario_edita) REFERENCES usuarios (id);

CREATE TABLE facturas (
  id                  INT IDENTITY (2000000, 1) NOT NULL,
  id_orden            INT                       NOT NULL,
  fecha               DATE                      NOT NULL,
  sub_total           DECIMAL(12, 2),
  monto_descuento     DECIMAL(12, 2),
  total               DECIMAL(12, 2),
  id_usuario_registra INT                       NOT NULL,
  fecha_registra      DATE                      NOT NULL,
  id_usuario_edita    INT                       NOT NULL,
  fecha_edita         DATE                      NOT NULL
);
ALTER TABLE facturas
  ADD CONSTRAINT PK_facturas PRIMARY KEY (id);
ALTER TABLE facturas
  ADD CONSTRAINT FK_facturas_ordenes
FOREIGN KEY (id_orden) REFERENCES ordenes (id);
-- ALTER TABLE facturas
--   ADD CONSTRAINT FK_facturas_usuarios_registra
-- FOREIGN KEY (id_usuario_registra) REFERENCES usuarios (id);
-- ALTER TABLE facturas
--   ADD CONSTRAINT FK_facturas_usuarios_edita
-- FOREIGN KEY (id_usuario_edita) REFERENCES usuarios (id);

/* Inserts */
INSERT INTO roles (nombre, descripcion) VALUES ('Administrador', 'Acceso a todo');
INSERT INTO roles (nombre, descripcion) VALUES ('Facturacion', 'Solo acceso a la factura');
INSERT INTO roles (nombre, descripcion) VALUES ('Encargado de Ordenes', 'Solo reportes');

INSERT INTO usuarios (nombre, apellido, nombre_usuario, email, contrasenna)
VALUES ('Cesar', 'Perez', 'cperez', 'cesarcucr@gmail.com', '123456');
INSERT INTO usuarios (nombre, apellido, nombre_usuario, email, contrasenna)
VALUES ('Dylan', 'Bolaños', 'dbolanos', 'dbolanos@gmail.com', '123456');

INSERT INTO roles_usuarios (id_usuario, id_rol) VALUES (500, 1);
INSERT INTO roles_usuarios (id_usuario, id_rol) VALUES (500, 6);
INSERT INTO roles_usuarios (id_usuario, id_rol) VALUES (500, 11);
INSERT INTO roles_usuarios (id_usuario, id_rol) VALUES (502, 1);
INSERT INTO roles_usuarios (id_usuario, id_rol) VALUES (502, 6);
INSERT INTO roles_usuarios (id_usuario, id_rol) VALUES (502, 11);

/* TTipo_Telefono */
INSERT INTO tipos_telefono (descripcion)
VALUES ('Empresarial');

INSERT INTO tipos_telefono (descripcion)
VALUES ('Celular');

INSERT INTO tipos_telefono (descripcion)
VALUES ('Linea de Casa');

/* TTipos_Servicios */
INSERT INTO tipos_servicio (descripcion)
VALUES ('Financiero');

INSERT INTO tipos_servicio (descripcion)
VALUES ('Tecnico');

INSERT INTO tipos_servicio (descripcion)
VALUES ('Construccion');

INSERT INTO tipos_servicio (descripcion)
VALUES ('Mecanico');

INSERT INTO tipos_servicio (descripcion)
VALUES ('Reclutamiento');

INSERT INTO provincias (id, nombre) VALUES ('1', 'San José');
INSERT INTO provincias (id, nombre) VALUES ('2', 'Alajuela');
INSERT INTO provincias (id, nombre) VALUES ('3', 'Cartago');
INSERT INTO provincias (id, nombre) VALUES ('4', 'Heredia');
INSERT INTO provincias (id, nombre) VALUES ('5', 'Guancaste');
INSERT INTO provincias (id, nombre) VALUES ('6', 'Puntarenas');
INSERT INTO provincias (id, nombre) VALUES ('7', 'Limón');

INSERT INTO cantones (id, id_provincia, nombre) VALUES ('101', '1', 'San José');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('102', '1', 'Escazú');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('103', '1', 'Desamparados');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('104', '1', 'Puriscal');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('105', '1', 'Tarrazú');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('106', '1', 'Aserrí');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('107', '1', 'Mora');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('108', '1', 'Goicoechea');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('109', '1', 'Santa Ana');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('110', '1', 'Alajuelita');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('111', '1', 'Vázquez de Coronado');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('112', '1', 'Acosta');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('113', '1', 'Tibás');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('114', '1', 'Moravia');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('115', '1', 'Montes de Oca');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('116', '1', 'Turrubares');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('117', '1', 'Dota');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('118', '1', 'Curridabat');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('119', '1', 'Pérez Zeledón');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('120', '1', 'León Cortés Castro');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('201', '2', 'Alajuela');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('202', '2', 'San Ramón');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('203', '2', 'Grecia');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('204', '2', 'San Mateo');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('205', '2', 'Atenas');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('206', '2', 'Naranjo');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('207', '2', 'Palmares');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('208', '2', 'Poás');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('209', '2', 'Orotina');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('210', '2', 'San Carlos');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('211', '2', 'Zarcero');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('212', '2', 'Valverde Vega');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('213', '2', 'Upala');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('214', '2', 'Los Chiles');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('215', '2', 'Guatuso');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('301', '3', 'Cartago');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('302', '3', 'Paraíso');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('303', '3', 'La Unión');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('304', '3', 'Jiménez');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('305', '3', 'Turrialba');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('306', '3', 'Alvarado');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('307', '3', 'Oreamuno');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('308', '3', 'El Guarco');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('401', '4', 'Heredia');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('402', '4', 'Barva');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('403', '4', 'Santo Domingo');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('404', '4', 'Santa Bárbara');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('405', '4', 'San Rafael');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('406', '4', 'San Isidro');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('407', '4', 'Belén');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('408', '4', 'Flores');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('409', '4', 'San Pablo');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('410', '4', 'Sarapiquí');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('501', '5', 'Liberia');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('502', '5', 'Nicoya');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('503', '5', 'Santa Cruz');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('504', '5', 'Bagaces');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('505', '5', 'Carrillo');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('506', '5', 'Cañas');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('507', '5', 'Abangares');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('508', '5', 'Tilarán');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('509', '5', 'Nandayure');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('510', '5', 'La Cruz');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('511', '5', 'Hojancha');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('601', '6', 'Puntarenas');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('602', '6', 'Esparza');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('603', '6', 'Buenos Aires');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('604', '6', 'Montes de Oro');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('605', '6', 'Osa');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('606', '6', 'Quepos');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('607', '6', 'Golfito');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('608', '6', 'Coto Brus');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('609', '6', 'Parrita');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('610', '6', 'Corredores');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('611', '6', 'Garabito');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('701', '7', 'Limón');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('702', '7', 'Pococí');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('703', '7', 'Siquirres');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('704', '7', 'Talamanca');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('705', '7', 'Matina');
INSERT INTO cantones (id, id_provincia, nombre) VALUES ('706', '7', 'Guácimo');


INSERT INTO distritos (id, id_canton, nombre) VALUES ('10101', '101', 'Carmen');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10102', '101', 'Merced');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10103', '101', 'Hospital');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10104', '101', 'Catedral');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10105', '101', 'Zapote');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10106', '101', 'San Francisco de Dos Ríos');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10107', '101', 'Uruca');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10108', '101', 'Mata Redonda');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10109', '101', 'Pavas');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10110', '101', 'Hatillo');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10111', '101', 'San Sebastián');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10201', '102', 'Escazú');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10202', '102', 'San Antonio');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10203', '102', 'San Rafael');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10301', '103', 'Desamparados');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10302', '103', 'San Miguel');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10303', '103', 'San Juan de Dios');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10304', '103', 'San Rafael Arriba');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10305', '103', 'San Antonio');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10306', '103', 'Frailes');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10307', '103', 'Patarrá');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10308', '103', 'San Cristóbal');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10309', '103', 'Rosario');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10310', '103', 'Damas');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10311', '103', 'San Rafael Abajo');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10312', '103', 'Gravilias');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10313', '103', 'Los Guido');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10401', '104', 'Santiago');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10402', '104', 'Mercedes Sur');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10403', '104', 'Barbacoas');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10404', '104', 'Grifo Alto');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10405', '104', 'San Rafael');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10406', '104', 'Candelarita');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10407', '104', 'Desamparaditos');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10408', '104', 'San Antonio');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10409', '104', 'Chires');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10501', '105', 'San Marcos');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10502', '105', 'San Lorenzo');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10503', '105', 'San Carlos');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10601', '106', 'Aserrí');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10602', '106', 'Tarbaca');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10603', '106', 'Vuelta de Jorco');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10604', '106', 'San Gabriel');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10605', '106', 'Legua');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10606', '106', 'Monterrey');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10607', '106', 'Salitrillos');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10701', '107', 'Colón');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10702', '107', 'Guayabo');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10703', '107', 'Tabarcia');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10704', '107', 'Piedras Negras');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10705', '107', 'Picagres');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10706', '107', 'Jaris');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10801', '108', 'Guadalupe');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10802', '108', 'San Francisco');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10803', '108', 'Calle Blancos');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10804', '108', 'Mata de Plátano');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10805', '108', 'Ipís');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10806', '108', 'Rancho Redondo');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10807', '108', 'Purral');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10901', '109', 'Santa Ana');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10902', '109', 'Salitral');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10903', '109', 'Pozos');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10904', '109', 'Uruca');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10905', '109', 'Piedades');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('10906', '109', 'Brasil');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11001', '110', 'Alajuelita');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11002', '110', 'San Josecito');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11003', '110', 'San Antonio');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11004', '110', 'Concepción');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11005', '110', 'San Felipe');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11101', '111', 'San Isidro');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11102', '111', 'San Rafael');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11103', '111', 'Dulce Nombre de Jesús');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11104', '111', 'Patalillo');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11105', '111', 'Cascajal');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11201', '112', 'San Ignacio');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11202', '112', 'Guaitil');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11203', '112', 'Palmichal');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11204', '112', 'Cangrejal');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11205', '112', 'Sabanillas');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11301', '113', 'San Juan');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11302', '113', 'Cinco Esquinas');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11303', '113', 'Anselmo Llorente');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11304', '113', 'León XIII');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11305', '113', 'Colima');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11401', '114', 'San Vicente');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11402', '114', 'San Jerónimo');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11403', '114', 'La Trinidad');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11501', '115', 'San Pedro');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11502', '115', 'Sabanilla');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11503', '115', 'Mercedes');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11504', '115', 'San Rafael');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11601', '116', 'San Pablo');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11602', '116', 'San Pedro');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11603', '116', 'San Juan de Mata');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11604', '116', 'San Luis');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11605', '116', 'Carara');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11701', '117', 'Santa María');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11702', '117', 'Jardín');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11703', '117', 'Copey');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11801', '118', 'Curridabat');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11802', '118', 'Granadilla');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11803', '118', 'Sánchez');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11804', '118', 'Tirrases');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11901', '119', 'San Isidro de El General');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11902', '119', 'General');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11903', '119', 'Daniel Flores');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11904', '119', 'Rivas');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11905', '119', 'San Pedro');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11906', '119', 'Platanares');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11907', '119', 'Pejibaye');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11908', '119', 'Cajón');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11909', '119', 'Barú');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11910', '119', 'Río Nuevo');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('11911', '119', 'Páramo');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('12001', '120', 'San Pablo');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('12002', '120', 'San Andrés');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('12003', '120', 'Llano Bonito');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('12004', '120', 'San Isidro');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('12005', '120', 'Santa Cruz');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('12006', '120', 'San Antonio');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20101', '201', 'Alajuela');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20102', '201', 'San José');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20103', '201', 'Carrizal');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20104', '201', 'San Antonio');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20105', '201', 'Guácima');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20106', '201', 'San Isidro');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20107', '201', 'Sabanilla');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20108', '201', 'San Rafael');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20109', '201', 'Río Segundo');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20110', '201', 'Desamparados');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20111', '201', 'Turrúcares');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20112', '201', 'Tambor');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20113', '201', 'Garita');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20114', '201', 'Sarapiquí');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20201', '202', 'San Ramón');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20202', '202', 'Santiago');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20203', '202', 'San Juan');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20204', '202', 'Piedades Norte');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20205', '202', 'Piedades Sur');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20206', '202', 'San Rafael');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20207', '202', 'San Isidro');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20208', '202', 'Los Ángeles');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20209', '202', 'Alfaro');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20210', '202', 'Volio');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20211', '202', 'Concepción');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20212', '202', 'Zapotal');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20213', '202', 'Peñas Blancas');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20301', '203', 'Grecia');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20302', '203', 'San Isidro');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20303', '203', 'San José');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20304', '203', 'San Roque');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20305', '203', 'Tacares');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20306', '203', 'Río Cuarto');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20307', '203', 'Puente de Piedra');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20308', '203', 'Bolívar');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20401', '204', 'San Mateo');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20402', '204', 'Desmonte');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20403', '204', 'Jesús María');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20501', '205', 'Atenas');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20502', '205', 'Jesús');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20503', '205', 'Mercedes');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20504', '205', 'San Isidro');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20505', '205', 'Concepción');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20506', '205', 'San José');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20507', '205', 'Santa Eulalia');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20508', '205', 'Escobal');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20601', '206', 'Naranjo');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20602', '206', 'San Miguel');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20603', '206', 'San José');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20604', '206', 'Cirrí Sur');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20605', '206', 'San Jerónimo');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20606', '206', 'San Juan');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20607', '206', 'El Rosario');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20608', '206', 'Palmitos');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20701', '207', 'Palmares');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20702', '207', 'Zaragoza');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20703', '207', 'Buenos Aires');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20704', '207', 'Santiago');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20705', '207', 'Candelaria');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20706', '207', 'Esquipulas');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20707', '207', 'La Granja');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20801', '208', 'San Pedro');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20802', '208', 'San Juan');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20803', '208', 'San Rafael');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20804', '208', 'Carrillos');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20805', '208', 'Sabana Redonda');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20901', '209', 'Orotina');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20902', '209', 'El Mastate');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20903', '209', 'Hacienda Vieja');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20904', '209', 'Coyolar');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('20905', '209', 'La Ceiba');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('21001', '210', 'Quesada');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('21002', '210', 'Florencia');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('21003', '210', 'Buenavista');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('21004', '210', 'Aguas Zarcas');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('21005', '210', 'Venecia');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('21006', '210', 'Pital');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('21007', '210', 'La Fortuna');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('21008', '210', 'La Tigra');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('21009', '210', 'La Palmera');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('21010', '210', 'Venado');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('21011', '210', 'Cutris');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('21012', '210', 'Monterrey');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('21013', '210', 'Pocosol');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('21101', '211', 'Zarcero');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('21102', '211', 'Laguna');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('21103', '211', 'Tapesco');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('21104', '211', 'Guadalupe');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('21105', '211', 'Palmira');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('21106', '211', 'Zapote');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('21107', '211', 'Brisas');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('21201', '212', 'Sarchí Norte');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('21202', '212', 'Sarchí Sur');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('21203', '212', 'Toro Amarillo');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('21204', '212', 'San Pedro');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('21205', '212', 'Rodríguez');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('21301', '213', 'Upala');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('21302', '213', 'Aguas Claras');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('21303', '213', 'San José (Pizote)');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('21304', '213', 'Bijagua');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('21305', '213', 'Delicias');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('21306', '213', 'Dos Ríos');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('21307', '213', 'Yoliyllal');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('21401', '214', 'Los Chiles');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('21402', '214', 'Caño Negro');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('21403', '214', 'El Amparo');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('21404', '214', 'San Jorge');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('21501', '215', 'San Rafael');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('21502', '215', 'Buenavista');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('21503', '215', 'Cote');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('21504', '215', 'Katira');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30101', '301', 'Oriental');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30102', '301', 'Occidental');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30103', '301', 'Carmen');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30104', '301', 'San Nicolás');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30105', '301', 'Aguacaliente (San Francisco)');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30106', '301', 'Guadalupe (Arenilla)');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30107', '301', 'Corralillo');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30108', '301', 'Tierra Blanca');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30109', '301', 'Dulce Nombre');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30110', '301', 'Llano Grande');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30111', '301', 'Quebradilla');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30201', '302', 'Paraíso');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30202', '302', 'Santiago');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30203', '302', 'Orosi');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30204', '302', 'Cachí');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30205', '302', 'Llanos de Santa Lucía');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30301', '303', 'Tres Ríos');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30302', '303', 'San Diego');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30303', '303', 'San Juan');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30304', '303', 'San Rafael');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30305', '303', 'Concepción');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30306', '303', 'Dulce Nombre');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30307', '303', 'San Ramón');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30308', '303', 'Río Azul');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30401', '304', 'Juan Viñas');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30402', '304', 'Tucurrique');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30403', '304', 'Pejibaye');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30501', '305', 'Turrialba');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30502', '305', 'La Suiza');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30503', '305', 'Peralta');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30504', '305', 'Santa Cruz');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30505', '305', 'Santa Teresita');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30506', '305', 'Pavones');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30507', '305', 'Tuis');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30508', '305', 'Tayutic');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30509', '305', 'Santa Rosa');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30510', '305', 'Tres Equis');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30511', '305', 'La Isabel');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30512', '305', 'Chirripó');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30601', '306', 'Pacayas');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30602', '306', 'Cervantes');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30603', '306', 'Capellades');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30701', '307', 'San Rafael');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30702', '307', 'Cot');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30703', '307', 'Potrero Cerrado');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30704', '307', 'Cipreses');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30705', '307', 'Santa Rosa');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30801', '308', 'El Tejar');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30802', '308', 'San Isidro');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30803', '308', 'Tobosi');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('30804', '308', 'Patio de Agua');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('40101', '401', 'Heredia');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('40102', '401', 'Mercedes');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('40103', '401', 'San Francisco');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('40104', '401', 'Ulloa');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('40105', '401', 'Varablanca');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('40201', '402', 'Barva');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('40202', '402', 'San Pedro');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('40203', '402', 'San Pablo');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('40204', '402', 'San Roque');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('40205', '402', 'Santa Lucía');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('40206', '402', 'San José de la Montaña');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('40301', '403', 'Santo Domingo');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('40302', '403', 'San Vicente');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('40303', '403', 'San Miguel');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('40304', '403', 'Paracito');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('40305', '403', 'Santo Tomás');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('40306', '403', 'Santa Rosa');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('40307', '403', 'Tures');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('40308', '403', 'Para');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('40401', '404', 'Santa Bárbara');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('40402', '404', 'San Pedro');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('40403', '404', 'San Juan');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('40404', '404', 'Jesús');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('40405', '404', 'Santo Domingo');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('40406', '404', 'Puraba');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('40501', '405', 'San Rafael');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('40502', '405', 'San Josécito');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('40503', '405', 'Santiago');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('40504', '405', 'Los Ángeles');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('40505', '405', 'Concepción');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('40601', '406', 'San Isidro');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('40602', '406', 'San José');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('40603', '406', 'Concepción');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('40604', '406', 'San Francisco');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('40701', '407', 'San Antonio');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('40702', '407', 'La Ribera');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('40703', '407', 'La Asunción');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('40801', '408', 'San Joaquín de Flores');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('40802', '408', 'Barrantes');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('40803', '408', 'Llorente');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('40901', '409', 'San Pablo');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('40902', '409', 'Rincón de Sabanilla');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('41001', '410', 'Puerto Viejo');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('41002', '410', 'La Virgen');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('41003', '410', 'Horquetas');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('41004', '410', 'Llanuras del Gaspar');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('41005', '410', 'Cureña');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50101', '501', 'Liberia');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50102', '501', 'Cañas Dulces');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50103', '501', 'Mayorga');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50104', '501', 'Nacascolo');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50105', '501', 'Curubande');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50201', '502', 'Nicoya');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50202', '502', 'Mansion');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50203', '502', 'San Antonio');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50204', '502', 'Quebrada Honda');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50205', '502', 'Samara');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50206', '502', 'Nosara');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50207', '502', 'Belén de Nosarita');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50301', '503', 'Santa Cruz');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50302', '503', 'Bolson');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50303', '503', 'Veintisiete de Abril');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50304', '503', 'Tempate');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50305', '503', 'Cartagena');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50306', '503', 'Cuajiniquil');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50307', '503', 'Diria');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50308', '503', 'Cabo Velas');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50309', '503', 'Tamarindo');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50401', '504', 'Bagaces');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50402', '504', 'Fortuna');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50403', '504', 'Mogote');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50404', '504', 'Río Naranjo');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50501', '505', 'Filadelfia');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50502', '505', 'Palmira');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50503', '505', 'Sardinal');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50504', '505', 'Belén');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50601', '506', 'Cañas');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50602', '506', 'Palmira');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50603', '506', 'San Miguel');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50604', '506', 'Bebedero');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50605', '506', 'Porozal');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50701', '507', 'Juntas');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50702', '507', 'Sierra');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50703', '507', 'San Juan');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50704', '507', 'Colorado');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50801', '508', 'Tilarán');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50802', '508', 'Quebrada Grande');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50803', '508', 'Tronadora');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50804', '508', 'Santa Rosa');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50805', '508', 'Líbano');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50806', '508', 'Tierras Morenas');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50807', '508', 'Arenal');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50901', '509', 'Carmona');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50902', '509', 'Santa Rita');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50903', '509', 'Zapotal');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50904', '509', 'San Pablo');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50905', '509', 'Porvenir');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('50906', '509', 'Bejuco');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('51001', '510', 'La Cruz');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('51002', '510', 'Santa Cecilia');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('51003', '510', 'Garita');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('51004', '510', 'Santa Elena');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('51101', '511', 'Hojancha');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('51102', '511', 'Monte Romo');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('51103', '511', 'Puerto Carrillo');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('51104', '511', 'Huacas');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60101', '601', 'Puntarenas');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60102', '601', 'Pitahaya');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60103', '601', 'Chomes');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60104', '601', 'Lepanto');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60105', '601', 'Paquera');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60106', '601', 'Manzanillo');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60107', '601', 'Guacimal');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60108', '601', 'Barranca');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60109', '601', 'Monte Verde');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60110', '601', 'Isla del Coco');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60111', '601', 'Cobano');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60112', '601', 'Chacarita');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60113', '601', 'Chira');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60114', '601', 'Acapulco');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60115', '601', 'El Roble');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60116', '601', 'Arancibia');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60201', '602', 'Espiritu Santo');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60202', '602', 'San Juan Grande');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60203', '602', 'Macacona');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60204', '602', 'San Rafael');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60205', '602', 'San Jerónimo');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60301', '603', 'Buenos Aires');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60302', '603', 'Volcan');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60303', '603', 'Potrero Grande');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60304', '603', 'Boruca');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60305', '603', 'Pilas');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60306', '603', 'Colinas');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60307', '603', 'Changena');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60308', '603', 'Briolley');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60309', '603', 'Brunka');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60401', '604', 'Miramar');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60402', '604', 'La Unión');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60403', '604', 'San Isidro');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60501', '605', 'Puerto Cortes');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60502', '605', 'Palmar');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60503', '605', 'Sierpe');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60504', '605', 'Bahia Ballena');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60505', '605', 'Piedras Blancas');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60601', '606', 'Quepos');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60602', '606', 'Savegre');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60603', '606', 'Naranjito');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60701', '607', 'Golfito');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60702', '607', 'Puerto Jiménez');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60703', '607', 'Guaycara');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60704', '607', 'Pavon');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60801', '608', 'San Vito');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60802', '608', 'Sabalito');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60803', '608', 'Aguabuena');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60804', '608', 'Limóncito');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60805', '608', 'Pittier');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('60901', '609', 'Parrita');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('61001', '610', 'Corredor');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('61002', '610', 'La Cuesta');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('61003', '610', 'Canoas');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('61004', '610', 'Laurel');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('61101', '611', 'Jacó');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('61102', '611', 'Tarcoles');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('70101', '701', 'Limón');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('70102', '701', 'Valle La Estrella');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('70103', '701', 'Río Blanco');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('70104', '701', 'Matama');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('70201', '702', 'Guapiles');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('70202', '702', 'Jiménez');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('70203', '702', 'Rita');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('70204', '702', 'Roxana');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('70205', '702', 'Cariari');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('70206', '702', 'Colorado');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('70301', '703', 'Siquirres');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('70302', '703', 'Pacuarito');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('70303', '703', 'Florida');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('70304', '703', 'Germania');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('70305', '703', 'Cairo');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('70306', '703', 'Alegria');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('70401', '704', 'Bratsi');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('70402', '704', 'Sixaola');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('70403', '704', 'Cahuita');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('70404', '704', 'Telire');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('70501', '705', 'Matina');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('70502', '705', 'Battan');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('70503', '705', 'Carrandi');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('70601', '706', 'Guácimo');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('70602', '706', 'Mercedes');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('70603', '706', 'Pocora');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('70604', '706', 'Río Jiménez');
INSERT INTO distritos (id, id_canton, nombre) VALUES ('70605', '706', 'Duacari');



