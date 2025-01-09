use Movistar;


-- 1. crear un trigger que cambie el cargo de los empleados y los datos viejos sean añadidos al historial de ventas
 delimiter //
 create trigger actualizar_cargo_empleados
 after update on empleados
 for each row 
 begin 
  insert into registros_antiguos (Fecha_registro,tipo, descripcion) values ('2025-01-06',old.cargo ,'accenso de cargo por su buen rendimientos en ventas al empleado que su id corresponde a "1"');
 end //
 delimiter ;
 
 update empleados  set cargo='Asesores de ventas' where id=1 ;
 
-- 2. cambiar el estado del reporte a inactivo y enviar detalles del reporte anterior a los registros antiguos
delimiter //
 create trigger actualizar_estado_reporte
 after update on reportes 
 for each row 
 begin 
  insert into registros_antiguos (Fecha_registro,tipo, descripcion) values ('2025-01-05',old.Nombre,old.descripcion);
 end //
 delimiter ;
 
 update reportes  set estado='Inactivo' where id=1 ;
 
-- 3. crear un trigger que actualice el estado de los servicios y los datos sean añadido a registros antiguos
delimiter //
 create trigger actualizar_estado_servicio
 after update on servicios 
 for each row 
 begin 
  insert into registros_antiguos (Fecha_registro,tipo, descripcion) values ('2025-01-05','servicio con id 1',old.descripcion);
 end //
 delimiter ;

 update servicios  set estado='Inactivo' where id=1 ;
 
-- 4.crear un trigger que actualice el estado de los planes y los datos sean añadido a registros antiguos
delimiter //
 create trigger actualizar_estado_plan
 after update on planes 
 for each row 
 begin 
  insert into registros_antiguos (Fecha_registro,tipo, descripcion) values ('2025-01-05','plan con id 2',old.descripcion);
 end //
 delimiter ;
 
 update planes  set estado='Inactivo' where id=2 ;
 
-- 5.  crear un trigger que elimine los  datos de la tabla registros antiguos segun la id ingresada
 delimiter //
 create trigger eliminar_datos_registrosAntiguos
 after delete on registros_antiguos
 for each row 
 begin 
	  delete from registros_antiguos where id=3;
 end //
 delimiter ;
 
 select* from registros_antiguos;
-- 6. crear un trigger que actualice el estado de las bonificaciones y los datos sean añadido a registros antiguos
delimiter //
 create trigger actualizar_estado_plan
 after update on planes 
 for each row 
 begin 
  insert into registros_antiguos (Fecha_registro,tipo, descripcion) values ('2025-01-05','plan con id 2',old.descripcion);
 end //
 delimiter ;

 update planes  set estado='Inactivo' where id=2 ;
 
-- 7.crear un trigger que actualice la bonificacion de los clientes y los datos sean añadido a registros antiguos
delimiter //
 create trigger actualizar_bonificacion_clienteclientes
 after update on clientes 
 for each row 
 begin 
  insert into registros_antiguos (Fecha_registro,tipo, descripcion) values ('2025-01-03','cliente con id 22',old.id_bonificaciones);
 end //
 delimiter ;

 update clientes  set id_bonificaciones=3 where id=22 ;
 
-- 8. crear un trigger que actualice el total de dinero de ventas y los datos sean añadido a registros antiguos
delimiter //
 create trigger actualizar_totalDinero
 after update on historial_ventas 
 for each row 
 begin 
  insert into registros_antiguos (Fecha_registro,tipo, descripcion) values ('2025-01-05','historial_ventas id 3',old.total_dinero_ventas);
 end //
 delimiter ;

 update historial_ventas  set total_dinero_ventas=510000 where id=3 ;
 
-- 9. crear un trigger que actualice el tipo de cliente y los datos sean añadido a registros antiguos
delimiter //
 create trigger actualizar_tipo_cliente
 after update on historico_fidelizacion 
 for each row 
 begin 
  insert into registros_antiguos (Fecha_registro,tipo, descripcion) values ('2025-01-05','historico_fidelizacion id 12',old.tipo_cliente);
 end //
 delimiter ;
 
 update historico_fidelizacion  set tipo_cliente='Nuevo' where id=12 ;
 
-- 10.crear un trigger que actualice el precio base y los datos sean añadido a registros antiguos
delimiter //
 create trigger actualizar_preciobase_RC
 after update on registro_compras 
 for each row 
 begin 
  insert into registros_antiguos (Fecha_registro,tipo, descripcion) values ('2025-01-05','registro compra con id 13',old.Precio_base);
 end //
 delimiter ;

 update registro_compras  set Precio_base=400000 where id=13 ;
 
