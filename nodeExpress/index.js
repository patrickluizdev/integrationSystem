const express = require('express');
const app = express();

app.get('/', function (req, res) {
  res.send('<body style="background-color:black;   display: flex;justify-content: center; align-items: center;height: 100vh;"> <h1 style="color:green; font-size: 6rem;">Hello Node!</h1></body>');
});

app.listen(3000, function () {
  console.log('Executando na porta 3000!');
});
