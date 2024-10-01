create database sistemaDevolucionUniformesEscolares;
USE sistemaDevolucionUniformesEscolares;

-- Crear tabla de usuarios
CREATE TABLE Usuarios (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre_usuario VARCHAR(50) NOT NULL,
    rol ENUM('usuario', 'administrador') NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    contrasena VARBINARY(255) NOT NULL
);

-- Crear tabla de productos
CREATE TABLE Productos (
    id_producto INT PRIMARY KEY AUTO_INCREMENT,
    nombre_producto VARCHAR(100) NOT NULL,
    tipo_producto ENUM('camisa', 'zapatos', 'cinturon') NOT NULL,
    talla VARCHAR(10) NOT NULL,
    cantidad INT NOT NULL
);

-- Crear tabla de devoluciones
CREATE TABLE Devoluciones (
    id_devolucion INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    id_producto INT,
    fecha_devolucion DATE NOT NULL,
    cantidad_devolucion INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);

-- Insertar datos de usuarios (15 usuarios y 15 administradores)
INSERT INTO Usuarios (nombre_usuario, rol, email, contrasena)
VALUES 
('usuario1', 'usuario', 'usuario1@mail.com', SHA2('password1', 256)),
('usuario2', 'usuario', 'usuario2@mail.com', SHA2('password2', 256)),
('usuario3', 'usuario', 'usuario3@mail.com', SHA2('password3', 256)),
('usuario4', 'usuario', 'usuario4@mail.com', SHA2('password4', 256)),
('usuario5', 'usuario', 'usuario5@mail.com', SHA2('password5', 256)),
('usuario6', 'usuario', 'usuario6@mail.com', SHA2('password6', 256)),
('usuario7', 'usuario', 'usuario7@mail.com', SHA2('password7', 256)),
('usuario8', 'usuario', 'usuario8@mail.com', SHA2('password8', 256)),
('usuario9', 'usuario', 'usuario9@mail.com', SHA2('password9', 256)),
('usuario10', 'usuario', 'usuario10@mail.com', SHA2('password10', 256)),
('usuario11', 'usuario', 'usuario11@mail.com', SHA2('password11', 256)),
('usuario12', 'usuario', 'usuario12@mail.com', SHA2('password12', 256)),
('usuario13', 'usuario', 'usuario13@mail.com', SHA2('password13', 256)),
('usuario14', 'usuario', 'usuario14@mail.com', SHA2('password14', 256)),
('usuario15', 'usuario', 'usuario15@mail.com', SHA2('password15', 256)),
('admin1','administrador', 'admin1@mail.com', SHA2('adminpassword1', 256)),
('admin2','administrador', 'admin2@mail.com', SHA2('adminpassword2', 256)),
('admin3','administrador', 'admin3@mail.com', SHA2('adminpassword3', 256)),
('Admin 4','administrador', 'admin4@ejemplo.com', SHA2('contrasenaA4', 256)),
('Admin 5','administrador', 'admin5@ejemplo.com', SHA2('contrasenaA5', 256)),
('Admin 6','administrador', 'admin6@ejemplo.com', SHA2('contrasenaA6', 256)),
('Admin 7','administrador', 'admin7@ejemplo.com', SHA2('contrasenaA7', 256)),
('Admin 8','administrador', 'admin8@ejemplo.com', SHA2('contrasenaA8', 256)),
('Admin 9','administrador', 'admin9@ejemplo.com', SHA2('contrasenaA9', 256)),
('Admin 10','administrador', 'admin10@ejemplo.com', SHA2('contrasenaA10', 256)),
('Admin 11','administrador', 'admin11@ejemplo.com', SHA2('contrasenaA11', 256)),
('Admin 12','administrador','admin12@ejemplo.com', SHA2('contrasenaA12', 256)),
('Admin 13','administrador', 'admin13@ejemplo.com', SHA2('contrasenaA13', 256)),
('Admin 14','administrador', 'admin14@ejemplo.com', SHA2('contrasenaA14', 256)),
('Admin 15','administrador', 'admin15@ejemplo.com', SHA2('contrasenaA15', 256));

select * from usuarios;

-- Insertar datos de productos
INSERT INTO Productos (nombre_producto, tipo_producto, talla, cantidad)
VALUES
('Camisa Escolar', 'camisa', 'M', 100),
('Zapatos Negros', 'zapatos', '40', 50),
('Cinturón Negro', 'cinturon', 'L', 70);

select * from productos;

