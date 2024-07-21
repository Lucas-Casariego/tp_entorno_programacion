#!/bin/bash

# Este script organiza las imágenes descargadas en directorios basados en sus etiquetas. Para cada etiqueta generada, el script realiza las siguientes acciones:

# 1. **Crea un Directorio**: Genera una carpeta para cada etiqueta encontrada.
# 2. **Organiza las Imágenes**: Copia las imágenes a una o más carpetas correspondientes según sus etiquetas.


# chequeamos si están todas las imagenes etiquetadas, de lo contrario las etiquetamos 
for image in *.jpg; do
  tag_file="${image%.*}.tag"
  if [ ! -f "$tag_file" ]; then
    echo "Encontrada una imagen sin etiqueta: $(basename "$image"). Etiquetando todas las imágenes..."

    /app/scripts/etiquetar.sh

    if [ $? -ne 0 ]; then
      echo "Error al generar las etiquetas. Saliendo..."
      exit 1
    fi

    break
  fi
done

SORTED_DIR="./imagenes_organizadas"
mkdir -p "$SORTED_DIR"

extraer_nombre_tag() {
  local complete_tag="$1"
  if [ "$complete_tag" = "no_detections" ]; then
    echo "no_detections"
    return
  fi

  # Extraer el número y la palabra
  local num=$(grep -o '^[0-9]*' <<< "$complete_tag")
  local tag=$(sed 's/^[0-9]* //' <<< "$complete_tag")

  # Retornar el tag (si es plural, sin la 's')
  if [ "$num" -eq 1 ]; then
    echo "$tag"
  else
    echo $(sed 's/s$//' <<< "$tag")
  fi
}

# crea todas las carpetas basadas en los tags
for tag_file in *.tag; do
  IFS=',' read -ra array_tags <<< "$(cat "$tag_file")"

  for complete_tag in "${array_tags[@]}"; do
    complete_tag=$(xargs <<< "$complete_tag")
    tag=$(extraer_nombre_tag "$complete_tag")

    mkdir -p "$SORTED_DIR/$tag"
  done
done

# Copia las imágenes a las carpetas correspondientes basadas en las etiquetas
for image in *.jpg; do
  tag_file="${image%.*}.tag"
  IFS=',' read -ra array_tags <<< "$(cat "$tag_file")"

  for complete_tag in "${array_tags[@]}"; do
    complete_tag=$(xargs <<< "$complete_tag")
    tag=$(extraer_nombre_tag "$complete_tag")

    # Copiar la imagen al directorio de la etiqueta
    if [ -d "$SORTED_DIR/$tag" ]; then
      cp "$image" "$SORTED_DIR/$tag/"
    fi
  done
done

echo "Las imágenes han sido organizadas según sus etiquetas."
exit 0