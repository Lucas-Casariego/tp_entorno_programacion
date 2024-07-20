#!/bin/bash
# Este script es un programa interactivo que no recibe argumentos.
# Debe preguntarle al usuario que etiqueta desea buscar y mostrar por
# pantalla todas las imágenes que tengan esa etiqueta.

DIR_IMAGES="/imagenes"  

if [ ! -d "$DIR_IMAGES" ]; then
    echo "El directorio $DIR_IMAGES no existe."
    exit 1
fi

read -p "Ingrese la etiqueta que desea buscar: " etiqueta

encontrado=false
for tagfile in "$DIR_IMAGES"/*.tag; do
    if [[ "$etiqueta" == "no_detections" ]]; then
        if grep -q -E "^no_detections$" "$tagfile"; then
            imagen="${tagfile%.tag}.jpg"
            echo "Imagen encontrada: $imagen"
            encontrado=true
        fi
    else
        if grep -q -E "([0-9]+ )?$etiqueta?s?(,|$)" "$tagfile"; then
            imagen="${tagfile%.tag}.jpg"
            echo "Imagen encontrada: $imagen"
            encontrado=true
        fi
    fi
done

if [ "$encontrado" = false ]; then
    echo "No se encontraron imágenes con la etiqueta '$etiqueta'."
fi

exit 0
