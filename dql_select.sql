use Movistar;

-- 1 mostrar los nombres y apellidos de todas las clientes mujeres.
select Nombre1,Nombre2,Apellido1, Apellido2 from clientes where sexo ='F';

-- 2. mostrar la cantidad de clientes de la ciudad de bogota 

select count(*) as Cantidad_clientes from clientes where ciudad='Bogota';

-- 3. mostrar las ciudades a la que pertenece cada clientes sin que estas repitan.

select distinct ciudad from clientes ;

-- 4. mostrar la cantidad de cliente que pertenecen a cada ciudad

select ciudad, count(ciudad) as cantidad_clientes from clientes group by 1;

-- 5. mostrar los clientes de apellido "garcia"

select CONCAT_WS( '', Nombre1,' ',Nombre2,' ', Apellido1,' ',Apellido2) as Nombre_Completo from clientes where Apellido1='Garcia' or Apellido2='Garcia';

-- 6. mostrar el nombre del cliente y la bonificaciones que obtuvo

select concat_ws( '',Nombre1,' ',Nombre2) as Nombre_cliente, Nombre as Bonificacion from clientes c inner join bonificaciones b on b.id=c.id_bonificaciones group by 1,2; 

-- 7. mostrar todos los datos de los cliente que su nombre comienza con "A"

select * from clientes where left (Nombre1,1)='A';

-- 8. mostrar todos los clientes que su cedula termina en 8

select * from clientes where right (cedula,1)='8';

-- 9. mostrar solo los clientes masculino que su numero de telefono termina en 7.

select * from clientes where sexo='M' and right(telefono,1)=7;

-- 10. mostrar todos lo clientes con bonificaciones null y 4

select * from clientes where id_bonificaciones is null or id_bonificaciones=4;

-- 11. mostrar todos los servicios de movistar sin repetir

select distinct Nombre from servicios ;

-- 12. mostrar los servicio y el precio

select distinct Nombre, precio from servicios ;

-- 13. mostrar el servicio junto con el tipo y marca del dispositivo.

select Nombre, marca,d.tipo from servicios s inner join Dispositivos d on d.id=s.id_dispositivos ;

-- 14. mostrar los dispositivos y muestra la cantidad de servicios que este ofrece

 select d.* , count(s.id_dispositivos) cantidad_Servicios from dispositivos d inner join servicios s on d.id=s.id_dispositivos group by 1;
 
-- 15. muestra los tipos de dispositivos y su cantidad
select tipo , count(tipo) as cantidad from dispositivos group by 1;

-- 16. Muestre la fecha de registro junto a los nombres y apellidos que se encontraran en una sola columna , en total se deben mostrar solos dos columnas.
select CONCAT_WS( '', Nombre1,' ',Nombre2,' ', Apellido1,' ',Apellido2) as Nombre_Completo, fecha_registro1 from clientes inner join historico_fidelizacion
on clientes.id=historico_fidelizacion.id_cliente;

-- 17. mostrar todos los datos de la tabla historico_fidelizacion
select * from historico_fidelizacion;

-- 18. mostrar los nombres y apellidos de los 3 clientes con mayor cantidad de interacciones 
select CONCAT_WS( '', Nombre1,' ',Nombre2,' ', Apellido1,' ',Apellido2) as Nombre_Completo, Cantidad_interacciones from clientes inner join historico_fidelizacion
on clientes.id=historico_fidelizacion.id_cliente order by 2 desc limit 3;

-- 19. mostrar los nombres y apellidos de los 3 clientes con menor cantidad de interacciones 
select CONCAT_WS( '', Nombre1,' ',Nombre2,' ', Apellido1,' ',Apellido2) as Nombre_Completo, Cantidad_interacciones from clientes inner join historico_fidelizacion
on clientes.id=historico_fidelizacion.id_cliente order by 2  limit 3;

-- 20. cuantos clientes se registraron en 2024
select count(*) as  clientes_registrados_2024 from historico_fidelizacion where year(fecha_registro1)=2024;

-- 21. cuantos clientess estan inactivos
select count(*) as  clientes_inactivos from historico_fidelizacion where tipo_cliente='inactivo';

-- 22. cuantos clientes son leales 
select count(*) as  clientes_inactivos from historico_fidelizacion where tipo_cliente='leal';

