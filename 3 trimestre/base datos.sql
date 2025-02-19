 create table crud ( 
id int(11) primary key not null auto_increment,
nombre varchar(40) ,
correo varchar(40) ,
contraseña varchar(250) 
);

 create table registro (nombre varchar(40) primary key,
correo varchar(40) ,
contraseña varchar(250) ,
rol varchar(20) 
);

CREATE TABLE productos (
  id_producto INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  precio DECIMAL(10, 2) NOT NULL
);

CREATE TABLE detalles_factura (
  id_detalle INT AUTO_INCREMENT PRIMARY KEY,
  id_factura INT NOT NULL,
  id_producto INT NOT NULL,
  talla VARCHAR(10) NOT NULL,
  cantidad INT NOT NULL,
  FOREIGN KEY (id_factura) REFERENCES facturas(id_factura),
  FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

CREATE TABLE facturas (
  id_factura INT AUTO_INCREMENT PRIMARY KEY,
  codigo VARCHAR(50) NOT NULL UNIQUE,
  cliente VARCHAR(100) NOT NULL
);

