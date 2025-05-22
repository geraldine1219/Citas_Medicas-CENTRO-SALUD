-- Creación de la base de datos
CREATE DATABASE IF NOT EXISTS nova_eps_citas;
USE nova_eps_citas;

-- Tabla de Usuarios
CREATE TABLE usuarios (
  id INT AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  rol ENUM('admin', 'medico', 'paciente') NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabla de Pacientes
CREATE TABLE pacientes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  usuario_id INT NOT NULL,
  identificacion VARCHAR(20) NOT NULL UNIQUE,
  nombre VARCHAR(100) NOT NULL,
  apellido VARCHAR(100) NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  genero ENUM('masculino', 'femenino', 'otro') NOT NULL,
  direccion VARCHAR(255),
  telefono VARCHAR(20),
  FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
);

-- Tabla de Médicos
CREATE TABLE medicos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  usuario_id INT NOT NULL,
  identificacion VARCHAR(20) NOT NULL UNIQUE,
  nombre VARCHAR(100) NOT NULL,
  apellido VARCHAR(100) NOT NULL,
  especialidad VARCHAR(100) NOT NULL,
  telefono VARCHAR(20),
  FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
);

-- Tabla de Citas
CREATE TABLE citas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  paciente_id INT NOT NULL,
  medico_id INT NOT NULL,
  fecha DATE NOT NULL,
  hora TIME NOT NULL,
  motivo TEXT NOT NULL,
  estado ENUM('pendiente', 'confirmada', 'cancelada', 'completada') DEFAULT 'pendiente',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (paciente_id) REFERENCES pacientes(id) ON DELETE CASCADE,
  FOREIGN KEY (medico_id) REFERENCES medicos(id) ON DELETE CASCADE
);

-- Índices para mejorar el rendimiento
CREATE INDEX idx_citas_paciente ON citas(paciente_id);
CREATE INDEX idx_citas_medico ON citas(medico_id);
CREATE INDEX idx_citas_fecha ON citas(fecha);


-- Insertar usuarios de prueba
INSERT INTO usuarios (email, password, rol) VALUES 
('admin@novaeps.com', '$2a$10$xD6L.5Z9Uz7vZ5V5h5ZJ.e5v5Z5V5Z5V5Z5V5Z5V5Z5V5Z5V5Z5V5', 'admin'),
('medico1@novaeps.com', '$2a$10$xD6L.5Z9Uz7vZ5V5h5ZJ.e5v5Z5V5Z5V5Z5V5Z5V5Z5V5Z5V5Z5V5', 'medico'),
('paciente1@novaeps.com', '$2a$10$xD6L.5Z9Uz7vZ5V5h5ZJ.e5v5Z5V5Z5V5Z5V5Z5V5Z5V5Z5V5Z5V5', 'paciente');

-- Insertar médico
INSERT INTO medicos (usuario_id, identificacion, nombre, apellido, especialidad, telefono) VALUES
(2, '123456789', 'Carlos', 'Gómez', 'Cardiología', '3001234567');

-- Insertar paciente
INSERT INTO pacientes (usuario_id, identificacion, nombre, apellido, fecha_nacimiento, genero, telefono) VALUES
(3, '987654321', 'Ana', 'Pérez', '1985-05-15', 'femenino', '3109876543');

-- Insertar cita de prueba
INSERT INTO citas (paciente_id, medico_id, fecha, hora, motivo, estado) VALUES
(1, 1, '2023-12-15', '09:00:00', 'Consulta por dolor en el pecho', 'pendiente');
