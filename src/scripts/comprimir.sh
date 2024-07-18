#!/bin/bash

# Este script comprime todo el contenido de la carpeta actual y además, genera
# una suma de verificación del archivo resultante en un archivo separado.

# Nombre del archivo comprimido
OUTPUT_FILE="contenido_comprimido.tar.gz"
# Nombre del archivo de suma de verificación
CHECKSUM_FILE="checksum.txt"

# Comprimir el contenido de la carpeta actual
tar -czf "$OUTPUT_FILE" ./*

# Verificar si la compresión fue exitosa
if [ $? -eq 0 ]; then
  echo "Compresión completada exitosamente: $OUTPUT_FILE"
else
  echo "Error durante la compresión." && exit 1
fi

# Generar la suma de verificación
sha256sum "$OUTPUT_FILE" > "$CHECKSUM_FILE"

# Verificar si la generación de la suma de verificación fue exitosa
if [ $? -eq 0 ]; then
  echo "Suma de verificación generada exitosamente: $CHECKSUM_FILE"
else
  echo "Error durante la generación de la suma de verificación." && exit 1
fi

echo Módulo de compresión no implementado. && exit 1
