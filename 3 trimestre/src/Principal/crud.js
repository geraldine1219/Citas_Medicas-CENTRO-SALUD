import React, { useState, useEffect } from 'react';
import axios from 'axios';
import './stylo/crud.css'; 

const Usuarios = () => {
  const [usuarios, setUsuarios] = useState([]);
  const [nombre, setNombre] = useState('');
  const [correo, setCorreo] = useState('');
  const [contraseña, setContraseña] = useState('');
  const [editId, setEditId] = useState(null);
  const [mensajeError, setMensajeError] = useState('');
  const [mensajeExito, setMensajeExito] = useState('');

  useEffect(() => {
    axios
      .get('http://localhost:3002/api/crud')
      .then((response) => {
        setUsuarios(response.data);
      })
      .catch((error) => {
        setMensajeError('Error al cargar los usuarios. Verifique la conexión.');
        setMensajeExito('');
        console.error('Error al cargar los usuarios', error);
      });
  }, []);

  const crearUsuario = () => {
    if (!nombre || !correo || !contraseña) {
      setMensajeError('Por favor, ingrese todos los campos.');
      setMensajeExito('');
      return;
    }

    axios
      .post('http://localhost:3002/api/crud', { nombre, correo, contraseña })
      .then((response) => {
        setUsuarios([...usuarios, response.data]);
        setNombre('');
        setCorreo('');
        setContraseña('');
        setMensajeError('');
        setMensajeExito('Usuario creado con éxito.');
      })
      .catch((error) => {
        setMensajeError('Error al crear el usuario. Verifique la conexión.');
        setMensajeExito('');
        console.error('Error al crear usuario', error);
      });
  };

  const editarUsuario = (id) => {
    const usuario = usuarios.find((u) => u.id === id);
    setNombre(usuario.nombre);
    setCorreo(usuario.correo);
    setContraseña(usuario.contraseña);
    setEditId(id);
    setMensajeError('');
    setMensajeExito('');
  };

  const actualizarUsuario = () => {
    if (!nombre || !correo || !contraseña) {
      setMensajeError('Por favor, ingrese todos los campos.');
      setMensajeExito('');
      return;
    }

    axios
      .put(`http://localhost:3002/api/crud/${editId}`, { nombre, correo, contraseña })
      .then((response) => {
        setUsuarios(usuarios.map((u) => (u.id === editId ? response.data : u)));
        setNombre('');
        setCorreo('');
        setContraseña('');
        setEditId(null);
        setMensajeError('');
        setMensajeExito('Usuario actualizado con éxito.');
      })
      .catch((error) => {
        setMensajeError('Error al actualizar el usuario. Verifique la conexión.');
        setMensajeExito('');
        console.error('Error al actualizar usuario', error);
      });
  };

  const eliminarUsuario = (id) => {
    axios
      .delete(`http://localhost:3002/api/crud/${id}`)
      .then(() => {
        setUsuarios(usuarios.filter((u) => u.id !== id));
        setMensajeError('');
        setMensajeExito('Usuario eliminado con éxito.');
      })
      .catch((error) => {
        setMensajeError('Error al eliminar el usuario. Verifique la conexión.');
        setMensajeExito('');
        console.error('Error al eliminar usuario', error);
      });
  };

  return (
    <div className="container">
      <h2><b>Gestión de Usuarios</b></h2>

      {mensajeError && <div className="error-message">{mensajeError}</div>}
      {mensajeExito && <div className="success-message">{mensajeExito}</div>}

      <form>
        <label htmlFor="nombre">Nombre</label>
        <input
          id="nombre"
          type="text"
          placeholder="Ingrese el nombre"
          value={nombre}
          onChange={(e) => setNombre(e.target.value)}
        />

        <label htmlFor="correo">Correo</label>
        <input
          id="correo"
          type="email"
          placeholder="Ingrese el correo"
          value={correo}
          onChange={(e) => setCorreo(e.target.value)}
        />

        <label htmlFor="contraseña">Contraseña</label>
        <input
          id="contraseña"
          type="password"
          placeholder="Ingrese la contraseña"
          value={contraseña}
          onChange={(e) => setContraseña(e.target.value)}
        />

        {editId ? (
          <button type="button" onClick={actualizarUsuario}>
            Actualizar Usuario
          </button>
        ) : (
          <button type="button-crear" onClick={crearUsuario}>
            Crear Usuario
          </button>
        )}
      </form>
<div className='titulo'>
      <h3>Lista de Usuarios</h3></div>
      <ul>
        {usuarios.map((usuario) => (
          <li key={usuario.id}>
            <strong>Nombre:</strong> {usuario.nombre}  <strong>Correo:</strong> {usuario.correo}{' '}
            <strong>Contraseña:</strong> {usuario.contraseña}
            <div>
              <button onClick={() => editarUsuario(usuario.id)}>Editar</button>
              <button onClick={() => eliminarUsuario(usuario.id)}>Eliminar</button>
            </div>
          </li>
        ))}
      </ul>
    </div>
  );
};

export default Usuarios;
