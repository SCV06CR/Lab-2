#!/bin/bash

# Directorio 
DIRECTORIO="/home/sergio06/Documentos"

# Archivo de log
LOG_FILE="/var/log/cambios_directorio.log"

# Bucle de monitoreo
while true; do
    inotifywait -r -e create,modify,delete $DIRECTORIO

# Registro de eventos
    echo "$(date +"%Y-%m-%d %H:%M:%S") - Se detectó un cambio en $DIRECTORIO" >> $LOG_FILE
done