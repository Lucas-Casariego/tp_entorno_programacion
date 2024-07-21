# Trabajo Práctico de Entorno de Programación (2024)

Este repositorio es un trabajo práctico para la materia "Entorno de
Programación" de la carrera T.U.I.A. en F.C.E.I.A. (U.N.R.)

Aquí puede leerse el [enunciado](docs/enunciado.md) del trabajo.

## Introducción

Este proyecto tiene como objetivo la implementación de un sistema para descargar, etiquetar y organizar imágenes usando Docker y Bash. El proyecto está dividido en varias partes principales y se ejecuta dentro de un contenedor Docker.

## Instrucciones

### Dependencias

Es necesario tener instalados `docker` y `docker buildx` para poder ejecutar
este programa. En distribuciones basadas en Ubuntu esto puede conseguirse así:
```bash
sudo apt update
sudo apt install docker.io docker-buildx
```

Luego será necesario habilitar el servicio de contenedores de docker:
```bash
sudo systemctl enable docker
sudo systemctl start docker
```

También puede ser de utilidad agregar al usuario actual al grupo `docker`:
```bash
sudo usermod -aG docker $USER
```
Para que este cambio surja efecto, es necesario reiniciar la sesión.

### Clonación del Repositorio


**Clonar el Repositorio**:
   ```bash
   git clone https://gitlab.com/sofiapelegri/tpentorno2024c1
```
**Acceder al Directorio del Proyecto**:
```bash
cd tpentorno2024c1
```

### Ejecución

Para poder utilizar el programa primero debe construir el contendor:
```bash
docker buildx build -t entorno .
```

Luego puede ejecutarse el contenedor con el siguiente comando:
```bash
docker run --name entorno -v ./imagenes:/imagenes -it entorno
```

Si lo necesitamos, podemos abrir una shell dentro del contenedor
```bash
docker exec -it entorno sh
```




## Estructura del Proyecto

- **Dockerfile**: Archivo para construir la imagen Docker necesaria para el proyecto.
- **src/scripts/**: Carpeta que contiene los scripts Bash que forman parte del proyecto.
  - `internet.sh`: Chequea la conexión a internet.
  - `descargar.sh`: Descarga una imagen de internet y la nombra adecuadamente.
  - `etiquetar.sh`: Genera archivos .tag con las etiquetas de la imagen del mismo nombre
  - `mostrar.sh`: Muestra imágenes que contienen objetos de una etiqueta dada.
  - `comprimir.sh`: Comprime la carpeta imagenes y genera una suma de verificación del archivo resultante en un archivo separado
  - `extra.sh`: Funcionalidad adicional (ver detalles más abajo).
- **imagenes/**: Carpeta donde se almacenan las imágenes descargadas, accesible dentro del contenedor en `/imagenes`.
También puede contener archivos `.tag`, la carpeta imagenes comprimida y la carpeta con las imágenes organizadas según etiquetas, dependiendo de las acciones ejecutadas por el usuario.

## Funcionalidad Extra

El script `extra.sh` organiza las imágenes descargadas en directorios basados en sus etiquetas. Las principales funcionalidades del script son:

1. **Chequeo de Imágenes Etiquetadas**: Verifica si todas las imágenes están etiquetadas. Si alguna imagen no tiene etiqueta, ejecuta el script de etiquetado.
2. **Creación de Directorios por Etiquetas**: Crea directorios para cada etiqueta encontrada.
3. **Organización de Imágenes**: Copia las imágenes en los directorios correspondientes según sus etiquetas.








## Integrantes

* Lucas Casariego
* Sofía Pelegri
