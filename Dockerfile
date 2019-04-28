FROM php:7.2-fpm-alpine

RUN apk update \
 && apk add --no-cache $PHPIZE_DEPS \
    bash \
    libzip-dev \
    zip \
    unzip

RUN docker-php-ext-install opcache pdo_mysql zip
RUN docker-php-ext-enable opcache
RUN docker-php-ext-configure zip --with-libzip=/usr/include

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --filename=composer \
    && php -r "unlink('composer-setup.php');" \
    && mv composer /usr/local/bin/composer

WORKDIR /var/srv/www

COPY app /var/srv/www

RUN composer install --prefer-dist --optimize-autoloader
