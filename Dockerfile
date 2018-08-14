FROM petronetto/php7-alpine

LABEL maintainer="Josep Pino"

USER root

RUN apk --update upgrade --no-cache; \    
    apk add --no-cache iconv git unzip; \    
    # echo 'extension=iconv.so' > /etc/php7/conf.d/iconv.ini; \
    apk del .build-deps; \
    rm -rf /var/cache/apk/*;    

# RUN rm /usr/bin/iconv \
#   && curl -SL http://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.14.tar.gz | tar -xz -C . \
#   && cd libiconv-1.14 \
#   && ./configure --prefix=/usr/local \
#   && curl -SL https://raw.githubusercontent.com/mxe/mxe/7e231efd245996b886b501dad780761205ecf376/src/libiconv-1-fixes.patch \
#   | patch -p1 -u  \
#   && make \
#   && make install \
#   && libtool --finish /usr/local/lib \
#   && cd .. \
#   && rm -rf libiconv-1.14

# ENV LD_PRELOAD /usr/local/lib/preloadable_libiconv.so

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