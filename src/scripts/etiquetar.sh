#!/bin/bash

# Este script trabaja sobre archivos de la carpeta "imagenes" que terminan en .jpg,
# clasificándolos usando YOLO:
#
# Debe crearse un archivo con el mismo nombre que la imagen, pero extensión .tag
# donde se guardan las etiquetas. Por ejemplo, un archivo .tag podría tener:
# 2 persons, 1 potted plant, 1 laptop, 2 books
#
# Asegúrese de devolver un valor de salida acorde a la situación.


# Script para etiquetar imágenes utilizando YOLO
#!/bin/bash

# Directorio de imágenes
directorio_imagenes="/imagenes"

# Verificación de existencia del directorio
if [ ! -d "$directorio_imagenes" ]; then
    echo "El directorio $directorio_imagenes no existe."
    exit 1
fi

for imagen in "$directorio_imagenes"/*.jpg; do
    echo -e "imagen: $imagen\n\n" 
    output=$(yolo predict source="$imagen")
    echo $output

done

# Procesar cada imagen en el directorio
# for imagen in "$directorio_imagenes"/*.jpg; do
#     # Nombre del archivo sin extensión
#     nombre=$(basename "$imagen" .jpg)

#     # Comando YOLO para etiquetar la imagen
#     output=$(yolo predict source="$imagen")

#     echo "$output"

#     # Comprobación de éxito del comando YOLO
#     if [ $? -ne 0 ]; then
#         echo "Error al etiquetar la imagen $imagen."
#         continue
#     fi

#     # Procesar la salida del comando YOLO
#     if echo "$output" | grep -q "(no detections)"; then
#         echo "no_detections" > "$directorio_imagenes/${nombre}.tag"
#     else
#         # Extraer etiquetas de la salida
#         etiquetas=$(echo "$output" | grep -oP "(?<=\d{3,4}x\d{3,4} ).*" | sed 's/[0-9]\+ //g' | sed 's/ ms.*//')
        
#         # Formatear las etiquetas
#         etiquetas=$(echo "$etiquetas" | tr ' ' ',')

#         # Eliminar la coma final si existe
#         etiquetas=$(echo "$etiquetas" | rev | cut -c 2- | rev)

#         echo "$etiquetas" > "$directorio_imagenes/${nombre}.tag"
#     fi

#     echo "Etiquetado exitoso. Archivo ${nombre}.tag generado."
# done

exit 0
