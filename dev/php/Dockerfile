FROM php:8.1.12-fpm-alpine3.16

RUN apk update \
    && apk add --no-cache \
        # Dependencies required by the gd extension
        libjpeg-turbo-dev \
        libpng-dev \
    # gd
    && docker-php-ext-configure gd --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
    # mysqli
    && docker-php-ext-install mysqli \
    # mysql extension for PDO
    && docker-php-ext-install pdo_mysql \
    # Remove unnecessary files
    && rm -rf /usr/src/php* \
    && rm -rf /var/cache/*

# Composer. Update version when appropriate.
COPY --from=composer:2.4.4 /usr/bin/composer /usr/local/bin/composer

# Config
ADD ./dev/php/fpm.conf /usr/local/etc/php-fpm.d/zz-site.conf
ADD ./dev/php/php.ini /usr/local/etc/php/conf.d/site.ini
