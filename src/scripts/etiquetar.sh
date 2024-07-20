#!/bin/bash

# Este script trabaja sobre archivos de la carpeta "imagenes" que terminan en .jpg,
# clasificándolos usando YOLO:
#
# Debe crearse un archivo con el mismo nombre que la imagen, pero extensión .tag
# donde se guardan las etiquetas. Por ejemplo, un archivo .tag podría tener:
# 2 persons, 1 potted plant, 1 laptop, 2 books
#
# Asegúrese de devolver un valor de salida acorde a la situación.


DIR_IMAGES="/imagenes"

if [ ! -d "$DIR_IMAGES" ]; then
    echo "El directorio $DIR_IMAGES no existe."
    exit 1
fi


for image in *.jpg; do

    tagfile="${image%.jpg}.tag"

    output=$(yolo predict model=yolov8l.pt source="$image")

    # Etraer tags de la imagen
    labels=$(echo "$output" | grep -oP '\d+x\d+ \K((?:\d+ \w+(?: \w+)*)(?:, \d+ (?:\w+(?: \w+)*))*)')
    
    if [ -z "$labels" ]; then
        echo "no_detections" > "$tagfile"
    else
        echo "$labels" > "$tagfile"
    fi
done

exit 0
