import React, { useState } from "react";
import axios from "axios";
import { Link } from "react-router-dom"; 
import "./stylo/registro.css"

function Registro() {
  const [nombre, setNombre] = useState("");
  const [correo, setCorreo] = useState("");
  const [contraseña, setContraseña] = useState("");
  const [rol, setRol] = useState("user");

  const handleRegister = async () => {
    try {
     
      const response = await axios.post("http://localhost:5000/api/registro", {
        nombre,
        correo,
        contraseña,
        rol,
      });
      alert(response.data.message || "Usuario registrado exitosamente");
    } catch (error) {
      console.error("Detalles del error:", error.response || error.message);

      const status = error.response?.status;
      const errorMessage =
        status === 404
          ? "No se encontró el endpoint. Verifica que el servidor esté corriendo."
          : error.response?.data?.message || error.message || "Ocurrió un error inesperado.";

      alert(`Hubo un problema al registrar: ${errorMessage}`);
    }
  };

  return (
    <div className="registro-container">
      <div className="registro-form">
        <h2 className="registro-title">Registrarse</h2>
        <input
          type="text"
          className="form-input"
          placeholder="Nombre"
          value={nombre}
          onChange={(e) => setNombre(e.target.value)}
        />
        <input
          type="email"
          className="form-input"
          placeholder="Correo Electrónico"
          value={correo}
          onChange={(e) => setCorreo(e.target.value)}
        />
        <input
          type="password"
          className="form-input"
          placeholder="Contraseña"
          value={contraseña}
          onChange={(e) => setContraseña(e.target.value)}
        />
        <select
          className="form-select"
          value={rol}
          onChange={(e) => setRol(e.target.value)}
        >
          <option value="user">Usuario</option>
          <option value="admin">Admin</option>
        </select>
        <button className="btn-registrar" onClick={handleRegister}>
          Registrar
        </button>

        <div className="registro-footer">
          <p>
            ¿Ya te registraste?{" "}
            <Link to="/Inicio" className="link-login">Iniciar sesión</Link>
          </p>
        </div>
      </div>
    </div>
  );
}

export default Registro;


