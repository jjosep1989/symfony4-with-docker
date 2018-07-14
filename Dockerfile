FROM php:7.0-apache

#creamos usuario que tenga permisos para poder manejar el fichero init
#m->crea directorio home, U->grupo de mismo nombre que el usuario, d ->directorio home
# RUN useradd -mUd /home/symfony symfony
# RUN usermod -a -G www-data symfony
# RUN chown -Rh symfony /usr/local
# RUN chown -Rh symfony /var/www/html
# RUN chown -Rh symfony /etc/apache2

RUN mkdir /app
# RUN chown -Rh www-data /app
# RUN chown -Rh www-data /var/www/html
# USER symfony

#ficheros para la ejecucion depues de la creacion del contenedor
COPY ./src/bin /usr/local/bin
# COPY ./src/bin/init /usr/local/bin/init
# COPY ./src/bin/server /usr/local/bin/server
#ficheros necesarios para arrancar y acceder al contenedor despues de ser creado
# COPY ./src/app  /home/symfony/app
# COPY ./src/app  /home/symfony/app
COPY ./src/app  /app

#ficheros de configuracion de php
COPY ./src/configuration/php.ini /usr/local/etc/php/php.ini
#fichero de configuracion de apache2
# COPY ./src/configuration/envvars /etc/apache2/envvars
COPY ./src/configuration/apache2.conf /etc/apache2/apache2.conf

# RUN chmod +x /usr/local/bin/init
# RUN chmod +x /usr/local/bin/server
# RUN chmod +xrw /usr/local/etc/php
EXPOSE 80
WORKDIR "/var/www/html"

# ubicacion del codigo de la aplicacion
VOLUME "/var/www/html"
#ubicacion de los logs de php
# VOLUME "/home/root/php-logs"
#configuracion de php
# VOLUME "/usr/local/etc/php/"

#comandos que se ejecutan al inicio
CMD [ "/usr/local/bin/server" ]