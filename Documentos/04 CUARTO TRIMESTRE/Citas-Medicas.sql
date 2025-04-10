CREATE DATABASE CITASMEDICAS;
USE CITASMEDICAS;

CREATE TABLE Medico(
id int auto_increment primary key,
apellido varchar(20),
nombre varchar (20),
especialidad VARCHAR (35),
consultorio int,
telefono varchar(10)
);

CREATE TABLE Paciente(
cedula varchar(10) primary key not null,
apellido varchar(20),
nombre varchar(20),
fechaNacimiento date,
telefono varchar(10)
);

CREATE TABLE CitaMedica(
id int auto_increment primary key,
idPaciente varchar(10),
idMedico int,
fechaCita date,
hora time
);

CREATE TABLE Horario(
id int primary key auto_increment,
idMedico int,
dia int,
hora time
);

USE CITASMEDICAS;
ALTER TABLE CitaMedica ADD CONSTRAINT fk_NumCedulaP FOREIGN KEY (idPaciente) REFERENCES Paciente (cedula) ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE CitaMedica ADD CONSTRAINT FK_IDMedico FOREIGN KEY (idMedico) REFERENCES Medico (id) ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE Horario ADD CONSTRAINT fk_IDMedico2 FOREIGN KEY (idMedico) REFERENCES Medico (id) ON DELETE CASCADE;

-- (INSERTAR DATOS (DML)

-- Médicos
INSERT INTO Medico (apellido, nombre, especialidad, consultorio, telefono)
VALUES 
('Martínez', 'Laura', 'Pediatría', 101, '3001234567'),
('Gómez', 'Carlos', 'Dermatología', 102, '3009876543');

-- Pacientes
INSERT INTO Paciente (cedula, apellido, nombre, fechaNacimiento, telefono)
VALUES 
('1234567890', 'Pérez', 'Ana', '1990-05-12', '3114567890'),
('0987654321', 'Rojas', 'Luis', '1985-11-30', '3123456789');

-- Horarios de médicos
INSERT INTO Horario (idMedico, dia, hora)
VALUES 
(1, 1, '08:00:00'),  -- lunes
(1, 3, '10:00:00'),  -- miércoles
(2, 2, '09:30:00');  -- martes

-- Citas médicas
INSERT INTO CitaMedica (idPaciente, idMedico, fechaCita, hora)
VALUES 
('1234567890', 1, '2025-04-15', '08:00:00'),
('0987654321', 2, '2025-04-16', '09:30:00');

-- (VERIFICAR DATOS DE PRUEBA)
-- Mostrar médicos registrados
SELECT * FROM Medico;

-- Mostrar pacientes registrados
SELECT * FROM Paciente;

-- Mostrar horarios
SELECT * FROM Horario;

-- Mostrar citas médicas
SELECT * FROM CitaMedica;


-- (CONSULTAS CON JOINS)
-- Ver citas médicas con datos completos del médico y paciente
SELECT 
  c.id,
  p.nombre AS nombrePaciente,
  m.nombre AS nombreMedico,
  m.especialidad,
  c.fechaCita,
  c.hora
FROM CitaMedica c
JOIN Paciente p ON c.idPaciente = p.cedula
JOIN Medico m ON c.idMedico = m.id;

-- (SUBCONSULTAS)
-- Pacientes que tienen citas con médicos de la especialidad "Pediatría"
SELECT nombre, apellido FROM Paciente
WHERE cedula IN (
  SELECT idPaciente FROM CitaMedica
  WHERE idMedico IN (
    SELECT id FROM Medico WHERE especialidad = 'Pediatría'
  )
);


-- (CONSULTAS EXTRA DE APOYO)
-- Horarios del Dr. Carlos Gómez
SELECT h.* FROM Horario h
JOIN Medico m ON h.idMedico = m.id
WHERE m.nombre = 'Carlos' AND m.apellido = 'Gómez';

-- Mostrar citas para una fecha específica
SELECT * FROM CitaMedica WHERE fechaCita = '2025-04-15';
