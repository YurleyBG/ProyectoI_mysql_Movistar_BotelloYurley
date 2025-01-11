# MOVISTAR
## Proyecto MYSQL

El objetivo de este proyecto fue diseñar y desarrollar un sistema de base de datos integral que permita a Movistar gestionar de manera eficiente sus servicios, mejorar la fidelización de clientes y optimizar la toma de decisiones estratégicas mediante el análisis de datos. Este sistema incluirá módulos específicos para la gestión de usuarios, servicios, reportes y bonificaciones, asegurando una solución robusta y escalable.

# Requisitos del sistema , Instalación y Ejecucion

Se requiere de la app mysql workbench en la pc  para poder ejecutar los script.

Al tener el primer requisito lo siguiente que debera hacer es clonar el repositorio  en git bash usando el siguiente comando
`git clone https://github.com/YurleyBG/ProyectoI_mysql_Movistar_BotelloYurley.git`
despues de haber hecho eso debe obtener la carpeta en tus archivos, luego accederas a mysql workbench y abriras inicialmente el archivo ddl que contiene las tablas de la base de datos,
luego el dml que son las inserciones para cada tabla y asi con cada archivo.

para ejecutar cada archivo deberas hacerlo con el rayito en la parte superior.

# Estructura de la Base de Datos

+ ddl: Contiene las tablas.
+ dml: Contiene los insert para cada tabla.
+ dql_usuario: Contiene 5 usuarios cada uno con permisos diferente a la hora de ingresar a la base de datos.
+ dql_select: Contiene 100 consultas posibles dentro de dicha base.
+ dql_procedimientos: Contiene 20 procedimientos posibles.
+ dql_funciones: Contiene 20  funciones posibles.
+ dql_event: Contiene 20 eventos posibles dentro de la base de datos.
+ dql_triggers: Contiene 20 eventos posibles en la base de datos.
+ diagrama.png: Contiene el diagrama lògico para el analice de la base de datos.

# Consultas
Se trata de una forma de acceder a las bases de datos y de realizar operaciones basica y complejas.

``` sql
	 mostrar los nombres y apellidos de todas las clientes mujeres.
	select Nombre1,Nombre2,Apellido1, Apellido2 from clientes where sexo ='F';
	select id, precio_total_compra from (select rc.id, p.precio*s.precio as precio_total_compra from registro_compras rc inner join servicios s
	on rc.id_servicios=s.id inner join planes p on rc.id_plan=p.id )as obtener;
```
# Procedimientos
Estan funciones buscan realizar acciones de manera ordenada  para obtener un resultado especificas como actualizar, eliminar o insertar nuevos datos.
```sql
  crear un procedimiento que permita insertar nuevas bonificaciones
  Delimiter //
  create procedure Agregarbonificacion(in Nombre varchar(30), Descripcion text,Estado ENUM('Pendiente', 'Expirada'),Fecha_inicio date,
  Fecha_fin date )
  begin
  	INSERT INTO bonificaciones (Nombre, Descripcion, Estado, Fecha_inicio, Fecha_fin) VALUES (Nombre, Descripcion, Estado, Fecha_inicio, Fecha_fin);
  end // 
  Delimiter ;
  call Agregarbonificacion('Mega lunes', 'Doble de datos el lunes', 'Pendiente', '2025-01-03','2025-01-04' );
```

# Triggers
 son objetos de base de datos que se activan cuando se produce un evento en una tabla
```sql
 crear un trigger que cambie el cargo de los empleados y los datos viejos sean añadidos al historial de ventas
 delimiter //
 create trigger actualizar_cargo_empleados
 after update on empleados
 for each row 
 begin 
  insert into registros_antiguos (Fecha_registro,tipo, descripcion) values ('2025-01-06',old.cargo ,'accenso de cargo por su buen rendimientos en ventas al empleado que su id corresponde a "1"');
 end //
 delimiter ;
 update empleados  set cargo='Asesores de ventas' where id=1 ;
```
# Eventos
son tareas que se ejecutan de manera programada, es decir, según un cronograma predefinido. 
```sql
  crear un evento que utilice el anterior procedimiento (-- 1. crear un procedimiento que permita insertar nuevas bonificaciones) cada  semana
delimiter //
create event nuevas_bonificaciones
on  schedule every 1 week
do 
begin 
	call Agregarbonificacion('Mega sabado', 'Doble de datos el sabado', 'Expirada', '2025-01-03','2025-01-04' );
end //
delimiter ;
```
# Creditos
Este proyecto fue desarrollado por Yurley Botello Garcia.


