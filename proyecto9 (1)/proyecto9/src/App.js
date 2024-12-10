import React from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Principal from "./Principal/principal.js";
import Inicio from "./Principal/inicio.js";
import Registro from "./Principal/registro.js";
import Producto from "./Principal/producto.js";
import Crud from "./Principal/crud.js";
import Devolucion from "./Principal/devolucion.js";
import Terminosycondiciones from "./Principal/terminosycondiciones.js";

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Principal />} />
        <Route path="/Inicio" element={<Inicio />} />
        <Route path="/Registro" element={<Registro />} />
        <Route path="/producto" element={<Producto />} />
        <Route path="/crud" element={<Crud />} />
        <Route path="/devolucion" element={<Devolucion />} />
        <Route path="/terminos" element={<Terminosycondiciones />} />
      </Routes>
    </Router>
  );
}

export default App;
