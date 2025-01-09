create database Movistar;
use Movistar;

create table bonificaciones (
Id int not null primary key auto_increment,
Nombre varchar(30) not null, 
Descripcion text,
Estado ENUM('Pendiente', 'Expirada'),
Fecha_inicio date,
Fecha_fin date not null
);
create table clientes(
Id int not null primary key auto_increment,
Nombre1 varchar(30) not null, 
Nombre2 varchar(30),
Apellido1 varchar(30) not null,
Apellido2 varchar(30),
Cedula varchar(15) not null,
Telefono varchar(15) not null,
Direccion varchar(40) not null,
Ciudad varchar(20),
Sexo ENUM('M', 'F'),
Correo varchar(50),
id_bonificaciones int ,
foreign key (id_bonificaciones) references bonificaciones(id)
);
create table historico_fidelizacion (
Id int not null primary key auto_increment,
id_cliente int not null,
foreign key (id_cliente) references clientes(id),
Fecha_registro1 date not null,
tipo_cliente ENUM('Nuevo', 'Leal','Inactivo') not null,
Fecha_ultimo_registro date,
Cantidad_interacciones int
);

 create table Dispositivos(
Id int not null primary key auto_increment,
modelo varchar(50) not null,
imei varchar(20) not null,
tipo varchar(30),
marca varchar(40) not null
 );
create table servicios(
Id int not null primary key auto_increment,
Nombre varchar(50) not null, 
Descripcion text,
Estado ENUM('Activo', 'Inactivo'),
Precio int(15) not null,
Tipo varchar(40) not null,
id_dispositivos int,
foreign key (id_dispositivos) references Dispositivos(id)
);

create table planes(
Id int not null primary key auto_increment,
Nombre varchar(50) not null, 
Descripcion text,
Estado ENUM('Activo', 'Inactivo'),
Precio int(15) not null,
Tipo varchar(40) not null,
id_dispositivos int,
foreign key (id_dispositivos) references Dispositivos(id)
);
create table Reportes(
Id int not null primary key auto_increment,
Nombre varchar(50) not null, 
Descripcion text,
Fecha date not null,
Estado ENUM('Activo', 'Inactivo'),
id_cliente int not null,
foreign key (id_cliente) references clientes(id),
id_servicio int ,
foreign key (id_servicio) references servicios(id),
id_plan int,
foreign key (id_plan) references planes(id)
);
create table Registro_Compras(
Id int not null primary key auto_increment,
Estado ENUM('Activo', 'Inactivo','cancelado'),
Precio_base int(15) not null,
Fecha date not null,
id_cliente int not null,
foreign key (id_cliente) references clientes(id),
id_servicios int,
foreign key (id_servicios) references servicios(id),
id_plan int,
foreign key (id_plan) references planes(id)
);
create table empleados(
id int not null primary key auto_increment,
Nombre1 varchar(30) not null, 
Nombre2 varchar(30),
Apellido1 varchar(30) not null,
Apellido2 varchar(30),
Cedula varchar(15) not null,
Telefono varchar(15) not null,
Direccion varchar(40) not null,
Ciudad varchar(20),
Sexo ENUM('M', 'F'),
Correo varchar(50),
cargo varchar(50)
);
create table Registro_pagos(
id int not null primary key auto_increment,
Forma_pago varchar(30) not null, 
total_pagar int(15) not null,
Fecha date not null,
id_compra int,
foreign key (id_compra) references Registro_Compras(id),
id_empleado INT, 
FOREIGN KEY (id_empleado) REFERENCES empleados(id)
);

create table Historial_Ventas(
Id int not null primary key auto_increment,
Fecha_registro date not null,
total_dinero_ventas int(15) not null,
id_pagos int,
foreign key (id_pagos) references Registro_pagos(id)
);

create table registros_antiguos (
Id int not null primary key auto_increment,
Fecha_registro date not null,
Tipo varchar (50) not null,
Descripcion varchar (100)
)

 
