const express = require('express');
const app = express();

app.get('/', function (req, res) {
  res.send('<!DOCTYPE html><html><head><title>Hello Node!</title><link rel="icon" href="https://www.onemanaged.com/wp-content/uploads/2014/08/world89.png"></head><body style="background-color:black;   display: flex;justify-content: center; align-items: center;height: 100vh;"> <h1 style="color:green; font-size: 6rem;">Hello Node!</h1></body></html>');
});

app.listen(3000, function () {
  console.log('Executando na porta 3000!');
});
