CREATE database horno;
use horno;


CREATE TABLE `horno`.`deposito` (
  `Id_deposito` INT(5) NOT NULL AUTO_INCREMENT,
  `Id_producto` INT(5) NOT NULL,
  `cantidad` int(5) NOT NULL,
  `fecha` Timestamp(6) NOT NULL,
  PRIMARY KEY (`Id_deposito`)
);

CREATE TABLE `horno`.`producto` (
  `ID_Producto` INT(5) NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(20) NOT NULL,
  `Descrip` VARCHAR(250) NOT NULL,
  `Precio` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`ID_Producto`)
);

ALTER TABLE `horno`.`producto`
ADD COLUMN `Id_deposito` INT(5) NOT NULL,
ADD FOREIGN KEY (`Id_deposito`) REFERENCES `deposito`(`Id_deposito`);

CREATE TABLE `horno`.`cliente` (
  `ID_Cliente` INT(5) NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(25) NOT NULL,
  `Direccion` VARCHAR(250) NOT NULL,
  `Telefono` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`ID_Cliente`)
);

CREATE TABLE `horno`.`pedido` (
  `ID_pedido` INT(5) NOT NULL AUTO_INCREMENT,
  `ID_deposito` INT(5) NOT NULL,
  `ID_Cliente` INT(5) NOT NULL,
  `Cantidad` INT(5) NOT NULL,
  `PrecioVenta` decimal(10,2) NOT NULL,
  `DireccionEnvio` Varchar(45) NOT NULL,
  `Fecha` Timestamp(6),
  PRIMARY KEY (`ID_pedido`),
  FOREIGN KEY (`ID_deposito`) REFERENCES `deposito`(`Id_deposito`),
  FOREIGN KEY (`ID_Cliente`) REFERENCES `cliente`(`ID_Cliente`)
);

INSERT INTO `horno`.`cliente`('Nombre','Direccion','Telefono')
VALUES ('Carlos','Lugones 777','260444444'),
        ('Esteban','Olavarria 152','2604474587'),
        ('Gianfranco','Garnacho 1227','2604877520');

INSERT INTO 'horno'.'producto' ('Nombre','Descript','Precio'),
VALUES ('Ladrillo','Ladrillo comun de toda la vida','50'),
        ('Adobon','Ladrillo de adobon','100');

INSERT INTO 'horno'.'deposito' ('Id_producto','cantidad','fecha')
VALUES ('1','1500',current_timestamp()),
        ('2','3500',current_timestamp());

INSERT INTO 'horno', 'pedido' ('ID_deposito','ID_Cliente','Cantidad','PrecioVenta','DireccionEnvio','Fecha')
VALUES ('1', '1', '2', 'Roca 123', '5,2', current_timestamp());
        ('1', '1', '2', 'Espanha 123', '2,1', current_timestamp());
        ('1', '1', '2', 'Villegas 123', '5,3', current_timestamp());



select ID_deposito "ID del Deposito: ",
    (select P.Nombre from producto P where P.ID_Producto = D.ID_Producto) "Producto: ",
    (select P.Descrip from producto P where P.ID_Producto = D.ID_Producto) "Descripcion Producto: ",
    cantidad,
    fecha
from deposito D
where date(fecha) = date('2024-02-19');