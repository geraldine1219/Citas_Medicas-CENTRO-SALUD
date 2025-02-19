const express = require("express");
const cors = require("cors");
const mysql = require("mysql");
const bcrypt = require("bcrypt");

const app = express();
app.use(cors());
app.use(express.json());

const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "proyecto",
});

db.connect((err) => {
  if (err) {
    console.error("Error al conectar con la base de datos MySQL:", err);
    return;
  }
  console.log("Conectado a la base de datos MySQL");
});

app.post("/api/registro", async (req, res) => {
  const { nombre, correo, contraseña, rol } = req.body;

  if (!nombre || !correo || !contraseña || !rol) {
    return res.status(400).json({ message: "Todos los campos son obligatorios" });
  }

  try {
    const querySelect = "SELECT * FROM registro WHERE correo = ?";
    db.query(querySelect, [correo], async (err, results) => {
      if (err) {
        console.error("Error al consultar usuario:", err);
        return res.status(500).json({ message: "Error en la base de datos" });
      }

      if (results.length > 0) {
        return res.status(400).json({ message: "El correo ya está registrado" });
      }

      const hashedPassword = await bcrypt.hash(contraseña, 10);
      const queryInsert =
        "INSERT INTO registro (nombre, correo, contraseña, rol) VALUES (?, ?, ?, ?)";
      db.query(
        queryInsert,
        [nombre, correo, hashedPassword, rol],
        (err, result) => {
          if (err) {
            console.error("Error al registrar usuario:", err);
            return res.status(500).json({ message: "Error en la base de datos" });
          }

          res.status(201).json({ message: "Usuario registrado exitosamente" });
        }
      );
    });
  } catch (error) {
    console.error("Error en el servidor:", error);
    res.status(500).json({ message: "Error en el servidor" });
  }
});

app.post("/api/login", (req, res) => {
  const { correo, contraseña } = req.body;

  if (!correo || !contraseña) {
    return res.status(400).json({ message: "Correo y contraseña son obligatorios" });
  }

  const query = "SELECT * FROM registro WHERE correo = ?";
  db.query(query, [correo], async (err, results) => {
    if (err) {
      console.error("Error al consultar usuario:", err);
      return res.status(500).json({ message: "Error en la base de datos" });
    }

    if (results.length === 0) {
      return res.status(404).json({ message: "Usuario no encontrado" });
    }

    const usuario = results[0];

    const validPassword = await bcrypt.compare(contraseña, usuario.contraseña);
    if (!validPassword) {
      return res.status(401).json({ message: "Contraseña incorrecta" });
    }

    res.json({
      message: "Inicio de sesión exitoso",
      nombre: usuario.nombre,
      rol: usuario.rol,
    });
  });
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Servidor corriendo en el puerto ${PORT}`);
});
