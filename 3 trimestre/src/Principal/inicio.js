import React, { useState } from "react";
import axios from "axios";
import { Link } from "react-router-dom"; 
import "./stylo/inicio.css"

function Inicio() {
  const [correo, setCorreo] = useState("");
  const [contraseña, setContraseña] = useState("");
  const [errorMessage, setErrorMessage] = useState("");

  const handleLogin = async () => {
    try {
  
      const response = await axios.post("http://localhost:5000/api/login", {
        correo,
        contraseña,
      });

     
      if (response.data.rol === "admin") {
        window.location.href = "/crud";
      } else {
        window.location.href = "/producto"; 
      }
    } catch (error) {
      setErrorMessage(error.response?.data?.message || "Error al iniciar sesión");
      console.error("Login error:", error);
    }
  };

  return (
    <div className="inicio-container">
      <div className="inicio-form">
        <h2 className="inicio-title">Iniciar Sesión</h2>
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

        {errorMessage && <p className="error-message">{errorMessage}</p>} 

        <div className="forgot-password">
          <button className="btn-link">
            <Link to="/recuperarContra">¿Olvidaste tu contraseña?</Link>
          </button>
        </div>

        <button className="btn-login" onClick={handleLogin}>
          Ingresar
        </button>
      </div>
    </div>
  );
}

export default Inicio;
