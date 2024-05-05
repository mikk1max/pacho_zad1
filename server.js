const http = require('http');
const os = require('os');
const url = require('url');

// Port, na którym serwer będzie nasłuchiwał
const PORT = process.env.PORT || 3000;

// Funkcja obsługująca żądania HTTP
const requestHandler = (req, res) => {
  const clientIP = req.connection.remoteAddress;
  const clientDate = new Date().toLocaleString("pl-PL", {timeZone: "Europe/Warsaw"});
  
  res.writeHead(200, {'Content-Type': 'text/html'});
  res.write(`<h1>Witaj, Twoje IP to: ${clientIP}</h1>`);
  res.write(`<p>Data i czas w twojej strefie czasowej: ${clientDate}</p>`);
  res.end();
};

// Tworzenie serwera HTTP
const server = http.createServer(requestHandler);

// Nasłuchiwanie na podanym porcie
server.listen(PORT, (err) => {
  if (err) {
    return console.error('Błąd podczas uruchamiania serwera:', err);
  }
  console.log(`Serwer działa, nasłuchuje na porcie ${PORT}`);
  console.log(`Autor serwera: Maksym Shepeta`);
  console.log(`Data uruchomienia: ${new Date().toLocaleString()}`);
});
