


drop database BD_proyecto_SISE;
CREATE DATABASE BD_proyecto_SISE
ON PRIMARY
( NAME = 'DB_producto', 
  	FILENAME = 'C:\BD\BD_proyecto_SISE.mdf' , 
    SIZE = 10500KB , 
   	MAXSIZE = UNLIMITED, 
	FILEGROWTH = 1024KB )
 LOG ON 
	( NAME = 'DB_productoLog', 
   	FILENAME = 'C:\BD\BD_proyecto_SISE.ldf' , 
    SIZE = 5536KB , 
    MAXSIZE = 2048GB , 
 	FILEGROWTH = 10%)
GO


/* Drop Table */
use BD_proyecto_SISE;

drop table TDetalle_Factura;
drop table TFactura;
drop table TCosto_Variable_Orden_Servicio;
drop table TOrden_Servicio;
drop table TServicio;
drop table TTipo_Servicio;
drop table TCliente_Telefono;
drop table TCliente;
drop table TDistrito
drop table TCanton;
drop table TProvincia;
drop table TTipo_Telefono;
drop table TCosto_Variable;
drop table TUser_TRol;
drop table TUser;
drop table TRol;


/* Tablas */
use BD_proyecto_SISE;

create table TUser(
	id_user int identity (500,2) not null,
	nombre varchar(160),
	email varchar(250),
	contraseña varchar(500),

);

create table TRol(
	id_rol int identity(1,5) not null,
	description varchar(150) not null,
);

create table TUser_TRol(
	id_user int not null,
	id_rol int not null
);

create table TTipo_Telefono(
	id_tipo_telefono int identity(1,1) not null,
	descripcion varchar(150),
);

create table TCliente_Telefono(
	id_cliente int not null,
	telefono varchar(15) not null,
	id_tipo_telefono int
);


create table TProvincia(
	id_provincia int identity(1,1) not null,
	descripcion varchar(150),
);

create table TCanton(
	id_canton int identity(1,1) not null,
	id_provincia int not null,
	descripcion varchar(150)
);

create table TDistrito(
	id_distrito int identity (1,1) not null,
	id_canton int not null,
	id_provincia int not null,
	descripcion varchar(150),
);

create table TCliente(
	id_cliente int identity(10000,5) not null,
	nombre varchar (150) not null,
	provincia varchar(150),
	id_distrito int not null,
	id_canton int not null,
	id_provincia int not null,
	otras_sennas varchar(150),
	email varchar(230),
	descuento decimal (12,3),
	usuario_registra int not null, 
	fecha_registra date not null, 
	usuario_edita_ULT int not null, 
	fecha_edita_ULT date not null

);

create table TCosto_Variable(
	id_costo_variable int identity(1,1) not null,
	descripcion varchar (200),
	costo decimal (12,2),
	usuario_registra int not null, 
	fecha_registra date not null, 
	usuario_edita_ULT int not null, 
	fecha_edita_ULT date not null

);

create table TTipo_Servicio(
	id_tipo_servicio int identity(1,1) not null,
	descripcion varchar(150)
);

create table TServicio(
	id_servicio int identity(100,1) not null,
	descripcion varchar(200) not null,
	precio_hora decimal(6,2) not null,
	estado varchar(60),
	id_tipo_servicio int not null,
	usuario_registra int not null, 
	fecha_registra date not null, 
	usuario_edita_ULT int not null, 
	fecha_edita_ULT date not null
);

create table TOrden_Servicio(
	id_orden int identity(1000, 1) not null,
	fecha_ejecucion date not null,
	estimacion_horas_duracion decimal (5,2) not null,
	lugar_servicio varchar(150) not null,
	id_distrito int not null,
	id_canton int not null,
	id_provincia int not null,
	otras_sennas varchar(150),
	id_cliente int not null,
	id_servicio int not null,
	detalle_servicio varchar(250),
	estado varchar(60),
	costos_variables decimal(12,2),
	usuario_registra int not null, 
	fecha_registra date not null, 
	usuario_edita_ULT int not null, 
	fecha_edita_ULT date not null
);

create table TCosto_Variable_Orden_Servicio(
	id_costo_variable int not null,
	id_orden int not null,
	usuario_registra int not null, 
	fecha_registra date not null, 
	usuario_edita_ULT int not null, 
	fecha_edita_ULT date not null
);

create table TFactura(
	id_factura int identity(2000000,1) not null,
	fecha date not null,
	total decimal (12,2),
	monto_descuento decimal(12,2),
	usuario_registra int not null, 
	fecha_registra date not null, 
	usuario_edita_ULT int not null, 
	fecha_edita_ULT date not null
);

