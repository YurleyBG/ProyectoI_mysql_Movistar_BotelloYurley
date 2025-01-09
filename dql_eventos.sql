use Movistar;


-- 1.crear un evento que utilice el anterior procedimiento (-- 1. crear un procedimiento que permita insertar nuevas bonificaciones) cada  semana
delimiter //
create event nuevas_bonificaciones
on  schedule every 1 week
do 
begin 
	call Agregarbonificacion('Mega sabado', 'Doble de datos el sabado', 'Expirada', '2025-01-03','2025-01-04' );
end //
delimiter ;

-- 2. crar un evento que actualize cada dia las interacciones de los clientes
delimiter //
create event descuento_producto
on schedule every 1 day
do 
begin 
	update historico_fidelizacion set Cantidad_interacciones=(select count(*) from registro_pagos rp inner join registro_compras rc on rp.id_compra=rc.id where id_cliente=2)where id_cliente=2;
end //
delimiter ;

select * from historico_fidelizacion;

-- 3.  crear un evento que actualize  la fecha de ultimo registro segun la id del cliente ingresada
delimiter //
create event fecha_ultimoRegistro
on schedule every 1 day
do 
begin 
	update historico_fidelizacion set Fecha_ultimo_registro=(select rp.Fecha from registro_pagos rp inner join registro_compras rc on rp.id_compra=rc.id where id_cliente=5 order by 1 desc limit 1)where id_cliente=5;
end //
delimiter ;
select * from historico_fidelizacion;

-- 4.crear un evento para que el siguiente procedimiento(-- 6. crear un procedimiento que permita insertar nuevos servicios de movistar)cada 2 dias 
delimiter //
create event insertar_servicio
on schedule every 2 day
do 
begin 
	call Agregarservicio('Movistar navideño', 'Servicio de línea fija con llamadas nacionales e internacionales.', 'Inactivo', 150, 'navideño', 2);
end //
delimiter ;

select * from servicios;

-- 5. crear un evento para que el siguiente procedimiento(-- 8. crear un procedimiento que permita insertar nuevos planes de movistar)cada 2 dias 
delimiter //
create event insertar_plan
on schedule every 2 day
do 
begin 
	call Agregarplanes( 'Plan navideño', 'Plan medio con 15 GB de datos y llamadas locales ilimitadas.', 'Inactivo', 80, 'Móvil', 2);
end //
delimiter ;

select * from planes;

-- 6. crear un evento para la siguiente funcion (-- 1.  crea una funcion que cuente la cantidad de interacciones que a tenido un cliente  con movistar ) cada semena
delimiter //
create event insertar_cantidad_interacciones
on schedule every 1 week
do 
begin 
	select calcular_interacciones(30);
end //
delimiter ;

-- 7.crear un evento para la siguiente funciom(-- 3. crear una funcion que muestre el tiempo que tiene los clientes desde que se registraron hasta la fecha) cada mes
delimiter //
create event Tiempo_Regitro
on schedule every 1 week
do 
begin 
	select tiempo_fidelizacion_cliente(51);
end //
delimiter ;

-- 8. crear una funcion (-- 4.crear una funcion que determine la categoria del cliente (tipo_cliente) segun su historico de fidelizacion  
-- recordando los tipos de categoria nuevo (1-2 meses), leal(6-12 meses), inactivo(1 mes)) cada mes
delimiter //
create event Categoria_cliente
on schedule every 1 month
do 
begin 
	select tiempo_fidelizacion_cliente(51);
end //
delimiter ;


-- 9.   crear un evento para el siguiente procedimiento(-- 10.crear un procedimientos que pemita eliminar los reportes ) este se activara cada semana
delimiter //
create event eliminar_reporte_id
on schedule every 1 week
do 
begin 
	call eliminar_reporte(50);
end //
delimiter ;

-- 10.crear un evento que elimine los reportes inactivos eventualmente
delimiter //
create event eliminar_reportes_inactivos
on schedule every 1 week
do 
begin 
	delete from reportes where estado='inactivo';
end //
delimiter ;
 
-- 11.crear un evento que actualice a inactivo el servicio  si  son de streming cada mes
delimiter //
create event actualizar_estado_servicio
on schedule every 1 week 
do 
begin 
	update servicios set Estado='Inactivo' where Tipo='Streaming';
end //
delimiter ;

-- 12. crear un evento que active despues de una semana a los servcios de streaming
delimiter //
create event actualizar_estado_servicios_activo
on schedule  every 2 week
do 
begin 
	update servicios set Estado='Activo' where Tipo='Streaming';
end //
delimiter ;

-- 13.crear un evento para  el siguiente procedimiento(12.crear un procedimiento que permita insertar los registro de compra) en la fecha de hoy

delimiter //
create event insertar_registroCompra
on schedule at '2025-01-05 20:20:00'
do 
begin 
	call Agregarcompra('Activo', 350, '2025-01-01', 3, 4, NULL);
end //
delimiter ;
drop event insertar_registroCompra;

-- 14. crear un evento para la siguiente funcion (15. crea un a funcion que nos muestre el cliente que mas compras a realizado ) cada mes 
delimiter //
create event cliente_del_mes
on schedule every 1 month
do 
begin 
	select cliente_ventas();
end //
delimiter ;

-- 15. crear un evento para el siguiente procedimiento(14. crear un procedimiento que permita insertar registros de pagos)en la fecha de hoy
delimiter //
create event Insertar_registroPago
on schedule at '2025-01-05 20:20:00'
do 
begin 
	call AgregarRegistroPagos('Efectivo', 350000, '2025-01-01', 60, 5);
end //
delimiter ;

-- 16. crear un evento para el siguiente procedimiento(20.crear un procedimiento que permita actualizar el total de dinero de las ventas en el historial de ventas por id)
--  cada semana
delimiter //
create event dinero_ventas
on schedule every 1 week
do 
begin 
	Call Actualizar_totaldinero(1, 390000);
end //
delimiter ;

-- 17. crear un evento para la siguiente funcion(16.crear una funcion que nos muestre cual ha sido el empleado que mas ventas realizo) cada mes
delimiter //
create event empleado_del_mes
on schedule every 1 month
do 
begin 
	select empleados_ventas();
end //
delimiter ;

-- 18. crear un evento para la siguiente funcion(14. crear una funcion que nos diga cual fue el plan mas solicitado )cada mes
delimiter //
create event plan_mas_solicitado
on schedule every 1 month
do 
begin 
	select plan_solicitado();
end //
delimiter ;

-- 19. crear un evento para el siguiente procedimiento(8. crear un procedimiento que permita insertar nuevos planes de movistar)cada 2 dias
delimiter //
create event insertar_planes
on schedule every 2 day
do 
begin 
	call Agregarplanes( 'Plan pospago', 'Plan medio con 15 GB de datos y llamadas locales ilimitadas.', 'Activo', 130, 'Tv', 2);
end //
delimiter ;

-- 20.crear un evento para la siguiente funcion(13. crear una funcion que nos diga cual fue el servicio mas solicitado ) cada mes 
delimiter //
create event servicio_mas_solicitado
on schedule every 1 month
do 
begin 
	select servicio_solicitado();
end //
delimiter ;