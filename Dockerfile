FROM php:7.2-fpm-alpine

RUN apk update \
 && apk add --no-cache $PHPIZE_DEPS \
    bash \
    zlib-dev \
    libzip-dev \
    zip

RUN docker-php-ext-install opcache \
    && docker-php-ext-enable opcache

RUN docker-php-ext-configure zip --with-libzip \
    && docker-php-ext-install zip

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --filename=composer \
    && php -r "unlink('composer-setup.php');" \
    && mv composer /usr/local/bin/composer

WORKDIR /usr/src/app

COPY app /usr/src/app

RUN chown www-data /usr/src/app

USER www-data

RUN composer install --prefer-dist --optimize-autoloader
