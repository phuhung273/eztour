FROM phuhung273/php-fpm-laravel-jet

RUN mkdir /var/www/cms_php
# Copy composer.lock and composer.json
COPY composer.lock composer.json /var/www/cms_php

# Set working directory
WORKDIR /var/www/cms_php

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