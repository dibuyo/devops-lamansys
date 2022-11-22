var express = require('express');
var app = express();
var PORT = 3000;
  
app.get('/', function(req, res){
    res.status(200).send(`Hola Curso. Me estoy ejecutando con Node: ${process.version}`);
    console.log("Se ejecuto un HTTP Request.");
})
  
app.listen(PORT, function(err){
    if (err) console.log(err);
    console.log("Server listening on PORT", PORT);
});