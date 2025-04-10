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
