#!/bin/bash

# Este script simplemente debe chequear que haya conexión a internet.
# Asegúrese de retornar un valor de salida acorde a la situación.
# Puede que necesite modificar el archivo Dockerfile.

ping -c 1 google.com >/dev/null
if [ $? -eq 0 ]
then
    exit 0
else
    echo No hay internet
    exit 1
fi
