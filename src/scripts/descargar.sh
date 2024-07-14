#!/bin/bash

# Este script debe descargar una sola imagen desde internet en la carpeta actual.
# Puede recibir un argumento opcional indicando la clase de la imagen.
# El nombre del archivo deberá ser su suma de verificación y debe terminar en .jpg
# Asegúrese de devolver un valor de salida acorde a la situación.

CLASE="$1"

./internet.sh

if [ $? -ne 0 ]; then   
    exit 1
fi    

LINK_IMAGENES="https://picsum.photos/512"
TEMP_NAME="temp_name.jpg"
curl -s -L "$LINK_IMAGENES" -o "$TEMP_NAME"
if [ $? -ne 0 ]; then
    echo "La descarga de la imagen ha fallado"
    exit 1
fi

CHECKSUM=$(sha256sum "$TEMP_NAME" | cut -d " " -f 1)
mv "$TEMP_NAME" "${CHECKSUM}.jpg"

exit 0