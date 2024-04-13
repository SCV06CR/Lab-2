#!/bin/bash

#Variables del nombre y comando del proceso
nombre_proceso="$1"
comando_ejecucion="$2"

#Funcion que verifica el estado del proceso y relanza en caso de que no este corriendo
verificar_proceso() {
    pgrep -x "$nombre_proceso" >/dev/null
    if [ $? -ne 0 ]; then
        echo "El proceso '$nombre_proceso' no está corriendo. Iniciando..."
        $comando_ejecucion &
    else
        echo "El proceso '$nombre_proceso' está corriendo."
    fi
}

#Bucle de monitoreo
while true; do
    verificar_proceso
    sleep 10
done