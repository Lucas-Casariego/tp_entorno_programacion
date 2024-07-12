#!/bin/bash

# Este script debe descargar una sola imagen desde internet en la carpeta actual.
# Puede recibir un argumento opcional indicando la clase de la imagen.
# El nombre del archivo deberá ser su suma de verificación y debe terminar en .jpg
# Asegúrese de devolver un valor de salida acorde a la situación.

./internet.sh

if [ $? -eq 0 ]; then   
    echo "Hay internet, continuando con la descarga"
    # implementación de descarga
else
    exit 1