-- 11.crear un trigger que actualice la forma de pago y los datos sean añadido a registros antiguos
delimiter //
 create trigger actualizar_formapago_RP
 after update on registro_pagos 
 for each row 
 begin 
  insert into registros_antiguos (Fecha_registro,tipo, descripcion) values ('2025-01-06','Registro Pago con id 10',old.Forma_pago);
 end //
 delimiter ;

 update registro_pagos  set Forma_pago='Tarjeta de crédito' where id=10 ;
 
-- 12.crear un trigger que actualice el total a pagar y los datos sean añadido a registros antiguos
delimiter //
 create trigger actualizar_totalPagar_RP
 after update on  registro_pagos
 for each row 
 begin 
  insert into registros_antiguos (Fecha_registro,tipo, descripcion) values ('2025-01-05','Registro pago con id 9',old.total_pagar);
 end //
 delimiter ;
 
 update registro_pagos  set total_pagar=330000 where id=9 ;
 
-- 13.crear un trigger que actualice el id del empleado en el registro compra y los datos sean añadido a registros antiguos
delimiter //
 create trigger actualizar_id_empleado_RP
 after update on registro_pagos 
 for each row 
 begin 
  insert into registros_antiguos (Fecha_registro,tipo, descripcion) values ('2025-01-03','registro pago con id 5',old.id_empleado);
 end //
 delimiter ;

 update  registro_pagos set id_empleado='4' where id=5 ;
 
-- 14. crear un trigger que actualice el nombre del reporte y los datos sean añadido a registros antiguos
delimiter //
 create trigger actualizar_nombre_reporte
 after update on reportes 
 for each row 
 begin 
  insert into registros_antiguos (Fecha_registro,tipo, descripcion) values ('2025-01-05','reporte con id 4',old.nombre);
 end //
 delimiter ;

 update Reportes  set nombre='Instalación Fibra Ópticas' where id=4 ;
 
-- 15. crear un trigger que actualice la descripcion del reporte y los datos sean añadido a registros antiguos
delimiter //
 create trigger actualizar_descripcion_reportes
 after update on reportes 
 for each row 
 begin 
  insert into registros_antiguos (Fecha_registro,tipo, descripcion) values ('2025-01-06','reporte con id 3',old.descripcion);
 end //
 delimiter ;

 update reportes  set descripcion='Pago Tardio' where id=3 ;
-- 16.crear un trigger que actualice la fecha del reporte y los datos sean añadido a registros antiguos
delimiter //
 create trigger actualizar_fecha_reporte
 after update on Reportes
 for each row 
 begin 
  insert into registros_antiguos (Fecha_registro,tipo, descripcion) values ('2025-01-05','reporte id 2',old.fecha);
 end //
 delimiter ;

 update reportes  set fecha='2025-01-03' where id=2 ;
 
-- 17. crear un trigger que actualice el precio del servicio y los datos sean añadido a registros antiguos
delimiter //
 create trigger actualizar_precio_servicios
 after update on servicios 
 for each row 
 begin 
  insert into registros_antiguos (Fecha_registro,tipo, descripcion) values ('2025-01-05','servicio con id 2',old.precio);
 end //
 delimiter ;

 update servicios  set precio='280' where id=2 ;
 
-- 18. crear un trigger que actualice el precio de los planes y los datos sean añadido a registros antiguos
delimiter //
 create trigger actualizar_precio_plan
 after update on planes 
 for each row 
 begin 
  insert into registros_antiguos (Fecha_registro,tipo, descripcion) values ('2025-01-05','plan con id 2',old.precio);
 end //
 delimiter ;

 update planes  set precio='70' where id=2 ;
 
-- 19. crear un trigger que actualice el tipo de los servicios y los datos sean añadido a registros antiguos
delimiter //
 create trigger actualizar_precio_servicio
 after update on servicios 
 for each row 
 begin 
  insert into registros_antiguos (Fecha_registro,tipo, descripcion) values ('2025-01-06','actualizar servicio con id 2',old.tipo);
 end //
 delimiter ;

 update servicios  set Tipo='Fijo' where id=2 ;
 
-- 20.crear un trigger que actualice el tipo de plan y los datos sean añadido a registros antiguos
delimiter //
 create trigger actualizar_tipo_plan
 after update on planes 
 for each row 
 begin 
  insert into registros_antiguos (Fecha_registro,tipo, descripcion) values ('2025-01-05','actualizar tipo plan id es 2',old.tipo);
 end //
 delimiter ;

 update planes  set Tipo='Fijo' where id=2 ;