-- Insertar datos de devoluciones
INSERT INTO Devoluciones (id_usuario, id_producto, fecha_devolucion, cantidad_devolucion)
VALUES
(1, 1, '2024-09-15', 1),
(2, 2, '2024-09-16', 1),
(3, 3, '2024-09-17', 2);

select*from devoluciones;

-----------------------------------------------------------------------------------------------

-- consultas de inner join

-- Ejemplo 1: Obtener todas las devoluciones con los nombres de los productos y los usuarios.
SELECT Usuarios.nombre_usuario, Productos.nombre_producto, Devoluciones.fecha_devolucion
FROM Devoluciones
INNER JOIN Usuarios ON Devoluciones.id_usuario = Usuarios.id_usuario
INNER JOIN Productos ON Devoluciones.id_producto = Productos.id_producto;

-- Ejemplo 2: Obtener productos devueltos por un usuario específico.
SELECT Usuarios.nombre_usuario, Productos.nombre_producto
FROM Devoluciones
INNER JOIN Usuarios ON Devoluciones.id_usuario = Usuarios.id_usuario
INNER JOIN Productos ON Devoluciones.id_producto = Productos.id_producto
WHERE Usuarios.nombre_usuario = 'usuario1';

-- Ejemplo 3: Obtener la cantidad de productos devueltos por usuario.
SELECT Usuarios.nombre_usuario, SUM(Devoluciones.cantidad_devolucion) AS total_devuelto
FROM Devoluciones
INNER JOIN Usuarios ON Devoluciones.id_usuario = Usuarios.id_usuario
GROUP BY Usuarios.nombre_usuario;

-- Ejemplo 4: Obtener la fecha de devolución y el nombre del producto para un usuario específico.
SELECT Usuarios.nombre_usuario, Productos.nombre_producto, Devoluciones.fecha_devolucion
FROM Devoluciones
INNER JOIN Usuarios ON Devoluciones.id_usuario = Usuarios.id_usuario
INNER JOIN Productos ON Devoluciones.id_producto = Productos.id_producto
WHERE Usuarios.nombre_usuario = 'usuario2';

-- Ejemplo 5: Listar las devoluciones junto con el tipo de producto devuelto.
SELECT Usuarios.nombre_usuario, Productos.tipo_producto, Devoluciones.fecha_devolucion
FROM Devoluciones
INNER JOIN Usuarios ON Devoluciones.id_usuario = Usuarios.id_usuario
INNER JOIN Productos ON Devoluciones.id_producto = Productos.id_producto;

-- Ejemplo 6: Obtener la cantidad devuelta por producto específico.
SELECT Productos.nombre_producto, SUM(Devoluciones.cantidad_devolucion) AS total_devuelto
FROM Devoluciones
INNER JOIN Productos ON Devoluciones.id_producto = Productos.id_producto
GROUP BY Productos.nombre_producto;

-- Ejemplo 7: Mostrar todos los usuarios que han devuelto zapatos.
SELECT Usuarios.nombre_usuario, Productos.nombre_producto
FROM Devoluciones
INNER JOIN Usuarios ON Devoluciones.id_usuario = Usuarios.id_usuario
INNER JOIN Productos ON Devoluciones.id_producto = Productos.id_producto
WHERE Productos.tipo_producto = 'zapatos';

-- Ejemplo 8: Mostrar productos devueltos y sus respectivas tallas.
SELECT Productos.nombre_producto, Productos.talla, Devoluciones.cantidad_devolucion
FROM Devoluciones
INNER JOIN Productos ON Devoluciones.id_producto = Productos.id_producto;

-- Ejemplo 9: Obtener los productos devueltos por un usuario con rol 'administrador'.
SELECT Usuarios.nombre_usuario, Productos.nombre_producto
FROM Devoluciones
INNER JOIN Usuarios ON Devoluciones.id_usuario = Usuarios.id_usuario
INNER JOIN Productos ON Devoluciones.id_producto = Productos.id_producto
WHERE Usuarios.rol = 'administrador';

-- Ejemplo 10: Listar todas las devoluciones con el nombre del usuario y producto.
SELECT Usuarios.nombre_usuario, Productos.nombre_producto, Devoluciones.fecha_devolucion
FROM Devoluciones
INNER JOIN Usuarios ON Devoluciones.id_usuario = Usuarios.id_usuario
INNER JOIN Productos ON Devoluciones.id_producto = Productos.id_producto;

