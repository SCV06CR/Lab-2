#!/bin/bash

#Variable para el nombre del ejecutable
ejecutable="$1"

#Funcion de ejecucion del binario y su monitoreo respecto a su uso de CPU y consumo de memoria
monitorear_proceso() {
    ./$ejecutable &
    pid=$!

    log_file="registro_$ejecutable.txt"
    echo "Tiempo Consumo_CPU Consumo_Memoria" > "$log_file"

#Bucle de monitoreo
    while ps -p $pid &>/dev/null; do
        tiempo=$(date +%s)
        cpu=$(ps -p $pid -o %cpu | sed 1d)
        memoria=$(ps -p $pid -o %mem | sed 1d)
        echo "$tiempo $cpu $memoria" >> "$log_file"
        sleep 1  
    done

#Generador de grafica
    gnuplot << EOF
set xlabel "Tiempo"
set ylabel "Consumo (%)"
set title "Consumo de CPU y Memoria de $ejecutable"
set key outside
set terminal png
set output "grafica_$ejecutable.png"
plot "$log_file" using 1:2 with lines lw 2 title "CPU", \
     "$log_file" using 1:3 with lines lw 2 title "Memoria"
EOF

    echo "El proceso $ejecutable ha finalizado."
}

#Llamado de la funcion 
monitorear_proceso