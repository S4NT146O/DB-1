CREATE database quinta;
use quinta;


CREATE TABLE `quinta`.`jaula` (
  `Id_jaula` INT(5) NOT NULL AUTO_INCREMENT,
  `Id_producto` INT(5) NOT NULL,
  `cantidad` int(5) NOT NULL,
  `fecha` Timestamp(6) NOT NULL,
  PRIMARY KEY (`Id_jaula`)
);

CREATE TABLE `quinta`.`producto` (
  `ID_Producto` INT(5) NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(20) NOT NULL,
  `Descrip` VARCHAR(250) NOT NULL,
  `Precio` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`ID_Producto`)
);



CREATE TABLE `quinta`.`cliente` (
  `ID_Cliente` INT(5) NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(25) NOT NULL,
  `Direccion` VARCHAR(250) NOT NULL,
  `Telefono` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`ID_Cliente`)
);

CREATE TABLE `quinta`.`pedido` (
  `ID_pedido` INT(5) NOT NULL AUTO_INCREMENT,
  `ID_jaula` INT(5) NOT NULL,
  `ID_Cliente` INT(5) NOT NULL,
  `Cantidad` INT(5) NOT NULL,
  `PrecioVenta` decimal(10,2) NOT NULL,
  `DireccionEnvio` Varchar(45) NOT NULL,
  `Fecha` Timestamp(6),
  PRIMARY KEY (`ID_pedido`),
  FOREIGN KEY (`ID_jaula`) REFERENCES `jaula`(`Id_jaula`),
  FOREIGN KEY (`ID_Cliente`) REFERENCES `cliente`(`ID_Cliente`)
);

INSERT INTO quinta.cliente(Nombre,Direccion,Telefono)
VALUES ('Carlos','Martinez 777','260444444'),
        ('Esteban','Messi 152','2604474587'),
        ('Gianfranco','Garnacho 1227','2604877520');

INSERT INTO quinta.producto (Nombre,Descrip,Precio)
VALUES ('Durazno','Primera produccion de durazno del dia','20'),
        ('Durazno','Segunda produccion de durazno del dia','20'),
        ('Durazno','Tercera produccion de durazno del dia','20');

INSERT INTO quinta.jaula (Id_producto,cantidad,fecha)
VALUES ('1','20',current_timestamp()),
        ('2','20',current_timestamp());

INSERT INTO quinta.pedido (ID_jaula,ID_Cliente,Cantidad,PrecioVenta,DireccionEnvio,Fecha)
VALUES ('1', '1', '2', '5.2', 'Roca 123', current_timestamp()),
        ('1', '2', '2', '2.1', 'Espanha 123', current_timestamp()),
        ('1', '3', '2', '5.2', 'Villegas 123', current_timestamp());



#consulta de stock de un determinado dia
select ID_jaula "ID de la jaula: ",
    (select P.Nombre from producto P where P.ID_Producto = D.ID_Producto) "Producto: ",
    (select P.Descrip from producto P where P.ID_Producto = D.ID_Producto) "Descripcion Producto: ",
    cantidad,
    fecha
from jaula D
where date(fecha) = date('2024-02-20');

#consulta de ventas registradas en una determinada fecha
SELECT
    date(P.Fecha) as "Fecha de Venta",
    SUM(P.PrecioVenta * P.Cantidad) as "Total de Ventas"
FROM
    quinta.pedido P
WHERE
    date(P.Fecha) = date('2024-02-20')
GROUP BY
    date(P.Fecha);


#consulta de pedidos en una determinada fecha
select ID_pedido "ID Pedido: ",
	(select P.Nombre from producto P where P.ID_Producto = (select D.ID_Producto from jaula D where D.ID_jaula = PE.ID_jaula)) "Producto: ",
    (select P.Descrip from producto P where P.ID_Producto = (select D.ID_Producto from jaula D where D.ID_jaula = PE.ID_jaula)) "Descripcion: ",
    (select C.Nombre from cliente C where C.ID_Cliente = PE.ID_Cliente) "Nombre Cliente: ",
    Cantidad,
    DireccionEnvio "Direccion del Envio: ",
    PrecioVenta "Precio: ",
    Fecha "Fecha: "
from pedido PE
where date(Fecha) = date('2024-02-20');