-- Ejemplo 11: Mostrar la cantidad de devoluciones realizadas por cada usuario.
SELECT Usuarios.nombre_usuario, COUNT(Devoluciones.id_devolucion) AS total_devoluciones
FROM Devoluciones
INNER JOIN Usuarios ON Devoluciones.id_usuario = Usuarios.id_usuario
GROUP BY Usuarios.nombre_usuario;

-- Ejemplo 12: Mostrar los productos que han sido devueltos más de una vez.
SELECT Productos.nombre_producto, COUNT(Devoluciones.id_devolucion) AS veces_devueltas
FROM Devoluciones
INNER JOIN Productos ON Devoluciones.id_producto = Productos.id_producto
GROUP BY Productos.nombre_producto
HAVING COUNT(Devoluciones.id_devolucion) > 1;

-- Ejemplo 13: Mostrar devoluciones realizadas en el mes actual.
SELECT Usuarios.nombre_usuario, Productos.nombre_producto, Devoluciones.fecha_devolucion
FROM Devoluciones
INNER JOIN Usuarios ON Devoluciones.id_usuario = Usuarios.id_usuario
INNER JOIN Productos ON Devoluciones.id_producto = Productos.id_producto
WHERE MONTH(Devoluciones.fecha_devolucion) = MONTH(CURDATE());

-- Ejemplo 14: Listar los administradores que han registrado devoluciones.
SELECT Usuarios.nombre_usuario, Productos.nombre_producto, Devoluciones.fecha_devolucion
FROM Devoluciones
INNER JOIN Usuarios ON Devoluciones.id_usuario = Usuarios.id_usuario
INNER JOIN Productos ON Devoluciones.id_producto = Productos.id_producto
WHERE Usuarios.rol = 'administrador';

-- Ejemplo 15: Obtener los nombres de los productos devueltos por más de 2 unidades.
SELECT Productos.nombre_producto
FROM Devoluciones
INNER JOIN Productos ON Devoluciones.id_producto = Productos.id_producto
WHERE Devoluciones.cantidad_devolucion > 2;

-- consultas de left join

-- Ejemplo 1: Obtener todas las devoluciones, incluso si un usuario no ha devuelto productos.
SELECT Usuarios.nombre_usuario, Devoluciones.cantidad_devolucion
FROM Usuarios
LEFT JOIN Devoluciones ON Usuarios.id_usuario = Devoluciones.id_usuario;

-- Ejemplo 2: Ver todas las devoluciones y detalles de productos, incluso si no se han devuelto ciertos productos.
SELECT Productos.nombre_producto, Devoluciones.cantidad_devolucion
FROM Productos
LEFT JOIN Devoluciones ON Productos.id_producto = Devoluciones.id_producto;

-- Ejemplo 3: Mostrar todos los usuarios y las devoluciones que han realizado (si las hay).
SELECT Usuarios.nombre_usuario, Devoluciones.fecha_devolucion
FROM Usuarios
LEFT JOIN Devoluciones ON Usuarios.id_usuario = Devoluciones.id_usuario;

-- Ejemplo 4: Mostrar todos los productos y sus devoluciones (si han sido devueltos).
SELECT Productos.nombre_producto, Devoluciones.cantidad_devolucion
FROM Productos
LEFT JOIN Devoluciones ON Productos.id_producto = Devoluciones.id_producto;

-- Ejemplo 5: Ver todos los usuarios, incluyendo aquellos sin devoluciones.
SELECT Usuarios.nombre_usuario, Devoluciones.cantidad_devolucion
FROM Usuarios
LEFT JOIN Devoluciones ON Usuarios.id_usuario = Devoluciones.id_usuario;

-- Ejemplo 6: Obtener la lista de usuarios con sus devoluciones, incluyendo aquellos sin devoluciones.
SELECT Usuarios.nombre_usuario, Productos.nombre_producto
FROM Usuarios
LEFT JOIN Devoluciones ON Usuarios.id_usuario = Devoluciones.id_usuario
LEFT JOIN Productos ON Devoluciones.id_producto = Productos.id_producto;

-- Ejemplo 7: Obtener todos los productos devueltos por un usuario, si los hay.
SELECT Usuarios.nombre_usuario, Productos.nombre_producto
FROM Usuarios
LEFT JOIN Devoluciones ON Usuarios.id_usuario = Devoluciones.id_usuario
LEFT JOIN Productos ON Devoluciones.id_producto = Productos.id_producto
WHERE Usuarios.nombre_usuario = 'usuario3';

