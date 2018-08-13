FROM petronetto/php7-alpine

LABEL maintainer="Josep Pino"

USER root

# RUN apk --update upgrade --no-cache; \
RUN apk add --no-cache git unzip php7-iconv php7-pcntl php7-posix bash; \  
    rm -rf /var/cache/apk/*;    

# https://gist.github.com/guillemcanal/be3db96d3caa315b4e2b8259cab7d07e problemas con iconv en alpine

RUN addgroup -g 1001 -S symfony
RUN adduser -u 1001 -D -S -h /home/symfony -s /sbin/nologin -G symfony symfony

COPY src/bin /usr/bin
COPY src/app /home/symfony

RUN mkdir /my-app
RUN chown -R symfony:symfony /usr/bin
RUN chown -R symfony:symfony /my-app

USER symfony

WORKDIR "/my-app"

VOLUME "/my-app"

EXPOSE 8000

CMD [ "/usr/sbin/php-fpm7" ]
# CMD [ "/usr/bin/server" ]