# Etap 1: Budowanie aplikacji
FROM node:16-alpine AS builder

# Ustawienie zmiennej środowiskowej z portem
ENV PORT=3000

# Ustawienie strefy czasowej
ENV TZ=Europe/Warsaw

# Tworzenie katalogu aplikacji w kontenerze
WORKDIR /app

# Copy package.json and package-lock.json into the Docker build context
COPY package.json package-lock.json ./

# Instalacja tylko niezbędnych zależności
RUN npm install --only=production && \
    npm cache clean --force && \
    rm -rf /tmp/*

# Skopiowanie plików aplikacji
COPY . .

# Etap 2: Uruchomienie aplikacji
FROM node:16-alpine

# Ustawienie zmiennej środowiskowej z portem
ENV PORT=3000

# Ustawienie strefy czasowej
ENV TZ=Europe/Warsaw

# Ustawienie autora serwera
ENV AUTHOR="Maksym Shepeta"

# Aktualizacja pakietów systemowych, w tym OpenSSL
RUN apk update && \
    apk upgrade && \
    apk add --no-cache openssl

# Tworzenie katalogu aplikacji w kontenerze
WORKDIR /app

# Skopiowanie plików aplikacji z poprzedniego etapu
COPY --from=builder /app .

# Otwarcie portu na którym działa serwer
EXPOSE $PORT

# Definicja healthcheck (nie zmieniona)
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
    CMD wget -qO- http://localhost:$PORT/ || exit 1

# Komenda uruchamiająca serwer
CMD ["node", "server.js"]
