FROM petronetto/php7-alpine

LABEL maintainer="Josep Pino"

USER root

RUN apk --update upgrade --no-cache; \
    apk add --no-cache git unzip; \  
    apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing gnu-libiconv;  \    
    rm -rf /var/cache/apk/*;    


ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so

# https://gist.github.com/guillemcanal/be3db96d3caa315b4e2b8259cab7d07e

RUN addgroup -g 1001 -S symfony
RUN adduser -u 1001 -D -S -h /home/symfony -s /sbin/nologin -G symfony symfony

COPY src/bin /usr/bin
COPY src/app /home/symfony

RUN chown -Rh symfony:symfony /usr/bin
RUN chown -Rh symfony:symfony /app

USER symfony

WORKDIR "/app"

VOLUME "/app"

CMD [ "/usr/sbin/php-fpm7" ]