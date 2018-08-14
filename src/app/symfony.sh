#!/usr/bin/env bash
# Punto de entrada para comunicarse con el contenedor
# - si el contenedor no esta ejecutandose, la arranca
# - caso contrario, ejecuta la orden pasada como segundo parametro

# nombre del contenedor (en docker-composer.yml)
name=symfony4.1-php7.1
running=`docker ps | grep ${name}`
cd symfony-app;
if [ -z "$1" ]; then
    # sin argumentos, se arranca el contenedor y la aplicacion
    # docker-compose rm -f;
    docker-compose up;
elif [ "$running" ]; then
    # ejecuta el comando pasado, ya sea para apache, php, symfony etc
    docker-compose exec php $*
else
    # arranca el compose eliminando los contenedores ya creados
    docker-compose run --rm php $*
    exit_code=$?
    # down is needed to not leave linked mongo container hanging
    docker-compose down
    exit $exit_code
fi
