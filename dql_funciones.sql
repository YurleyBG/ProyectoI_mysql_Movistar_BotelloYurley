use Movistar;


-- 1.  crea una funcion que cuente la cantidad de interacciones que a tenido un cliente  con movistar 

delimiter //
create function calcular_interacciones (id_cliente_buscado int)
returns int deterministic
begin
	declare interaciones_totales int;
	set interaciones_totales =(select count(*) from registro_pagos rp inner join registro_compras rc on rp.id_compra=rc.id  where rc.id_cliente= id_cliente_buscado );
	return interaciones_totales;
end//
delimiter ;

select calcular_interacciones(30);

-- 2. crear una funcion que calcule los totales a pagar de las ventas que llevaron un servicio y un plan segun la id de la compra que se solicite.
delimiter //
create function calcular_pago (id_pago int )
returns int deterministic
begin
	declare pago_total int;
	set pago_total =(select s.precio+p.precio from  registro_compras rc inner join servicios s  on rc.id_servicios=s.id inner join planes p on rc.id_plan=p.id  where rc.id= id_pago );
	return pago_total;
end//
delimiter ;

select calcular_pago(8);

-- 3. crear una funcion que muestre el tiempo que tiene los clientes desde que se registraron hasta la fecha
delimiter //
create function tiempo_fidelizacion_cliente (id_cliente int)
returns int deterministic
begin
	declare total_dias int ;
    set total_dias=(select datediff(Fecha_ultimo_registro,fecha_registro1) as dias from historico_fidelizacion where historico_fidelizacion.id_cliente=id_cliente );
    return total_dias;
end //
delimiter ;

select tiempo_fidelizacion_cliente(51);

-- 4.crear una funcion que determine la categoria del cliente (tipo_cliente) segun su historico de fidelizacion  
-- recordando los tipos de categoria nuevo (1-2 meses), leal(6-12 meses), inactivo(1 mes)

delimiter //
create function categoria_cliente(id_clientes int)
returns varchar(30) deterministic
begin
	declare categoria varchar(30);
    declare days int ;
    set days=(select datediff(Fecha_ultimo_registro,fecha_registro1) as dias from historico_fidelizacion where historico_fidelizacion.id_cliente=id_clientes);
    if days<30 or days<60 then
		Update historico_fidelizacion set tipo_cliente='nuevo' where id_cliente = id_clientes;
	
	elseif days>61 or days<365 then
		Update historico_fidelizacion set tipo_cliente='leal' where id_cliente = id_clientes;
	elseif days<0 then
		Update historico_fidelizacion set tipo_cliente='inactivo' where id_cliente = id_clientes;
	end if;
	set categoria=(select tipo_cliente from historico_fidelizacion where id_cliente=id_clientes);
    return categoria;
    
end //
delimiter ;

select categoria_cliente(51);
-- 5.  crear una funcion que calcule el total de ingresos donde solo se vendieron servicios 
 delimiter //
 create function ingresos_servicios ()
 returns int deterministic
 begin
	declare ingresos int ;
    set ingresos = (select sum(total_pagar) from registro_pagos rp inner join registro_compras rc on rp.id_compra=rc.id  where rc.id_plan is null);
    return ingresos;
 end //
 delimiter ;
 select ingresos_servicios();
 
-- 6.  crear una funcion que calcule el total de ingresos donde solo se vendieron planes 
 delimiter //
 create function ingresos_planes ()
 returns int deterministic
 begin
	declare ingresos int ;
    set ingresos = (select sum(total_pagar) from registro_pagos rp inner join registro_compras rc on rp.id_compra=rc.id  where rc.id_servicios is null);
    return ingresos;
 end //
 delimiter ;
 select ingresos_planes();
 
-- 7.crear una funcion que calcule el total de ingresos donde se vendieron servicios y plan 
 delimiter //
 create function ingresos_planes_servicios ()
 returns int deterministic
 begin
	declare ingresos int ;
    set ingresos = (select sum(total_pagar) from registro_pagos rp inner join registro_compras rc on rp.id_compra=rc.id  where rc.id_plan is not null and rc.id_servicios is not null );
    return ingresos;
 end //
 delimiter ;
 select ingresos_planes_servicios();
 
-- 8. crear una funcion que calcule el total de ingresos por las ventas realizadas en el ultimo mes(diciembre)
 delimiter //
 create function ingresos_totales_ultimo_mes (mes int)
 returns int deterministic
 begin
	declare ingresos int ;
    set ingresos = (select sum(total_pagar) from registro_pagos where month(fecha)= mes );
    return ingresos;
 end //
 delimiter ;
 select ingresos_totales_ultimo_mes(12);
 
-- 9. Obten el promedio del total de ingresos de ventas que se han tenido .
delimiter //
 create function promedio_total_ventas ()
 returns int deterministic
 begin
	declare ingresos int ;
    set ingresos = (select avg(cantidad) from(select count(*) as cantidad from registro_pagos)as obtener );
    return ingresos;
 end //
 delimiter ;
 select promedio_total_ventas();

-- 10.Obten el promedio del total de ingresos de ventas que se han tenido por solo servicios .
delimiter //
 create function promedio_servicios_ventas ()
 returns int deterministic
 begin
	declare ingresos int ;
    set ingresos = (select avg(cantidad) from(select count(*) as cantidad from registro_pagos rp inner join registro_compras rc on rp.id_compra=rc.id  where rc.id_plan is null)as obtener );
    return ingresos;
 end //
 delimiter ;
 select promedio_servicios_ventas();
 
