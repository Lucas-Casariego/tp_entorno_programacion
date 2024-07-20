#!/bin/bash

# Este script comprime todo el contenido de la carpeta actual y además, genera
# una suma de verificación del archivo resultante en un archivo separado.

IMAGENES_COMPRIMIDAS="imagenes.tar.gz"

CHECKSUM_FILE="checksum.txt"

tar -czf "$IMAGENES_COMPRIMIDAS" ./*

if [ $? -eq 0 ]; then
  echo "Compresión completada exitosamente: $IMAGENES_COMPRIMIDAS"
else
  echo "Error durante la compresión." && exit 1
fi

sha256sum "$IMAGENES_COMPRIMIDAS" > "$CHECKSUM_FILE"

if [ $? -eq 0 ]; then
  echo "Suma de verificación generada exitosamente: $CHECKSUM_FILE"
else
  echo "Error durante la generación de la suma de verificación." && exit 1
fi