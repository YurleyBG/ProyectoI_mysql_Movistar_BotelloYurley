use Movistar;

-- 1. crear un procedimiento que permita insertar nuevas bonificaciones
Delimiter //
create procedure Agregarbonificacion(in Nombre varchar(30), Descripcion text,Estado ENUM('Pendiente', 'Expirada'),Fecha_inicio date,
Fecha_fin date )
begin
	INSERT INTO bonificaciones (Nombre, Descripcion, Estado, Fecha_inicio, Fecha_fin) VALUES (Nombre, Descripcion, Estado, Fecha_inicio, Fecha_fin);
end // 
Delimiter ;

call Agregarbonificacion('Mega lunes', 'Doble de datos el lunes', 'Pendiente', '2025-01-03','2025-01-04' );

-- 2. crear un procedimiento que permita actualizar los estados de las bonificaciones existe
Delimiter //
Create procedure Actualizar_Estado1(in id_boni int,in estado_actualizar varchar(50))
begin
	Update bonificaciones set estado=estado_actualizar where id = id_boni;
end// 
Delimiter ;

Call Actualizar_Estado1(1, 'Pendiente');

select * from bonificaciones;

-- 3. crear un procedimiento que permita insertar nuevos clientes
Delimiter //
create procedure Agregarcliente(in Nombre1 varchar(30), in Nombre2 varchar(30),in Apellido1 varchar(30),in Apellido2 varchar(30),in Cedula varchar(15),
in Telefono varchar(15),in Direccion varchar(40),in Ciudad varchar(20),in Sexo ENUM('M', 'F'),in Correo varchar(50),in id_bonificaciones int)
begin
	INSERT INTO clientes (Nombre1, Nombre2, Apellido1, Apellido2, Cedula, Telefono, Direccion, Ciudad, Sexo, Correo, id_bonificaciones) VALUES 
    (Nombre1, Nombre2, Apellido1, Apellido2, Cedula, Telefono, Direccion, Ciudad, Sexo, Correo, id_bonificaciones);
end // 
Delimiter ;

call Agregarcliente('alexander','yefi','sandoval','calderon','100789645','3024573898','cr2 #33-5','cucuta','M','YefiA@gmail.com',59 );

-- 4. crear un procedimiento que permita actualizar las bonificaciones de los clientes
Delimiter //
Create procedure Actualizar_bonificacion(in id_cliente int,in bonifi_actualizar varchar(50))
begin
	Update clientes set id_bonificaciones=bonifi_actualizar where id = id_cliente;
end// 
Delimiter ;

Call Actualizar_bonificacion(1, 2);

select * from clientes;

-- 5. crear un procedimiento que permita insertar nuevos dispositivos
Delimiter //
create procedure Agregardispositivos(in modelo varchar(50),in imei varchar(20) ,in tipo varchar(30),in marca varchar(40) )
begin
	INSERT INTO Dispositivos (modelo, imei, tipo, marca) VALUES (modelo, imei, tipo, marca)
    ;
end // 
Delimiter ;

call Agregardispositivos('Samsung Galaxy S26', '358237337737838', 'Smartphone', 'Samsung' );

-- 6. crear un procedimiento que permita insertar nuevos servicios de movistar 
Delimiter //
create procedure Agregarservicio(in Nombre varchar(50) , in Descripcion text, in Estado ENUM('Activo', 'Inactivo'),in Precio int(15) , in Tipo varchar(40) , in id_dispositivos int)
begin
	INSERT INTO servicios (Nombre, Descripcion, Estado, Precio, Tipo, id_dispositivos) VALUES (Nombre, Descripcion, Estado, Precio, Tipo, id_dispositivos)
;
end // 
Delimiter ;

call Agregarservicio('Movistar Fijo', 'Servicio de línea fija con llamadas nacionales e internacionales.', 'Inactivo', 150, 'Fijo', 2);

-- 7.crear un procedimiento que permita actualizarlos estados de los servicios 
Delimiter //
Create procedure Actualizar_estado2(in id_servicio int,in servicio_actualizar varchar(50))
begin
	Update servicios set Estado=servicio_actualizar where id = id_servicio;
end// 
Delimiter ;

Call Actualizar_estado2(1,'Inactivo');

select * from servicios;

-- 8. crear un procedimiento que permita insertar nuevos planes de movistar
Delimiter //
create procedure Agregarplanes(in Nombre varchar(50) , in Descripcion text, in Estado ENUM('Activo', 'Inactivo'),in Precio int(15) , in Tipo varchar(40) , in id_dispositivos int)
begin
	INSERT INTO planes (Nombre, Descripcion, Estado, Precio, Tipo, id_dispositivos) VALUES (Nombre, Descripcion, Estado, Precio, Tipo, id_dispositivos)
    ;
end // 
Delimiter ;

call Agregarplanes( 'Plan Medio', 'Plan medio con 15 GB de datos y llamadas locales ilimitadas.', 'Activo', 60, 'Móvil', 2);

-- 9.crear un procedimiento que permita actualizar los estados de los planes 
Delimiter //
Create procedure Actualizar_estado_plan(in id_plan int,in plan_actualizar varchar(50))
begin
	Update planes set Estado=plan_actualizar where id = id_plan;
end// 
Delimiter ;

Call Actualizar_estado_plan(1,'Inactivo');

select * from planes;

-- 10.crear un procedimientos que pemita eliminar los reportes 
delimiter //
create procedure eliminar_reporte (in id_reporte int)
begin 	
	declare eliminar int;
    set eliminar= (select count(*) from reportes where reportes.id=id_reporte);
    if eliminar = 1 then 
		delete from reportes where reportes.id=id_reporte;
    else 
     signal sqlstate '45000' set message_text = 'No hay reportes con esta id';
	end if ;