-- 11.Obten el promedio del total de ingresos de ventas que se han tenido por solo planes .
delimiter //
 create function promedio_planes_ventas ()
 returns int deterministic
 begin
	declare ingresos int ;
    set ingresos = (select avg(cantidad) from(select count(*) as cantidad from registro_pagos rp inner join registro_compras rc on rp.id_compra=rc.id  where rc.id_servicios is null)as obtener );
    return ingresos;
 end //
 delimiter ;
 select promedio_planes_ventas();
 
-- 12.Obten el promedio del total de ingresos de ventas que se han tenido por servicios y planes .
delimiter //
 create function promedio_planes_servicios_ventas ()
 returns int deterministic
 begin
	declare ingresos int ;
    set ingresos = (select avg(cantidad) from(select count(*) as cantidad from registro_pagos rp inner join registro_compras rc on rp.id_compra=rc.id  where rc.id_plan is not null and rc.id_servicios is not null )as obtener );
    return ingresos;
 end //
 delimiter ;
 select promedio_planes_servicios_ventas();
 
-- 13. crear una funcion que nos diga cual fue el servicio mas solicitado 
delimiter //
create function servicio_solicitado ()
returns varchar(100) deterministic
begin
 declare servicio varchar(100);
 set servicio = (select servicio_mas_solicitado from (select  s.nombre as servicio_mas_solicitado, count(id_servicios) from registro_pagos  rp inner join registro_compras rc
 on rp.id_compra = rc.id inner join servicios s on rc.id_servicios=s.id group by 1 order by 2 desc limit 1 )as obtener);
 return servicio;
end //
delimiter ;
select servicio_solicitado();

-- 14. crear una funcion que nos diga cual fue el plan mas solicitado 
delimiter //
create function plan_solicitado ()
returns varchar(100) deterministic
begin
 declare plan varchar(100);
 set plan = (select plan_mas_solicitado from (select  p.nombre as plan_mas_solicitado, count(id_plan) from registro_pagos  rp inner join registro_compras rc
 on rp.id_compra = rc.id inner join planes p on rc.id_plan=p.id group by 1 order by 2 desc limit 1 )as obtener);
 return plan;
end //
delimiter ;

select plan_solicitado();
-- 15. crea un a funcion que nos muestre el cliente que mas compras a realizado 
delimiter // 
create function cliente_ventas ()
returns varchar(60) deterministic
begin
	declare cliente varchar(50);
	set cliente = (select nombre_cliente from (select  CONCAT_WS( '',c.Nombre1,' ',c.Nombre2,' ', c.Apellido1,' ',c.Apellido2)as nombre_cliente, count(id_cliente) from registro_pagos  rp inner join registro_compras rc
	on rp.id_compra = rc.id inner join clientes c on rc.id_cliente=c.id group by 1 order by 2 desc  limit 1 )as obtener);
	return cliente;
end // 
delimiter ;

select cliente_ventas();

-- 16.crear una funcion que nos muestre cual ha sido el empleado que mas ventas realizo

delimiter // 
create function empleados_ventas ()
returns varchar(60) deterministic
begin
	declare empleado varchar(50);
	set empleado = (select nombre_empleado from (select  CONCAT_WS( '',e.Nombre1,' ',e.Nombre2,' ', e.Apellido1,' ',e.Apellido2)as nombre_empleado, count(id_empleado) from registro_pagos  rp 
	inner join empleados e on rp.id_empleado=e.id group by 1 order by 2 desc  limit 1 )as obtener);
	return empleado;
end // 
delimiter ;

select empleados_ventas();

-- 17. crear una funcion que calcule la cantidad de clientes masculinos que han realizado compras
delimiter // 
create function clientes_masculinos ()
returns varchar(60) deterministic
begin
	declare clientes_M varchar(50);
	set clientes_M = (select cantidad_cliente from (select   count(id_cliente) as cantidad_cliente from registro_pagos  rp inner join registro_compras rc
	on rp.id_compra = rc.id inner join clientes c on rc.id_cliente=c.id  where c.sexo='M' order by 1 desc  limit 1 )as obtener);
	return clientes_M;
end // 
delimiter ;

select clientes_masculinos();

-- 18. crear una funcion que calcule la cantidad de clientes femeninos que han realizado compras
delimiter // 
create function clientes_femeninos ()
returns varchar(60) deterministic
begin
	declare clientes_F varchar(50);
	set clientes_F = (select cantidad_cliente from (select   count(id_cliente) as cantidad_cliente from registro_pagos  rp inner join registro_compras rc
	on rp.id_compra = rc.id inner join clientes c on rc.id_cliente=c.id  where c.sexo='F' order by 1 desc  limit 1 )as obtener);
	return clientes_F;
end // 
delimiter ;

select clientes_femeninos();

-- 19. crear una funcion que calcule la cantidad de empleados masculinos 
delimiter // 
create function empleados_masculinos ()
returns varchar(60) deterministic
begin
	declare empleado_M varchar(50);
	set empleado_M = (select empleado_masculinos_cantidad from (select   count(id_empleado) as empleado_masculinos_cantidad  from registro_pagos  rp 
	inner join empleados e on rp.id_empleado=e.id where e.sexo='M'order by 1 desc  limit 1 )as obtener);
	return empleado_M;
end // 
delimiter ;

select empleados_masculinos();

-- 20.crear una funcion que calcule la cantidad de empleados femeninos 
delimiter // 
create function empleados_femeninos ()
returns varchar(60) deterministic
begin
	declare empleado_F varchar(50);
	set empleado_F = (select empleado_femenino_cantidad from (select count(id_empleado) as empleado_femenino_cantidad from registro_pagos  rp 
	inner join empleados e on rp.id_empleado=e.id where e.sexo='F'order by 1 desc  limit 1 )as obtener);
	return empleado_F;
end // 
delimiter ;

select empleados_femeninos();



