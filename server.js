const http = require('http');

const PORT = process.env.PORT || 3000;
const TIMEZONE = process.env.TZ || 'UTC';
const AUTHOR = process.env.AUTHOR || 'Nieznany autor';

const requestHandler = (req, res) => {
  const clientIP = req.connection.remoteAddress.replace('::ffff:', '');
  const clientDate = new Date().toLocaleString("pl-PL", { timeZone: TIMEZONE });
  
  res.writeHead(200, {'Content-Type': 'text/html'});
  res.end(`<h1>Witaj, Twoje IP to: ${clientIP}</h1>
            <p>Data i czas w twojej strefie czasowej: ${clientDate}</p>`);
};

const server = http.createServer(requestHandler);

server.listen(PORT, () => {
  console.log(`Serwer działa, nasłuchuje na porcie ${PORT}`);
  console.log(`Autor serwera: ${AUTHOR}`);
  console.log(`Data uruchomienia: ${new Date().toLocaleString()}`);
});
