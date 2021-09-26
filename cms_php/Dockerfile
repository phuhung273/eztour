# Build vendoor directory
FROM composer:latest as composerBuilder
RUN mkdir -p /app
WORKDIR /app
COPY . /app

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions gd

RUN composer install --optimize-autoloader --no-dev

# Build app.js and app.css
FROM node:14-alpine as npmBuilder
RUN mkdir -p /app
WORKDIR /app
COPY . /app
RUN npm install && npm run prod



FROM php:8.0-fpm

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    libzip-dev \
    unzip \
    git \
    libonig-dev \
    curl

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install extensions
RUN docker-php-ext-install pdo_mysql mbstring zip exif pcntl
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd


# Set working directory
RUN mkdir /var/www/cms_php
WORKDIR /var/www/cms_php

# Copy existing application directory contents
COPY . /var/www/cms_php

# Copy dependencies from builder
COPY --from=composerBuilder /app/vendor /var/www/cms_php/vendor
COPY --from=npmBuilder /app/public/css/app.css /var/www/cms_php/public/css/app.css
COPY --from=npmBuilder /app/public/js/app.js /var/www/cms_php/public/js/app.js

# Add user for laravel application
RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www

# Test permission
RUN usermod -a -G www-data www
RUN chown -R www:www-data /var/www/cms_php
RUN chmod -R 775 /var/www/cms_php/

RUN touch /var/log/fpm-php.www.log
RUN chown www-data:www-data /var/log/fpm-php.www.log

# Change current user to www
USER www