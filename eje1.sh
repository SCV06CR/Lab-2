#!/bin/bash

#Obtener ID del proceso
pid=$1

if ! ps -p $pid > /dev/null; then
    echo "El proceso $pid no existe"
    exit 1
fi

#Obtener informacion del proceso
nombre=$(ps -o comm= -p $pid)
ppid=$(ps -o ppid= -p $pid)
usuario=$(ps -o usuario= -p $pid)
cpu=$(ps -o %cpu= -p $pid)
memoria=$(ps -o %mem= -p $pid)
estado=$(ps -o stat= -p $pid)
ejecutable=$(readlink /proc/$pid/exe)

#Imprimir informacion del proceso
echo "Nombre: $nombre"
echo "ID: $pid"
echo "Parent Process ID: $ppid"
echo "Usuario Propietario: $usuario"
echo "Uso del CPU: $cpu%"
echo "Consumo de Memoria: $memoria%"
echo "Estado: $estado"
echo "Path: $ejecutable"