-- Ejemplo 8: Listar todos los usuarios y si han devuelto algún cinturón.
SELECT Usuarios.nombre_usuario, Devoluciones.cantidad_devolucion
FROM Usuarios
LEFT JOIN Devoluciones ON Usuarios.id_usuario = Devoluciones.id_usuario
LEFT JOIN Productos ON Devoluciones.id_producto = Productos.id_producto
WHERE Productos.tipo_producto = 'cinturon';

-- Ejemplo 9: Mostrar todos los productos, indicando si han sido devueltos por un usuario específico.
SELECT Productos.nombre_producto, Devoluciones.cantidad_devolucion
FROM Productos
LEFT JOIN Devoluciones ON Productos.id_producto = Devoluciones.id_producto
LEFT JOIN Usuarios ON Devoluciones.id_usuario = Usuarios.id_usuario
WHERE Usuarios.nombre_usuario = 'usuario4';

-- Ejemplo 10: Mostrar usuarios y productos devueltos, incluso si no hay devoluciones.
SELECT Usuarios.nombre_usuario, Productos.nombre_producto
FROM Usuarios
LEFT JOIN Devoluciones ON Usuarios.id_usuario = Devoluciones.id_usuario
LEFT JOIN Productos ON Devoluciones.id_producto = Productos.id_producto;

-- Ejemplo 11: Listar todos los usuarios con devoluciones de productos, si las tienen.
SELECT Usuarios.nombre_usuario, Devoluciones.cantidad_devolucion
FROM Usuarios
LEFT JOIN Devoluciones ON Usuarios.id_usuario = Devoluciones.id_usuario;

-- Ejemplo 12: Mostrar productos y cantidad devuelta, incluso si no hay devoluciones.
SELECT Productos.nombre_producto, SUM(Devoluciones.cantidad_devolucion) AS total_devuelto
FROM Productos
LEFT JOIN Devoluciones ON Productos.id_producto = Devoluciones.id_producto
GROUP BY Productos.nombre_producto;

-- Ejemplo 13: Listar todas las devoluciones, incluyendo productos no devueltos.
SELECT Productos.nombre_producto, Devoluciones.cantidad_devolucion
FROM Productos
LEFT JOIN Devoluciones ON Productos.id_producto = Devoluciones.id_producto;

-- Ejemplo 14: Mostrar los productos que no han sido devueltos por ningún usuario.
SELECT Productos.nombre_producto
FROM Productos
LEFT JOIN Devoluciones ON Productos.id_producto = Devoluciones.id_producto
WHERE Devoluciones.id_devolucion IS NULL;

-- Ejemplo 15: Listar los usuarios que no han hecho devoluciones.
SELECT Usuarios.nombre_usuario
FROM Usuarios
LEFT JOIN Devoluciones ON Usuarios.id_usuario = Devoluciones.id_usuario
WHERE Devoluciones.id_devolucion IS NULL;

-- consultas de right join

-- Ejemplo 1: Obtener todas las devoluciones, incluso si no todos los productos han sido devueltos.
SELECT Productos.nombre_producto, Devoluciones.cantidad_devolucion
FROM Devoluciones
RIGHT JOIN Productos ON Devoluciones.id_producto = Productos.id_producto;

-- Ejemplo 2: Obtener devoluciones y detalles de usuarios, incluso si no todos los usuarios han hecho devoluciones.
SELECT Usuarios.nombre_usuario, Devoluciones.cantidad_devolucion
FROM Devoluciones
RIGHT JOIN Usuarios ON Devoluciones.id_usuario = Usuarios.id_usuario;

-- Ejemplo 3: Mostrar productos devueltos y detalles de usuario, incluso si el usuario no tiene productos devueltos.
SELECT Usuarios.nombre_usuario, Productos.nombre_producto
FROM Devoluciones
RIGHT JOIN Productos ON Devoluciones.id_producto = Productos.id_producto
RIGHT JOIN Usuarios ON Devoluciones.id_usuario = Usuarios.id_usuario;

-- Ejemplo 4: Mostrar devoluciones con detalles de productos, incluso si algunos productos no han sido devueltos.
SELECT Productos.nombre_producto, Devoluciones.cantidad_devolucion
FROM Devoluciones
RIGHT JOIN Productos ON Devoluciones.id_producto = Productos.id_producto;

