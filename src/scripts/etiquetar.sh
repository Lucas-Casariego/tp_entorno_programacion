#!/bin/bash

# Este script trabaja sobre archivos de la carpeta "imagenes" que terminan en .jpg,
# clasificándolos usando YOLO:
#
# Debe crearse un archivo con el mismo nombre que la imagen, pero extensión .tag
# donde se guardan las etiquetas. Por ejemplo, un archivo .tag podría tener:
# 2 persons, 1 potted plant, 1 laptop, 2 books
#
# Asegúrese de devolver un valor de salida acorde a la situación.

# Ruta al archivo de configuración de YOLO
CONFIG_FILE="yolov3.cfg"
WEIGHTS_FILE="yolov3.weights"
NAMES_FILE="coco.names"

# Verificamos si los archivos necesarios existen
if [[ ! -f "$CONFIG_FILE" || ! -f "$WEIGHTS_FILE" || ! -f "$NAMES_FILE" ]]; then
  echo "Archivos de configuración de YOLO no encontrados." && exit 1
fi

# Ruta a la carpeta de imágenes
IMAGE_DIR="imagenes"

# Verificamos si la carpeta de imágenes existe
if [[ ! -d "$IMAGE_DIR" ]]; then
  echo "Carpeta de imágenes no encontrada." && exit 1
fi

# Iteramos sobre cada archivo .jpg en la carpeta de imágenes
for image in "$IMAGE_DIR"/*.jpg; do
  if [[ -f "$image" ]]; then
    output=$(darknet detect "$CONFIG_FILE" "$WEIGHTS_FILE" "$image")
    
    # Extraer etiquetas del resultado
    labels=$(echo "$output" | grep "Objects:" -A 999 | grep -v "Objects:" | grep -v "Enter" | awk '{print $2}' | sort | uniq -c | awk '{print $1, $2}' | tr '\n' ', ' | sed 's/, $//')

    if [[ -n "$labels" ]]; then
      # Creamos el archivo .tag con las etiquetas
      echo "$labels" > "${image%.jpg}.tag"
    else
      echo "No se encontraron etiquetas para $image."
    fi
  fi
done

exit 0