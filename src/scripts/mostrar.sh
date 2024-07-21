#!/bin/bash
# Este script es un programa interactivo que no recibe argumentos.
# Debe preguntarle al usuario que etiqueta desea buscar y mostrar por
# pantalla todas las imágenes que tengan esa etiqueta.


# chequeamos si están todas las imagenes etiquetadas, y las etiquetamos de lo contrario
for image in *.jpg; do
    TAG_FILE="${image%.*}.tag"
    if [ ! -f "$TAG_FILE" ]; then
      echo "Encontrada una imagen sin etiqueta: $(basename "$image"). Etiquetando todas las imágenes..."

      /app/scripts/etiquetar.sh

      if [ $? -ne 0 ]; then
        echo "Error al generar las etiquetas. Saliendo..."
        exit 1
      fi
      break
    fi
done

read -p "Ingrese la etiqueta que desea buscar: " etiqueta

encontrado=false
for tagfile in *.tag; do
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
