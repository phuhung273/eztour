# Build vendoor directory
FROM composer as composerBuilder
RUN mkdir -p /app
WORKDIR /app
COPY . /app
RUN composer install --optimize-autoloader --no-dev

# Build app.js and app.css
FROM node:14-alpine as npmBuilder
RUN mkdir -p /app
WORKDIR /app
COPY . /app
RUN npm install && npm run prod



FROM php:8.0-fpm

RUN mkdir /var/www/cms_php

# Set working directory
WORKDIR /var/www/cms_php

# Copy dependencies from builder
COPY --from=composerBuilder /app/vendor /var/www/cms_php/vendor
COPY --from=npmBuilder /app/public/css/app.css /var/www/cms_php/public/css/app.css
COPY --from=npmBuilder /app/public/js/app.js /var/www/cms_php/public/js/app.js

# Add user for laravel application
RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www

# Copy existing application directory contents
COPY . /var/www/cms_php

# Copy existing application directory permissions
COPY --chown=www:www . /var/www/cms_php
RUN chown -R www-data:www-data /var/www/cms_php

# Change current user to www
USER www