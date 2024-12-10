import React from "react";
import { Link } from "react-router-dom";
import './stylo/principal.css';
import 'bootstrap/dist/css/bootstrap.min.css';
import { Carousel } from 'react-bootstrap';
import imagen1 from "./imagenes/pexels-ron-lach-10646606.jpg";  // Import the image correctly
import descarga from "./imagenes/imagen2.jpg";
import decarga1 from "./imagenes/imagen3.jpg";

function Home() {
  return (
    <div className="container-principal">
      {/* Carousel for background images */}
      <Carousel fade>
        <Carousel.Item>
          <img
            className="d-block w-100"
            src={imagen1} // Correct way to use the imported image
            alt="Uniform 1"
          />
          <Carousel.Caption>
          <div className="titulo-h3">
            <h3><b>El uniforme escolar perfecto para cada día de aprendizaje.</b></h3>
            </div>
          </Carousel.Caption>
        </Carousel.Item>
        <Carousel.Item>
          <img
            className="d-block w-100"
            src={descarga} // Image from public folder
            alt="Uniform 2"
          />
          <Carousel.Caption>
          <div className="titulo-h3">
            <h3><b>La comodidad y calidad que tu hijo merece,solo en nuestros uniformes</b></h3>
            </div>
          </Carousel.Caption>
        </Carousel.Item>
        <Carousel.Item>
          <img
            className="d-block w-100"
            src={decarga1} // Image from public folder
            alt="Uniform 3"
          />
          <Carousel.Caption>
          <div className="titulo-h3">
            <h3><b>Elige entre una amplia variedad de tallas y estilos para que tu hijo luzca increíble</b></h3>
            </div>
          </Carousel.Caption>
        </Carousel.Item>
      </Carousel>
      <br></br>
      <ul className="menu-principal">
        <li><Link to="/terminos">Términos y condiciones</Link></li>
        <li><Link to="/Registro">Registrarse</Link></li>
        <li><Link to="/Inicio">Iniciar Sesión</Link></li>
      </ul>
<br></br>
      <h2><b>Este es el sistema para gestionar las devoluciones de uniformes escolares.</b></h2>
    
     
      <div className="titulo-h2">
      <center><h3><b>Bienvenido al Sistema de Devolución de Uniformes Escolares</b></h3></center>
      
     
   
    </div>
    </div>
    
  );
}

export default Home;

