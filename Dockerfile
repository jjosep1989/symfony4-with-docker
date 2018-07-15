FROM php:7.2-apache

# git, composer
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y \  
  libzip-dev \
  libsodium-dev \
  curl \
  git \
  && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
  && apt-get autoremove \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN docker-php-source extract \
  && docker-php-ext-configure zip --with-libzip \
  && docker-php-ext-install zip \
  && docker-php-ext-install sodium \
  && docker-php-source delete


#creamos usuario que tenga permisos para poder manejar el fichero init
#m->crea directorio home, U->grupo de mismo nombre que el usuario, d ->directorio home
# RUN useradd -mUd /home/symfony symfony
# RUN usermod -a -G www-data symfony
# RUN chown -Rh symfony /usr/local

RUN mkdir /app
RUN mkdir /php-logs
#ficheros para la ejecucion depues de la creacion del contenedor
COPY ./src/bin /usr/local/bin
COPY ./src/app  /app

#ficheros de configuracion de php
COPY ./src/configuration/php.ini /usr/local/etc/php/php.ini
#fichero de configuracion de apache2
# COPY ./src/configuration/envvars /etc/apache2/envvars
COPY ./src/configuration/apache2.conf /etc/apache2/apache2.conf

# RUN chmod +xrw /usr/local/etc/php

EXPOSE 80
WORKDIR "/var/www/html"

# ubicacion del codigo de la aplicacion
VOLUME "/var/www/html"
#ubicacion de los logs de php
VOLUME "/php-logs"

#comandos que se ejecutan al inicio
CMD [ "/usr/local/bin/server" ]