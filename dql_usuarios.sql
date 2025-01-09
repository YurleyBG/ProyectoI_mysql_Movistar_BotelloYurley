use Movistar;
-- usuario administrador con Acceso total al sistema.

CREATE USER 'Administrador'@'localhost' IDENTIFIED BY 'admi123';
GRANT ALL PRIVILEGES ON * . * TO 'Administrador'@'localhost';
SHOW GRANTS FOR 'Administrador'@'localhost';

-- usuario asesor de ventas con Gestión de servicios y usuarios asociados a bonificaciones.
CREATE USER 'Asesor de Ventas'@'localhost' IDENTIFIED BY 'AseV123';
GRANT ALL PRIVILEGES ON Movistar.servicios TO 'Asesor de Ventas'@'localhost';
GRANT select,update ON Movistar.clientes TO 'Asesor de Ventas'@'localhost';
GRANT ALL PRIVILEGES ON Movistar.bonificaciones TO 'Asesor de Ventas'@'localhost';
SHOW GRANTS FOR 'Asesor de Ventas'@'localhost';

-- usuario Encargado de Reportes con  Acceso exclusivo al módulo de reportes.

CREATE USER 'Encargado de Reportes'@'localhost' IDENTIFIED BY 'EnRe123';
GRANT ALL PRIVILEGES ON Movistar.Reportes TO 'Encargado de Reportes'@'localhost';
SHOW GRANTS FOR 'Encargado de Reportes'@'localhost';

-- usuario Gestor de Servicios con CRUD de servicios ofrecidos por la empresa.

CREATE USER 'Gestor de Servicios'@'localhost' IDENTIFIED BY 'GeSe123';
GRANT create,select,delete,update ON Movistar.servicios TO 'Gestor de Servicios'@'localhost';
SHOW GRANTS FOR 'Gestor de Servicios'@'localhost';

-- usuario Encargado de Fidelización con Gestión de clientes leales y bonificaciones.

CREATE USER 'Encargado de Fidelización'@'localhost' IDENTIFIED BY 'EnFi123';
GRANT ALL PRIVILEGES ON Movistar.bonificaciones TO 'Encargado de Fidelización'@'localhost';
GRANT select,update ON Movistar.clientes TO 'Asesor de Ventas'@'localhost';
SHOW GRANTS FOR 'Encargado de Fidelización'@'localhost';

Select user from mysql.user;  