-- Ejemplo 5: Obtener la lista de productos devueltos por los administradores.
SELECT Usuarios.nombre_usuario, Productos.nombre_producto
FROM Devoluciones
RIGHT JOIN Usuarios ON Devoluciones.id_usuario = Usuarios.id_usuario
RIGHT JOIN Productos ON Devoluciones.id_producto = Productos.id_producto
WHERE Usuarios.rol = 'administrador';

-- Ejemplo 6: Mostrar todos los productos, independientemente de si fueron devueltos.
SELECT Productos.nombre_producto, Devoluciones.fecha_devolucion
FROM Productos
RIGHT JOIN Devoluciones ON Productos.id_producto = Devoluciones.id_producto;

-- Ejemplo 7: Ver todos los usuarios, incluso aquellos que no han hecho devoluciones.
SELECT Usuarios.nombre_usuario, Devoluciones.fecha_devolucion
FROM Usuarios
RIGHT JOIN Devoluciones ON Usuarios.id_usuario = Devoluciones.id_usuario;

-- Ejemplo 8: Listar todos los usuarios con la cantidad de productos devueltos.
SELECT Usuarios.nombre_usuario, SUM(Devoluciones.cantidad_devolucion) AS total_devuelto
FROM Usuarios
RIGHT JOIN Devoluciones ON Usuarios.id_usuario = Devoluciones.id_usuario
GROUP BY Usuarios.nombre_usuario;

-- Ejemplo 9: Mostrar productos devueltos por un usuario específico.
SELECT Productos.nombre_producto, Devoluciones.cantidad_devolucion
FROM Productos
RIGHT JOIN Devoluciones ON Productos.id_producto = Devoluciones.id_producto
RIGHT JOIN Usuarios ON Devoluciones.id_usuario = Usuarios.id_usuario
WHERE Usuarios.nombre_usuario = 'usuario5';

-- Ejemplo 10: Ver detalles de productos devueltos, incluso si algunos productos no han sido devueltos.
SELECT Productos.nombre_producto, Devoluciones.fecha_devolucion
FROM Productos
RIGHT JOIN Devoluciones ON Productos.id_producto = Devoluciones.id_producto;

-- Ejemplo 11: Mostrar todos los usuarios con sus devoluciones, incluso si no han devuelto nada.
SELECT Usuarios.nombre_usuario, Devoluciones.cantidad_devolucion
FROM Usuarios
RIGHT JOIN Devoluciones ON Usuarios.id_usuario = Devoluciones.id_usuario;

-- Ejemplo 12: Mostrar todos los productos con sus devoluciones, si las hay.
SELECT Productos.nombre_producto, SUM(Devoluciones.cantidad_devolucion) AS total_devuelto
FROM Productos
RIGHT JOIN Devoluciones ON Productos.id_producto = Devoluciones.id_producto
GROUP BY Productos.nombre_producto;

-- Ejemplo 13: Ver todas las devoluciones, incluso si algunos productos no han sido devueltos.
SELECT Productos.nombre_producto, Devoluciones.fecha_devolucion
FROM Productos
RIGHT JOIN Devoluciones ON Productos.id_producto = Devoluciones.id_producto;

-- Ejemplo 14: Listar usuarios que han hecho devoluciones de cinturones, incluso si algunos no lo han hecho.
SELECT Usuarios.nombre_usuario, Productos.nombre_producto
FROM Usuarios
RIGHT JOIN Devoluciones ON Usuarios.id_usuario = Devoluciones.id_usuario
RIGHT JOIN Productos ON Devoluciones.id_producto = Productos.id_producto
WHERE Productos.tipo_producto = 'cinturon';

-- Ejemplo 15: Mostrar productos devueltos y cantidad devuelta, si es que hay devoluciones.
SELECT Productos.nombre_producto, SUM(Devoluciones.cantidad_devolucion) AS total_devuelto
FROM Productos
RIGHT JOIN Devoluciones ON Productos.id_producto = Devoluciones.id_producto
GROUP BY Productos.nombre_producto;

---------------------------------------------------------------------------------------------------------------

-- consultas anidadas

-- Ejemplo 1: Obtener los usuarios que han hecho más de una devolución.
SELECT nombre_usuario
FROM Usuarios
WHERE id_usuario IN (
    SELECT id_usuario 
    FROM Devoluciones 
    GROUP BY id_usuario 
    HAVING COUNT(id_devolucion) > 1
);

-- Ejemplo 2: Obtener los productos que han sido devueltos más de 2 veces.
SELECT nombre_producto
FROM Productos
WHERE id_producto IN (
    SELECT id_producto
    FROM Devoluciones
    GROUP BY id_producto
    HAVING SUM(cantidad_devolucion) > 2
);

