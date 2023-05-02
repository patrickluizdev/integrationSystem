const express = require('express');
const app = express();
const port = 4000

app.get('/', function (req, res) {
  res.send('<!DOCTYPE html><html><head><title>Hello Node!</title><link rel="icon" href="https://www.onemanaged.com/wp-content/uploads/2014/08/world89.png"></head><body style="background-color:black;   display: flex;justify-content: center; align-items: center;height: 100vh;"> <button onclick="runScript()">Run Script</button><script src="db.js"></script></body></html>');
});

app.listen(port, function () {
  console.log('Executando na porta 3000!');
});


const mysql = require('mysql');

// Configurações de conexão com o banco de dados
const config = {
  host: 'db',
  user: 'root',
  password: 'jatabara',
  database: 'nodedb'
};

// Conexão com o banco de dados
const connection = mysql.createConnection(config);

// Query para inserir um registro na tabela "people"
const sql = "INSERT INTO people(name) VALUES('teste234')";

// Execução da query
connection.query(sql, function (error, results, fields) {
  if (error) throw error;
  console.log('Registro inserido com sucesso!');
});

// Fechamento da conexão com o banco de dados
connection.end();
