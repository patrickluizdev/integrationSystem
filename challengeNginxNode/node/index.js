const express = require("express");
const mysql = require("mysql");

const app = express();
const port = 3000;

//CONECT DB
const db = mysql.createConnection({
  host: process.env.DB_HOST,
  host: 'db',
  user: 'root',
  password: 'jatabara',
  database: 'nodedb'
});
//MSG DB SUCESS
db.connect((err) => {
  if (err) {
    console.log("Error connecting to DB: ", err);
    return;
  }
  console.log("Connected to DB!");
});

// VERIFICA OS REQUISITOS
function createTable() {
  db.query(`
    CREATE TABLE IF NOT EXISTS nodedb.people (
      id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
      name VARCHAR(255) NOT NULL);`, (error, results, fields) => {
    if (error) throw error;
    console.log('Table created successfully');
  });
  createTable();
}

app.get("/", (req, res) => {
  db.query("SELECT name FROM people", (err, result) => {
    if (err) {
      console.log("Error querying DB: ", err);
      return res.status(500).send("Error querying DB");
    }

    const names = result.map((row) => row.name).join(", ");
    res.send(`
    <body style="background-color:#0A0A0A; color:#FAFAFA;">
    <h1>Full Cycle Rocks!</h1>
      <p>Names: ${names}</p>
      <div>
        <h2>Adicionar Nomes</h2>
        <form method="POST" action="/add-name">
          <label for="name">Nome:</label>
          <input type="text" id="name" name="name">
          <button type="submit">Adicionar</button>
        </form>
      </div>
      </body>
    `);
  });
});

// Configuração do body parser para ler dados de formulários
app.use(express.urlencoded({ extended: true }));

// Rota para adicionar nome via POST
app.post("/add-name", (req, res) => {
  const name = req.body.name;
  if (name) {
    db.query(`INSERT INTO people (name) VALUES ("${name}")`, (err, result) => {
      if (err) {
        console.log("Error inserting into DB: ", err);
        return res.status(500).send("Error inserting into DB");
      }
      console.log("Inserted into DB: ", name);
      res.redirect("/");
    });
  } else {
    res.send("No name provided");
  }
});

app.listen(port, () => console.log(`App listening on port ${port}`));

