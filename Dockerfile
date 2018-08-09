FROM petronetto/php7-alpine

LABEL maintainer="Josep Pino"

USER root

RUN apk --update upgrade --no-cache; \
    apk add --no-cache git unzip; \    
    echo 'extension=iconv.so' > /etc/php7/conf.d/iconv.ini; \
    apk del .build-deps; \
    rm -rf /var/cache/apk/*;    

RUN addgroup -g 1001 -S symfony
RUN adduser -u 1001 -D -S -h /home/symfony -s /sbin/nologin -G symfony symfony

COPY src/bin /usr/bin
COPY src/app /home/symfony

RUN chown -Rh symfony:symfony /usr/bin
RUN chown -Rh symfony:symfony /app

USER symfony

WORKDIR "/app"

# EXPOSE 80

VOLUME "/app"

CMD [ "/usr/sbin/php-fpm7" ]