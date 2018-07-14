#!/usr/bin/env bash
# Punto de entrada para comunicarse con el contenedor
# - si el contenedor no esta ejecutandose, la arranca
# - caso contrario, ejecuta la orden pasada como segundo parametro

# nombre del servicio (en docker-composer.yml)
name=symfony
running=`docker ps | grep ${name}_1`

if [ -z "$1" ]; then
    # sin argumentos, se arranca el contenedor y la aplicacion
    docker-compose up
elif [ "$running" ]; then
    # ejecuta el comando pasado, ya sea para apache, php, symfony etc
    docker-compose exec $name $*
else
    # arranca el compose eliminando los contenedores ya creados
    docker-compose run --rm $name $*
    exit_code=$?
    # down is needed to not leave linked mongo container hanging
    docker-compose down
    exit $exit_code
fi
