FROM php:7.0-apache

# ARG volume=/var/www/html


#creamos usuario que tenga permisos para poder manejar el fichero init
#m->crea directorio home, U->grupo de mismo nombre que el usuario, d ->directorio home
# RUN useradd -md /home/symfony symfony --group root
# USER symfony

#ficheros para la ejecucion depues de la creacion del contenedor
# COPY ./src/bin /usr/local/bin
COPY ./src/bin/init /usr/local/bin/init
COPY ./src/bin/server /usr/local/bin/server
#ficheros necesarios para arrancar y acceder al contenedor despues de ser creado
# COPY ./src/app  /home/symfony/app
COPY ./src/app  /home/root/app
#ficheros de configuracion de php
COPY ./src/configuration /home/root/configuration
# COPY ./src/configuration /home/symfony/configuration

# USER root
# RUN chown -Rh symfony /usr/local/bin/*
# RUN chown -Rh symfony /usr/local/etc/php

# USER symfony
RUN chmod +x /usr/local/bin/init
RUN chmod +x /usr/local/bin/server
RUN chmod +xrw /usr/local/etc/php

EXPOSE 80
WORKDIR "/var/www/html"

# ubicacion del codigo de la aplicacion
VOLUME "/var/www/html"
#configuracion de php
VOLUME "/usr/local/etc/php/"

#comandos que se ejecutan al inicio
CMD [ "/usr/local/bin/server" ]