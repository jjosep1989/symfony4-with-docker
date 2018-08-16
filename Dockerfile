FROM petronetto/php7-alpine

LABEL maintainer="Josep Pino"

USER root
#es un apaño ya que con alpine da problemas de permisos si se usa un usuario y grupo de 
#distinto id que el ususario host, que por lo general tiene la id 1000:1000
RUN deluser www-data

# RUN apk --update upgrade --no-cache; \
RUN apk add --no-cache git unzip php7-iconv php7-pcntl php7-posix bash; \  
    rm -rf /var/cache/apk/*;    

# https://gist.github.com/guillemcanal/be3db96d3caa315b4e2b8259cab7d07e problemas con iconv en alpine

RUN addgroup -g 1000 -S symfony
RUN adduser -u 1000 -D -S -h /home/symfony -s /sbin/nologin -G symfony symfony

COPY src/bin /usr/bin
COPY src/app /home/symfony

RUN chown -R symfony:symfony /usr/bin
RUN chown -R symfony:symfony /app

USER symfony

WORKDIR "/app"

VOLUME "/app"

EXPOSE 8000

CMD [ "/usr/sbin/php-fpm7" ]