create table TDetalle_Factura(
	id_detalle int identity(1,1) not null,
	id_factura int not null,
	id_orden_servicio int not null,
	precio_orden decimal (12,2)
);

/* PrimaryKey */
use BD_proyecto_SISE;

ALTER TABLE TUser
ADD CONSTRAINT PK_TUser PRIMARY KEY (id_user);

ALTER TABLE TRol
ADD CONSTRAINT PK_TRol PRIMARY KEY (id_rol);

ALTER TABLE TUser_TRol
ADD CONSTRAINT PK_TUser_TRol PRIMARY KEY (id_user, id_rol);

ALTER TABLE TTipo_Telefono
ADD CONSTRAINT PK_Tipo_Telefono PRIMARY KEY (id_tipo_telefono);

ALTER TABLE TCliente_Telefono
ADD CONSTRAINT PK_Cliente_Telefono PRIMARY KEY (id_cliente, telefono);

ALTER TABLE TCliente
ADD CONSTRAINT PK_Cliente PRIMARY KEY (id_cliente);

ALTER TABLE TProvincia
ADD CONSTRAINT PK_Provincia PRIMARY KEY (id_provincia);

ALTER TABLE TCanton
ADD CONSTRAINT PK_Canton PRIMARY KEY (id_canton, id_provincia);

ALTER TABLE TDistrito
ADD CONSTRAINT PK_Distrito PRIMARY KEY (id_distrito, id_canton, id_provincia);

ALTER TABLE TTipo_Servicio
ADD CONSTRAINT PK_Tipo_Servicio PRIMARY KEY (id_tipo_servicio);

ALTER TABLE TServicio
ADD CONSTRAINT PK_Servicio PRIMARY KEY (id_servicio);

ALTER TABLE TCosto_Variable
ADD CONSTRAINT PK_Costo_Variable PRIMARY KEY (id_costo_variable);

ALTER TABLE TOrden_Servicio
ADD CONSTRAINT PK_Orden_Servicio PRIMARY KEY (id_orden);

ALTER TABLE TCosto_Variable_Orden_Servicio
ADD CONSTRAINT PK_Costo_Variable_Orden_Servicio PRIMARY KEY (id_costo_variable, id_orden);

ALTER TABLE TFactura
ADD CONSTRAINT PK_Factura PRIMARY KEY (id_factura);

ALTER TABLE TDetalle_Factura
ADD CONSTRAINT PK_Detalle_Factura PRIMARY KEY (id_detalle, id_factura);


/* ForeignKey */

ALTER TABLE TUser_TRol ADD CONSTRAINT FK_TUser_TUser_Rol
FOREIGN KEY (id_user) REFERENCES TUser(id_user);

ALTER TABLE TUser_TRol ADD CONSTRAINT FK_TUser_Rol_TRol
FOREIGN KEY (id_rol) REFERENCES TRol(id_rol);

ALTER TABLE TCanton ADD CONSTRAINT FK_TCanton_TProvincia
FOREIGN KEY (id_provincia) REFERENCES TProvincia(id_provincia);

ALTER TABLE TDistrito ADD CONSTRAINT FK_TDistrito_TCanton
FOREIGN KEY (id_canton, id_provincia) REFERENCES TCanton(id_canton,id_provincia);

ALTER TABLE TCliente ADD CONSTRAINT FK_TCliente_TDistrito
FOREIGN KEY (id_distrito, id_canton, id_provincia) REFERENCES TDistrito(id_distrito, id_canton, id_provincia); 

ALTER TABLE TCliente_Telefono ADD CONSTRAINT FK_TCliente_TCliente_Telefono
FOREIGN KEY (id_cliente) REFERENCES TCliente (id_cliente); 

ALTER TABLE TCliente_Telefono ADD CONSTRAINT FK_TCliente_Telefono_TTipo_Telefono
FOREIGN KEY (id_tipo_telefono) REFERENCES TTipo_Telefono(id_tipo_telefono); 

ALTER TABLE TServicio ADD CONSTRAINT FK_TTipo_Servicio
FOREIGN KEY (id_tipo_servicio) REFERENCES TTipo_Servicio(id_tipo_servicio);

ALTER TABLE TOrden_Servicio ADD CONSTRAINT FK_TCliente_TOrden_Servicio
FOREIGN KEY (id_cliente) REFERENCES TCliente(id_cliente);  

