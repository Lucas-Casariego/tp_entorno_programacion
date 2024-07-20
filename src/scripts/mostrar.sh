#!/bin/bash
# Este script es un programa interactivo que no recibe argumentos.
# Debe preguntarle al usuario que etiqueta desea buscar y mostrar por
# pantalla todas las imágenes que tengan esa etiqueta.

DIR_IMAGES="/imagenes"  

# Verificar si el directorio de imágenes existe
if [ ! -d "$DIR_IMAGES" ]; then
    echo "El directorio $DIR_IMAGES no existe."
    exit 1
fi

# Pedir al usuario que ingrese la etiqueta a buscar
read -p "Ingrese la etiqueta que desea buscar: " etiqueta

# Buscar y mostrar imágenes con la etiqueta especificada
encontrado=false
for tagfile in "$DIR_IMAGES"/*.tag; do
    if grep -q "$etiqueta" "$tagfile"; then
        imagen="${tagfile%.tag}.jpg"
        echo "Imagen encontrada: $imagen"
        encontrado=true
    fi
done

if [ "$encontrado" = false ]; then
    echo "No se encontraron imágenes con la etiqueta '$etiqueta'."
fi

exit 0
