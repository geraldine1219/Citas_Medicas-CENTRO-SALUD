import React, { useState } from "react";
import jsPDF from 'jspdf';
import 'jspdf-autotable';
import './producto.css';
import axios from "axios";
import producto1 from "./imagenes/image-removebg-preview (1).png";
import producto2 from "./imagenes/image-removebg-preview (2).png"; 
import producto3 from "./imagenes/image-removebg-preview (3).png"
import producto4 from "./imagenes/image-removebg-preview (5).png"
import producto6 from "./imagenes/image-removebg-preview (7).png"
import producto7 from "./imagenes/image-removebg-preview (8).png"
import producto8 from "./imagenes/image-removebg-preview (9).png"
import producto9 from "./imagenes/image-removebg-preview (10).png"
import producto10 from "./imagenes/image-removebg-preview (11).png"
import producto11 from "./imagenes/image-removebg-preview (12).png"

const producto = [
  { id: 1, src: producto1, nombre: 'Camisa Escolar', precio: 20 },
  { id: 2, src: producto2, nombre: 'Pantalón Escolar', precio: 25 },
  { id: 3, src: producto3, nombre: 'Zapatos Escolares', precio: 30 },
  { id: 4, src: producto4 ,nombre: 'Cinturón Escolar', precio: 10 },
  { id: 5, src: producto6 ,nombre: 'Falda Escolar', precio: 22 },
  { id: 6, src: producto7, nombre: 'Corbata Escolar', precio: 15 },
  { id: 7, src: producto8, nombre: 'Medias Escolares', precio: 8 },
  { id: 8, src: producto9, nombre: 'Suéter Escolar', precio: 35 },
  { id: 9, src: producto10,nombre: 'Chaleco Escolar', precio: 28 },
  { id: 10,src: producto11,nombre: 'Camiseta Escolar', precio: 40 },
];

const Producto = () => {
  const [carrito, setCarrito] = useState([]);
  const [tallasSeleccionadas, setTallasSeleccionadas] = useState({});
  const [metodoPago, setMetodoPago] = useState('');
  const tallasDisponibles = ['S', 'M', 'L', 'XL'];

  const agregarAlCarrito = (producto) => {
    const tallaSeleccionada = tallasSeleccionadas[producto.id];
    if (!tallaSeleccionada) {
      alert('Por favor selecciona una talla.');
      return;
    }
    const productoConTalla = { ...producto, talla: tallaSeleccionada };
    setCarrito([...carrito, productoConTalla]);
  };

  const eliminarDelCarrito = (index) => {
    const nuevoCarrito = carrito.filter((_, i) => i !== index);
    setCarrito(nuevoCarrito);
  };

  const manejarCambioTalla = (productoId, talla) => {
    setTallasSeleccionadas({ ...tallasSeleccionadas, [productoId]: talla });
  };

  const generarPDF = () => {
    const doc = new jsPDF();
    doc.text('Factura de Compra', 10, 10);

    const tableColumn = ['Producto', 'Talla', 'Precio'];
    const tableRows = carrito.map(item => [item.nombre, item.talla, `$${item.precio}`]);

    doc.autoTable({
      head: [tableColumn],
      body: tableRows,
      startY: 20,
    });

    const total = carrito.reduce((acc, item) => acc + item.precio, 0);
    doc.text(`Total: $${total}`, 10, doc.autoTable.previous.finalY + 10);

    if (metodoPago) {
      doc.text(`Método de pago: ${metodoPago}`, 10, doc.autoTable.previous.finalY + 20);
    }

    doc.save('factura.pdf');
  };

  const procesarDevolucion = async () => {
    if (carrito.length === 0) {
      alert('El carrito está vacío.');
      return;
    }
    try {
      const devoluciones = carrito.map(item => ({
        user_id: 1, // Cambiar según el usuario logueado
        product_id: item.id,
        quantity: 1,
      }));

      await axios.post('http://localhost/api/returns.php', { devoluciones });
      alert('Devolución procesada exitosamente.');
      setCarrito([]);
    } catch (error) {
      console.error('Error al procesar la devolución:', error);
      alert('Hubo un problema al procesar la devolución. Intenta de nuevo.');
    }
  };

  const total = carrito.reduce((acc, item) => acc + item.precio, 0);

  return (
    <div className="producto-container">
      <center>
        <h1 className="producto-titulo">Carrito de Uniformes Escolares</h1>
      </center>
      <div className="producto-row">
        {/* Lista de productos */}
        <div className="producto-col">
          <div className="producto-row">
            {producto.map((producto) => (
              <div className="producto-card-container" key={producto.id}>
                <div className="producto-card">
                  <img src={producto.src} alt={producto.nombre} className="producto-card-img" />
                  <div className="producto-card-body">
                    <h3 className="producto-card-title">{producto.nombre}</h3>
                    <p className="producto-card-text">Precio: ${producto.precio}</p>

                    <div className="producto-form-group">
                      <label>Selecciona una talla:</label>
                      <select
                        onChange={(e) => manejarCambioTalla(producto.id, e.target.value)}
                        value={tallasSeleccionadas[producto.id] || ''}
                      >
                        <option value="">Elige una talla</option>
                        {tallasDisponibles.map((talla) => (
                          <option key={talla} value={talla}>
                            {talla}
                          </option>
                        ))}
                      </select>
                    </div>

                    <button
                      className="producto-button"
                      onClick={() => agregarAlCarrito(producto)}
                    >
                      Agregar al carrito
                    </button>
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* Carrito */}
        <div className="producto-col-carrito">
          <h3 className="producto-lista-titulo">Carrito</h3>
          <div className="producto-list-group">
            {carrito.map((item, index) => (
              <div className="producto-lista-item" key={index}>
                {item.nombre} (Talla: {item.talla}) - ${item.precio}{' '}
                <button
                  className="producto-button-remove"
                  onClick={() => eliminarDelCarrito(index)}
                >
                  Eliminar
                </button>
              </div>
            ))}
          </div>

          <h4 className="producto-total">Total: ${total}</h4>

          <div className="producto-form-group">
            <label>Selecciona un método de pago:</label>
            <select
              value={metodoPago}
              onChange={(e) => setMetodoPago(e.target.value)}
            >
              <option value="">Elige un método de pago</option>
              <option value="Tarjeta de Crédito">Tarjeta de Crédito</option>
              <option value="PayPal">PayPal</option>
              <option value="Nequi">Nequi</option>
              <option value="daviplata">Daviplata</option>
            </select>
          </div>

          <button
            className="producto-button-success"
            disabled={carrito.length === 0 || !metodoPago}
            onClick={generarPDF}
          >
            Generar Factura
          </button>

          <button
            className="producto-button-warning"
            disabled={carrito.length === 0}
            onClick={procesarDevolucion}
          >
            Procesar Devolución
          </button>
        </div>
      </div>
    </div>
  );
};

export default Producto;
