FROM php:8.2-fpm
MAINTAINER Ivan Ivanov <kasper_wps@mail.ru>

EXPOSE 9000

RUN apt-get update && apt-get install -y \
        libpng-dev libjpeg-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev libzip-dev zip unzip sudo \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd opcache mysqli pdo pdo_mysql zip \
    && rm -rf /usr/src/php*

RUN { \
    echo 'opcache.memory_consumption=128'; \
    echo 'opcache.interned_strings_buffer=8'; \
    echo 'opcache.max_accelerated_files=4000'; \
    echo 'opcache.fast_shutdown=1'; \
    echo 'opcache.enable_cli=1'; \
} > /usr/local/etc/php/conf.d/opcache-recommended.ini

RUN { \
    echo 'date.timezone=GMT+3'; \
} > /usr/local/etc/php/conf.d/datetime.ini

ENV MODX_VERSION 3.0.5
ENV MODX_SHA1 c8abde97ab72be7472549270e9af65d9d959062e

RUN curl -o /usr/src/modx.zip -SL https://kdev.su/d/modx-${MODX_VERSION}-pl.zip \
    && echo "$MODX_SHA1 */usr/src/modx.zip" | sha1sum -c - \
    && unzip -q /usr/src/modx.zip -d / \
    && rm -rf /modx \
    && mkdir /modx \
    && mv /modx-${MODX_VERSION}-pl/* /modx/ \
    && rm -rf /modx-${MODX_VERSION}-pl \
    && rm -f /usr/src/modx.zip \
    && find /modx -name 'ht.access' -exec bash -c 'rm $0' {} \;

COPY --chown=www-data entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

WORKDIR /var/www/html

ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm"]

