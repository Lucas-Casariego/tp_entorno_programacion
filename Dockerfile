# syntax = edrevo/dockerfile-plus
INCLUDE+ .Dockerfile.base

# Instalar los programas necesarios
RUN apt install -y iputils-ping

# Configuracion de la aplicación
ENV TERM=xterm
ENV COLORTERM=24bit
COPY ["src/", "/app/"]
COPY ["imagenes/", "/imagenes/"]
WORKDIR /app
ENTRYPOINT ["/app/main.sh"]