-- 23. cuantos clientes son nuevos
select count(*) as  clientes_inactivos from historico_fidelizacion where tipo_cliente='nuevo';

-- 24.  mostrar las cantidad de clientes que hicieron su ultimo registro en el 2025
select count(*) as  clientes_ultimo_registro_2024 from historico_fidelizacion where year(Fecha_ultimo_registro)=2025;

-- 25. mostrar la tabla cliente
select * from clientes;

-- 26. mostrar todos los planes de movistar sin repetir

select distinct Nombre from planes ;

-- 27. mostrar los planes y el precio

select distinct Nombre, precio from planes ;

-- 28. mostrar el planes junto con el tipo y marca del dispositivo.

select Nombre, marca,d.tipo from planes p inner join Dispositivos d on d.id=p.id_dispositivos ;

-- 29. mostrar los dispositivos y muestra la cantidad de planes que este ofrece

 select d.* , count(p.id_dispositivos) cantidad_planes from dispositivos d inner join planes p on d.id=p.id_dispositivos group by 1;
  
-- 30. mostrar todos los datos de la tabla planes
select * from planes;

-- 31.  mostrar todas la bonificaciones que han expirados 
select id,nombre,estado from bonificaciones where estado='expirada';

-- 32. mostra las bonificaciones que comience con A
select * from bonificaciones where left (Nombre,1)='A';

-- 33.mostrar la bonificaciones que terminan en r
select * from bonificaciones where right (Nombre,1)='r';

-- 34. mostrar las bonificaciones que estan pendientes

select * from bonificaciones where estado='Pendiente';

-- 35. mostrar todos los datos de la tabla bonificacion
select * from bonificaciones;

-- 36. mostrar la id del cliente y la bonificacion obtenida
  select c.id , b.nombre from clientes c inner join bonificaciones b 
  on c.id_bonificaciones=b.id ;
  
-- 37. mostrar la bonificacion que mas se repitieron
  select count(c.id) as Cantidad , b.nombre from clientes c inner join bonificaciones b 
  on c.id_bonificaciones=b.id group by 2 ;
  
-- 38. mostrar la cantidad de bonificaciones que se tienen hasta el momento
select count(*) as cantidad_bonificaciones from bonificaciones;

-- 39.mostrar la bonificaciones que estaban prevista  con fecha de inicio del mes de marzo
select * from bonificaciones where month(fecha_inicio)='03';

-- 40. mostrar la tabla empleados con todos sus datos
select * from empleados;

-- 41 mostrar los nombres y apellidos de todas las empleadas mujeres.
select Nombre1,Nombre2,Apellido1, Apellido2 from empleados where sexo ='F';

-- 42. mostrar la cantidad de clientes de la ciudad de bogota 

select count(*) as Cantidad_empleadoss from empleados where ciudad='Bogota';

-- 43. mostrar las ciudades a la que pertenece cada clientes sin que estas repitan.

select distinct ciudad from empleados ;

-- 44. mostrar la cantidad de cliente que pertenecen a cada ciudad

select ciudad, count(ciudad) as cantidad_empleados from empleados group by 1;

-- 45. mostrar los empleados de apellido "garcia"

select CONCAT_WS( '', Nombre1,' ',Nombre2,' ', Apellido1,' ',Apellido2) as Nombre_Completo from empleados where Apellido1='Garcia' or Apellido2='Garcia';

-- 46. mostrar el nombre del empleados y su cargo

select concat_ws( '',Nombre1,' ',Nombre2) as Nombre_empleado, cargo from empleados ; 

-- 47. mostrar todos los datos de los empleados que su nombre comienza con "A"

select * from empleados where left (Nombre1,1)='A';

-- 48. mostrar todos los empleados que su cedula termina en 3

select * from empleados where right (cedula,1)='3';

-- 49. mostrar solo los empleados masculino que su numero de telefono termina en 4.

select * from empleados where sexo='f'and right(telefono,1)=2;

-- 50. mostrar todos lo empleados con cargo de Encargado de reportes

select * from empleados where cargo='Encargado de reportes';

-- 51. mostrar la tabla de reportes con todos los datos
select * from reportes ;

-- 52.mostrar la id y el estado de cda reporte
select  id, estado from reportes;

-- 53.mostrar los repotes inactivos
select* from reportes where estado='inactivo';