end //
delimiter ;

call eliminar_reporte(50);
select * from reportes;

-- 11.crear un procedimiento que permita actualizar el estado de los reportes
Delimiter //
Create procedure Actualizar_Reportes(in id_estado_RE int,in reporte_actualizar varchar(50))
begin
	Update Reportes set Estado=reporte_actualizar where id = id_estado_RE;
end// 
Delimiter ;

Call Actualizar_Reportes(2,'Inactivo');

select * from Reportes;

-- 12.crear un procedimiento que permita insertar los registro de compra
Delimiter //
create procedure Agregarcompra(in Estado ENUM('Activo', 'Inactivo','cancelado'),
in Precio_base int(15) ,in Fecha date ,in id_cliente int,in id_servicios int,in id_plan int)
begin
	INSERT INTO Registro_Compras (Estado, Precio_base, Fecha, id_cliente, id_servicios, id_plan) VALUES (Estado, Precio_base, Fecha, id_cliente, id_servicios, id_plan) ;
end // 
Delimiter ;

call Agregarcompra('Activo', 190000, '2025-01-01', 3, 4, NULL);

-- 13.crear un procedimiento que permita actualizar el estado de los registros de compra 
Delimiter //
Create procedure Actualizar_estado_RC(in id_estado int,in estado_actualizar varchar(50))
begin
	Update registro_compras set Estado=estado_actualizar where id = id_estado;
end// 
Delimiter ;

Call Actualizar_estado_RC(60,'Activo');

select * from registro_compras;

-- 14. crear un procedimiento que permita insertar registros de pagos
Delimiter //
create procedure AgregarRegistroPagos(in Forma_pago varchar(30) , in total_pagar int(15) ,in Fecha date, in id_compra int,in id_empleado INT )
begin
	INSERT INTO registro_pagos (Forma_pago, total_pagar, Fecha, id_compra, id_empleado) VALUES (Forma_pago, total_pagar, Fecha, id_compra, id_empleado);
end // 
Delimiter ;

call AgregarRegistroPagos('Efectivo', 220000, '2025-01-01', 1, 45);

-- 15. crear un procedimiento que permita actualizar el dinero de los registros de pagos
Delimiter //
Create procedure Actualizar_EstadoRP(in id_RP int,in DineroRP_actualizar varchar(50))
begin
	Update registro_pagos set total_pagar=DineroRP_actualizar where id = id_RP;
end// 
Delimiter ;

Call Actualizar_EstadoRP(1, 154000);

select * from registro_pagos;

-- 16.crear un procedimiento que permita insertar empleados

Delimiter //
create procedure Agregarempleados(in Nombre1 varchar(30) , in Nombre2 varchar(30),in Apellido1 varchar(30),in Apellido2 varchar(30),in Cedula varchar(15) ,
in Telefono varchar(15) ,in Direccion varchar(40) ,in Ciudad varchar(20),in Sexo ENUM('M', 'F'),in Correo varchar(50),in cargo varchar(50))
begin
	INSERT INTO empleados (Nombre1, Nombre2, Apellido1, Apellido2, Cedula, Telefono, Direccion, Ciudad, Sexo, Correo, Cargo) VALUES (Nombre1, Nombre2, Apellido1, Apellido2, Cedula, Telefono, Direccion, Ciudad, Sexo, Correo, Cargo);
    end // 
Delimiter ;

call Agregarempleados('yefi', 'Alfonso', 'Pérez', 'Garcia', '176278727', '312321347', 'Calle 1 # 33-12', 'Bogotá', 'M', 'yefe.perez@gmail.com', 'Vendedor' );

-- 17. crear un procedimiento que permita insertar el historial de fidelizacion

Delimiter //
create procedure Agregarfidelizacion(in id_cliente int,in Fecha_registro1 date,in tipo_cliente ENUM('Nuevo', 'Leal','Inactivo'),in Fecha_ultimo_registro date,in Cantidad_interacciones int)
begin
	INSERT INTO historico_fidelizacion (id_cliente, Fecha_registro1, tipo_cliente, Fecha_ultimo_registro, Cantidad_interacciones) VALUES (id_cliente, Fecha_registro1, tipo_cliente, Fecha_ultimo_registro, Cantidad_interacciones)
    ;
end // 
Delimiter ;

call Agregarfidelizacion(51, '2025-01-04', 'nuevo', '2025-01-04', 21);

-- 18. crear un procedimiento que permita actualizar el tipo de cliente en el historial de fidelizacion 
Delimiter //
Create procedure Actualizar(in idHF int,in fidelizacion_actualizar varchar(50))
begin
	Update historico_fidelizacion set tipo_cliente=fidelizacion_actualizar where id = idHF;
end// 
Delimiter ;

Call Actualizar(2,'Nuevo');

select * from historico_fidelizacion;

-- 19. crear un procedimiento que permita insertar el historial de ventas
Delimiter //
create procedure Agregarventas(in Fecha_registro date,in total_dinero_ventas int(15) ,in id_pagos int)
begin
	INSERT INTO Historial_Ventas (Fecha_registro, total_dinero_ventas, id_pagos) VALUES (Fecha_registro, total_dinero_ventas, id_pagos);
end // 
Delimiter ;

call Agregarventas('2025-01-01', 280000, 35 );

-- 20.crear un procedimiento que permita actualizar el total de dinero de las ventas en el historial de ventas por id
Delimiter //
Create procedure Actualizar_totaldinero(in id_venta int,in dinero_actualizar int)
begin
	Update  historial_ventas set total_dinero_ventas=dinero_actualizar where id = id_venta;
end// 
Delimiter ;

Call Actualizar_totaldinero(1, 385000);

select * from historial_ventas;