ALTER TABLE TOrden_Servicio ADD CONSTRAINT FK_TOrden_Servicio_TDistrito
FOREIGN KEY (id_distrito, id_canton, id_provincia) REFERENCES TDistrito(id_distrito, id_canton, id_provincia); 

ALTER TABLE TCosto_Variable_Orden_Servicio ADD CONSTRAINT FK_TCosto_Variable_Orden_Servicio_TCosto_Variable
FOREIGN KEY (id_costo_variable) REFERENCES TCosto_Variable(id_costo_variable);

ALTER TABLE TCosto_Variable_Orden_Servicio ADD CONSTRAINT FK_TCosto_Variable_Orden_Servicio_TOrden_Servicio
FOREIGN KEY (id_orden) REFERENCES TOrden_Servicio(id_orden);

ALTER TABLE TOrden_Servicio ADD CONSTRAINT FK_TOrden_Servicio_TServicio
FOREIGN KEY (id_servicio) REFERENCES TServicio(id_servicio);

ALTER TABLE TDetalle_Factura ADD CONSTRAINT FK_TDetalle_Factura_TOrden_Servicio
FOREIGN KEY (id_orden_servicio) REFERENCES TOrden_Servicio(id_orden);

ALTER TABLE TDetalle_Factura ADD CONSTRAINT FK_TDetalle_Factura_TFactura
FOREIGN KEY (id_factura) REFERENCES TFactura(id_factura);




ALTER TABLE TCliente ADD CONSTRAINT FK_TCliente_TUser_Registra
FOREIGN KEY (usuario_registra) REFERENCES TUser (id_user); 

ALTER TABLE TCliente ADD CONSTRAINT FK_TCliente_TUser_Edita
FOREIGN KEY (usuario_edita_ULT) REFERENCES TUser (id_user); 

ALTER TABLE TCosto_Variable ADD CONSTRAINT FK_TCosto_Variable_TUser_Registra
FOREIGN KEY (usuario_registra) REFERENCES TUser (id_user); 

ALTER TABLE TCosto_Variable ADD CONSTRAINT FK_TCosto_Variable_TUser_Edita
FOREIGN KEY (usuario_edita_ULT) REFERENCES TUser (id_user); 

ALTER TABLE TServicio ADD CONSTRAINT FK_TServicio_TUser_Registra
FOREIGN KEY (usuario_registra) REFERENCES TUser (id_user); 

ALTER TABLE TServicio ADD CONSTRAINT FK_TServicio_TUser_Edita
FOREIGN KEY (usuario_edita_ULT) REFERENCES TUser (id_user); 

ALTER TABLE TOrden_Servicio ADD CONSTRAINT FK_TOrden_Servicio_TUser_Registra
FOREIGN KEY (usuario_registra) REFERENCES TUser (id_user); 

ALTER TABLE TOrden_Servicio ADD CONSTRAINT FK_TOrden_Servicio_TUser_Edita
FOREIGN KEY (usuario_edita_ULT) REFERENCES TUser (id_user); 

ALTER TABLE TCosto_Variable_Orden_Servicio ADD CONSTRAINT FK_TCosto_Variable_Orden_Servicio_TUser_Registra
FOREIGN KEY (usuario_registra) REFERENCES TUser (id_user); 

ALTER TABLE TCosto_Variable_Orden_Servicio ADD CONSTRAINT FK_TCosto_Variable_Orden_Servicio_TUser_Edita
FOREIGN KEY (usuario_edita_ULT) REFERENCES TUser (id_user); 

ALTER TABLE TFactura ADD CONSTRAINT FK_TFactura_TUser_Registra
FOREIGN KEY (usuario_registra) REFERENCES TUser (id_user); 

ALTER TABLE TFactura ADD CONSTRAINT FK_TFactura_TUser_Edita
FOREIGN KEY (usuario_edita_ULT) REFERENCES TUser (id_user); 




/* Inserts */

/* TTipo_Telefono */
INSERT INTO TTipo_Telefono (descripcion)
VALUES ('Empresarial');

INSERT INTO TTipo_Telefono (descripcion)
VALUES ('Celular');

INSERT INTO TTipo_Telefono (descripcion)
VALUES ('Linea de Casa');

/* TTipos_Servicios */
INSERT INTO TTipo_Servicio (descripcion)
VALUES ('Financiero');

INSERT INTO TTipo_Servicio (descripcion)
VALUES ('Tecnico');

INSERT INTO TTipo_Servicio (descripcion)
VALUES ('Construccion');

INSERT INTO TTipo_Servicio (descripcion)
VALUES ('Mecanico');

INSERT INTO TTipo_Servicio (descripcion)
VALUES ('Reclutamiento');