-- 54. mostrar el nombre del cliente que realizo el reporte
select reportes.id, CONCAT_WS( '', Nombre1,' ',Nombre2,' ', Apellido1,' ',Apellido2) as nombre_cliente from reportes 
inner join clientes on reportes.id_cliente=clientes.id;

-- 55. mostrar la cantidad de reportes 
select count(*) as cantidad_Reportes from reportes;

-- 56. mostrar todos los datos del reporte donde en la descripcion se muestra la siguiente informacion "cliente solicita"
select * from reportes where Descripcion like "%cliente solicita%";

-- 57. mostrar los reportes que tiene como palbra clave la siguiente frase " fibra optica"
select * from reportes where Nombre like "%fibra optica%";

-- 58. mostrar los servicios por el cual se presento el reporte solo debne estar la id del reporte, el nombre y el nombre del servicio
select r.id,id_cliente,s.nombre from reportes r inner join servicios s on 
r.id_servicio=s.id;

-- 59. mostrar los planes por el cual se presento el reporte solo debne estar la id del reporte, el nombre y el nombre del plan
select r.id,id_cliente,p.nombre from reportes r inner join planes p on 
r.id_plan=p.id;

-- 60. mostrar la tabla de historial ventas
select * from historial_ventas;

-- 61.calcular la suma total del dinero de las ventas
select sum(total_dinero_ventas) as acomulado_total from historial_ventas;

-- 62. mostrar la cantidad acomulada de los dias 19 del mes de diciembre del 2024
select sum(total_dinero_ventas) as acomulado_total from historial_ventas where day(fecha_registro)='19' ;

-- 63. mostrar los totales de ventas entre 150000 y300000 
select * from historial_ventas where  total_dinero_ventas between 150000 and 300000;

-- 64. mostrar los totales de ventas entre 300000 y 900000
select * from historial_ventas where  total_dinero_ventas between  300000 and 900000;

-- 65. mostrar cuales fueron las ganancia mas bajas y en que fecha se presentaron
select total_dinero_ventas , fecha_registro from historial_ventas order by 1 limit 3;

-- 66.  mostrar cuales fueron las ganancia mas altas y en que fecha se presentaron
select total_dinero_ventas , fecha_registro from historial_ventas order by 1 desc limit 3;

-- 67. contar la cantidad de ganacias que van de 180000 a 240000
select count(*) as cantidad from  historial_ventas where total_dinero_ventas between  180000 and 240000 ;

-- 68. calcular el promedio total del acomulado 
select avg(total_dinero_ventas) as acomulado_total from historial_ventas;

-- 69. calcular el promedio total del acomulado entre 180000 y 240000
select avg(cantidad) from(select sum(total_dinero_ventas) as cantidad from  historial_ventas where total_dinero_ventas between  180000 and 240000)as obtener;

-- 70.mostrar la tabla registros pagos 
select * from registro_pagos;

-- 71. hacer una subconsulta que permita encontrar el promedio de la suma del acomulado total de pagos
select avg(suma_total) from (select sum(total_pagar) as suma_total from registro_pagos)as obtener; 

-- 72. mostrar las formas de pagos y el promedio de cada una
select forma_pago, avg(cantidad) as promedio from (select forma_pago as forma_pago, count(*) as cantidad from registro_pagos group by 1) 
as obtener group by 1;

-- 73. mostra el nombre del empleado que realizo la venta del servicio o plan de movistar
select id_pago, nombre_empleado from (select  CONCAT_WS( '', Nombre1,' ',Nombre2,' ', Apellido1,' ',Apellido2) as nombre_empleado ,
 rp.id as id_pago from empleados inner join registro_pagos rp  on rp.id_empleado=empleados.id)as obtener;

-- 74.muestra la cantidad de ventas que ha realizado cada empleado
select nombre_empleado, cantidad_ventas from (select  CONCAT_WS( '', Nombre1,' ',Nombre2,' ', Apellido1,' ',Apellido2) as nombre_empleado , 
count(*) as cantidad_ventas  from empleados inner join registro_pagos rp  on rp.id_empleado=empleados.id group by 1)as obtener;

-- 75. mostrar la cantidad de registros de ventas que hay
select count(*) as cantidad from registro_pagos;

-- 76. contar la cantidad de ganacias que van de 180000 a 240000
select count(*) as cantidad from  registro_pagos where total_pagar between  180000 and 240000; 