-- Ejemplo 3: Obtener los usuarios que han devuelto más de una vez.
SELECT nombre_usuario
FROM Usuarios
WHERE id_usuario IN (
    SELECT id_usuario
    FROM Devoluciones
    GROUP BY id_usuario
    HAVING COUNT(id_devolucion) > 1
);

-- Ejemplo 4: Obtener los productos devueltos por más de un usuario.
SELECT nombre_producto
FROM Productos
WHERE id_producto IN (
    SELECT id_producto
    FROM Devoluciones
    GROUP BY id_producto
    HAVING COUNT(id_usuario) > 1
);

-- Ejemplo 5: Listar usuarios que han devuelto más de un producto.
SELECT nombre_usuario
FROM Usuarios
WHERE id_usuario IN (
    SELECT id_usuario
    FROM Devoluciones
    GROUP BY id_usuario
    HAVING COUNT(id_producto) > 1
);

-- Ejemplo 6: Obtener productos devueltos en más de una fecha.
SELECT nombre_producto
FROM Productos
WHERE id_producto IN (
    SELECT id_producto
    FROM Devoluciones
    GROUP BY fecha_devolucion
    HAVING COUNT(fecha_devolucion) > 1
);

-- Ejemplo 7: Listar usuarios que han devuelto más de dos productos de diferente tipo.
SELECT nombre_usuario
FROM Usuarios
WHERE id_usuario IN (
    SELECT id_usuario
    FROM Devoluciones
    INNER JOIN Productos ON Devoluciones.id_producto = Productos.id_producto
    GROUP BY Productos.tipo_producto
    HAVING COUNT(DISTINCT Productos.tipo_producto) > 2
);

-- Ejemplo 8: Obtener la cantidad total de devoluciones para productos específicos.
SELECT nombre_producto
FROM Productos
WHERE id_producto IN (
    SELECT id_producto
    FROM Devoluciones
    WHERE cantidad_devolucion > 1
);

-- Ejemplo 9: Obtener la lista de productos devueltos por administradores.
SELECT nombre_producto
FROM Productos
WHERE id_producto IN (
    SELECT id_producto
    FROM Devoluciones
    WHERE id_usuario IN (
        SELECT id_usuario
        FROM Usuarios
        WHERE rol = 'administrador'
    )
);

-- Ejemplo 10: Listar productos devueltos más de 5 veces.
SELECT nombre_producto
FROM Productos
WHERE id_producto IN (
    SELECT id_producto
    FROM Devoluciones
    GROUP BY id_producto
    HAVING SUM(cantidad_devolucion) > 5
);

-- Ejemplo 11: Mostrar los productos que han sido devueltos por todos los usuarios.
SELECT nombre_producto
FROM Productos
WHERE id_producto IN (
    SELECT id_producto
    FROM Devoluciones
    GROUP BY id_producto
    HAVING COUNT(DISTINCT id_usuario) = (
        SELECT COUNT(*) FROM Usuarios
    )
);

-- Ejemplo 12: Mostrar usuarios que han devuelto productos más de dos veces.
SELECT nombre_usuario
FROM Usuarios
WHERE id_usuario IN (
    SELECT id_usuario
    FROM Devoluciones
    GROUP BY id_usuario
    HAVING COUNT(id_producto) > 2
);

-- Ejemplo 13: Obtener los productos devueltos por más de dos usuarios diferentes.
SELECT nombre_producto
FROM Productos
WHERE id_producto IN (
    SELECT id_producto
    FROM Devoluciones
    GROUP BY id_usuario
    HAVING COUNT(DISTINCT id_usuario) > 2
);

-- Ejemplo 14: Obtener los productos devueltos por un usuario específico en más de una fecha.
SELECT nombre_producto
FROM Productos
WHERE id_producto IN (
    SELECT id_producto
    FROM Devoluciones
    WHERE id_usuario = (
        SELECT id_usuario FROM Usuarios WHERE nombre_usuario = 'usuario1'
    )
    GROUP BY fecha_devolucion
    HAVING COUNT(fecha_devolucion) > 1
);

-- Ejemplo 15: Listar los productos que han sido devueltos por diferentes usuarios en un solo día.
SELECT nombre_producto
FROM Productos
WHERE id_producto IN (
    SELECT id_producto
    FROM Devoluciones
    GROUP BY fecha_devolucion
    HAVING COUNT(DISTINCT id_usuario) > 1
);