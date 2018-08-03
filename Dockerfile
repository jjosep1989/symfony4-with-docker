FROM webdevops/php-apache-dev:alpine-php7

#creamos usuario que tenga permisos para poder manejar el fichero init
#m->crea directorio home, U->grupo de mismo nombre que el usuario, d ->directorio home
# RUN useradd -mUd /home/symfony symfony
# RUN usermod -a -G www-data symfony
# RUN chown -Rh symfony /usr/local


COPY ./src/bin /usr/local/bin
COPY ./src/app  /src/app

EXPOSE 80
WORKDIR "/app"

# ubicacion del codigo de la aplicacion
VOLUME "/app"

#comandos que se ejecutan al inicio
# CMD [ "/usr/local/bin/server" ]