-- 77.mostrar  las 5 ventas con mayor ganancia
select * from registro_pagos order by 3 desc limit 5 ;

-- 78. mostrar  las 5 ventas con menor ganancia
select * from registro_pagos order by 3 asc limit 5 ;

-- 79. mostrar de que forma se pagaron la mayor cantidad de ventas
select forma_pago, cantidad  from (select forma_pago as forma_pago, count(*) as cantidad from registro_pagos group by 1) 
as obtener group by 1 order by 2 desc limit 1;

-- 80.mostrar la tabla registro compra
select * from registro_compras;

-- 81. mostrar la cantidad  de compras que fueron canceladas
select count(*) as cantidad_compras_canceladas from registro_compras where estado='cancelado';

-- 82.hacer una subconsulta que nos de el promedio total del acomulado de los precio base que estan activos
select avg(suma) from(select sum(precio_base) as suma from registro_compras where estado='activo')as obtener;

-- 83.mostrar la cantidad de compra hechas por el cliente ,en solo dos columna una para nombre y apellidos del cliente y la cantidad de compra 
select CONCAT_WS( '', Nombre1,' ',Nombre2,' ', Apellido1,' ',Apellido2) as Nombre_Completo , count(rc.id_cliente) as total_compras from clientes c inner join registro_compras rc 
on c.id=rc.id_cliente group by 1;

-- 84. muestre las compras que tienen plan y servicio 
select * from registro_compras where id_plan is not null and id_servicios is not null ;

-- 85. muestres la compras que solo incluyeron servicio
select * from registro_compras where id_plan  is null;

-- 86.muestre las compras que solo incluyeron plan 
select * from registro_compras where id_servicios  is null;

-- 87. muestres la compras que estan inactivas
select * from registro_compras where estado='inactivo';

-- 88. cual fue el cliente que mas realizo compras en el 2024
select CONCAT_WS( '', Nombre1,' ',Nombre2,' ', Apellido1,' ',Apellido2) as Nombre_Completo , count(rc.id_cliente) as total_compras from clientes c inner join registro_compras rc 
on c.id=rc.id_cliente where year(fecha)=2024  group by 1 order by 2 desc limit 1 ;

-- 89. mostrar  las 5 ventas con mayor ganancia
select * from registro_compras order by 3 desc limit 5 ;

-- 90. mostrar  las 5 ventas con menor ganancia
select * from registro_compras order by 3 asc limit 5 ;

-- 91.calcular el total del precio de la compra segun el precio base del servicio y plan adquirido.
select id, precio_total_compra from (select rc.id, p.precio*s.precio as precio_total_compra from registro_compras rc inner join servicios s
on rc.id_servicios=s.id inner join planes p on rc.id_plan=p.id )as obtener;

-- 92. contar la cantidad de ganacias que van de 180000 a 240000
select count(*) as cantidad from  registro_pagos where total_pagar between  180000 and 240000; 

-- 93. contar la cantidad de ganacias que superan los 400000
select count(*) as cantidad from  registro_pagos where total_pagar>400000;

-- 94. contar la cantidad de ganacias que son mayor a 300000  
select count(*) as cantidad from  registro_pagos where total_pagar>300000;

-- 95. contar la cantidad de ganacias que son menor a 180000  
select count(*) as cantidad from  registro_pagos where total_pagar<180000;

-- 96. cual es el acomulado de las compras que siguen activas
select sum(precio_base) as acomulado_compras_activas from registro_compras where estado='activo';

-- 97.muestras las compra donde el id del cliente es igual a 12
select * from registro_compras where id_cliente=12;

-- 98. muestra las compras que se realizaron en los dias 15 de diciembre del 2024
select * from registro_compras where day(fecha)=15;

-- 99. muestre el servicio que mas fue adquirido
select servicio , cantidad from (select s.nombre as servicio,count(rc.id_servicios) as cantidad from registro_compras rc inner join servicios s
on rc.id_servicios=s.id group by 1  )as obtener order by 2 desc limit 1;

-- 100. muestre el plan que mas fue adquerido

select plan , cantidad from (select p.nombre as plan,count(rc.id_plan) as cantidad from registro_compras rc inner join planes p
on rc.id_plan=p.id group by 1  )as obtener order by 2 desc limit 1 ;