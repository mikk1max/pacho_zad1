# Wybieramy obraz bazowy Node.js w wersji 14
FROM node:14

# Metadane o autorze
LABEL author="Maksym Shepeta"

# Ustawienie zmiennej środowiskowej z portem
ENV PORT=3000

# Tworzenie katalogu aplikacji w kontenerze
WORKDIR /app

# Skopiowanie plików aplikacji do kontenera
COPY server.js .

# Instalacja zależności
RUN npm install

# Otwarcie portu na którym działa serwer
EXPOSE $PORT

# Komenda uruchamiająca serwer
CMD ["node", "server.js"]
