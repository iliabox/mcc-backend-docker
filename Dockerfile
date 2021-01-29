FROM composer:latest AS composer
FROM mlocati/php-extension-installer:latest as php-extension-installer
FROM php:7.4.14-fpm-alpine

ENV WD /var/www/app
ENV COMPOSER_MEMORY_LIMIT -1
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

COPY --from=composer /usr/bin/composer /usr/bin/composer
COPY --from=php-extension-installer /usr/bin/install-php-extensions /usr/bin/

RUN apk --no-cache add \
        nginx \
        supervisor \
        curl \
        su-exec \
    && mv $PHP_INI_DIR/php.ini-production $PHP_INI_DIR/php.ini \
    && install-php-extensions \
        apcu \
        pdo_mysql \
        opcache \
        pcntl \
        intl \
        gd \
        zip \
        bcmath \
    && rm -rf /tmp/* /var/cache/apk/* \
    && mkdir -p $WD \
    && chown -R nginx:nginx $WD \
    && mkdir -p /var/run/php-fpm/ \
    && chown -R nginx:nginx /var/run/php-fpm/ \
    && mkdir -p /etc/supervisor.d/ \
    && mkdir -p /run/nginx/ \
    && rm -f /etc/nginx/conf.d/default.conf \
    && sed -i 's/^\(\[supervisord\]\)$/\1\nnodaemon=true/' /etc/supervisord.conf \
    && sed -i 's/# server_tokens off/server_tokens off/' /etc/nginx/nginx.conf \
    && sed -i 's/^listen/;listen/' /usr/local/etc/php-fpm.d/zz-docker.conf

WORKDIR $WD

CMD ["supervisord","-c","/etc/supervisord.conf"]

