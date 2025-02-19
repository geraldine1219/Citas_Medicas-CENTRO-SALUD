const express = require('express');
const mysql = require('mysql');
const cors = require('cors');

const app = express();
const port = 3002;

// Configura CORS
app.use(cors());
app.use(express.json());

// Configura la conexión a MySQL
const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',  // Tu contraseña de MySQL
  database: 'proyecto',  // Nombre de tu base de datos
});

db.connect((err) => {
  if (err) {
    console.error('Error al conectar a la base de datos:', err);
  } else {
    console.log('Conexión a la base de datos exitosa');
  }
});

// Método GET: Obtener todos los registros
app.get('/api/crud', (req, res) => {
  db.query('SELECT * FROM crud', (err, results) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.json(results);
  });
});

// Método POST: Crear un nuevo registro
app.post('/api/crud', (req, res) => {
  const {nombre,correo,contraseña} = req.body;
  const query = 'INSERT INTO crud (nombre,correo,contraseña) VALUES (?, ?,?)';
  db.query(query, [nombre,correo,contraseña], (err, result) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.status(201).json({ id: result.insertId, nombre,correo,contraseña });
  });
});

// Método PUT: Actualizar un registro
app.put('/api/crud/:id', (req, res) => {
  const { id } = req.params;
  const {nombre,correo,contraseña } = req.body;
  const query = 'UPDATE crud SET  nombre = ?, correo = ?, contraseña = ? WHERE id = ?';
  db.query(query, [nombre,correo,contraseña, id], (err, result) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.json({nombre,correo,contraseña, id});
  });
});

// Método DELETE: Eliminar un registro
app.delete('/api/crud/:id', (req, res) => {
  const { id } = req.params;
  const query = 'DELETE FROM crud WHERE id = ?';
  db.query(query, [id], (err, result) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.json({ message: 'Usuario eliminado', id });
  });
});

// Inicia el servidor
app.listen(port, () => {
  console.log(`Servidor backend en http://localhost:${port}`);
});
